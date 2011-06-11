package com.teravin.catalogue.maintenance

import grails.converters.XML
import grails.converters.JSON

class UnitTypeController {

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
				[unitTypeInstanceList: UnitType.list(params), unitTypeInstanceTotal: UnitType.count()]
			}
			xml {
				render UnitType.list( params ) as XML
			}
			json {
				response.status = 200
				if(params.callback) {
					render "${params.callback}(${UnitType.list( params ) as JSON})"
				}
				else {
					render "${UnitType.list( params ) as JSON}"
				}
			}
		}
    }

    def create = {
        def unitTypeInstance = new UnitType()
        unitTypeInstance.properties = params
        return [unitTypeInstance: unitTypeInstance]
    }

    def save = {
        def unitTypeInstance = new UnitType(params)
        unitTypeInstance.createdBy = springSecurityService.principal.username
        withFormat {
			html {
                if (unitTypeInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.created.message', args: [message(code: 'unitType.label', default: 'UnitType'), unitTypeInstance.id])}"
                    redirect(action: "show", id: unitTypeInstance.id)
                }
                else {
                    render(view: "create", model: [unitTypeInstance: unitTypeInstance])
                }
			}
			xml {
				if(unitTypeInstance.save(flush: true)) {
					unitTypeInstance as XML
				}
				else {
					render "UnitType not valid" as XML
				}
			}
			json {
				if(unitTypeInstance.save(flush: true)) {
					response.status = 201
					if(params.callback) {
						render "${params.callback}(${unitTypeInstance as JSON})"
					}
					else {
						render "${unitTypeInstance as JSON}"
					}
				}
				else {
					sendValidationFailedResponse(params.callback,unitTypeInstance,400)
				}
			}
		}
    }

    def show = {   
      withFormat {
        html {
            def unitTypeInstance = UnitType.get( params.id )
            if(!unitTypeInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'unitType.label', default: 'UnitType'), params.id])}"
                redirect(action: "list")
            }
            else { return [ unitTypeInstance : unitTypeInstance ] }
          }
          xml {
              if(params.id && UnitType.get(params.id)) {
                  def c = UnitType.get(params.id)
                  render c as XML
              }
              else {
                  def all = UnitType.get(params)
                  render all as XML
              }
          }
          json {
              if(params.id && UnitType.get(params.id)) {
                  def c = UnitType.get(params.id)
				  response.status = 200
				  if(params.callback) {
					  render "${params.callback}(${c as JSON})"
				  }
				  else {
					  render "${c as JSON}"
				  }
              }
              else {
                  def all = UnitType.get(params)
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
        def unitTypeInstance = UnitType.get(params.id)
        if (!unitTypeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'unitType.label', default: 'UnitType'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [unitTypeInstance: unitTypeInstance]
        }
    }

    def update = {
        def unitTypeInstance = UnitType.get(params.id)
        unitTypeInstance.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(unitTypeInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(unitTypeInstance.version > version) {
							
							unitTypeInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'unitType.label', default: 'UnitType')] as Object[], "Another user has updated this UnitType while you were editing")
							render(view:"edit", model:[unitTypeInstance:unitTypeInstance])
							return
						}
					}
					unitTypeInstance.properties = params
					if(!unitTypeInstance.hasErrors() && unitTypeInstance.save(flush: true)) {
						flash.message = "${message(code: 'default.updated.message', args: [message(code: 'unitType.label', default: 'UnitType'), unitTypeInstance.id])}"
						redirect(action: "show", id:unitTypeInstance.id)
					}
					else {
						render(view: "edit", model:[unitTypeInstance:unitTypeInstance])
					}
				}
				else {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'unitType.label', default: 'UnitType'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(unitTypeInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(unitTypeInstance.version > version) {
							render "UnitType has been updated by another user" as XML
						}
					}
					unitTypeInstance.properties = params
					if(!unitTypeInstance.hasErrors() && unitTypeInstance.save(flush: true)) {
						unitTypeInstance as XML
					}
					else {
						render "UnitType not valid" as XML
					}
				}
				else {
					render "UnitType not found with id ${params.id}" as XML
				}
			}
			json {
				if(unitTypeInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(unitTypeInstance.version > version) {
							response.status = 409
						}
					}
					unitTypeInstance.properties = params
					if(!unitTypeInstance.hasErrors() && unitTypeInstance.save(flush: true)) {
						response.status = 200
						if(params.callback) {
							render "${params.callback}(${unitTypeInstance as JSON})"
						}
						else {
							render "${unitTypeInstance as JSON}"
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
        def unitTypeInstance = UnitType.get(params.id)
		unitTypeInstance.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(unitTypeInstance) {
					try {
						unitTypeInstance.deleteFlag = "Y";
						unitTypeInstance.save(flush:true);
                        flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'unitType.label', default: 'UnitType'), params.id])}"
                        redirect(action: "list")
                    }
                    catch (org.springframework.dao.DataIntegrityViolationException e) {
                        flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'unitType.label', default: 'UnitType'), params.id])}"
                        redirect(action: "show", id: params.id)
                    }
                }
                else {
                    flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'unitType.label', default: 'UnitType'), params.id])}"
                    redirect(action: "list")
                }
			}
			xml {
				if(params.id && unitTypeInstance) {
					try {
						unitTypeInstance.deleteFlag = "Y";
						unitTypeInstance.save(flush:true);
						render "UnitType ${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "UnitType ${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "UnitType not found with id ${params.id}" as XML
				}
			}
			json {
				if(params.id && unitTypeInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(unitTypeInstance.version > version) {
							response.status = 409
						}
					}
					try {
						unitTypeInstance.deleteFlag = "Y";
						unitTypeInstance.save(flush:true)
						response.status = 204
						if(params.callback) {
							render "${params.callback}(${unitTypeInstance as JSON})"
						}
						else {
							render "${unitTypeInstance as JSON}"
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
		def unitTypeInstance = UnitType.get(params.id)
		withFormat {
			html {
				if(unitTypeInstance) {
					try {
						unitTypeInstance.delete(flush: true)
						flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'unitType.label', default: 'UnitType'), params.id])}"
						redirect(action: "list")
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'unitType.label', default: 'UnitType'), params.id])}"
						redirect(action: "show", id: params.id)
					}
				}
				else {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'unitType.label', default: 'UnitType'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(params.id && unitTypeInstance) {
					try {
						unitTypeInstance.delete(flush:true)
						render "UnitType ${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "UnitType ${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "UnitType not found with id ${params.id}" as XML
				}
			}
			json {
				if(params.id && unitTypeInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(unitTypeInstance.version > version) {
							response.status = 409
						}
					}
					try {
						unitTypeInstance.delete(flush:true)
						response.status = 204
						if(params.callback) {
							render "${params.callback}(${unitTypeInstance as JSON})"
						}
						else {
							render "${unitTypeInstance as JSON}"
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
		def listData = UnitType.findAll(params)
		def totalRecord=UnitType.count()

		
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
	
	private def sendValidationFailedResponse(callback, unitTypeInstance, status)
	{
		response.status = status
		if(callback) {
			render contentType: "application/json", callback({
				errors {
					unitTypeInstance?.errors?.fieldErrors?.each {
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
					unitTypeInstance?.errors?.fieldErrors?.each {
						err ->
							field(err.field)
							message(g.message(error:err))
					}
				}
			}
		}
	}
}
