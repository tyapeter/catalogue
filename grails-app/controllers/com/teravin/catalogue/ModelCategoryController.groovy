package com.teravin.catalogue

import grails.converters.XML
import grails.converters.JSON

class ModelCategoryController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def springSecurityService

    def index = {
        redirect(action: "list", params: params)
    }

	def getModelCategory = {
		
		def modelCategoryInstance = ModelCategory.get( params.id )
			
		render modelCategoryInstance as JSON
	}
	
    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		params.sort = "idx"
		params.order = "asc"
        withFormat {
			html {
				[modelCategoryInstanceList: ModelCategory.list(params), modelCategoryInstanceTotal: ModelCategory.count()]
			}
			xml {
				render ModelCategory.list( params ) as XML
			}
			json {
				response.status = 200
				if(params.callback) {
					render "${params.callback}(${ModelCategory.list( params ) as JSON})"
				}
				else {
					render "${ModelCategory.list( params ) as JSON}"
				}
			}
		}
    }

    def create = {
        def modelCategoryInstance = new ModelCategory()
        modelCategoryInstance.properties = params
        return [modelCategoryInstance: modelCategoryInstance]
    }

    def save = {
        def modelCategoryInstance = new ModelCategory(params)
        modelCategoryInstance.createdBy = springSecurityService.principal.username
        withFormat {
			html {
                if (modelCategoryInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.created.message', args: [message(code: 'modelCategory.label', default: 'ModelCategory'), modelCategoryInstance.id])}"
                    redirect(action: "show", id: modelCategoryInstance.id)
                }
                else {
                    render(view: "create", model: [modelCategoryInstance: modelCategoryInstance])
                }
			}
			xml {
				if(modelCategoryInstance.save(flush: true)) {
					modelCategoryInstance as XML
				}
				else {
					render "ModelCategory not valid" as XML
				}
			}
			json {
				if(modelCategoryInstance.save(flush: true)) {
					response.status = 201
					if(params.callback) {
						render "${params.callback}(${modelCategoryInstance as JSON})"
					}
					else {
						render "${modelCategoryInstance as JSON}"
					}
				}
				else {
					sendValidationFailedResponse(params.callback,modelCategoryInstance,400)
				}
			}
		}
    }

    def show = {   
      withFormat {
        html {
            def modelCategoryInstance = ModelCategory.get( params.id )
            if(!modelCategoryInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'modelCategory.label', default: 'ModelCategory'), params.id])}"
                redirect(action: "list")
            }
            else { return [ modelCategoryInstance : modelCategoryInstance ] }
          }
          xml {
              if(params.id && ModelCategory.get(params.id)) {
                  def c = ModelCategory.get(params.id)
                  render c as XML
              }
              else {
                  def all = ModelCategory.get(params)
                  render all as XML
              }
          }
          json {
              if(params.id && ModelCategory.get(params.id)) {
                  def c = ModelCategory.get(params.id)
				  response.status = 200
				  if(params.callback) {
					  render "${params.callback}(${c as JSON})"
				  }
				  else {
					  render "${c as JSON}"
				  }
              }
              else {
                  def all = ModelCategory.get(params)
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
        def modelCategoryInstance = ModelCategory.get(params.id)
        if (!modelCategoryInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'modelCategory.label', default: 'ModelCategory'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [modelCategoryInstance: modelCategoryInstance]
        }
    }

    def update = {
        def modelCategoryInstance = ModelCategory.get(params.id)
        modelCategoryInstance.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(modelCategoryInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(modelCategoryInstance.version > version) {
							
							modelCategoryInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'modelCategory.label', default: 'ModelCategory')] as Object[], "Another user has updated this ModelCategory while you were editing")
							render(view:"edit", model:[modelCategoryInstance:modelCategoryInstance])
							return
						}
					}
					modelCategoryInstance.properties = params
					if(!modelCategoryInstance.hasErrors() && modelCategoryInstance.save(flush: true)) {
						flash.message = "${message(code: 'default.updated.message', args: [message(code: 'modelCategory.label', default: 'ModelCategory'), modelCategoryInstance.id])}"
						redirect(action: "show", id:modelCategoryInstance.id)
					}
					else {
						render(view: "edit", model:[modelCategoryInstance:modelCategoryInstance])
					}
				}
				else {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'modelCategory.label', default: 'ModelCategory'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(modelCategoryInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(modelCategoryInstance.version > version) {
							render "ModelCategory has been updated by another user" as XML
						}
					}
					modelCategoryInstance.properties = params
					if(!modelCategoryInstance.hasErrors() && modelCategoryInstance.save(flush: true)) {
						modelCategoryInstance as XML
					}
					else {
						render "ModelCategory not valid" as XML
					}
				}
				else {
					render "ModelCategory not found with id ${params.id}" as XML
				}
			}
			json {
				if(modelCategoryInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(modelCategoryInstance.version > version) {
							response.status = 409
						}
					}
					modelCategoryInstance.properties = params
					if(!modelCategoryInstance.hasErrors() && modelCategoryInstance.save(flush: true)) {
						response.status = 200
						if(params.callback) {
							render "${params.callback}(${modelCategoryInstance as JSON})"
						}
						else {
							render "${modelCategoryInstance as JSON}"
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
        def modelCategoryInstance = ModelCategory.get(params.id)
		modelCategoryInstance.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(modelCategoryInstance) {
					try {
						modelCategoryInstance.deleteFlag = "Y";
						modelCategoryInstance.save(flush:true);
                        flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'modelCategory.label', default: 'ModelCategory'), params.id])}"
                        redirect(action: "list")
                    }
                    catch (org.springframework.dao.DataIntegrityViolationException e) {
                        flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'modelCategory.label', default: 'ModelCategory'), params.id])}"
                        redirect(action: "show", id: params.id)
                    }
                }
                else {
                    flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'modelCategory.label', default: 'ModelCategory'), params.id])}"
                    redirect(action: "list")
                }
			}
			xml {
				if(params.id && modelCategoryInstance) {
					try {
						modelCategoryInstance.deleteFlag = "Y";
						modelCategoryInstance.save(flush:true);
						render "ModelCategory ${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "ModelCategory ${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "ModelCategory not found with id ${params.id}" as XML
				}
			}
			json {
				if(params.id && modelCategoryInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(modelCategoryInstance.version > version) {
							response.status = 409
						}
					}
					try {
						modelCategoryInstance.deleteFlag = "Y";
						modelCategoryInstance.save(flush:true)
						response.status = 204
						if(params.callback) {
							render "${params.callback}(${modelCategoryInstance as JSON})"
						}
						else {
							render "${modelCategoryInstance as JSON}"
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
		def modelCategoryInstance = ModelCategory.get(params.id)
		withFormat {
			html {
				if(modelCategoryInstance) {
					try {
						modelCategoryInstance.delete(flush: true)
						flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'modelCategory.label', default: 'ModelCategory'), params.id])}"
						redirect(action: "list")
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'modelCategory.label', default: 'ModelCategory'), params.id])}"
						redirect(action: "show", id: params.id)
					}
				}
				else {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'modelCategory.label', default: 'ModelCategory'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(params.id && modelCategoryInstance) {
					try {
						modelCategoryInstance.delete(flush:true)
						render "ModelCategory ${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "ModelCategory ${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "ModelCategory not found with id ${params.id}" as XML
				}
			}
			json {
				if(params.id && modelCategoryInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(modelCategoryInstance.version > version) {
							response.status = 409
						}
					}
					try {
						modelCategoryInstance.delete(flush:true)
						response.status = 204
						if(params.callback) {
							render "${params.callback}(${modelCategoryInstance as JSON})"
						}
						else {
							render "${modelCategoryInstance as JSON}"
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
		def listData = ModelCategory.findAll(params)
		def totalRecord=ModelCategory.count()

		
		listData.each{list <<[it.id,it.name,it.createdBy,it.dateCreated,it.deleteFlag]}

		def data = ["iTotalRecords": totalRecord,"iTotalDisplayRecords": totalRecord,"aaData":list]
		render data as JSON
	}

	String getColumnToField (String index)
	{
		if ( index == '0' ) return "id";
					else if ( index == '1' ) return "name";
					else if ( index == '2' ) return "createdBy";
					else if ( index == '3' ) return "dateCreated";
					else if ( index == '4' ) return "deleteFlag";
					
	}
	
	private def sendValidationFailedResponse(callback, modelCategoryInstance, status)
	{
		response.status = status
		if(callback) {
			render contentType: "application/json", callback({
				errors {
					modelCategoryInstance?.errors?.fieldErrors?.each {
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
					modelCategoryInstance?.errors?.fieldErrors?.each {
						err ->
							field(err.field)
							message(g.message(error:err))
					}
				}
			}
		}
	}
}
