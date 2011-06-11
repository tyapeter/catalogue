package com.teravin.catalogue

import com.teravin.catalogue.maintenance.UnitType

class ProductDetail {

    static auditable = true

    Product product
	Material material
	Double unit
	Double price
	Double idxx
	String isPriceOverwrite = "N"
	String deleteFlag = "N"
    int idx = 99
    String createdBy
    Date dateCreated
    String updatedBy = ""
    Date lastUpdated

    static constraints = {
		product()
		material()
		unit()
		price()
		idxx()
		isPriceOverwrite()
        idx(maxSize:3)
        createdBy(blank:false,maxSize:50)
        dateCreated(blank:false)
        updatedBy(maxSize:50)
        lastUpdated()
    }

    String toString() {
      "$name"
    }


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
		println "new ProductDetail inserted"
		// may optionally refer to newState map
	}
	def onDelete = {
		println "ProductDetail was deleted"
                // may optionally refer to oldState map
	}
	def onChange = { oldMap,newMap ->
		println "ProductDetail was changed ..."
		oldMap.each({ key, oldVal ->
			if(oldVal != newMap[key]) {
				println " * $key changed from $oldVal to " + newMap[key]
			}
		})
	}//*/
}
