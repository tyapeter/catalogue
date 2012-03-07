package com.teravin.catalogue

import grails.converters.XML
import grails.converters.JSON

class ProductTypeController {

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
				[productTypeInstanceList: ProductType.list(params), productTypeInstanceTotal: ProductType.count()]
			}
			xml {
				render ProductType.list( params ) as XML
			}
			json {
				response.status = 200
				if(params.callback) {
					render "${params.callback}(${ProductType.list( params ) as JSON})"
				}
				else {
					render "${ProductType.list( params ) as JSON}"
				}
			}
		}
    }

    def create = {
        def productTypeInstance = new ProductType()
        productTypeInstance.properties = params
        return [productTypeInstance: productTypeInstance]
    }

    def save = {
        def productTypeInstance = new ProductType(params)
        productTypeInstance.createdBy = springSecurityService.principal.username
        withFormat {
			html {
                if (productTypeInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.created.message', args: [message(code: 'productType.label', default: 'ProductType'), productTypeInstance.id])}"
                    redirect(action: "show", id: productTypeInstance.id)
                }
                else {
                    render(view: "create", model: [productTypeInstance: productTypeInstance])
                }
			}
			xml {
				if(productTypeInstance.save(flush: true)) {
					productTypeInstance as XML
				}
				else {
					render "ProductType not valid" as XML
				}
			}
			json {
				if(productTypeInstance.save(flush: true)) {
					response.status = 201
					if(params.callback) {
						render "${params.callback}(${productTypeInstance as JSON})"
					}
					else {
						render "${productTypeInstance as JSON}"
					}
				}
				else {
					sendValidationFailedResponse(params.callback,productTypeInstance,400)
				}
			}
		}
    }

    def show = {   
      withFormat {
        html {
            def productTypeInstance = ProductType.get( params.id )
            if(!productTypeInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'productType.label', default: 'ProductType'), params.id])}"
                redirect(action: "list")
            }
            else { return [ productTypeInstance : productTypeInstance ] }
          }
          xml {
              if(params.id && ProductType.get(params.id)) {
                  def c = ProductType.get(params.id)
                  render c as XML
              }
              else {
                  def all = ProductType.get(params)
                  render all as XML
              }
          }
          json {
              if(params.id && ProductType.get(params.id)) {
                  def c = ProductType.get(params.id)
				  response.status = 200
				  if(params.callback) {
					  render "${params.callback}(${c as JSON})"
				  }
				  else {
					  render "${c as JSON}"
				  }
              }
              else {
                  def all = ProductType.get(params)
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
        def productTypeInstance = ProductType.get(params.id)
        if (!productTypeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'productType.label', default: 'ProductType'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [productTypeInstance: productTypeInstance]
        }
    }

    def update = {
        def productTypeInstance = ProductType.get(params.id)
        productTypeInstance.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(productTypeInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(productTypeInstance.version > version) {
							
							productTypeInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'productType.label', default: 'ProductType')] as Object[], "Another user has updated this ProductType while you were editing")
							render(view:"edit", model:[productTypeInstance:productTypeInstance])
							return
						}
					}
					productTypeInstance.properties = params
					if(!productTypeInstance.hasErrors() && productTypeInstance.save(flush: true)) {
						flash.message = "${message(code: 'default.updated.message', args: [message(code: 'productType.label', default: 'ProductType'), productTypeInstance.id])}"
						redirect(action: "show", id:productTypeInstance.id)
					}
					else {
						render(view: "edit", model:[productTypeInstance:productTypeInstance])
					}
				}
				else {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'productType.label', default: 'ProductType'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(productTypeInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(productTypeInstance.version > version) {
							render "ProductType has been updated by another user" as XML
						}
					}
					productTypeInstance.properties = params
					if(!productTypeInstance.hasErrors() && productTypeInstance.save(flush: true)) {
						productTypeInstance as XML
					}
					else {
						render "ProductType not valid" as XML
					}
				}
				else {
					render "ProductType not found with id ${params.id}" as XML
				}
			}
			json {
				if(productTypeInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(productTypeInstance.version > version) {
							response.status = 409
						}
					}
					productTypeInstance.properties = params
					if(!productTypeInstance.hasErrors() && productTypeInstance.save(flush: true)) {
						response.status = 200
						if(params.callback) {
							render "${params.callback}(${productTypeInstance as JSON})"
						}
						else {
							render "${productTypeInstance as JSON}"
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
        def productTypeInstance = ProductType.get(params.id)
		productTypeInstance.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(productTypeInstance) {
					try {
						productTypeInstance.deleteFlag = "Y";
						productTypeInstance.save(flush:true);
                        flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'productType.label', default: 'ProductType'), params.id])}"
                        redirect(action: "list")
                    }
                    catch (org.springframework.dao.DataIntegrityViolationException e) {
                        flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'productType.label', default: 'ProductType'), params.id])}"
                        redirect(action: "show", id: params.id)
                    }
                }
                else {
                    flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'productType.label', default: 'ProductType'), params.id])}"
                    redirect(action: "list")
                }
			}
			xml {
				if(params.id && productTypeInstance) {
					try {
						productTypeInstance.deleteFlag = "Y";
						productTypeInstance.save(flush:true);
						render "ProductType ${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "ProductType ${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "ProductType not found with id ${params.id}" as XML
				}
			}
			json {
				if(params.id && productTypeInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(productTypeInstance.version > version) {
							response.status = 409
						}
					}
					try {
						productTypeInstance.deleteFlag = "Y";
						productTypeInstance.save(flush:true)
						response.status = 204
						if(params.callback) {
							render "${params.callback}(${productTypeInstance as JSON})"
						}
						else {
							render "${productTypeInstance as JSON}"
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
		def productTypeInstance = ProductType.get(params.id)
		withFormat {
			html {
				if(productTypeInstance) {
					try {
						productTypeInstance.delete(flush: true)
						flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'productType.label', default: 'ProductType'), params.id])}"
						redirect(action: "list")
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'productType.label', default: 'ProductType'), params.id])}"
						redirect(action: "show", id: params.id)
					}
				}
				else {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'productType.label', default: 'ProductType'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(params.id && productTypeInstance) {
					try {
						productTypeInstance.delete(flush:true)
						render "ProductType ${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "ProductType ${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "ProductType not found with id ${params.id}" as XML
				}
			}
			json {
				if(params.id && productTypeInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(productTypeInstance.version > version) {
							response.status = 409
						}
					}
					try {
						productTypeInstance.delete(flush:true)
						response.status = 204
						if(params.callback) {
							render "${params.callback}(${productTypeInstance as JSON})"
						}
						else {
							render "${productTypeInstance as JSON}"
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
		def listData = ProductType.findAll(params)
		def totalRecord=ProductType.count()

		
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
	
	private def sendValidationFailedResponse(callback, productTypeInstance, status)
	{
		response.status = status
		if(callback) {
			render contentType: "application/json", callback({
				errors {
					productTypeInstance?.errors?.fieldErrors?.each {
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
					productTypeInstance?.errors?.fieldErrors?.each {
						err ->
							field(err.field)
							message(g.message(error:err))
					}
				}
			}
		}
	}
}
