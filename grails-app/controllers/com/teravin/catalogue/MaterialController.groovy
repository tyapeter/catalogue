package com.teravin.catalogue

import grails.converters.JSON
import grails.converters.XML

class MaterialController {

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
				[materialInstanceList: Material.list(params), materialInstanceTotal: Material.count()]
			}
			xml {
				render Material.list( params ) as XML
			}
			json {
				response.status = 200
				if(params.callback) {
					render "${params.callback}(${Material.list( params ) as JSON})"
				}
				else {
					render "${Material.list( params ) as JSON}"
				}
			}
		}
    }

    def create = {
        def materialInstance = new Material()
        materialInstance.properties = params
        return [materialInstance: materialInstance]
    }

    def save = {
        def materialInstance = new Material(params)
        materialInstance.createdBy = springSecurityService.principal.username
        withFormat {
			html {
                if (materialInstance.save(flush: true,failOnError:true)) {
                    flash.message = "${message(code: 'default.created.message', args: [message(code: 'material.label', default: 'Material'), materialInstance.id])}"
                    redirect(action: "show", id: materialInstance.id)
                }
                else {
                    render(view: "create", model: [materialInstance: materialInstance])
                }
			}
			xml {
				if(materialInstance.save(flush: true,failOnError:true)) {
					materialInstance as XML
				}
				else {
					render "Material not valid" as XML
				}
			}
			json {
				if(materialInstance.save(flush: true,failOnError:true)) {
					response.status = 201
					if(params.callback) {
						render "${params.callback}(${materialInstance as JSON})"
					}
					else {
						render "${materialInstance as JSON}"
					}
				}
				else {
					sendValidationFailedResponse(params.callback,materialInstance,400)
				}
			}
		}
    }

    def show = {   
      withFormat {
        html {
            def materialInstance = Material.get( params.id )
            if(!materialInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'material.label', default: 'Material'), params.id])}"
                redirect(action: "list")
            }
            else { return [ materialInstance : materialInstance ] }
          }
          xml {
              if(params.id && Material.get(params.id)) {
                  def c = Material.get(params.id)
                  render c as XML
              }
              else {
                  def all = Material.get(params)
                  render all as XML
              }
          }
          json {
              if(params.id && Material.get(params.id)) {
                  def c = Material.get(params.id)
				  response.status = 200
				  if(params.callback) {
					  render "${params.callback}(${c as JSON})"
				  }
				  else {
					  render "${c as JSON}"
				  }
              }
              else {
                  def all = Material.get(params)
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
        def materialInstance = Material.get(params.id)
        if (!materialInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'material.label', default: 'Material'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [materialInstance: materialInstance]
        }
    }

    def update = {
        def materialInstance = Material.get(params.id)
        materialInstance.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(materialInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(materialInstance.version > version) {
							
							materialInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'material.label', default: 'Material')] as Object[], "Another user has updated this Material while you were editing")
							render(view:"edit", model:[materialInstance:materialInstance])
							return
						}
					}
					materialInstance.properties = params
					if(!materialInstance.hasErrors() && materialInstance.save(flush: true)) {
						flash.message = "${message(code: 'default.updated.message', args: [message(code: 'material.label', default: 'Material'), materialInstance.id])}"
						redirect(action: "show", id:materialInstance.id)
					}
					else {
						render(view: "edit", model:[materialInstance:materialInstance])
					}
				}
				else {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'material.label', default: 'Material'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(materialInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(materialInstance.version > version) {
							render "Material has been updated by another user" as XML
						}
					}
					materialInstance.properties = params
					if(!materialInstance.hasErrors() && materialInstance.save(flush: true)) {
						materialInstance as XML
					}
					else {
						render "Material not valid" as XML
					}
				}
				else {
					render "Material not found with id ${params.id}" as XML
				}
			}
			json {
				if(materialInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(materialInstance.version > version) {
							response.status = 409
						}
					}
					materialInstance.properties = params
					if(!materialInstance.hasErrors() && materialInstance.save(flush: true)) {
						response.status = 200
						if(params.callback) {
							render "${params.callback}(${materialInstance as JSON})"
						}
						else {
							render "${materialInstance as JSON}"
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
        def materialInstance = Material.get(params.id)
		materialInstance.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(materialInstance) {
					try {
						materialInstance.deleteFlag = "Y";
						materialInstance.save(flush:true);
                        flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'material.label', default: 'Material'), params.id])}"
                        redirect(action: "list")
                    }
                    catch (org.springframework.dao.DataIntegrityViolationException e) {
                        flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'material.label', default: 'Material'), params.id])}"
                        redirect(action: "show", id: params.id)
                    }
                }
                else {
                    flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'material.label', default: 'Material'), params.id])}"
                    redirect(action: "list")
                }
			}
			xml {
				if(params.id && materialInstance) {
					try {
						materialInstance.deleteFlag = "Y";
						materialInstance.save(flush:true);
						render "Material ${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "Material ${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "Material not found with id ${params.id}" as XML
				}
			}
			json {
				if(params.id && materialInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(materialInstance.version > version) {
							response.status = 409
						}
					}
					try {
						materialInstance.deleteFlag = "Y";
						materialInstance.save(flush:true)
						response.status = 204
						if(params.callback) {
							render "${params.callback}(${materialInstance as JSON})"
						}
						else {
							render "${materialInstance as JSON}"
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
		def materialInstance = Material.get(params.id)
		withFormat {
			html {
				if(materialInstance) {
					try {
						materialInstance.delete(flush: true)
						flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'material.label', default: 'Material'), params.id])}"
						redirect(action: "list")
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'material.label', default: 'Material'), params.id])}"
						redirect(action: "show", id: params.id)
					}
				}
				else {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'material.label', default: 'Material'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(params.id && materialInstance) {
					try {
						materialInstance.delete(flush:true)
						render "Material ${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "Material ${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "Material not found with id ${params.id}" as XML
				}
			}
			json {
				if(params.id && materialInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(materialInstance.version > version) {
							response.status = 409
						}
					}
					try {
						materialInstance.delete(flush:true)
						response.status = 204
						if(params.callback) {
							render "${params.callback}(${materialInstance as JSON})"
						}
						else {
							render "${materialInstance as JSON}"
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
		def listData = Material.findAll(params)
		def totalRecord=Material.count()

		
		listData.each{list <<[it.id,it.name,it.createdBy,it.dateCreated,it.deleteFlag,it.idxx]}

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
					else if ( index == '5' ) return "idxx";
					
	}
	
	private def sendValidationFailedResponse(callback, materialInstance, status)
	{
		response.status = status
		if(callback) {
			render contentType: "application/json", callback({
				errors {
					materialInstance?.errors?.fieldErrors?.each {
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
					materialInstance?.errors?.fieldErrors?.each {
						err ->
							field(err.field)
							message(g.message(error:err))
					}
				}
			}
		}
	}
}
