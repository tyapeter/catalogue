package com.teravin.catalogue.security

import grails.converters.JSON

/**
 * Created by IntelliJ IDEA.
 * User: Ronald
 * Date: 4/16/12
 * Time: 9:02 PM
 * To change this template use File | Settings | File Templates.
 */
class RoleController {
    def getRoleLikeAuthority = {
        if( params.name ) {
            def m = Role.createCriteria()

            def roles = m.list{
                like('authority','%'+params.name+'%')

            }


            render roles as JSON
        }
    }

}
