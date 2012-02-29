package com.teravin.catalogue

import com.teravin.catalogue.Product
import com.teravin.catalogue.Material
import com.teravin.catalogue.Accesories
import com.teravin.catalogue.Miscellaneous
import org.apache.commons.collections.list.LazyList;
import org.apache.commons.collections.FactoryUtils;

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
	boolean _deleted
    
    static transients = [ '_deleted' ]
	static searchable = true
	
    static constraints = {
//		product()
		unit(nullable:true)
		price(nullable:true)
		idxx()
		isPriceOverwrite()
        idx(maxSize:3)
        createdBy(blank:false,maxSize:50)
        dateCreated(blank:false)
        updatedBy(maxSize:50)
        lastUpdated()
    }

    String toString() {
      "unit :${unit},price :${price},idxx: ${idxx},isPriceOverwrite : ${isPriceOverwrite},deleteFlag: ${deleteFlag}"
    }
	static belongsTo = [product:Product]

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
