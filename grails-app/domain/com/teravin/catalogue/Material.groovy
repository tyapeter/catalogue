package com.teravin.catalogue

import com.teravin.catalogue.maintenance.UnitType

class Material {

    static auditable = true
	
	MaterialCategory materialCategory
	String code
	String type
	String isAccesories
    String name
	Double price
	Double idxx = 1
	UnitType unitType
    String description = ""
	String deleteFlag = "N"
    int idx = 99
    String createdBy
    Date dateCreated
    String updatedBy = ""
    Date lastUpdated

    static constraints = {
        name(blank:false,maxSize:100)
		code(blank:true,maxSize:100)
        description(maxSize:500)
        idx(maxSize:3)
		idxx(maxSize:10)
        isAccesories(blank:true,maxSize:100)
        type(blank:true,maxSize:100)
        createdBy(blank:false,maxSize:50)
        dateCreated(blank:false)
        updatedBy(maxSize:50)
        lastUpdated()
    }
	
    String toString() {
      "$name code:$code"
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
		println "new Material inserted"
		// may optionally refer to newState map
	}
	def onDelete = {
		println "Material was deleted"
                // may optionally refer to oldState map
	}
	def onChange = { oldMap,newMap ->
		println "Material was changed ..."
		oldMap.each({ key, oldVal ->
			if(oldVal != newMap[key]) {
				println " * $key changed from $oldVal to " + newMap[key]
			}
		})
	}//*/
}
