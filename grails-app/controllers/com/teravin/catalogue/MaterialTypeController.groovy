package com.teravin.catalogue

import grails.converters.XML
import grails.converters.JSON

class MaterialTypeController {

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
				[materialTypeInstanceList: MaterialType.list(params), materialTypeInstanceTotal: MaterialType.count()]
			}
			xml {
				render MaterialType.list( params ) as XML
			}
			json {
				response.status = 200
				if(params.callback) {
					render "${params.callback}(${MaterialType.list( params ) as JSON})"
				}
				else {
					render "${MaterialType.list( params ) as JSON}"
				}
			}
		}
    }

    def create = {
        def materialTypeInstance = new MaterialType()
        materialTypeInstance.properties = params
        return [materialTypeInstance: materialTypeInstance]
    }

    def save = {
        def materialTypeInstance = new MaterialType(params)
        materialTypeInstance.createdBy = springSecurityService.principal.username
        withFormat {
			html {
                if (materialTypeInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.created.message', args: [message(code: 'materialType.label', default: 'MaterialType'), materialTypeInstance.id])}"
                    redirect(action: "show", id: materialTypeInstance.id)
                }
                else {
                    render(view: "create", model: [materialTypeInstance: materialTypeInstance])
                }
			}
			xml {
				if(materialTypeInstance.save(flush: true)) {
					materialTypeInstance as XML
				}
				else {
					render "MaterialType not valid" as XML
				}
			}
			json {
				if(materialTypeInstance.save(flush: true)) {
					response.status = 201
					if(params.callback) {
						render "${params.callback}(${materialTypeInstance as JSON})"
					}
					else {
						render "${materialTypeInstance as JSON}"
					}
				}
				else {
					sendValidationFailedResponse(params.callback,materialTypeInstance,400)
				}
			}
		}
    }

    def show = {   
      withFormat {
        html {
            def materialTypeInstance = MaterialType.get( params.id )
            if(!materialTypeInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'materialType.label', default: 'MaterialType'), params.id])}"
                redirect(action: "list")
            }
            else { return [ materialTypeInstance : materialTypeInstance ] }
          }
          xml {
              if(params.id && MaterialType.get(params.id)) {
                  def c = MaterialType.get(params.id)
                  render c as XML
              }
              else {
                  def all = MaterialType.get(params)
                  render all as XML
              }
          }
          json {
              if(params.id && MaterialType.get(params.id)) {
                  def c = MaterialType.get(params.id)
				  response.status = 200
				  if(params.callback) {
					  render "${params.callback}(${c as JSON})"
				  }
				  else {
					  render "${c as JSON}"
				  }
              }
              else {
                  def all = MaterialType.get(params)
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
        def materialTypeInstance = MaterialType.get(params.id)
        if (!materialTypeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'materialType.label', default: 'MaterialType'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [materialTypeInstance: materialTypeInstance]
        }
    }

    def update = {
        def materialTypeInstance = MaterialType.get(params.id)
        materialTypeInstance.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(materialTypeInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(materialTypeInstance.version > version) {
							
							materialTypeInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'materialType.label', default: 'MaterialType')] as Object[], "Another user has updated this MaterialType while you were editing")
							render(view:"edit", model:[materialTypeInstance:materialTypeInstance])
							return
						}
					}
					materialTypeInstance.properties = params
					if(!materialTypeInstance.hasErrors() && materialTypeInstance.save(flush: true)) {
						flash.message = "${message(code: 'default.updated.message', args: [message(code: 'materialType.label', default: 'MaterialType'), materialTypeInstance.id])}"
						redirect(action: "show", id:materialTypeInstance.id)
					}
					else {
						render(view: "edit", model:[materialTypeInstance:materialTypeInstance])
					}
				}
				else {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'materialType.label', default: 'MaterialType'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(materialTypeInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(materialTypeInstance.version > version) {
							render "MaterialType has been updated by another user" as XML
						}
					}
					materialTypeInstance.properties = params
					if(!materialTypeInstance.hasErrors() && materialTypeInstance.save(flush: true)) {
						materialTypeInstance as XML
					}
					else {
						render "MaterialType not valid" as XML
					}
				}
				else {
					render "MaterialType not found with id ${params.id}" as XML
				}
			}
			json {
				if(materialTypeInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(materialTypeInstance.version > version) {
							response.status = 409
						}
					}
					materialTypeInstance.properties = params
					if(!materialTypeInstance.hasErrors() && materialTypeInstance.save(flush: true)) {
						response.status = 200
						if(params.callback) {
							render "${params.callback}(${materialTypeInstance as JSON})"
						}
						else {
							render "${materialTypeInstance as JSON}"
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
        def materialTypeInstance = MaterialType.get(params.id)
		materialTypeInstance.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(materialTypeInstance) {
					try {
						materialTypeInstance.deleteFlag = "Y";
						materialTypeInstance.save(flush:true);
                        flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'materialType.label', default: 'MaterialType'), params.id])}"
                        redirect(action: "list")
                    }
                    catch (org.springframework.dao.DataIntegrityViolationException e) {
                        flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'materialType.label', default: 'MaterialType'), params.id])}"
                        redirect(action: "show", id: params.id)
                    }
                }
                else {
                    flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'materialType.label', default: 'MaterialType'), params.id])}"
                    redirect(action: "list")
                }
			}
			xml {
				if(params.id && materialTypeInstance) {
					try {
						materialTypeInstance.deleteFlag = "Y";
						materialTypeInstance.save(flush:true);
						render "MaterialType ${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "MaterialType ${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "MaterialType not found with id ${params.id}" as XML
				}
			}
			json {
				if(params.id && materialTypeInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(materialTypeInstance.version > version) {
							response.status = 409
						}
					}
					try {
						materialTypeInstance.deleteFlag = "Y";
						materialTypeInstance.save(flush:true)
						response.status = 204
						if(params.callback) {
							render "${params.callback}(${materialTypeInstance as JSON})"
						}
						else {
							render "${materialTypeInstance as JSON}"
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
		def materialTypeInstance = MaterialType.get(params.id)
		withFormat {
			html {
				if(materialTypeInstance) {
					try {
						materialTypeInstance.delete(flush: true)
						flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'materialType.label', default: 'MaterialType'), params.id])}"
						redirect(action: "list")
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'materialType.label', default: 'MaterialType'), params.id])}"
						redirect(action: "show", id: params.id)
					}
				}
				else {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'materialType.label', default: 'MaterialType'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(params.id && materialTypeInstance) {
					try {
						materialTypeInstance.delete(flush:true)
						render "MaterialType ${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "MaterialType ${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "MaterialType not found with id ${params.id}" as XML
				}
			}
			json {
				if(params.id && materialTypeInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(materialTypeInstance.version > version) {
							response.status = 409
						}
					}
					try {
						materialTypeInstance.delete(flush:true)
						response.status = 204
						if(params.callback) {
							render "${params.callback}(${materialTypeInstance as JSON})"
						}
						else {
							render "${materialTypeInstance as JSON}"
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
		def listData = MaterialType.findAll(params)
		def totalRecord=MaterialType.count()

		
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
	
	private def sendValidationFailedResponse(callback, materialTypeInstance, status)
	{
		response.status = status
		if(callback) {
			render contentType: "application/json", callback({
				errors {
					materialTypeInstance?.errors?.fieldErrors?.each {
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
					materialTypeInstance?.errors?.fieldErrors?.each {
						err ->
							field(err.field)
							message(g.message(error:err))
					}
				}
			}
		}
	}
}
