package com.teravin.catalogue

import java.util.Set;

import com.teravin.catalogue.maintenance.Color

class Product {

    static auditable = true
	
	String code
	Model model
	ProductType productType
	Color color
    Double width
	Double height
	Double length
	Double seatHeight
	Double estLoad
	Double cbm
	String deleteFlag = "N"
    int idx = 99
    String createdBy
    Date dateCreated
    String updatedBy = ""
    Date lastUpdated
//	List productDetails
	static hasMany = [ productDetails:ProductDetail ]
    static constraints = {
		code(nullable:true)
        model()
        productType(nullable:true)
		color(nullable:true)
		width()
		height()
		length()
		seatHeight()
		estLoad()
		cbm()
        idx(maxSize:3)
        createdBy(blank:false,maxSize:50)
        dateCreated(blank:false)
        updatedBy(maxSize:50)
        lastUpdated()
    }

    String toString() {
      "code:${code},model:${model},width:${width},height:${height},length:${length},seatHeightL:${seatHeight},estLoad:${estLoad},cbm:${cbm}"
    }
	
<<<<<<< HEAD
	static hasMany = [productDetails:ProductDetail]
	
=======
	
//	static belongsTo =ProductDetail
	
//	Set<ProductDetail> getProductDetails() {
//		ProductDetail.findByProduct(this).collect { it.productdetail } as Set
//	}
>>>>>>> dev-0.1
	
	static mapping = {
		productDetails cascade:"all-delete-orphan"
	}
//	def getExpandableProductDetailList() {
//		return LazyList.decorate(productDetails,FactoryUtils.instantiateFactory(ProductDetail.class))
//	}
  /**
    *
    */
   def beforeInsert = {
//        createdBy = springSecurityService.principal.username
        dateCreated = new Date()
   }
   def beforeUpdate ={
//        updatedBy = springSecurityService.principal.username
        lastUpdated = new Date()
   }

    /**
     * Audit Logging
     */
    def onSave = {
		println "new Product inserted"
		// may optionally refer to newState map
	}
	def onDelete = {
		println "Product was deleted"
                // may optionally refer to oldState map
	}
	def onChange = { oldMap,newMap ->
		println "Product was changed ..."
		oldMap.each({ key, oldVal ->
			if(oldVal != newMap[key]) {
				println " * $key changed from $oldVal to " + newMap[key]
			}
		})
	}//*/
}
