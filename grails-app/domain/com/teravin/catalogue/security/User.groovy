package com.teravin.catalogue.security

import java.util.List;

class User {

	String username
	String password
	boolean enabled
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

//    List roles = new ArrayList()
//
//	hasMany = [ roles:Role]
//	static belongsTo = Role
	static constraints = {
		username blank: false, unique: true
		password blank: false
	}

	static mapping = {
		password column: '`password`'
	}

	Set<Role> getAuthorities() {
		UserRole.findAllByUser(this).collect { it.role } as Set
	}
}
