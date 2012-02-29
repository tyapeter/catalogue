package com.teravin.catalogue

import grails.converters.XML
import grails.converters.JSON

class ProductController {

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
				[productInstanceList: Product.list(params), productInstanceTotal: Product.count()]
			}
			xml {
				render Product.list( params ) as XML
			}
			json {
				response.status = 200
				if(params.callback) {
					render "${params.callback}(${Product.list( params ) as JSON})"
				}
				else {
					render "${Product.list( params ) as JSON}"
				}
			}
		}
    }
	def listSearch = {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		params.properties = ["Product.model.name","Product.model.code"]

		if (!params.sort && !params.order) {
			params.sort = "name"
			params.order = "asc"
		}

		def query = "+deleteFlag:N "
		if (params.test) {
			query += "*${params.test}*"
		}
		
		def results = new ArrayList()
		def result = Product.search(query, params).results
		results.add(result)
			
		def count = Product.countHits(query, properties: ["Product.model.name","Product.model.code"])
		results.add(count)
		for (i in 0..<result.size()) {
			println	"${result[i].toString()} " 
				
		}
		System.out.println("results====="+results[1].toString())

		return results
	}
    def create = {
        def productInstance = new Product()
        productInstance.properties = params
        return [productInstance: productInstance]
    }

    def save = {
        def productInstance = new Product(params)
        productInstance.createdBy = springSecurityService.principal.username
        withFormat {
			html {
                if (productInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.created.message', args: [message(code: 'product.label', default: 'Product'), productInstance.id])}"
                    redirect(action: "show", id: productInstance.id)
                }
                else {
                    render(view: "create", model: [productInstance: productInstance])
                }
			}
			xml {
				if(productInstance.save(flush: true)) {
					productInstance as XML
				}
				else {
					render "Product not valid" as XML
				}
			}
			json {
				if(productInstance.save(flush: true)) {
					response.status = 201
					if(params.callback) {
						render "${params.callback}(${productInstance as JSON})"
					}
					else {
						render "${productInstance as JSON}"
					}
				}
				else {
					sendValidationFailedResponse(params.callback,productInstance,400)
				}
			}
		}
    }

    def show = {   
      withFormat {
        html {
            def productInstance = Product.get( params.id )
            if(!productInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'product.label', default: 'Product'), params.id])}"
                redirect(action: "list")
            }
            else { return [ productInstance : productInstance ] }
          }
          xml {
              if(params.id && Product.get(params.id)) {
                  def c = Product.get(params.id)
                  render c as XML
              }
              else {
                  def all = Product.get(params)
                  render all as XML
              }
          }
          json {
              if(params.id && Product.get(params.id)) {
                  def c = Product.get(params.id)
				  response.status = 200
				  if(params.callback) {
					  render "${params.callback}(${c as JSON})"
				  }
				  else {
					  render "${c as JSON}"
				  }
              }
              else {
                  def all = Product.get(params)
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
        def productInstance = Product.get(params.id)
        if (!productInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'product.label', default: 'Product'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [productInstance: productInstance]
        }
    }

    def update = {
        def productInstance = Product.get(params.id)
        productInstance.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(productInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(productInstance.version > version) {
							
							productInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'product.label', default: 'Product')] as Object[], "Another user has updated this Product while you were editing")
							render(view:"edit", model:[productInstance:productInstance])
							return
						}
					}
					productInstance.properties = params
					if(!productInstance.hasErrors() && productInstance.save(flush: true)) {
						flash.message = "${message(code: 'default.updated.message', args: [message(code: 'product.label', default: 'Product'), productInstance.id])}"
						redirect(action: "show", id:productInstance.id)
					}
					else {
						render(view: "edit", model:[productInstance:productInstance])
					}
				}
				else {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'product.label', default: 'Product'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(productInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(productInstance.version > version) {
							render "Product has been updated by another user" as XML
						}
					}
					productInstance.properties = params
					if(!productInstance.hasErrors() && productInstance.save(flush: true)) {
						productInstance as XML
					}
					else {
						render "Product not valid" as XML
					}
				}
				else {
					render "Product not found with id ${params.id}" as XML
				}
			}
			json {
				if(productInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(productInstance.version > version) {
							response.status = 409
						}
					}
					productInstance.properties = params
					if(!productInstance.hasErrors() && productInstance.save(flush: true)) {
						response.status = 200
						if(params.callback) {
							render "${params.callback}(${productInstance as JSON})"
						}
						else {
							render "${productInstance as JSON}"
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
        def productInstance = Product.get(params.id)
		productInstance.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(productInstance) {
					try {
						productInstance.deleteFlag = "Y";
						productInstance.save(flush:true);
                        flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'product.label', default: 'Product'), params.id])}"
                        redirect(action: "list")
                    }
                    catch (org.springframework.dao.DataIntegrityViolationException e) {
                        flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'product.label', default: 'Product'), params.id])}"
                        redirect(action: "show", id: params.id)
                    }
                }
                else {
                    flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'product.label', default: 'Product'), params.id])}"
                    redirect(action: "list")
                }
			}
			xml {
				if(params.id && productInstance) {
					try {
						productInstance.deleteFlag = "Y";
						productInstance.save(flush:true);
						render "Product ${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "Product ${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "Product not found with id ${params.id}" as XML
				}
			}
			json {
				if(params.id && productInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(productInstance.version > version) {
							response.status = 409
						}
					}
					try {
						productInstance.deleteFlag = "Y";
						productInstance.save(flush:true)
						response.status = 204
						if(params.callback) {
							render "${params.callback}(${productInstance as JSON})"
						}
						else {
							render "${productInstance as JSON}"
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
		def productInstance = Product.get(params.id)
		withFormat {
			html {
				if(productInstance) {
					try {
						productInstance.delete(flush: true)
						flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'product.label', default: 'Product'), params.id])}"
						redirect(action: "list")
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'product.label', default: 'Product'), params.id])}"
						redirect(action: "show", id: params.id)
					}
				}
				else {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'product.label', default: 'Product'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(params.id && productInstance) {
					try {
						productInstance.delete(flush:true)
						render "Product ${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "Product ${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "Product not found with id ${params.id}" as XML
				}
			}
			json {
				if(params.id && productInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(productInstance.version > version) {
							response.status = 409
						}
					}
					try {
						productInstance.delete(flush:true)
						response.status = 204
						if(params.callback) {
							render "${params.callback}(${productInstance as JSON})"
						}
						else {
							render "${productInstance as JSON}"
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
		def listData = Product.findAll(params)
		def totalRecord=Product.count()

		
		listData.each{list <<[it.id,it.code,it.model,it.productType,it.color,it.width]}

		def data = ["iTotalRecords": totalRecord,"iTotalDisplayRecords": totalRecord,"aaData":list]
		render data as JSON
	}

	String getColumnToField (String index)
	{
		if ( index == '0' ) return "id";
					else if ( index == '1' ) return "code";
					else if ( index == '2' ) return "model";
					else if ( index == '3' ) return "productType";
					else if ( index == '4' ) return "color";
					else if ( index == '5' ) return "width";
					
	}
	
	private def sendValidationFailedResponse(callback, productInstance, status)
	{
		response.status = status
		if(callback) {
			render contentType: "application/json", callback({
				errors {
					productInstance?.errors?.fieldErrors?.each {
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
					productInstance?.errors?.fieldErrors?.each {
						err ->
							field(err.field)
							message(g.message(error:err))
					}
				}
			}
		}
	}
}
