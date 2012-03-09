package com.teravin.catalogue

import java.util.Set;

import com.teravin.catalogue.maintenance.Color

class Product {

    static auditable = true
	String name
	String code
	String materials
	Model model
	MaterialMain materialMain
//	ProductType productType
	Color color
    Double width
	Double length
    Double height
    Double seatWidth
    Double seatLength
    Double seatHeight
    Double packingWidth
    Double packingLength
    Double packingHeight
	Double estLoad
    Double totalWeight
    Double totalCubic
	Double cbm
    BigDecimal indexPricing
    BigDecimal idxx
    BigDecimal price
    BigDecimal baseCost
	String deleteFlag = "N"
    int idx = 99
    String createdBy
    Date dateCreated
    String updatedBy = ""
    Date lastUpdated
	List productDetails
	String imagePathFront
	String imagePathSide
	String description = ""
	

	static hasMany = [productDetails:ProductDetail]

    static constraints = {
		code(nullable:true)
		materials(nullable:true)
		name()
        model()
//        productType(nullable:true)
		color(nullable:true)
		width()
		length()
        height()
        seatWidth()
        seatLength()
		seatHeight()
        packingWidth()
        packingLength()
        packingHeight()
		estLoad()
        totalWeight()
        totalWeight()
		cbm()
        indexPricing()
        idxx()
        price()
        baseCost()
        idx(maxSize:3)
        createdBy(blank:false,maxSize:50)
        dateCreated(blank:false)
        updatedBy(maxSize:50)
        lastUpdated()
		description(maxSize:500)
		imagePathFront(nullable:true)
		imagePathSide(nullable:true)
		
    }

    String toString() {
     "code :${code},name :${name},idxx: ${idxx},width : ${width},length: ${length},height: ${height},seatWidth : ${seatWidth},seatLength: ${seatLength},seatHeight: ${seatHeight}"
    }
//	static searchable = {
//		except = ["version", "createdBy", "dateCreated", "updatedBy", "lastUpdated"]
//		model component:true
//		only =["productDetails"]
//	}
//	


	
	

	Set<ProductDetail> getProductDetail() {
		ProductDetail.findByProduct(this).collect { it.productdetail } as Set
	}

	
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
