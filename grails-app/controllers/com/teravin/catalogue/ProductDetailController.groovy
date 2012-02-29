package com.teravin.catalogue

import grails.converters.XML
import grails.converters.JSON
import com.teravin.catalogue.Product
import com.teravin.catalogue.ProductDetail
import com.teravin.catalogue.Model
import com.teravin.catalogue.Material

class ProductDetailController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def springSecurityService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		params.sort = "id"
		params.order = "asc"
		
		def productList = Product.createCriteria().list(params){
			eq("deleteFlag","N")
			maxResults(params.max)
			
		}
        withFormat {
			html {
				[productInstanceList: productList, productInstanceTotal: productList.getTotalCount()]
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
	

	def listFront = {
		params.max = Math.min(params.max ? params.int('max') : 8, 100)
		
		if(params.sort==null)
		{
		
			params.sort="id"
		
		}
		println("========"+params.sort)
		if(params.offset==null)
		{
			
			params.offset=0
			
		}
		if(params.order==null)
		{
			
			params.order="asc"
			
		}	
		println("========"+params.order)
	//	def products = ProductDetail.executeQuery("select pd.product.id as id,pd.product.name as name,pd.product.code as code,pd.product.dateCreated as dateCreated from ProductDetail pd  where pd.product.deleteFlag='N' and pd.material.materialCategory.id=?  and pd.product.model.modelCategory.id=?  order by "+params.sort+" "+params.order,[Long.parseLong(params.materialCategoryId) ,Long.parseLong(params.modelId)],[max:params.max,offset:params.offset])
		def products = ProductDetail.executeQuery("select pd.product.id as id,pd.product.name as name,pd.product.id as code,pd.product.dateCreated as dateCreated from ProductDetail pd  where pd.product.deleteFlag='N' and pd.material.materialCategory.id=?  and pd.product.model.modelCategory.id=?  order by "+params.sort+" "+params.order,[Long.parseLong(params.materialCategoryId) ,Long.parseLong(params.modelId)],[max:params.max,offset:params.offset])
	//	def productsCount = Product.executeQuery("select pd.product.id as id,pd.product.name as name,pd.product.code as code,pd.product.dateCreated as dateCreated from ProductDetail pd  where pd.product.deleteFlag='N' and pd.material.materialCategory.id=?  and pd.product.model.modelCategory.id=?  ",[Long.parseLong(params.materialCategoryId) ,Long.parseLong(params.modelId)]).size()
		def productsCount = Product.executeQuery("select pd.product.id as id,pd.product.name as name,pd.product.id as code,pd.product.dateCreated as dateCreated from ProductDetail pd  where pd.product.deleteFlag='N' and pd.material.materialCategory.id=?  and pd.product.model.modelCategory.id=?  ",[Long.parseLong(params.materialCategoryId) ,Long.parseLong(params.modelId)]).size()
		def productsList = new ArrayList()
		def product
		def materialList
		def materialTemp
		for (def i=0;i < products.size();i++)
		{	
			
			product = Product.get(products[i][0])
			
			materialList = ProductDetail.executeQuery("select pd.material.name from ProductDetail pd where pd.product.deleteFlag='N' and pd.product.id=?",product.id);
				
			
			materialTemp=""
			for(def x=0;x < materialList.size();x++)
			{
				if(x > 0)
					materialTemp = materialTemp +" ,"
				materialTemp = materialTemp +""+ materialList[x]
				
			}
			
			product.materials = materialTemp
			productsList.add(product)
		}
		println("========"+productsList)
		withFormat {
			html {
				[productInstanceList: productsList, productInstanceTotal: productsCount,materialCategoryName:params.materialCategoryName,modelName:params.modelName,modelId:params.modelId,materialCategoryId:params.materialCategoryId,sort:params.sort]
			}
			xml {
				render productsList as XML
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
	
    def create = {
        def productInstance = new Product()
        productInstance.properties = params
		
        return [productInstance: productInstance]
    }

    def save = {
		println(params)
		def productDetailInstance
		def product = new Product(params)
		product.createdBy= springSecurityService.principal.username
		if(params.name=="")
			product.name=null
		def error = false
		def materialList
		def accesoriesList
		def miscellaneousList
		
		try{
				product.model	 = Model.get(params.modelID)
				product.idxx = new BigDecimal(params.idxx)
				def sizes
				if(params.materialName!=null)
				{
					
					if(params.materialName.class == String)
						sizes=1
					else
						sizes = params.materialName.size()
						
					for(def i = 0; i<sizes; i++){
						productDetailInstance = new ProductDetail()
						productDetailInstance.properties = params
						
						if(sizes==1){
							productDetailInstance.material= Material.get(params.materialID)
							productDetailInstance.price = Double.parseDouble(params.materialPrice)
							productDetailInstance.idxx = Double.parseDouble(params.materialIndex)
							if(params.productMaterialIndex!="" && params.productMaterialIndex!=null)
								productDetailInstance.idxx = Double.parseDouble(params.productMaterialIndex)
							else
								productDetailInstance.idxx = Double.parseDouble(params.materialIndex)
								
							productDetailInstance.unit= Double.parseDouble(params.materialUnit)
						
						}else{
							productDetailInstance.material= Material.get(params.materialID[i])
							productDetailInstance.price = Double.parseDouble(params.materialPrice[i])
							if(params.productMaterialIndex[i]!="" && params.productMaterialIndex[i]!=null)
								productDetailInstance.idxx = Double.parseDouble(params.productMaterialIndex[i])
							else
								productDetailInstance.idxx = Double.parseDouble(params.materialIndex[i])
							productDetailInstance.unit= Double.parseDouble(params.materialUnit[i])
						}
												
						productDetailInstance.createdBy = springSecurityService.principal.username
						
						product.addToProductDetails(productDetailInstance)
						
					}
				}
				if(params.accesoriesName!=null)
				{
					if(params.accesoriesName.class == String)
						sizes=1
					else
						sizes = params.accesoriesName.size()
					for(def i = 0; i<sizes; i++){
						
						productDetailInstance = new ProductDetail(params)
						
						
						if(sizes==1){
							productDetailInstance.material = Material.get(params.accesoriesID)
							productDetailInstance.price = Double.parseDouble(params.accesoriesPrice)
							productDetailInstance.idxx = Double.parseDouble(params.accesoriesIndex)
							productDetailInstance.unit = Double.parseDouble(params.accesoriesUnit)
						}else{
							productDetailInstance.material = Material.get(params.accesoriesID[i])
							productDetailInstance.price = Double.parseDouble(params.accesoriesPrice[i])
							productDetailInstance.idxx = Double.parseDouble(params.accesoriesIndex)
							productDetailInstance.idxx = Double.parseDouble(params.accesoriesIndex[i])
							productDetailInstance.unit = Double.parseDouble(params.accesoriesUnit[i])
						}
						productDetailInstance.createdBy = springSecurityService.principal.username
						product.addToProductDetails(productDetailInstance)
						
					}
				}
				if(params.miscellaneousName !=null)
				{
					if(params.miscellaneousName.class == String)
						sizes=1
					else
						sizes = params.miscellaneousName.size()
					
					for(def i = 0; i< sizes; i++){
						
						productDetailInstance = new ProductDetail(params)
						
						if(sizes==1){
							productDetailInstance.material = Material.get(params.miscellaneousID)
							productDetailInstance.price = Double.parseDouble(params.miscellaneousPrice)
							productDetailInstance.idxx = Double.parseDouble(params.miscellaneousPrice)
							productDetailInstance.unit = Double.parseDouble(params.miscellaneousUnit)
						}else{
							productDetailInstance.material = Material.get(params.miscellaneousID[i])
							productDetailInstance.price = Double.parseDouble(params.miscellaneousPrice[i])
							productDetailInstance.idxx = Double.parseDouble(params.miscellaneousIndex[i])
							productDetailInstance.unit = Double.parseDouble(params.miscellaneousUnit[i])
						}
						productDetailInstance.createdBy = springSecurityService.principal.username

						product.addToProductDetails(productDetailInstance)
						
					}
				}

				
		}catch(RuntimeException e){	
			println e
			error = true
			if (e instanceof MissingResourceException) {
				println "aa"+e.getMessage()
				flash.message = e.getMessage()
			}
			materialList = new ArrayList()
//			if(params.materialName.class == String){
//				materialList.add(params.materialName)
//			}
//			else{
//				for(def i = 0; i<params.materialName.size(); i++){
//					materialList.add(params.materialName[i])
//				}
//			}
			
		}
        withFormat {
			html {
				if (!error && product.save(flush:true)) {
					flash.message = "${message(code: 'default.created.message', args: [message(code: 'product.label', default: 'Product'), product.id])}"
					redirect(action: "show", id: product.id)
				}
				else { 
					
					render(view: "create", model: [productInstance: product, materialList :materialList ])
				}
			}
			xml {
				if (!error && product.save(flush:true)) {
					result as XML
				}
				else {
					render "Product not valid" as XML
				}
			}
			json {
				if (!error && product.save(flush:true)) {
					response.status = 201
					if(params.callback) {
						render "${params.callback}(${result as JSON})"
					}
					else {
						render "${result as JSON}"
					}
				}
				else {
					sendValidationFailedResponse(params.callback,product,400)
				}
			}
		}
    }

    def show = {   
      def productInstance = Product.get(params.id)
	  def materialList = ProductDetail.createCriteria().list{ 
							product{
								eq('id',productInstance.id)
								
							}
		  					material{
								  materialCategory{
									  materialType{
										  eq('name','material')
						
									  }
								  }
							  }
					}
	  def accesoriesList = ProductDetail.createCriteria().list{
		  product{
			  eq('id',productInstance.id)
			
		  }
			material{
				materialCategory{
					materialType{
						eq('name','accesories')
	
					}
				}
			}
	  }
	  def miscellaneousList = ProductDetail.createCriteria().list{
		  product{
			  eq('id',productInstance.id)
			
		  }
			material{
				materialCategory{
					materialType{
						eq('name','miscellaneous')
					}
				}
			}
	  }
	 
      withFormat {
        html {
           
            if(!productInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'productDetail.label', default: 'ProductDetail'), params.id])}"
                redirect(action: "list")
            }
            else { return [ productInstance : productInstance,materialList:materialList,accesoriesList:accesoriesList,miscellaneousList:miscellaneousList ] }
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
        def productInstance = Product.get(params.id)
		println("productInstance=="+productInstance.model.modelCategory.name)
		def materialList = ProductDetail.createCriteria().list{ 
							product{
								eq('id',productInstance.id)
							}
		  					material{
								  materialCategory{
									  materialType{
										  eq('name','material')
									  }
								  }
							  }
					}
	  def accesoriesList = ProductDetail.createCriteria().list{
		  product{
			  eq('id',productInstance.id)
		  }
			material{
				materialCategory{
					materialType{
						eq('name','accesories')
					}
				}
			}
	  }
	  def miscellaneousList = ProductDetail.createCriteria().list{
		  product{
			  eq('id',productInstance.id)
		  }
			material{
				materialCategory{
					materialType{
						eq('name','miscellaneous')
					}
				}
			}
	  }
	    if (!productInstance) {
	        flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'productDetail.label', default: 'Product'), params.id])}"
	        redirect(action: "list")
	    }
	    else {
	        return [productInstance: productInstance,materialList:materialList, accesoriesList:accesoriesList, miscellaneousList:miscellaneousList]
	    }
    }

     def update = {
		 
        def productInstance = Product.get(params.id)
        productInstance.updatedBy = springSecurityService.principal.username
		
		println(params)
	
	
		def productDetailInstance
	
		def error = false
		def sizes=0
		try{
				
				
				productInstance.updatedBy = springSecurityService.principal.username
				productInstance.model	 = Model.get(params.modelID)
				
//				
				
	
		}catch(RuntimeException e){
			println e
			error = true
			if (e instanceof MissingResourceException) {
				println "aa"+e.getMessage()
				flash.message = e.getMessage()
			}
			
		}
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
					if(params.materialName!=null)
					{
					
						if(params.materialName.class == String)
							sizes=1
						else
							sizes = params.materialName.size()
						
							println("========"+sizes)	
						for(def i = 0; i<sizes; i++){
							
							if(sizes==1){
								if(params.productDetailInstance!="null")
								{
									productDetailInstance = ProductDetail.get(params.productDetailInstance)
									productDetailInstance.material= Material.get(params.materialID)
									productDetailInstance.price = Double.parseDouble(params.materialPrice)
									productDetailInstance.idxx = Double.parseDouble(params.materialIndex)
									productDetailInstance.updatedBy = springSecurityService.principal.username
									
									if(params.materialDelete=="false")
										productDetailInstance.save(flush:true)
									else{
										productDetailInstance.delete(flush: true)
									}
								}else{
									productDetailInstance=new ProductDetail()
									productDetailInstance.material= Material.get(params.materialID)
									productDetailInstance.price = Double.parseDouble(params.materialPrice)
									productDetailInstance.idxx = Double.parseDouble(params.materialIndex)
									productDetailInstance.createdBy = springSecurityService.principal.username
									productDetailInstance.updatedBy = springSecurityService.principal.username
									
									productInstance.addToProductDetails(productDetailInstance)
									
								}
							}else{
								
								if(params.productDetailInstance[i]!="null")
								{
									productDetailInstance = ProductDetail.get(params.productDetailInstance[i])
									productDetailInstance.material= Material.get(params.materialID[i])
									productDetailInstance.price = Double.parseDouble(params.materialPrice[i])
									productDetailInstance.idxx = Double.parseDouble(params.materialIndex[i])
									productDetailInstance.updatedBy = springSecurityService.principal.username
								
									if(params.materialDelete[i]=="false")
										
										productDetailInstance.save(flush:true)
									else{
										productDetailInstance.delete(flush: true)
										
									}
								}else{
									productDetailInstance=new ProductDetail()
									productDetailInstance.material= Material.get(params.materialID[i])
									productDetailInstance.price = Double.parseDouble(params.materialPrice[i])
									productDetailInstance.idxx = Double.parseDouble(params.materialIndex[i])
									productDetailInstance.updatedBy = springSecurityService.principal.username
									productDetailInstance.createdBy = springSecurityService.principal.username
								
									productDetailInstance.isPriceOverwrite="N"
									productInstance.addToProductDetails(productDetailInstance)
								
								}
							}
													
													
							
						}
					}
					if(params.accesoriesName!=null)
					{
					
						if(params.accesoriesName.class == String)
							sizes=1
						else
							sizes = params.accesoriesName.size()
						
							println("========"+sizes)
						for(def i = 0; i<sizes; i++){
							
							if(sizes==1){
								if(params.productDetailAccesoriesInstance!="null")
								{
									productDetailInstance = ProductDetail.get(params.productDetailAccesoriesInstance)
									productDetailInstance.material= Material.get(params.accesoriesID)
									productDetailInstance.price = Double.parseDouble(params.accesoriesPrice)
									productDetailInstance.idxx = Double.parseDouble(params.accesoriesIndex)
									productDetailInstance.updatedBy = springSecurityService.principal.username
									
									if(params.accesoriesDelete=="false")
										productDetailInstance.save(flush:true)
									else{
										productDetailInstance.delete(flush: true)
									}
								}else{
									productDetailInstance=new ProductDetail()
									productDetailInstance.material= Material.get(params.accesoriesID)
									productDetailInstance.price = Double.parseDouble(params.accesoriesPrice)
									productDetailInstance.idxx = Double.parseDouble(params.accesoriesIndex)
									productDetailInstance.createdBy = springSecurityService.principal.username
									productDetailInstance.updatedBy = springSecurityService.principal.username
									
									productInstance.addToProductDetails(productDetailInstance)
									
								}
							}else{
								
								if(params.productDetailAccesoriesInstance[i]!="null")
								{
									productDetailInstance = ProductDetail.get(params.productDetailAccesoriesInstance[i])
									productDetailInstance.material= Material.get(params.accesoriesID[i])
									productDetailInstance.price = Double.parseDouble(params.accesoriesPrice[i])
									productDetailInstance.idxx = Double.parseDouble(params.accesoriesIndex[i])
									productDetailInstance.updatedBy = springSecurityService.principal.username
								
									if(params.accesoriesDelete[i]=="false")
										
										productDetailInstance.save(flush:true)
									else{
										productDetailInstance.delete(flush: true)
										
									}
								}else{
									productDetailInstance=new ProductDetail()
									productDetailInstance.material= Material.get(params.accesoriesID[i])
									productDetailInstance.price = Double.parseDouble(params.accesoriesPrice[i])
									productDetailInstance.idxx = Double.parseDouble(params.accesoriesIndex[i])
									productDetailInstance.updatedBy = springSecurityService.principal.username
									productDetailInstance.createdBy = springSecurityService.principal.username
							
									productDetailInstance.isPriceOverwrite="N"
									productInstance.addToProductDetails(productDetailInstance)
								
								}
							}
													
													
							
						}
					}
					if(params.miscellaneousName!=null)
					{
					
						if(params.miscellaneousName.class == String)
							sizes=1
						else
							sizes = params.miscellaneousName.size()
						
							println("========"+sizes)
						for(def i = 0; i<sizes; i++){
							
							if(sizes==1){
								if(params.productDetailMiscellaneousInstance!="null")
								{
									productDetailInstance = ProductDetail.get(params.productDetailMiscellaneousInstance)
									productDetailInstance.material= Material.get(params.miscellaneousID)
									productDetailInstance.price = Double.parseDouble(params.miscellaneousPrice)
									productDetailInstance.idxx = Double.parseDouble(params.miscellaneousIndex)
									productDetailInstance.updatedBy = springSecurityService.principal.username
									
									if(params.miscellaneousDelete=="false")
										productDetailInstance.save(flush:true)
									else{
										productDetailInstance.delete(flush: true)
									}
								}else{
									productDetailInstance=new ProductDetail()
									productDetailInstance.material= Material.get(params.miscellaneousID)
									productDetailInstance.price = Double.parseDouble(params.miscellaneousPrice)
									productDetailInstance.idxx = Double.parseDouble(params.miscellaneousIndex)
									productDetailInstance.createdBy = springSecurityService.principal.username
									productDetailInstance.updatedBy = springSecurityService.principal.username
									
									productInstance.addToProductDetails(productDetailInstance)
									
								}
							}else{
								
								if(params.productDetailMiscellaneousInstance[i]!="null")
								{
									productDetailInstance = ProductDetail.get(params.productDetailMiscellaneousInstance[i])
									productDetailInstance.material= Material.get(params.miscellaneousID[i])
									productDetailInstance.price = Double.parseDouble(params.miscellaneousPrice[i])
									productDetailInstance.idxx = Double.parseDouble(params.miscellaneousIndex[i])
									productDetailInstance.updatedBy = springSecurityService.principal.username
								
									if(params.miscellaneousDelete[i]=="false")
										
										productDetailInstance.save(flush:true)
									else{
										productDetailInstance.delete(flush: true)
										
									}
								}else{
									productDetailInstance=new ProductDetail()
									productDetailInstance.material= Material.get(params.miscellaneousID[i])
									productDetailInstance.price = Double.parseDouble(params.miscellaneousPrice[i])
									productDetailInstance.idxx = Double.parseDouble(params.miscellaneousIndex[i])
									productDetailInstance.updatedBy = springSecurityService.principal.username
									productDetailInstance.createdBy = springSecurityService.principal.username
							
									productDetailInstance.isPriceOverwrite="N"
									productInstance.addToProductDetails(productDetailInstance)
								
								}
							}
													
													
							
						}
					}
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
							render "${params.callback}(${productDetailInstance as JSON})"
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
