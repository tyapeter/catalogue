package com.teravin.catalogue

import com.teravin.catalogue.ModelCategory
import com.teravin.catalogue.Product

class Model {

    static auditable = true
	static searchable = true
	String code
    String name
	ModelCategory modelCategory

	String imagePath
    String description = ""
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
	Double cbm
	String deleteFlag = "N"
    int idx = 99
    String createdBy
    Date dateCreated
    String updatedBy = ""
    Date lastUpdated

    static constraints = {
        code(blank:false,maxSize:100)
        name(blank:false,maxSize:100)
        description(maxSize:500)
        width()
        length()
        height()
        seatWidth(blank:true,maxSize:100)
        seatLength(blank:true,maxSize:100)
        seatHeight(blank:true,maxSize:100)
        packingWidth(blank:true,maxSize:100)
        packingLength(blank:true,maxSize:100)
        packingHeight(blank:true,maxSize:100)
		cbm()
        idx(maxSize:3)
        createdBy(blank:false,maxSize:50)
        dateCreated(blank:false)
        updatedBy(maxSize:50)
        lastUpdated()
		imagePath(nullable:true)
    }

    String toString() {
      "$name"
    }

	static hasMany = [products:Product]
	static mapping = {
		products cascade:"all-delete-orphan"
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
		println "new Model inserted"
		// may optionally refer to newState map
	}
	def onDelete = {
		println "Model was deleted"
                // may optionally refer to oldState map
	}
	def onChange = { oldMap,newMap ->
		println "Model was changed ..."
		oldMap.each({ key, oldVal ->
			if(oldVal != newMap[key]) {
				println " * $key changed from $oldVal to " + newMap[key]
			}
		})
	}//*/
}
