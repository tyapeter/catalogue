package com.teravin.catalogue

import grails.converters.XML
import grails.converters.JSON

class AccesoriesController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def springSecurityService

    def index = {
        redirect(action: "list", params: params)
    }
	def getAccesoriesLikeName = {
		if( params.name ) {
			def acc = Accesories.createCriteria()
			
			def Accesoriess = acc.list{ like('name','%'+params.name+'%')}
				 
			render Accesoriess as JSON
		}
	}
    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		params.sort = "idx"
		params.order = "asc"
        withFormat {
			html {
				[accesoriesInstanceList: Accesories.list(params), accesoriesInstanceTotal: Accesories.count()]
			}
			xml {
				render Accesories.list( params ) as XML
			}
			json {
				response.status = 200
				if(params.callback) {
					render "${params.callback}(${Accesories.list( params ) as JSON})"
				}
				else {
					render "${Accesories.list( params ) as JSON}"
				}
			}
		}
    }

    def create = {
        def accesoriesInstance = new Accesories()
        accesoriesInstance.properties = params
        return [accesoriesInstance: accesoriesInstance]
    }

    def save = {
        def accesoriesInstance = new Accesories(params)
        accesoriesInstance.createdBy = springSecurityService.principal.username
        withFormat {
			html {
                if (accesoriesInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.created.message', args: [message(code: 'accesories.label', default: 'Accesories'), accesoriesInstance.id])}"
                    redirect(action: "show", id: accesoriesInstance.id)
                }
                else {
                    render(view: "create", model: [accesoriesInstance: accesoriesInstance])
                }
			}
			xml {
				if(accesoriesInstance.save(flush: true)) {
					accesoriesInstance as XML
				}
				else {
					render "Accesories not valid" as XML
				}
			}
			json {
				if(accesoriesInstance.save(flush: true)) {
					response.status = 201
					if(params.callback) {
						render "${params.callback}(${accesoriesInstance as JSON})"
					}
					else {
						render "${accesoriesInstance as JSON}"
					}
				}
				else {
					sendValidationFailedResponse(params.callback,accesoriesInstance,400)
				}
			}
		}
    }

    def show = {   
      withFormat {
        html {
            def accesoriesInstance = Accesories.get( params.id )
            if(!accesoriesInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'accesories.label', default: 'Accesories'), params.id])}"
                redirect(action: "list")
            }
            else { return [ accesoriesInstance : accesoriesInstance ] }
          }
          xml {
              if(params.id && Accesories.get(params.id)) {
                  def c = Accesories.get(params.id)
                  render c as XML
              }
              else {
                  def all = Accesories.get(params)
                  render all as XML
              }
          }
          json {
              if(params.id && Accesories.get(params.id)) {
                  def c = Accesories.get(params.id)
				  response.status = 200
				  if(params.callback) {
					  render "${params.callback}(${c as JSON})"
				  }
				  else {
					  render "${c as JSON}"
				  }
              }
              else {
                  def all = Accesories.get(params)
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
        def accesoriesInstance = Accesories.get(params.id)
        if (!accesoriesInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'accesories.label', default: 'Accesories'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [accesoriesInstance: accesoriesInstance]
        }
    }

    def update = {
        def accesoriesInstance = Accesories.get(params.id)
        accesoriesInstance.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(accesoriesInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(accesoriesInstance.version > version) {
							
							accesoriesInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'accesories.label', default: 'Accesories')] as Object[], "Another user has updated this Accesories while you were editing")
							render(view:"edit", model:[accesoriesInstance:accesoriesInstance])
							return
						}
					}
					accesoriesInstance.properties = params
					if(!accesoriesInstance.hasErrors() && accesoriesInstance.save(flush: true)) {
						flash.message = "${message(code: 'default.updated.message', args: [message(code: 'accesories.label', default: 'Accesories'), accesoriesInstance.id])}"
						redirect(action: "show", id:accesoriesInstance.id)
					}
					else {
						render(view: "edit", model:[accesoriesInstance:accesoriesInstance])
					}
				}
				else {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'accesories.label', default: 'Accesories'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(accesoriesInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(accesoriesInstance.version > version) {
							render "Accesories has been updated by another user" as XML
						}
					}
					accesoriesInstance.properties = params
					if(!accesoriesInstance.hasErrors() && accesoriesInstance.save(flush: true)) {
						accesoriesInstance as XML
					}
					else {
						render "Accesories not valid" as XML
					}
				}
				else {
					render "Accesories not found with id ${params.id}" as XML
				}
			}
			json {
				if(accesoriesInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(accesoriesInstance.version > version) {
							response.status = 409
						}
					}
					accesoriesInstance.properties = params
					if(!accesoriesInstance.hasErrors() && accesoriesInstance.save(flush: true)) {
						response.status = 200
						if(params.callback) {
							render "${params.callback}(${accesoriesInstance as JSON})"
						}
						else {
							render "${accesoriesInstance as JSON}"
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
        def accesoriesInstance = Accesories.get(params.id)
		accesoriesInstance.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(accesoriesInstance) {
					try {
						accesoriesInstance.deleteFlag = "Y";
						accesoriesInstance.save(flush:true);
                        flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'accesories.label', default: 'Accesories'), params.id])}"
                        redirect(action: "list")
                    }
                    catch (org.springframework.dao.DataIntegrityViolationException e) {
                        flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'accesories.label', default: 'Accesories'), params.id])}"
                        redirect(action: "show", id: params.id)
                    }
                }
                else {
                    flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'accesories.label', default: 'Accesories'), params.id])}"
                    redirect(action: "list")
                }
			}
			xml {
				if(params.id && accesoriesInstance) {
					try {
						accesoriesInstance.deleteFlag = "Y";
						accesoriesInstance.save(flush:true);
						render "Accesories ${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "Accesories ${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "Accesories not found with id ${params.id}" as XML
				}
			}
			json {
				if(params.id && accesoriesInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(accesoriesInstance.version > version) {
							response.status = 409
						}
					}
					try {
						accesoriesInstance.deleteFlag = "Y";
						accesoriesInstance.save(flush:true)
						response.status = 204
						if(params.callback) {
							render "${params.callback}(${accesoriesInstance as JSON})"
						}
						else {
							render "${accesoriesInstance as JSON}"
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
		def accesoriesInstance = Accesories.get(params.id)
		withFormat {
			html {
				if(accesoriesInstance) {
					try {
						accesoriesInstance.delete(flush: true)
						flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'accesories.label', default: 'Accesories'), params.id])}"
						redirect(action: "list")
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'accesories.label', default: 'Accesories'), params.id])}"
						redirect(action: "show", id: params.id)
					}
				}
				else {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'accesories.label', default: 'Accesories'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(params.id && accesoriesInstance) {
					try {
						accesoriesInstance.delete(flush:true)
						render "Accesories ${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "Accesories ${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "Accesories not found with id ${params.id}" as XML
				}
			}
			json {
				if(params.id && accesoriesInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(accesoriesInstance.version > version) {
							response.status = 409
						}
					}
					try {
						accesoriesInstance.delete(flush:true)
						response.status = 204
						if(params.callback) {
							render "${params.callback}(${accesoriesInstance as JSON})"
						}
						else {
							render "${accesoriesInstance as JSON}"
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
		def listData = Accesories.findAll(params)
		def totalRecord=Accesories.count()

		
		listData.each{list <<[it.id,it.name,it.createdBy,it.dateCreated,it.deleteFlag,it.price]}

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
					else if ( index == '5' ) return "price";
					
	}
	
	private def sendValidationFailedResponse(callback, accesoriesInstance, status)
	{
		response.status = status
		if(callback) {
			render contentType: "application/json", callback({
				errors {
					accesoriesInstance?.errors?.fieldErrors?.each {
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
					accesoriesInstance?.errors?.fieldErrors?.each {
						err ->
							field(err.field)
							message(g.message(error:err))
					}
				}
			}
		}
	}
}
