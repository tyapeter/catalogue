package com.teravin.catalogue

import grails.converters.XML
import grails.converters.JSON

class MaterialCategoryController {

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
				[materialCategoryInstanceList: MaterialCategory.list(params), materialCategoryInstanceTotal: MaterialCategory.count()]
			}
			xml {
				render MaterialCategory.list( params ) as XML
			}
			json {
				response.status = 200
				if(params.callback) {
					render "${params.callback}(${MaterialCategory.list( params ) as JSON})"
				}
				else {
					render "${MaterialCategory.list( params ) as JSON}"
				}
			}
		}
    }

    def create = {
        def materialCategoryInstance = new MaterialCategory()
        materialCategoryInstance.properties = params
        return [materialCategoryInstance: materialCategoryInstance]
    }

    def save = {
        def materialCategoryInstance = new MaterialCategory(params)
        materialCategoryInstance.createdBy = springSecurityService.principal.username
        withFormat {
			html {
                if (materialCategoryInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.created.message', args: [message(code: 'materialCategory.label', default: 'MaterialCategory'), materialCategoryInstance.id])}"
                    redirect(action: "show", id: materialCategoryInstance.id)
                }
                else {
                    render(view: "create", model: [materialCategoryInstance: materialCategoryInstance])
                }
			}
			xml {
				if(materialCategoryInstance.save(flush: true)) {
					materialCategoryInstance as XML
				}
				else {
					render "MaterialCategory not valid" as XML
				}
			}
			json {
				if(materialCategoryInstance.save(flush: true)) {
					response.status = 201
					if(params.callback) {
						render "${params.callback}(${materialCategoryInstance as JSON})"
					}
					else {
						render "${materialCategoryInstance as JSON}"
					}
				}
				else {
					sendValidationFailedResponse(params.callback,materialCategoryInstance,400)
				}
			}
		}
    }

    def show = {   
      withFormat {
        html {
            def materialCategoryInstance = MaterialCategory.get( params.id )
            if(!materialCategoryInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'materialCategory.label', default: 'MaterialCategory'), params.id])}"
                redirect(action: "list")
            }
            else { return [ materialCategoryInstance : materialCategoryInstance ] }
          }
          xml {
              if(params.id && MaterialCategory.get(params.id)) {
                  def c = MaterialCategory.get(params.id)
                  render c as XML
              }
              else {
                  def all = MaterialCategory.get(params)
                  render all as XML
              }
          }
          json {
              if(params.id && MaterialCategory.get(params.id)) {
                  def c = MaterialCategory.get(params.id)
				  response.status = 200
				  if(params.callback) {
					  render "${params.callback}(${c as JSON})"
				  }
				  else {
					  render "${c as JSON}"
				  }
              }
              else {
                  def all = MaterialCategory.get(params)
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
        def materialCategoryInstance = MaterialCategory.get(params.id)
        if (!materialCategoryInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'materialCategory.label', default: 'MaterialCategory'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [materialCategoryInstance: materialCategoryInstance]
        }
    }

    def update = {
        def materialCategoryInstance = MaterialCategory.get(params.id)
        materialCategoryInstance.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(materialCategoryInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(materialCategoryInstance.version > version) {
							
							materialCategoryInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'materialCategory.label', default: 'MaterialCategory')] as Object[], "Another user has updated this MaterialCategory while you were editing")
							render(view:"edit", model:[materialCategoryInstance:materialCategoryInstance])
							return
						}
					}
					materialCategoryInstance.properties = params
					if(!materialCategoryInstance.hasErrors() && materialCategoryInstance.save(flush: true)) {
						flash.message = "${message(code: 'default.updated.message', args: [message(code: 'materialCategory.label', default: 'MaterialCategory'), materialCategoryInstance.id])}"
						redirect(action: "show", id:materialCategoryInstance.id)
					}
					else {
						render(view: "edit", model:[materialCategoryInstance:materialCategoryInstance])
					}
				}
				else {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'materialCategory.label', default: 'MaterialCategory'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(materialCategoryInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(materialCategoryInstance.version > version) {
							render "MaterialCategory has been updated by another user" as XML
						}
					}
					materialCategoryInstance.properties = params
					if(!materialCategoryInstance.hasErrors() && materialCategoryInstance.save(flush: true)) {
						materialCategoryInstance as XML
					}
					else {
						render "MaterialCategory not valid" as XML
					}
				}
				else {
					render "MaterialCategory not found with id ${params.id}" as XML
				}
			}
			json {
				if(materialCategoryInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(materialCategoryInstance.version > version) {
							response.status = 409
						}
					}
					materialCategoryInstance.properties = params
					if(!materialCategoryInstance.hasErrors() && materialCategoryInstance.save(flush: true)) {
						response.status = 200
						if(params.callback) {
							render "${params.callback}(${materialCategoryInstance as JSON})"
						}
						else {
							render "${materialCategoryInstance as JSON}"
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
        def materialCategoryInstance = MaterialCategory.get(params.id)
		materialCategoryInstance.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(materialCategoryInstance) {
					try {
						materialCategoryInstance.deleteFlag = "Y";
						materialCategoryInstance.save(flush:true);
                        flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'materialCategory.label', default: 'MaterialCategory'), params.id])}"
                        redirect(action: "list")
                    }
                    catch (org.springframework.dao.DataIntegrityViolationException e) {
                        flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'materialCategory.label', default: 'MaterialCategory'), params.id])}"
                        redirect(action: "show", id: params.id)
                    }
                }
                else {
                    flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'materialCategory.label', default: 'MaterialCategory'), params.id])}"
                    redirect(action: "list")
                }
			}
			xml {
				if(params.id && materialCategoryInstance) {
					try {
						materialCategoryInstance.deleteFlag = "Y";
						materialCategoryInstance.save(flush:true);
						render "MaterialCategory ${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "MaterialCategory ${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "MaterialCategory not found with id ${params.id}" as XML
				}
			}
			json {
				if(params.id && materialCategoryInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(materialCategoryInstance.version > version) {
							response.status = 409
						}
					}
					try {
						materialCategoryInstance.deleteFlag = "Y";
						materialCategoryInstance.save(flush:true)
						response.status = 204
						if(params.callback) {
							render "${params.callback}(${materialCategoryInstance as JSON})"
						}
						else {
							render "${materialCategoryInstance as JSON}"
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
		def materialCategoryInstance = MaterialCategory.get(params.id)
		withFormat {
			html {
				if(materialCategoryInstance) {
					try {
						materialCategoryInstance.delete(flush: true)
						flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'materialCategory.label', default: 'MaterialCategory'), params.id])}"
						redirect(action: "list")
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'materialCategory.label', default: 'MaterialCategory'), params.id])}"
						redirect(action: "show", id: params.id)
					}
				}
				else {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'materialCategory.label', default: 'MaterialCategory'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(params.id && materialCategoryInstance) {
					try {
						materialCategoryInstance.delete(flush:true)
						render "MaterialCategory ${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "MaterialCategory ${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "MaterialCategory not found with id ${params.id}" as XML
				}
			}
			json {
				if(params.id && materialCategoryInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(materialCategoryInstance.version > version) {
							response.status = 409
						}
					}
					try {
						materialCategoryInstance.delete(flush:true)
						response.status = 204
						if(params.callback) {
							render "${params.callback}(${materialCategoryInstance as JSON})"
						}
						else {
							render "${materialCategoryInstance as JSON}"
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
		def listData = MaterialCategory.findAll(params)
		def totalRecord=MaterialCategory.count()

		
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
	
	private def sendValidationFailedResponse(callback, materialCategoryInstance, status)
	{
		response.status = status
		if(callback) {
			render contentType: "application/json", callback({
				errors {
					materialCategoryInstance?.errors?.fieldErrors?.each {
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
					materialCategoryInstance?.errors?.fieldErrors?.each {
						err ->
							field(err.field)
							message(g.message(error:err))
					}
				}
			}
		}
	}
}
