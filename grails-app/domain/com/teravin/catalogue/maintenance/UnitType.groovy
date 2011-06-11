package com.teravin.catalogue.maintenance

class UnitType {

    static auditable = true

    String name
    String description = ""
	String deleteFlag = "N"
    int idx = 99
    String createdBy
    Date dateCreated
    String updatedBy = ""
    Date lastUpdated

    static constraints = {
        name(blank:false,maxSize:100)
        description(maxSize:500)
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
		println "new UnitType inserted"
		// may optionally refer to newState map
	}
	def onDelete = {
		println "UnitType was deleted"
                // may optionally refer to oldState map
	}
	def onChange = { oldMap,newMap ->
		println "UnitType was changed ..."
		oldMap.each({ key, oldVal ->
			if(oldVal != newMap[key]) {
				println " * $key changed from $oldVal to " + newMap[key]
			}
		})
	}//*/
}
