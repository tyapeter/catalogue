class UrlMappings {

	static mappings = {
		"/login/$action?"(controller: "login")
		"/logout"(controller: "logout")
		
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}
		"/undefined"(view: "/index")
		"/materialMain/getMaterialMenu"(view: "/index")
		"/"(view:"/index")
		"/backOffice"(view:"/index2")
		"500"(view:'/error')
	}
}
