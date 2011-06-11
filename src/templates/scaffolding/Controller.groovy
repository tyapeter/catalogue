<%=packageName ? "package ${packageName}\n\nimport grails.converters.XML\nimport grails.converters.JSON\n\n" : "import grails.converters.XML\nimport grails.converters.JSON\n\n"%>class ${className}Controller {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def springSecurityService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		params.sort = "idx"
		params.order = "asc"
        withFormat {
			html {
				[${propertyName}List: ${className}.list(params), ${propertyName}Total: ${className}.count()]
			}
			xml {
				render ${className}.list( params ) as XML
			}
			json {
				response.status = 200
				if(params.callback) {
					render "\${params.callback}(\${${className}.list( params ) as JSON})"
				}
				else {
					render "\${${className}.list( params ) as JSON}"
				}
			}
		}
    }

    def create = {
        def ${propertyName} = new ${className}()
        ${propertyName}.properties = params
        return [${propertyName}: ${propertyName}]
    }

    def save = {
        def ${propertyName} = new ${className}(params)
        ${propertyName}.createdBy = springSecurityService.principal.username
        withFormat {
			html {
                if (${propertyName}.save(flush: true)) {
                    flash.message = "\${message(code: 'default.created.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), ${propertyName}.id])}"
                    redirect(action: "show", id: ${propertyName}.id)
                }
                else {
                    render(view: "create", model: [${propertyName}: ${propertyName}])
                }
			}
			xml {
				if(${propertyName}.save(flush: true)) {
					${propertyName} as XML
				}
				else {
					render "${className} not valid" as XML
				}
			}
			json {
				if(${propertyName}.save(flush: true)) {
					response.status = 201
					if(params.callback) {
						render "\${params.callback}(\${${propertyName} as JSON})"
					}
					else {
						render "\${${propertyName} as JSON}"
					}
				}
				else {
					sendValidationFailedResponse(params.callback,${propertyName},400)
				}
			}
		}
    }

    def show = {   
      withFormat {
        html {
            def ${propertyName} = ${className}.get( params.id )
            if(!${propertyName}) {
                flash.message = "\${message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])}"
                redirect(action: "list")
            }
            else { return [ ${propertyName} : ${propertyName} ] }
          }
          xml {
              if(params.id && ${className}.get(params.id)) {
                  def c = ${className}.get(params.id)
                  render c as XML
              }
              else {
                  def all = ${className}.get(params)
                  render all as XML
              }
          }
          json {
              if(params.id && ${className}.get(params.id)) {
                  def c = ${className}.get(params.id)
				  response.status = 200
				  if(params.callback) {
					  render "\${params.callback}(\${c as JSON})"
				  }
				  else {
					  render "\${c as JSON}"
				  }
              }
              else {
                  def all = ${className}.get(params)
				  response.status = 200
				  if(params.callback) {
					  render "\${params.callback}(\${all as JSON})"
				  }
				  else {
					  render "\${all as JSON}}"
				  }
              }
          }
      	}
    }

    def edit = {
        def ${propertyName} = ${className}.get(params.id)
        if (!${propertyName}) {
            flash.message = "\${message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [${propertyName}: ${propertyName}]
        }
    }

    def update = {
        def ${propertyName} = ${className}.get(params.id)
        ${propertyName}.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(${propertyName}) {
					if(params.version) {
						def version = params.version.toLong()
						if(${propertyName}.version > version) {
							<%def lowerCaseName = grails.util.GrailsNameUtils.getPropertyName(className)%>
							${propertyName}.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: '${domainClass.propertyName}.label', default: '${className}')] as Object[], "Another user has updated this ${className} while you were editing")
							render(view:"edit", model:[${propertyName}:${propertyName}])
							return
						}
					}
					${propertyName}.properties = params
					if(!${propertyName}.hasErrors() && ${propertyName}.save(flush: true)) {
						flash.message = "\${message(code: 'default.updated.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), ${propertyName}.id])}"
						redirect(action: "show", id:${propertyName}.id)
					}
					else {
						render(view: "edit", model:[${propertyName}:${propertyName}])
					}
				}
				else {
					flash.message = "\${message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(${propertyName}) {
					if(params.version) {
						def version = params.version.toLong()
						if(${propertyName}.version > version) {
							render "${className} has been updated by another user" as XML
						}
					}
					${propertyName}.properties = params
					if(!${propertyName}.hasErrors() && ${propertyName}.save(flush: true)) {
						${propertyName} as XML
					}
					else {
						render "${className} not valid" as XML
					}
				}
				else {
					render "${className} not found with id \${params.id}" as XML
				}
			}
			json {
				if(${propertyName}) {
					if(params.version) {
						def version = params.version.toLong()
						if(${propertyName}.version > version) {
							response.status = 409
						}
					}
					${propertyName}.properties = params
					if(!${propertyName}.hasErrors() && ${propertyName}.save(flush: true)) {
						response.status = 200
						if(params.callback) {
							render "\${params.callback}(\${${propertyName} as JSON})"
						}
						else {
							render "\${${propertyName} as JSON}"
						}
					}
					else {
						response.status = 400
					}
				}
				else {
					response.status = 404
				}
			}
		}
    }

    def delete = {
        def ${propertyName} = ${className}.get(params.id)
		${propertyName}.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(${propertyName}) {
					try {
						${propertyName}.deleteFlag = "Y";
						${propertyName}.save(flush:true);
                        flash.message = "\${message(code: 'default.deleted.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])}"
                        redirect(action: "list")
                    }
                    catch (org.springframework.dao.DataIntegrityViolationException e) {
                        flash.message = "\${message(code: 'default.not.deleted.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])}"
                        redirect(action: "show", id: params.id)
                    }
                }
                else {
                    flash.message = "\${message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])}"
                    redirect(action: "list")
                }
			}
			xml {
				if(params.id && ${propertyName}) {
					try {
						${propertyName}.deleteFlag = "Y";
						${propertyName}.save(flush:true);
						render "${className} \${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "${className} \${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "${className} not found with id \${params.id}" as XML
				}
			}
			json {
				if(params.id && ${propertyName}) {
					if(params.version) {
						def version = params.version.toLong()
						if(${propertyName}.version > version) {
							response.status = 409
						}
					}
					try {
						${propertyName}.deleteFlag = "Y";
						${propertyName}.save(flush:true)
						response.status = 204
						if(params.callback) {
							render "\${params.callback}(\${${propertyName} as JSON})"
						}
						else {
							render "\${${propertyName} as JSON}"
						}
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						response.status = 405
					}
				}
				else {
				  response.status = 404
				}
			}
		}
    }
	
	def hardDelete = {
		def ${propertyName} = ${className}.get(params.id)
		withFormat {
			html {
				if(${propertyName}) {
					try {
						${propertyName}.delete(flush: true)
						flash.message = "\${message(code: 'default.deleted.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])}"
						redirect(action: "list")
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						flash.message = "\${message(code: 'default.not.deleted.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])}"
						redirect(action: "show", id: params.id)
					}
				}
				else {
					flash.message = "\${message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(params.id && ${propertyName}) {
					try {
						${propertyName}.delete(flush:true)
						render "${className} \${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "${className} \${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "${className} not found with id \${params.id}" as XML
				}
			}
			json {
				if(params.id && ${propertyName}) {
					if(params.version) {
						def version = params.version.toLong()
						if(${propertyName}.version > version) {
							response.status = 409
						}
					}
					try {
						${propertyName}.delete(flush:true)
						response.status = 204
						if(params.callback) {
							render "\${params.callback}(\${${propertyName} as JSON})"
						}
						else {
							render "\${${propertyName} as JSON}"
						}
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						response.status = 405
					}
				}
				else {
				  response.status = 404
				}
			}
		}
	}

    def returnJSON = {
		params.offset =  params.iDisplayStart ? params.iDisplayStart : 0
		params.max =  params.iDisplayLength ? params.iDisplayLength : 10
		params.sort=params.iSortCol_0 ? getColumnToField(params.iSortCol_0) : "id"
		params.order=params.sSortDir_0 ? params.sSortDir_0 : "asc"

		def list= []
		def listData = ${className}.findAll(params)
		def totalRecord=${className}.count()

		<%
			def paramList="";
			excludedProps = ['version',
				org.codehaus.groovy.grails.orm.hibernate.support.ClosureEventTriggeringInterceptor.ONLOAD_EVENT,
				org.codehaus.groovy.grails.orm.hibernate.support.ClosureEventTriggeringInterceptor.BEFORE_DELETE_EVENT,
				org.codehaus.groovy.grails.orm.hibernate.support.ClosureEventTriggeringInterceptor.BEFORE_INSERT_EVENT,
				org.codehaus.groovy.grails.orm.hibernate.support.ClosureEventTriggeringInterceptor.BEFORE_UPDATE_EVENT,
			   'idx',
			   'description',
			   'updatedBy',
			   'lastUpdated',
			   'onSave',
			   'onDelete',
			   'onChange']

			props = domainClass.properties.findAll { !excludedProps.contains(it.name) && it.type != Set.class }
			Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
			props.eachWithIndex { p,i ->
				if (i<6)
				{
					if(i==0)
					{
						paramList=paramList+"it."+p.name
					}else{
						paramList=paramList+",it."+p.name
					}
				}
			}
		%>
		listData.each{list <<[${paramList}]}

		def data = ["iTotalRecords": totalRecord,"iTotalDisplayRecords": totalRecord,"aaData":list]
		render data as JSON
	}

	String getColumnToField (String index)
	{
		<%
			props.eachWithIndex { p,i ->
				if(i<6)
				{
					if(i==0)
					{
					%>if ( index == '${i}' ) return "${p.name}";
					<%
						}else{
					%>else if ( index == '${i}' ) return "${p.name}";
					<%
					}
				}
			}
		%>
	}
	
	private def sendValidationFailedResponse(callback, ${propertyName}, status)
	{
		response.status = status
		if(callback) {
			render contentType: "application/json", callback({
				errors {
					${propertyName}?.errors?.fieldErrors?.each {
						err ->
							field(err.field)
							message(g.message(error:err))
					}
				}
			})
			
		}
		else {
			render contentType: "application/json", {
				errors {
					${propertyName}?.errors?.fieldErrors?.each {
						err ->
							field(err.field)
							message(g.message(error:err))
					}
				}
			}
		}
	}
}
