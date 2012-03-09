package com.teravin.catalogue.maintenance


import com.teravin.catalogue.maintenance.Kurs;

import grails.converters.XML
import grails.converters.JSON

class KursController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def springSecurityService

    def index = {
        redirect(action: "list", params: params)
    }
	def getKursUSD = {
		
		def kursUSD = Kurs.findAllByName( "USD" )
		
		render kursUSD as JSON
	}
    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		params.sort = "idx"
		params.order = "asc"
		def kursList = Kurs.createCriteria().list(params){
			eq("deleteFlag","N")
			maxResults(params.max)
			
		}
        withFormat {
			html {
				[kursInstanceList:kursList, kursInstanceTotal: kursList.getTotalCount()]
			}
			xml {
				render Kurs.list( params ) as XML
			}
			json {
				response.status = 200
				if(params.callback) {
					render "${params.callback}(${Kurs.list( params ) as JSON})"
				}
				else {
					render "${Kurs.list( params ) as JSON}"
				}
			}
		}
    }

    def create = {
        def kursInstance = new Kurs()
        kursInstance.properties = params
        return [kursInstance: kursInstance]
    }

    def save = {
        def kursInstance = new Kurs(params)
        kursInstance.createdBy = springSecurityService.principal.username
        withFormat {
			html {
                if (kursInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.created.message', args: [message(code: 'kurs.label', default: 'Kurs'), kursInstance.id])}"
                    redirect(action: "show", id: kursInstance.id)
                }
                else {
                    render(view: "create", model: [kursInstance: kursInstance])
                }
			}
			xml {
				if(kursInstance.save(flush: true)) {
					kursInstance as XML
				}
				else {
					render "Kurs not valid" as XML
				}
			}
			json {
				if(kursInstance.save(flush: true)) {
					response.status = 201
					if(params.callback) {
						render "${params.callback}(${kursInstance as JSON})"
					}
					else {
						render "${kursInstance as JSON}"
					}
				}
				else {
					sendValidationFailedResponse(params.callback,kursInstance,400)
				}
			}
		}
    }

    def show = {   
      withFormat {
        html {
            def kursInstance = Kurs.get( params.id )
            if(!kursInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'kurs.label', default: 'Kurs'), params.id])}"
                redirect(action: "list")
            }
            else { return [ kursInstance : kursInstance ] }
          }
          xml {
              if(params.id && Kurs.get(params.id)) {
                  def c = Kurs.get(params.id)
                  render c as XML
              }
              else {
                  def all = Kurs.get(params)
                  render all as XML
              }
          }
          json {
              if(params.id && Kurs.get(params.id)) {
                  def c = Kurs.get(params.id)
				  response.status = 200
				  if(params.callback) {
					  render "${params.callback}(${c as JSON})"
				  }
				  else {
					  render "${c as JSON}"
				  }
              }
              else {
                  def all = Kurs.get(params)
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
        def kursInstance = Kurs.get(params.id)
        if (!kursInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'kurs.label', default: 'Kurs'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [kursInstance: kursInstance]
        }
    }

    def update = {
        def kursInstance = Kurs.get(params.id)
        kursInstance.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(kursInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(kursInstance.version > version) {
							
							kursInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'kurs.label', default: 'Kurs')] as Object[], "Another user has updated this Kurs while you were editing")
							render(view:"edit", model:[kursInstance:kursInstance])
							return
						}
					}
					kursInstance.properties = params
					if(!kursInstance.hasErrors() && kursInstance.save(flush: true)) {
						flash.message = "${message(code: 'default.updated.message', args: [message(code: 'kurs.label', default: 'Kurs'), kursInstance.id])}"
						redirect(action: "show", id:kursInstance.id)
					}
					else {
						render(view: "edit", model:[kursInstance:kursInstance])
					}
				}
				else {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'kurs.label', default: 'Kurs'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(kursInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(kursInstance.version > version) {
							render "Kurs has been updated by another user" as XML
						}
					}
					kursInstance.properties = params
					if(!kursInstance.hasErrors() && kursInstance.save(flush: true)) {
						kursInstance as XML
					}
					else {
						render "Kurs not valid" as XML
					}
				}
				else {
					render "Kurs not found with id ${params.id}" as XML
				}
			}
			json {
				if(kursInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(kursInstance.version > version) {
							response.status = 409
						}
					}
					kursInstance.properties = params
					if(!kursInstance.hasErrors() && kursInstance.save(flush: true)) {
						response.status = 200
						if(params.callback) {
							render "${params.callback}(${kursInstance as JSON})"
						}
						else {
							render "${kursInstance as JSON}"
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
        def kursInstance = Kurs.get(params.id)
		kursInstance.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(kursInstance) {
					try {
						kursInstance.deleteFlag = "Y";
						kursInstance.save(flush:true);
                        flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'kurs.label', default: 'Kurs'), params.id])}"
                        redirect(action: "list")
                    }
                    catch (org.springframework.dao.DataIntegrityViolationException e) {
                        flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'kurs.label', default: 'Kurs'), params.id])}"
                        redirect(action: "show", id: params.id)
                    }
                }
                else {
                    flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'kurs.label', default: 'Kurs'), params.id])}"
                    redirect(action: "list")
                }
			}
			xml {
				if(params.id && kursInstance) {
					try {
						kursInstance.deleteFlag = "Y";
						kursInstance.save(flush:true);
						render "Kurs ${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "Kurs ${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "Kurs not found with id ${params.id}" as XML
				}
			}
			json {
				if(params.id && kursInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(kursInstance.version > version) {
							response.status = 409
						}
					}
					try {
						kursInstance.deleteFlag = "Y";
						kursInstance.save(flush:true)
						response.status = 204
						if(params.callback) {
							render "${params.callback}(${kursInstance as JSON})"
						}
						else {
							render "${kursInstance as JSON}"
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
		def kursInstance = Kurs.get(params.id)
		withFormat {
			html {
				if(kursInstance) {
					try {
						kursInstance.delete(flush: true)
						flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'kurs.label', default: 'Kurs'), params.id])}"
						redirect(action: "list")
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'kurs.label', default: 'Kurs'), params.id])}"
						redirect(action: "show", id: params.id)
					}
				}
				else {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'kurs.label', default: 'Kurs'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(params.id && kursInstance) {
					try {
						kursInstance.delete(flush:true)
						render "Kurs ${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "Kurs ${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "Kurs not found with id ${params.id}" as XML
				}
			}
			json {
				if(params.id && kursInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(kursInstance.version > version) {
							response.status = 409
						}
					}
					try {
						kursInstance.delete(flush:true)
						response.status = 204
						if(params.callback) {
							render "${params.callback}(${kursInstance as JSON})"
						}
						else {
							render "${kursInstance as JSON}"
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
		def listData = Kurs.findAll(params)
		def totalRecord=Kurs.count()

		
		listData.each{list <<[it.id,it.name,it.createdBy,it.dateCreated,it.deleteFlag,it.kursValue]}

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
					else if ( index == '5' ) return "kursValue";
					
	}
	
	private def sendValidationFailedResponse(callback, kursInstance, status)
	{
		response.status = status
		if(callback) {
			render contentType: "application/json", callback({
				errors {
					kursInstance?.errors?.fieldErrors?.each {
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
					kursInstance?.errors?.fieldErrors?.each {
						err ->
							field(err.field)
							message(g.message(error:err))
					}
				}
			}
		}
	}
}
