package com.teravin.catalogue.security

class Role {

	String authority
//	static hasMany = [people: User]
//	static belongsTo = [User]
	static mapping = {
		cache true
	}

	static constraints = {
		authority blank: false, unique: true
	}
}
