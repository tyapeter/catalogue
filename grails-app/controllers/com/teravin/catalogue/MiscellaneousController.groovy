package com.teravin.catalogue

import grails.converters.XML
import grails.converters.JSON

class MiscellaneousController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def springSecurityService

    def index = {
        redirect(action: "list", params: params)
    }
	def getMiscellaneousLikeName = {
		if( params.name ) {
			def misc = Miscellaneous.createCriteria()
			
			def Miscellaneouss = misc.list{ like('name','%'+params.name+'%')}
				 
			render Miscellaneouss as JSON
		}
	}
    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		params.sort = "idx"
		params.order = "asc"
        withFormat {
			html {
				[miscellaneousInstanceList: Miscellaneous.list(params), miscellaneousInstanceTotal: Miscellaneous.count()]
			}
			xml {
				render Miscellaneous.list( params ) as XML
			}
			json {
				response.status = 200
				if(params.callback) {
					render "${params.callback}(${Miscellaneous.list( params ) as JSON})"
				}
				else {
					render "${Miscellaneous.list( params ) as JSON}"
				}
			}
		}
    }

    def create = {
        def miscellaneousInstance = new Miscellaneous()
        miscellaneousInstance.properties = params
        return [miscellaneousInstance: miscellaneousInstance]
    }

    def save = {
        def miscellaneousInstance = new Miscellaneous(params)
        miscellaneousInstance.createdBy = springSecurityService.principal.username
        withFormat {
			html {
                if (miscellaneousInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.created.message', args: [message(code: 'miscellaneous.label', default: 'Miscellaneous'), miscellaneousInstance.id])}"
                    redirect(action: "show", id: miscellaneousInstance.id)
                }
                else {
                    render(view: "create", model: [miscellaneousInstance: miscellaneousInstance])
                }
			}
			xml {
				if(miscellaneousInstance.save(flush: true)) {
					miscellaneousInstance as XML
				}
				else {
					render "Miscellaneous not valid" as XML
				}
			}
			json {
				if(miscellaneousInstance.save(flush: true)) {
					response.status = 201
					if(params.callback) {
						render "${params.callback}(${miscellaneousInstance as JSON})"
					}
					else {
						render "${miscellaneousInstance as JSON}"
					}
				}
				else {
					sendValidationFailedResponse(params.callback,miscellaneousInstance,400)
				}
			}
		}
    }

    def show = {   
      withFormat {
        html {
            def miscellaneousInstance = Miscellaneous.get( params.id )
            if(!miscellaneousInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'miscellaneous.label', default: 'Miscellaneous'), params.id])}"
                redirect(action: "list")
            }
            else { return [ miscellaneousInstance : miscellaneousInstance ] }
          }
          xml {
              if(params.id && Miscellaneous.get(params.id)) {
                  def c = Miscellaneous.get(params.id)
                  render c as XML
              }
              else {
                  def all = Miscellaneous.get(params)
                  render all as XML
              }
          }
          json {
              if(params.id && Miscellaneous.get(params.id)) {
                  def c = Miscellaneous.get(params.id)
				  response.status = 200
				  if(params.callback) {
					  render "${params.callback}(${c as JSON})"
				  }
				  else {
					  render "${c as JSON}"
				  }
              }
              else {
                  def all = Miscellaneous.get(params)
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
        def miscellaneousInstance = Miscellaneous.get(params.id)
        if (!miscellaneousInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'miscellaneous.label', default: 'Miscellaneous'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [miscellaneousInstance: miscellaneousInstance]
        }
    }

    def update = {
        def miscellaneousInstance = Miscellaneous.get(params.id)
        miscellaneousInstance.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(miscellaneousInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(miscellaneousInstance.version > version) {
							
							miscellaneousInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'miscellaneous.label', default: 'Miscellaneous')] as Object[], "Another user has updated this Miscellaneous while you were editing")
							render(view:"edit", model:[miscellaneousInstance:miscellaneousInstance])
							return
						}
					}
					miscellaneousInstance.properties = params
					if(!miscellaneousInstance.hasErrors() && miscellaneousInstance.save(flush: true)) {
						flash.message = "${message(code: 'default.updated.message', args: [message(code: 'miscellaneous.label', default: 'Miscellaneous'), miscellaneousInstance.id])}"
						redirect(action: "show", id:miscellaneousInstance.id)
					}
					else {
						render(view: "edit", model:[miscellaneousInstance:miscellaneousInstance])
					}
				}
				else {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'miscellaneous.label', default: 'Miscellaneous'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(miscellaneousInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(miscellaneousInstance.version > version) {
							render "Miscellaneous has been updated by another user" as XML
						}
					}
					miscellaneousInstance.properties = params
					if(!miscellaneousInstance.hasErrors() && miscellaneousInstance.save(flush: true)) {
						miscellaneousInstance as XML
					}
					else {
						render "Miscellaneous not valid" as XML
					}
				}
				else {
					render "Miscellaneous not found with id ${params.id}" as XML
				}
			}
			json {
				if(miscellaneousInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(miscellaneousInstance.version > version) {
							response.status = 409
						}
					}
					miscellaneousInstance.properties = params
					if(!miscellaneousInstance.hasErrors() && miscellaneousInstance.save(flush: true)) {
						response.status = 200
						if(params.callback) {
							render "${params.callback}(${miscellaneousInstance as JSON})"
						}
						else {
							render "${miscellaneousInstance as JSON}"
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
        def miscellaneousInstance = Miscellaneous.get(params.id)
		miscellaneousInstance.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(miscellaneousInstance) {
					try {
						miscellaneousInstance.deleteFlag = "Y";
						miscellaneousInstance.save(flush:true);
                        flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'miscellaneous.label', default: 'Miscellaneous'), params.id])}"
                        redirect(action: "list")
                    }
                    catch (org.springframework.dao.DataIntegrityViolationException e) {
                        flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'miscellaneous.label', default: 'Miscellaneous'), params.id])}"
                        redirect(action: "show", id: params.id)
                    }
                }
                else {
                    flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'miscellaneous.label', default: 'Miscellaneous'), params.id])}"
                    redirect(action: "list")
                }
			}
			xml {
				if(params.id && miscellaneousInstance) {
					try {
						miscellaneousInstance.deleteFlag = "Y";
						miscellaneousInstance.save(flush:true);
						render "Miscellaneous ${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "Miscellaneous ${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "Miscellaneous not found with id ${params.id}" as XML
				}
			}
			json {
				if(params.id && miscellaneousInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(miscellaneousInstance.version > version) {
							response.status = 409
						}
					}
					try {
						miscellaneousInstance.deleteFlag = "Y";
						miscellaneousInstance.save(flush:true)
						response.status = 204
						if(params.callback) {
							render "${params.callback}(${miscellaneousInstance as JSON})"
						}
						else {
							render "${miscellaneousInstance as JSON}"
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
		def miscellaneousInstance = Miscellaneous.get(params.id)
		withFormat {
			html {
				if(miscellaneousInstance) {
					try {
						miscellaneousInstance.delete(flush: true)
						flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'miscellaneous.label', default: 'Miscellaneous'), params.id])}"
						redirect(action: "list")
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'miscellaneous.label', default: 'Miscellaneous'), params.id])}"
						redirect(action: "show", id: params.id)
					}
				}
				else {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'miscellaneous.label', default: 'Miscellaneous'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(params.id && miscellaneousInstance) {
					try {
						miscellaneousInstance.delete(flush:true)
						render "Miscellaneous ${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "Miscellaneous ${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "Miscellaneous not found with id ${params.id}" as XML
				}
			}
			json {
				if(params.id && miscellaneousInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(miscellaneousInstance.version > version) {
							response.status = 409
						}
					}
					try {
						miscellaneousInstance.delete(flush:true)
						response.status = 204
						if(params.callback) {
							render "${params.callback}(${miscellaneousInstance as JSON})"
						}
						else {
							render "${miscellaneousInstance as JSON}"
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
		def listData = Miscellaneous.findAll(params)
		def totalRecord=Miscellaneous.count()

		
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
	
	private def sendValidationFailedResponse(callback, miscellaneousInstance, status)
	{
		response.status = status
		if(callback) {
			render contentType: "application/json", callback({
				errors {
					miscellaneousInstance?.errors?.fieldErrors?.each {
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
					miscellaneousInstance?.errors?.fieldErrors?.each {
						err ->
							field(err.field)
							message(g.message(error:err))
					}
				}
			}
		}
	}
}
