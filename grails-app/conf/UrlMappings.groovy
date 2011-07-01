class UrlMappings {

	static mappings = {
		"/login/$action?"(controller: "login")
		"/logout"(controller: "logout")
		
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		"/"(view:"/index")
		"500"(view:'/error')
	}
}
