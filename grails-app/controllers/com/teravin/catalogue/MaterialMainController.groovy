package com.teravin.catalogue

import grails.converters.XML
import grails.converters.JSON

class MaterialMainController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def springSecurityService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		params.sort = "idx"
		params.order = "asc"
		def materialMainList = MaterialMain.createCriteria().list(params){
			eq("deleteFlag","N")
			maxResults(params.max)
			
		}
        withFormat {
			html {
				[materialMainInstanceList: materialMainList, materialMainInstanceTotal: materialMainList.getTotalCount()]
			}
			xml {
				render MaterialMain.list( params ) as XML
			}
			json {
				response.status = 200
				if(params.callback) {
					render "${params.callback}(${MaterialMain.list( params ) as JSON})"
				}
				else {
					render "${MaterialMain.list( params ) as JSON}"
				}
			}
		}
    }

    def create = {
        def materialMainInstance = new MaterialMain()
        materialMainInstance.properties = params
        return [materialMainInstance: materialMainInstance]
    }

    def save = {
        def materialMainInstance = new MaterialMain(params)
        materialMainInstance.createdBy = springSecurityService.principal.username
        withFormat {
			html {
                if (materialMainInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.created.message', args: [message(code: 'materialMain.label', default: 'MaterialMain'), materialMainInstance.id])}"
                    redirect(action: "show", id: materialMainInstance.id)
                }
                else {
                    render(view: "create", model: [materialMainInstance: materialMainInstance])
                }
			}
			xml {
				if(materialMainInstance.save(flush: true)) {
					materialMainInstance as XML
				}
				else {
					render "MaterialMain not valid" as XML
				}
			}
			json {
				if(materialMainInstance.save(flush: true)) {
					response.status = 201
					if(params.callback) {
						render "${params.callback}(${materialMainInstance as JSON})"
					}
					else {
						render "${materialMainInstance as JSON}"
					}
				}
				else {
					sendValidationFailedResponse(params.callback,materialMainInstance,400)
				}
			}
		}
    }

    def show = {   
      withFormat {
        html {
            def materialMainInstance = MaterialMain.get( params.id )
            if(!materialMainInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'materialMain.label', default: 'MaterialMain'), params.id])}"
                redirect(action: "list")
            }
            else { return [ materialMainInstance : materialMainInstance ] }
          }
          xml {
              if(params.id && MaterialMain.get(params.id)) {
                  def c = MaterialMain.get(params.id)
                  render c as XML
              }
              else {
                  def all = MaterialMain.get(params)
                  render all as XML
              }
          }
          json {
              if(params.id && MaterialMain.get(params.id)) {
                  def c = MaterialMain.get(params.id)
				  response.status = 200
				  if(params.callback) {
					  render "${params.callback}(${c as JSON})"
				  }
				  else {
					  render "${c as JSON}"
				  }
              }
              else {
                  def all = MaterialMain.get(params)
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
        def materialMainInstance = MaterialMain.get(params.id)
        if (!materialMainInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'materialMain.label', default: 'MaterialMain'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [materialMainInstance: materialMainInstance]
        }
    }

    def update = {
        def materialMainInstance = MaterialMain.get(params.id)
        materialMainInstance.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(materialMainInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(materialMainInstance.version > version) {
							
							materialMainInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'materialMain.label', default: 'MaterialMain')] as Object[], "Another user has updated this MaterialMain while you were editing")
							render(view:"edit", model:[materialMainInstance:materialMainInstance])
							return
						}
					}
					materialMainInstance.properties = params
					if(!materialMainInstance.hasErrors() && materialMainInstance.save(flush: true)) {
						flash.message = "${message(code: 'default.updated.message', args: [message(code: 'materialMain.label', default: 'MaterialMain'), materialMainInstance.id])}"
						redirect(action: "show", id:materialMainInstance.id)
					}
					else {
						render(view: "edit", model:[materialMainInstance:materialMainInstance])
					}
				}
				else {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'materialMain.label', default: 'MaterialMain'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(materialMainInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(materialMainInstance.version > version) {
							render "MaterialMain has been updated by another user" as XML
						}
					}
					materialMainInstance.properties = params
					if(!materialMainInstance.hasErrors() && materialMainInstance.save(flush: true)) {
						materialMainInstance as XML
					}
					else {
						render "MaterialMain not valid" as XML
					}
				}
				else {
					render "MaterialMain not found with id ${params.id}" as XML
				}
			}
			json {
				if(materialMainInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(materialMainInstance.version > version) {
							response.status = 409
						}
					}
					materialMainInstance.properties = params
					if(!materialMainInstance.hasErrors() && materialMainInstance.save(flush: true)) {
						response.status = 200
						if(params.callback) {
							render "${params.callback}(${materialMainInstance as JSON})"
						}
						else {
							render "${materialMainInstance as JSON}"
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
        def materialMainInstance = MaterialMain.get(params.id)
		materialMainInstance.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(materialMainInstance) {
					try {
						materialMainInstance.deleteFlag = "Y";
						materialMainInstance.save(flush:true);
                        flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'materialMain.label', default: 'MaterialMain'), params.id])}"
                        redirect(action: "list")
                    }
                    catch (org.springframework.dao.DataIntegrityViolationException e) {
                        flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'materialMain.label', default: 'MaterialMain'), params.id])}"
                        redirect(action: "show", id: params.id)
                    }
                }
                else {
                    flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'materialMain.label', default: 'MaterialMain'), params.id])}"
                    redirect(action: "list")
                }
			}
			xml {
				if(params.id && materialMainInstance) {
					try {
						materialMainInstance.deleteFlag = "Y";
						materialMainInstance.save(flush:true);
						render "MaterialMain ${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "MaterialMain ${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "MaterialMain not found with id ${params.id}" as XML
				}
			}
			json {
				if(params.id && materialMainInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(materialMainInstance.version > version) {
							response.status = 409
						}
					}
					try {
						materialMainInstance.deleteFlag = "Y";
						materialMainInstance.save(flush:true)
						response.status = 204
						if(params.callback) {
							render "${params.callback}(${materialMainInstance as JSON})"
						}
						else {
							render "${materialMainInstance as JSON}"
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
		def materialMainInstance = MaterialMain.get(params.id)
		withFormat {
			html {
				if(materialMainInstance) {
					try {
						materialMainInstance.delete(flush: true)
						flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'materialMain.label', default: 'MaterialMain'), params.id])}"
						redirect(action: "list")
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'materialMain.label', default: 'MaterialMain'), params.id])}"
						redirect(action: "show", id: params.id)
					}
				}
				else {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'materialMain.label', default: 'MaterialMain'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(params.id && materialMainInstance) {
					try {
						materialMainInstance.delete(flush:true)
						render "MaterialMain ${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "MaterialMain ${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "MaterialMain not found with id ${params.id}" as XML
				}
			}
			json {
				if(params.id && materialMainInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(materialMainInstance.version > version) {
							response.status = 409
						}
					}
					try {
						materialMainInstance.delete(flush:true)
						response.status = 204
						if(params.callback) {
							render "${params.callback}(${materialMainInstance as JSON})"
						}
						else {
							render "${materialMainInstance as JSON}"
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
		def listData = MaterialMain.findAll(params)
		def totalRecord=MaterialMain.count()

		
		listData.each{list <<[it.id,it.name,it.code,it.createdBy,it.dateCreated,it.deleteFlag]}

		def data = ["iTotalRecords": totalRecord,"iTotalDisplayRecords": totalRecord,"aaData":list]
		render data as JSON
	}

	String getColumnToField (String index)
	{
		if ( index == '0' ) return "id";
					else if ( index == '1' ) return "name";
					else if ( index == '2' ) return "code";
					else if ( index == '3' ) return "createdBy";
					else if ( index == '4' ) return "dateCreated";
					else if ( index == '5' ) return "deleteFlag";
					
	}
	
	private def sendValidationFailedResponse(callback, materialMainInstance, status)
	{
		response.status = status
		if(callback) {
			render contentType: "application/json", callback({
				errors {
					materialMainInstance?.errors?.fieldErrors?.each {
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
					materialMainInstance?.errors?.fieldErrors?.each {
						err ->
							field(err.field)
							message(g.message(error:err))
					}
				}
			}
		}
	}
}
