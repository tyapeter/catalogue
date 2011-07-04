package com.teravin.catalogue

import grails.converters.XML
import grails.converters.JSON
import org.grails.plugins.imagetools.*

class ModelController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def springSecurityService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		params.sort = "idx"
		params.order = "asc"
        withFormat {
			html {
				[modelInstanceList: Model.list(params), modelInstanceTotal: Model.count()]
			}
			xml {
				render Model.list( params ) as XML
			}
			json {
				response.status = 200
				if(params.callback) {
					render "${params.callback}(${Model.list( params ) as JSON})"
				}
				else {
					render "${Model.list( params ) as JSON}"
				}
			}
		}
    }

    def create = {
        def modelInstance = new Model()
        modelInstance.properties = params
        return [modelInstance: modelInstance]
    }

    def save = {
        def modelInstance = new Model(params)
        modelInstance.createdBy = springSecurityService.principal.username
		def downloadedfile = request.getFile('imageFile')
		def imageTool = new ImageTool()
		
        withFormat {
			html {
                if (modelInstance.save(flush: true && downloadedfile)) {
					String imagepath = grailsAttributes.getApplicationContext().getResource("images/").getFile().toString() + File.separatorChar + "${modelInstance.id}.jpg"
					downloadedfile.transferTo(new File(imagepath))
					println ""+imagepath
					imageTool.load(imagepath)
					imageTool.thumbnail(360)
					
					imageTool.writeResult(imagepath, "JPEG")
					imageTool.square()
                    flash.message = "${message(code: 'default.created.message', args: [message(code: 'model.label', default: 'Model'), modelInstance.id])}"
                    redirect(action: "show", id: modelInstance.id)
                }
                else {
                    render(view: "create", model: [modelInstance: modelInstance])
                }
			}
			xml {
				if(modelInstance.save(flush: true)) {
					modelInstance as XML
				}
				else {
					render "Model not valid" as XML
				}
			}
			json {
				if(modelInstance.save(flush: true)) {
					response.status = 201
					if(params.callback) {
						render "${params.callback}(${modelInstance as JSON})"
					}
					else {
						render "${modelInstance as JSON}"
					}
				}
				else {
					sendValidationFailedResponse(params.callback,modelInstance,400)
				}
			}
		}
    }

    def show = {   
      withFormat {
        html {
            def modelInstance = Model.get( params.id )
            if(!modelInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'model.label', default: 'Model'), params.id])}"
                redirect(action: "list")
            }
            else { return [ modelInstance : modelInstance ] }
          }
          xml {
              if(params.id && Model.get(params.id)) {
                  def c = Model.get(params.id)
                  render c as XML
              }
              else {
                  def all = Model.get(params)
                  render all as XML
              }
          }
          json {
              if(params.id && Model.get(params.id)) {
                  def c = Model.get(params.id)
				  response.status = 200
				  if(params.callback) {
					  render "${params.callback}(${c as JSON})"
				  }
				  else {
					  render "${c as JSON}"
				  }
              }
              else {
                  def all = Model.get(params)
				  response.status = 200
				  if(params.callback) {
					  render "${params.callback}(${all as JSON})"
				  }
				  else {
					  render "${all as JSON}}"
				  }
              }
          }
      	}
    }

    def edit = {
        def modelInstance = Model.get(params.id)
        if (!modelInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'model.label', default: 'Model'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [modelInstance: modelInstance]
        }
    }

    def update = {
        def modelInstance = Model.get(params.id)
        modelInstance.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(modelInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(modelInstance.version > version) {
							
							modelInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'model.label', default: 'Model')] as Object[], "Another user has updated this Model while you were editing")
							render(view:"edit", model:[modelInstance:modelInstance])
							return
						}
					}
					modelInstance.properties = params
					if(!modelInstance.hasErrors() && modelInstance.save(flush: true)) {
						flash.message = "${message(code: 'default.updated.message', args: [message(code: 'model.label', default: 'Model'), modelInstance.id])}"
						redirect(action: "show", id:modelInstance.id)
					}
					else {
						render(view: "edit", model:[modelInstance:modelInstance])
					}
				}
				else {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'model.label', default: 'Model'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(modelInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(modelInstance.version > version) {
							render "Model has been updated by another user" as XML
						}
					}
					modelInstance.properties = params
					if(!modelInstance.hasErrors() && modelInstance.save(flush: true)) {
						modelInstance as XML
					}
					else {
						render "Model not valid" as XML
					}
				}
				else {
					render "Model not found with id ${params.id}" as XML
				}
			}
			json {
				if(modelInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(modelInstance.version > version) {
							response.status = 409
						}
					}
					modelInstance.properties = params
					if(!modelInstance.hasErrors() && modelInstance.save(flush: true)) {
						response.status = 200
						if(params.callback) {
							render "${params.callback}(${modelInstance as JSON})"
						}
						else {
							render "${modelInstance as JSON}"
						}
					}
					else {
						response.status = 400
					}
				}
				else {
					response.status = 404
				}
			}
		}
    }

    def delete = {
        def modelInstance = Model.get(params.id)
		modelInstance.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(modelInstance) {
					try {
						modelInstance.deleteFlag = "Y";
						modelInstance.save(flush:true);
                        flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'model.label', default: 'Model'), params.id])}"
                        redirect(action: "list")
                    }
                    catch (org.springframework.dao.DataIntegrityViolationException e) {
                        flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'model.label', default: 'Model'), params.id])}"
                        redirect(action: "show", id: params.id)
                    }
                }
                else {
                    flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'model.label', default: 'Model'), params.id])}"
                    redirect(action: "list")
                }
			}
			xml {
				if(params.id && modelInstance) {
					try {
						modelInstance.deleteFlag = "Y";
						modelInstance.save(flush:true);
						render "Model ${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "Model ${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "Model not found with id ${params.id}" as XML
				}
			}
			json {
				if(params.id && modelInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(modelInstance.version > version) {
							response.status = 409
						}
					}
					try {
						modelInstance.deleteFlag = "Y";
						modelInstance.save(flush:true)
						response.status = 204
						if(params.callback) {
							render "${params.callback}(${modelInstance as JSON})"
						}
						else {
							render "${modelInstance as JSON}"
						}
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						response.status = 405
					}
				}
				else {
				  response.status = 404
				}
			}
		}
    }
	
	def hardDelete = {
		def modelInstance = Model.get(params.id)
		withFormat {
			html {
				if(modelInstance) {
					try {
						modelInstance.delete(flush: true)
						flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'model.label', default: 'Model'), params.id])}"
						redirect(action: "list")
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'model.label', default: 'Model'), params.id])}"
						redirect(action: "show", id: params.id)
					}
				}
				else {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'model.label', default: 'Model'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(params.id && modelInstance) {
					try {
						modelInstance.delete(flush:true)
						render "Model ${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "Model ${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "Model not found with id ${params.id}" as XML
				}
			}
			json {
				if(params.id && modelInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(modelInstance.version > version) {
							response.status = 409
						}
					}
					try {
						modelInstance.delete(flush:true)
						response.status = 204
						if(params.callback) {
							render "${params.callback}(${modelInstance as JSON})"
						}
						else {
							render "${modelInstance as JSON}"
						}
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						response.status = 405
					}
				}
				else {
				  response.status = 404
				}
			}
		}
	}

    def returnJSON = {
		params.offset =  params.iDisplayStart ? params.iDisplayStart : 0
		params.max =  params.iDisplayLength ? params.iDisplayLength : 10
		params.sort=params.iSortCol_0 ? getColumnToField(params.iSortCol_0) : "id"
		params.order=params.sSortDir_0 ? params.sSortDir_0 : "asc"

		def list= []
		def listData = Model.findAll(params)
		def totalRecord=Model.count()

		
		listData.each{list <<[it.id,it.code,it.name,it.width,it.heigth,it.length]}

		def data = ["iTotalRecords": totalRecord,"iTotalDisplayRecords": totalRecord,"aaData":list]
		render data as JSON
	}

	String getColumnToField (String index)
	{
		if ( index == '0' ) return "id";
					else if ( index == '1' ) return "code";
					else if ( index == '2' ) return "name";
					else if ( index == '3' ) return "width";
					else if ( index == '4' ) return "heigth";
					else if ( index == '5' ) return "length";
					
	}
	
	private def sendValidationFailedResponse(callback, modelInstance, status)
	{
		response.status = status
		if(callback) {
			render contentType: "application/json", callback({
				errors {
					modelInstance?.errors?.fieldErrors?.each {
						err ->
							field(err.field)
							message(g.message(error:err))
					}
				}
			})
			
		}
		else {
			render contentType: "application/json", {
				errors {
					modelInstance?.errors?.fieldErrors?.each {
						err ->
							field(err.field)
							message(g.message(error:err))
					}
				}
			}
		}
	}
}
