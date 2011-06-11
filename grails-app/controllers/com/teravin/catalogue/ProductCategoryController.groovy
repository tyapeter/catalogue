package com.teravin.catalogue

import grails.converters.XML
import grails.converters.JSON

class ProductCategoryController {

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
				[productCategoryInstanceList: ProductCategory.list(params), productCategoryInstanceTotal: ProductCategory.count()]
			}
			xml {
				render ProductCategory.list( params ) as XML
			}
			json {
				response.status = 200
				if(params.callback) {
					render "${params.callback}(${ProductCategory.list( params ) as JSON})"
				}
				else {
					render "${ProductCategory.list( params ) as JSON}"
				}
			}
		}
    }

    def create = {
        def productCategoryInstance = new ProductCategory()
        productCategoryInstance.properties = params
        return [productCategoryInstance: productCategoryInstance]
    }

    def save = {
        def productCategoryInstance = new ProductCategory(params)
        productCategoryInstance.createdBy = springSecurityService.principal.username
        withFormat {
			html {
                if (productCategoryInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.created.message', args: [message(code: 'productCategory.label', default: 'ProductCategory'), productCategoryInstance.id])}"
                    redirect(action: "show", id: productCategoryInstance.id)
                }
                else {
                    render(view: "create", model: [productCategoryInstance: productCategoryInstance])
                }
			}
			xml {
				if(productCategoryInstance.save(flush: true)) {
					productCategoryInstance as XML
				}
				else {
					render "ProductCategory not valid" as XML
				}
			}
			json {
				if(productCategoryInstance.save(flush: true)) {
					response.status = 201
					if(params.callback) {
						render "${params.callback}(${productCategoryInstance as JSON})"
					}
					else {
						render "${productCategoryInstance as JSON}"
					}
				}
				else {
					sendValidationFailedResponse(params.callback,productCategoryInstance,400)
				}
			}
		}
    }

    def show = {   
      withFormat {
        html {
            def productCategoryInstance = ProductCategory.get( params.id )
            if(!productCategoryInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'productCategory.label', default: 'ProductCategory'), params.id])}"
                redirect(action: "list")
            }
            else { return [ productCategoryInstance : productCategoryInstance ] }
          }
          xml {
              if(params.id && ProductCategory.get(params.id)) {
                  def c = ProductCategory.get(params.id)
                  render c as XML
              }
              else {
                  def all = ProductCategory.get(params)
                  render all as XML
              }
          }
          json {
              if(params.id && ProductCategory.get(params.id)) {
                  def c = ProductCategory.get(params.id)
				  response.status = 200
				  if(params.callback) {
					  render "${params.callback}(${c as JSON})"
				  }
				  else {
					  render "${c as JSON}"
				  }
              }
              else {
                  def all = ProductCategory.get(params)
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
        def productCategoryInstance = ProductCategory.get(params.id)
        if (!productCategoryInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'productCategory.label', default: 'ProductCategory'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [productCategoryInstance: productCategoryInstance]
        }
    }

    def update = {
        def productCategoryInstance = ProductCategory.get(params.id)
        productCategoryInstance.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(productCategoryInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(productCategoryInstance.version > version) {
							
							productCategoryInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'productCategory.label', default: 'ProductCategory')] as Object[], "Another user has updated this ProductCategory while you were editing")
							render(view:"edit", model:[productCategoryInstance:productCategoryInstance])
							return
						}
					}
					productCategoryInstance.properties = params
					if(!productCategoryInstance.hasErrors() && productCategoryInstance.save(flush: true)) {
						flash.message = "${message(code: 'default.updated.message', args: [message(code: 'productCategory.label', default: 'ProductCategory'), productCategoryInstance.id])}"
						redirect(action: "show", id:productCategoryInstance.id)
					}
					else {
						render(view: "edit", model:[productCategoryInstance:productCategoryInstance])
					}
				}
				else {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'productCategory.label', default: 'ProductCategory'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(productCategoryInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(productCategoryInstance.version > version) {
							render "ProductCategory has been updated by another user" as XML
						}
					}
					productCategoryInstance.properties = params
					if(!productCategoryInstance.hasErrors() && productCategoryInstance.save(flush: true)) {
						productCategoryInstance as XML
					}
					else {
						render "ProductCategory not valid" as XML
					}
				}
				else {
					render "ProductCategory not found with id ${params.id}" as XML
				}
			}
			json {
				if(productCategoryInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(productCategoryInstance.version > version) {
							response.status = 409
						}
					}
					productCategoryInstance.properties = params
					if(!productCategoryInstance.hasErrors() && productCategoryInstance.save(flush: true)) {
						response.status = 200
						if(params.callback) {
							render "${params.callback}(${productCategoryInstance as JSON})"
						}
						else {
							render "${productCategoryInstance as JSON}"
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
        def productCategoryInstance = ProductCategory.get(params.id)
		productCategoryInstance.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(productCategoryInstance) {
					try {
						productCategoryInstance.deleteFlag = "Y";
						productCategoryInstance.save(flush:true);
                        flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'productCategory.label', default: 'ProductCategory'), params.id])}"
                        redirect(action: "list")
                    }
                    catch (org.springframework.dao.DataIntegrityViolationException e) {
                        flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'productCategory.label', default: 'ProductCategory'), params.id])}"
                        redirect(action: "show", id: params.id)
                    }
                }
                else {
                    flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'productCategory.label', default: 'ProductCategory'), params.id])}"
                    redirect(action: "list")
                }
			}
			xml {
				if(params.id && productCategoryInstance) {
					try {
						productCategoryInstance.deleteFlag = "Y";
						productCategoryInstance.save(flush:true);
						render "ProductCategory ${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "ProductCategory ${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "ProductCategory not found with id ${params.id}" as XML
				}
			}
			json {
				if(params.id && productCategoryInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(productCategoryInstance.version > version) {
							response.status = 409
						}
					}
					try {
						productCategoryInstance.deleteFlag = "Y";
						productCategoryInstance.save(flush:true)
						response.status = 204
						if(params.callback) {
							render "${params.callback}(${productCategoryInstance as JSON})"
						}
						else {
							render "${productCategoryInstance as JSON}"
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
		def productCategoryInstance = ProductCategory.get(params.id)
		withFormat {
			html {
				if(productCategoryInstance) {
					try {
						productCategoryInstance.delete(flush: true)
						flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'productCategory.label', default: 'ProductCategory'), params.id])}"
						redirect(action: "list")
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'productCategory.label', default: 'ProductCategory'), params.id])}"
						redirect(action: "show", id: params.id)
					}
				}
				else {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'productCategory.label', default: 'ProductCategory'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(params.id && productCategoryInstance) {
					try {
						productCategoryInstance.delete(flush:true)
						render "ProductCategory ${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "ProductCategory ${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "ProductCategory not found with id ${params.id}" as XML
				}
			}
			json {
				if(params.id && productCategoryInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(productCategoryInstance.version > version) {
							response.status = 409
						}
					}
					try {
						productCategoryInstance.delete(flush:true)
						response.status = 204
						if(params.callback) {
							render "${params.callback}(${productCategoryInstance as JSON})"
						}
						else {
							render "${productCategoryInstance as JSON}"
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
		def listData = ProductCategory.findAll(params)
		def totalRecord=ProductCategory.count()

		
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
	
	private def sendValidationFailedResponse(callback, productCategoryInstance, status)
	{
		response.status = status
		if(callback) {
			render contentType: "application/json", callback({
				errors {
					productCategoryInstance?.errors?.fieldErrors?.each {
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
					productCategoryInstance?.errors?.fieldErrors?.each {
						err ->
							field(err.field)
							message(g.message(error:err))
					}
				}
			}
		}
	}
}
