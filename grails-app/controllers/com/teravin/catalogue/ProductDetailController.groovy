package com.teravin.catalogue

import grails.converters.XML
import grails.converters.JSON

class ProductDetailController {

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
				[productDetailInstanceList: ProductDetail.list(params), productDetailInstanceTotal: ProductDetail.count()]
			}
			xml {
				render ProductDetail.list( params ) as XML
			}
			json {
				response.status = 200
				if(params.callback) {
					render "${params.callback}(${ProductDetail.list( params ) as JSON})"
				}
				else {
					render "${ProductDetail.list( params ) as JSON}"
				}
			}
		}
    }

    def create = {
        def productDetailInstance = new ProductDetail()
        productDetailInstance.properties = params
		def materialList = new ArrayList()
        return [productDetailInstance: productDetailInstance, materialList:materialList]
    }

    def save = {
        def productDetailInstance = new ProductDetail(params)
		 
        productDetailInstance.createdBy = springSecurityService.principal.username
        withFormat {
			html {
                if (productDetailInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.created.message', args: [message(code: 'productDetail.label', default: 'ProductDetail'), productDetailInstance.id])}"
                    redirect(action: "show", id: productDetailInstance.id)
                }
                else {
                    render(view: "create", model: [productDetailInstance: productDetailInstance])
                }
			}
			xml {
				if(productDetailInstance.save(flush: true)) {
					productDetailInstance as XML
				}
				else {
					render "ProductDetail not valid" as XML
				}
			}
			json {
				if(productDetailInstance.save(flush: true)) {
					response.status = 201
					if(params.callback) {
						render "${params.callback}(${productDetailInstance as JSON})"
					}
					else {
						render "${productDetailInstance as JSON}"
					}
				}
				else {
					sendValidationFailedResponse(params.callback,productDetailInstance,400)
				}
			}
		}
    }

    def show = {   
      withFormat {
        html {
            def productDetailInstance = ProductDetail.get( params.id )
            if(!productDetailInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'productDetail.label', default: 'ProductDetail'), params.id])}"
                redirect(action: "list")
            }
            else { return [ productDetailInstance : productDetailInstance ] }
          }
          xml {
              if(params.id && ProductDetail.get(params.id)) {
                  def c = ProductDetail.get(params.id)
                  render c as XML
              }
              else {
                  def all = ProductDetail.get(params)
                  render all as XML
              }
          }
          json {
              if(params.id && ProductDetail.get(params.id)) {
                  def c = ProductDetail.get(params.id)
				  response.status = 200
				  if(params.callback) {
					  render "${params.callback}(${c as JSON})"
				  }
				  else {
					  render "${c as JSON}"
				  }
              }
              else {
                  def all = ProductDetail.get(params)
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
        def productDetailInstance = ProductDetail.get(params.id)
        if (!productDetailInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'productDetail.label', default: 'ProductDetail'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [productDetailInstance: productDetailInstance]
        }
    }

    def update = {
        def productDetailInstance = ProductDetail.get(params.id)
        productDetailInstance.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(productDetailInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(productDetailInstance.version > version) {
							
							productDetailInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'productDetail.label', default: 'ProductDetail')] as Object[], "Another user has updated this ProductDetail while you were editing")
							render(view:"edit", model:[productDetailInstance:productDetailInstance])
							return
						}
					}
					productDetailInstance.properties = params
					if(!productDetailInstance.hasErrors() && productDetailInstance.save(flush: true)) {
						flash.message = "${message(code: 'default.updated.message', args: [message(code: 'productDetail.label', default: 'ProductDetail'), productDetailInstance.id])}"
						redirect(action: "show", id:productDetailInstance.id)
					}
					else {
						render(view: "edit", model:[productDetailInstance:productDetailInstance])
					}
				}
				else {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'productDetail.label', default: 'ProductDetail'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(productDetailInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(productDetailInstance.version > version) {
							render "ProductDetail has been updated by another user" as XML
						}
					}
					productDetailInstance.properties = params
					if(!productDetailInstance.hasErrors() && productDetailInstance.save(flush: true)) {
						productDetailInstance as XML
					}
					else {
						render "ProductDetail not valid" as XML
					}
				}
				else {
					render "ProductDetail not found with id ${params.id}" as XML
				}
			}
			json {
				if(productDetailInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(productDetailInstance.version > version) {
							response.status = 409
						}
					}
					productDetailInstance.properties = params
					if(!productDetailInstance.hasErrors() && productDetailInstance.save(flush: true)) {
						response.status = 200
						if(params.callback) {
							render "${params.callback}(${productDetailInstance as JSON})"
						}
						else {
							render "${productDetailInstance as JSON}"
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
        def productDetailInstance = ProductDetail.get(params.id)
		productDetailInstance.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(productDetailInstance) {
					try {
						productDetailInstance.deleteFlag = "Y";
						productDetailInstance.save(flush:true);
                        flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'productDetail.label', default: 'ProductDetail'), params.id])}"
                        redirect(action: "list")
                    }
                    catch (org.springframework.dao.DataIntegrityViolationException e) {
                        flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'productDetail.label', default: 'ProductDetail'), params.id])}"
                        redirect(action: "show", id: params.id)
                    }
                }
                else {
                    flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'productDetail.label', default: 'ProductDetail'), params.id])}"
                    redirect(action: "list")
                }
			}
			xml {
				if(params.id && productDetailInstance) {
					try {
						productDetailInstance.deleteFlag = "Y";
						productDetailInstance.save(flush:true);
						render "ProductDetail ${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "ProductDetail ${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "ProductDetail not found with id ${params.id}" as XML
				}
			}
			json {
				if(params.id && productDetailInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(productDetailInstance.version > version) {
							response.status = 409
						}
					}
					try {
						productDetailInstance.deleteFlag = "Y";
						productDetailInstance.save(flush:true)
						response.status = 204
						if(params.callback) {
							render "${params.callback}(${productDetailInstance as JSON})"
						}
						else {
							render "${productDetailInstance as JSON}"
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
		def productDetailInstance = ProductDetail.get(params.id)
		withFormat {
			html {
				if(productDetailInstance) {
					try {
						productDetailInstance.delete(flush: true)
						flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'productDetail.label', default: 'ProductDetail'), params.id])}"
						redirect(action: "list")
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'productDetail.label', default: 'ProductDetail'), params.id])}"
						redirect(action: "show", id: params.id)
					}
				}
				else {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'productDetail.label', default: 'ProductDetail'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(params.id && productDetailInstance) {
					try {
						productDetailInstance.delete(flush:true)
						render "ProductDetail ${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "ProductDetail ${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "ProductDetail not found with id ${params.id}" as XML
				}
			}
			json {
				if(params.id && productDetailInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(productDetailInstance.version > version) {
							response.status = 409
						}
					}
					try {
						productDetailInstance.delete(flush:true)
						response.status = 204
						if(params.callback) {
							render "${params.callback}(${productDetailInstance as JSON})"
						}
						else {
							render "${productDetailInstance as JSON}"
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
		def listData = ProductDetail.findAll(params)
		def totalRecord=ProductDetail.count()

		
		listData.each{list <<[it.id,it.product,it.material,it.unit,it.price,it.idxx]}

		def data = ["iTotalRecords": totalRecord,"iTotalDisplayRecords": totalRecord,"aaData":list]
		render data as JSON
	}

	String getColumnToField (String index)
	{
		if ( index == '0' ) return "id";
					else if ( index == '1' ) return "product";
					else if ( index == '2' ) return "material";
					else if ( index == '3' ) return "unit";
					else if ( index == '4' ) return "price";
					else if ( index == '5' ) return "idxx";
					
	}
	
	private def sendValidationFailedResponse(callback, productDetailInstance, status)
	{
		response.status = status
		if(callback) {
			render contentType: "application/json", callback({
				errors {
					productDetailInstance?.errors?.fieldErrors?.each {
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
					productDetailInstance?.errors?.fieldErrors?.each {
						err ->
							field(err.field)
							message(g.message(error:err))
					}
				}
			}
		}
	}
}
