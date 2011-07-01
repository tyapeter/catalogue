import grails.util.GrailsUtil

import com.teravin.catalogue.security.RequestMap
import com.teravin.catalogue.security.Role
import com.teravin.catalogue.security.User
import com.teravin.catalogue.security.UserRole

class BootStrap {

    def springSecurityService

    def init = { servletContext ->
    
      Object.metaClass.s = {
		def o = delegate.save()
		if (!o) {
			delegate.errors.allErrors.each {
				println it
			}
		}
		o
	  }

      def md5pass = springSecurityService.encodePassword('password')

      if (GrailsUtil.environment == 'development') {
        if (!User.get(1)) {
            new RequestMap(url: "/login/**",
                    configAttribute: "IS_AUTHENTICATED_ANONYMOUSLY").save()

            new RequestMap(url: "/css/**",
                    configAttribute: "IS_AUTHENTICATED_ANONYMOUSLY").save()

            new RequestMap(url: "/images/**",
                    configAttribute: "IS_AUTHENTICATED_ANONYMOUSLY").save()

            new RequestMap(url: "/js/**",
                    configAttribute: "IS_AUTHENTICATED_ANONYMOUSLY").save()

            new RequestMap(url: "/",
                    configAttribute: "IS_AUTHENTICATED_ANONYMOUSLY").save()

            new RequestMap(url: "/**",
                    configAttribute: "IS_AUTHENTICATED_FULLY").save()

            def role_user = Role.findByAuthority('ROLE_USER') ?: new Role(description: "User Role",
                authority: "ROLE_USER").save(failOnError:true)

            def tyapeter = User.findByUsername('tyapeter') ?: new User(username: 'tyapeter',
                password: md5pass,
                enabled: true).save(failOnError: true)

            if (!tyapeter.authorities.contains(role_user)) {
	            def userRole = UserRole.create(User.findByUsername('tyapeter'), Role.findByAuthority('ROLE_USER'))
                if (userRole.hasErrors()) println "Failed to assign user role to ${tyapeter.username}: ${userRole.errors}"
	        }
        }
      }
    }
    def destroy = {
    }
}
