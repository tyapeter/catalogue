package com.teravin.catalogue.maintenance

import grails.converters.XML
import grails.converters.JSON

class ColorController {

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
				[colorInstanceList: Color.list(params), colorInstanceTotal: Color.count()]
			}
			xml {
				render Color.list( params ) as XML
			}
			json {
				response.status = 200
				if(params.callback) {
					render "${params.callback}(${Color.list( params ) as JSON})"
				}
				else {
					render "${Color.list( params ) as JSON}"
				}
			}
		}
    }

    def create = {
        def colorInstance = new Color()
        colorInstance.properties = params
        return [colorInstance: colorInstance]
    }

    def save = {
        def colorInstance = new Color(params)
        colorInstance.createdBy = springSecurityService.principal.username
        withFormat {
			html {
                if (colorInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.created.message', args: [message(code: 'color.label', default: 'Color'), colorInstance.id])}"
                    redirect(action: "show", id: colorInstance.id)
                }
                else {
                    render(view: "create", model: [colorInstance: colorInstance])
                }
			}
			xml {
				if(colorInstance.save(flush: true)) {
					colorInstance as XML
				}
				else {
					render "Color not valid" as XML
				}
			}
			json {
				if(colorInstance.save(flush: true)) {
					response.status = 201
					if(params.callback) {
						render "${params.callback}(${colorInstance as JSON})"
					}
					else {
						render "${colorInstance as JSON}"
					}
				}
				else {
					sendValidationFailedResponse(params.callback,colorInstance,400)
				}
			}
		}
    }

    def show = {   
      withFormat {
        html {
            def colorInstance = Color.get( params.id )
            if(!colorInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'color.label', default: 'Color'), params.id])}"
                redirect(action: "list")
            }
            else { return [ colorInstance : colorInstance ] }
          }
          xml {
              if(params.id && Color.get(params.id)) {
                  def c = Color.get(params.id)
                  render c as XML
              }
              else {
                  def all = Color.get(params)
                  render all as XML
              }
          }
          json {
              if(params.id && Color.get(params.id)) {
                  def c = Color.get(params.id)
				  response.status = 200
				  if(params.callback) {
					  render "${params.callback}(${c as JSON})"
				  }
				  else {
					  render "${c as JSON}"
				  }
              }
              else {
                  def all = Color.get(params)
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
        def colorInstance = Color.get(params.id)
        if (!colorInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'color.label', default: 'Color'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [colorInstance: colorInstance]
        }
    }

    def update = {
        def colorInstance = Color.get(params.id)
        colorInstance.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(colorInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(colorInstance.version > version) {
							
							colorInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'color.label', default: 'Color')] as Object[], "Another user has updated this Color while you were editing")
							render(view:"edit", model:[colorInstance:colorInstance])
							return
						}
					}
					colorInstance.properties = params
					if(!colorInstance.hasErrors() && colorInstance.save(flush: true)) {
						flash.message = "${message(code: 'default.updated.message', args: [message(code: 'color.label', default: 'Color'), colorInstance.id])}"
						redirect(action: "show", id:colorInstance.id)
					}
					else {
						render(view: "edit", model:[colorInstance:colorInstance])
					}
				}
				else {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'color.label', default: 'Color'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(colorInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(colorInstance.version > version) {
							render "Color has been updated by another user" as XML
						}
					}
					colorInstance.properties = params
					if(!colorInstance.hasErrors() && colorInstance.save(flush: true)) {
						colorInstance as XML
					}
					else {
						render "Color not valid" as XML
					}
				}
				else {
					render "Color not found with id ${params.id}" as XML
				}
			}
			json {
				if(colorInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(colorInstance.version > version) {
							response.status = 409
						}
					}
					colorInstance.properties = params
					if(!colorInstance.hasErrors() && colorInstance.save(flush: true)) {
						response.status = 200
						if(params.callback) {
							render "${params.callback}(${colorInstance as JSON})"
						}
						else {
							render "${colorInstance as JSON}"
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
        def colorInstance = Color.get(params.id)
		colorInstance.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(colorInstance) {
					try {
						colorInstance.deleteFlag = "Y";
						colorInstance.save(flush:true);
                        flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'color.label', default: 'Color'), params.id])}"
                        redirect(action: "list")
                    }
                    catch (org.springframework.dao.DataIntegrityViolationException e) {
                        flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'color.label', default: 'Color'), params.id])}"
                        redirect(action: "show", id: params.id)
                    }
                }
                else {
                    flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'color.label', default: 'Color'), params.id])}"
                    redirect(action: "list")
                }
			}
			xml {
				if(params.id && colorInstance) {
					try {
						colorInstance.deleteFlag = "Y";
						colorInstance.save(flush:true);
						render "Color ${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "Color ${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "Color not found with id ${params.id}" as XML
				}
			}
			json {
				if(params.id && colorInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(colorInstance.version > version) {
							response.status = 409
						}
					}
					try {
						colorInstance.deleteFlag = "Y";
						colorInstance.save(flush:true)
						response.status = 204
						if(params.callback) {
							render "${params.callback}(${colorInstance as JSON})"
						}
						else {
							render "${colorInstance as JSON}"
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
		def colorInstance = Color.get(params.id)
		withFormat {
			html {
				if(colorInstance) {
					try {
						colorInstance.delete(flush: true)
						flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'color.label', default: 'Color'), params.id])}"
						redirect(action: "list")
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'color.label', default: 'Color'), params.id])}"
						redirect(action: "show", id: params.id)
					}
				}
				else {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'color.label', default: 'Color'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(params.id && colorInstance) {
					try {
						colorInstance.delete(flush:true)
						render "Color ${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "Color ${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "Color not found with id ${params.id}" as XML
				}
			}
			json {
				if(params.id && colorInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(colorInstance.version > version) {
							response.status = 409
						}
					}
					try {
						colorInstance.delete(flush:true)
						response.status = 204
						if(params.callback) {
							render "${params.callback}(${colorInstance as JSON})"
						}
						else {
							render "${colorInstance as JSON}"
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
		def listData = Color.findAll(params)
		def totalRecord=Color.count()

		
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
	
	private def sendValidationFailedResponse(callback, colorInstance, status)
	{
		response.status = status
		if(callback) {
			render contentType: "application/json", callback({
				errors {
					colorInstance?.errors?.fieldErrors?.each {
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
					colorInstance?.errors?.fieldErrors?.each {
						err ->
							field(err.field)
							message(g.message(error:err))
					}
				}
			}
		}
	}
}
