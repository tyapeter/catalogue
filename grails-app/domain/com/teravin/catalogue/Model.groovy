package com.teravin.catalogue

class Model {

    static auditable = true
	
	String code
    String name
    String description = ""
	Double width
	Double heigth
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

    static constraints = {
        code(blank:false,maxSize:100)
        name(blank:false,maxSize:100)
        description(maxSize:500)
		width()
		heigth()
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
