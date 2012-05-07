package com.teravin.catalogue.security

import grails.converters.XML
import grails.converters.JSON


class UserController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def springSecurityService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		params.sort = "id"
		params.order = "asc"

        withFormat {
			html {
				[userInstanceList: User.list(params), userInstanceTotal: User.count()]
			}
			xml {
				render User.list( params ) as XML
			}
			json {
				response.status = 200
				if(params.callback) {
					render "${params.callback}(${User.list( params ) as JSON})"
				}
				else {
					render "${User.list( params ) as JSON}"
				}
			}
		}
    }

    def create = {
        def userInstance = new User()
        userInstance.properties = params
        return [userInstance: userInstance]
    }

    def save = {
        def userInstance = new User(params)
//        userInstance.createdBy = springSecurityService.principal.username
        def md5pass = springSecurityService.encodePassword('password')
        userInstance.password = md5pass
        def UserRole = new UserRole()
        def roleInstance;
        def sizes


        withFormat {
			html {
                if (userInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])}"
                    if(params.roleName!=null)
                    {

                        if(params.roleName.class == String)
                            sizes=1
                        else
                            sizes = params.roleName.size()

                        for(def i = 0; i<sizes; i++){



                            if(sizes==1){
                                roleInstance =Role.findByAuthority(params.roleName)

                            }else{
                                roleInstance = Role.findByAuthority(params.roleName[i])

                            }

                            UserRole.create(userInstance,roleInstance ,true)

                        }
                    }
                    redirect(action: "show", id: userInstance.id)
                }
                else {
                    render(view: "create", model: [userInstance: userInstance])
                }
			}
			xml {
				if(userInstance.save(flush: true)) {
					userInstance as XML
				}
				else {
					render "User not valid" as XML
				}
			}
			json {
				if(userInstance.save(flush: true)) {
					response.status = 201
					if(params.callback) {
						render "${params.callback}(${userInstance as JSON})"
					}
					else {
						render "${userInstance as JSON}"
					}
				}
				else {
					sendValidationFailedResponse(params.callback,userInstance,400)
				}
			}
		}
    }

    def show = {   
      withFormat {
        html {
            def userInstance = User.get( params.id )
            def userRoleList = UserRole.findAllByUser(userInstance)
            def roleList = new ArrayList()
            def role
            for (int i=0; i< userRoleList.size();i++){
               role = Role.findById(userRoleList[i].role.id)
               roleList.add(role)
            }

            if(!userInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
                redirect(action: "list")
            }
            else { return [ userInstance : userInstance, roleList : roleList ] }
          }
          xml {
              if(params.id && User.get(params.id)) {
                  def c = User.get(params.id)
                  render c as XML
              }
              else {
                  def all = User.get(params)
                  render all as XML
              }
          }
          json {
              if(params.id && User.get(params.id)) {
                  def c = User.get(params.id)
				  response.status = 200
				  if(params.callback) {
					  render "${params.callback}(${c as JSON})"
				  }
				  else {
					  render "${c as JSON}"
				  }
              }
              else {
                  def all = User.get(params)
				  response.status = 200
				  if(params.callback) {
					  render "${params.callback}(${all as JSON})"
				  }
				  else {
					  render "${all as JSON}}"
				  }
              }
          }
      	}
    }

    def edit = {
        def userInstance = User.get(params.id)
        def userRoleList = UserRole.findAllByUser(userInstance)
        def roleList = new ArrayList()
        def role
        for (int i=0; i< userRoleList.size();i++){
            role = Role.findById(userRoleList[i].role.id)
            roleList.add(role)
        }
        if (!userInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [userInstance: userInstance,roleList: roleList]
        }
    }

    def update = {
        def userInstance = User.get(params.id)
//        userInstance.updatedBy = springSecurityService.principal.username
        UserRole.executeUpdate("delete from UserRole ur where ur.user.id=?",[userInstance.id])
        System.out.println("testdekete")
        def sizes
        def roleInstance
        if(params.roleName!=null)
        {

            if(params.roleName.class == String)
                sizes=1
            else
                sizes = params.roleName.size()

            for(def i = 0; i<sizes; i++){



                if(sizes==1){
                     System.out.println("params.roleDelete"+params.roleDelete)

                    if(params.roleDelete=="false"){
                        roleInstance =Role.findByAuthority(params.roleName)
                        UserRole.create(userInstance,roleInstance ,true)
                    }
                }else{
                    System.out.println("params.roleDelete[i]"+params.roleDelete[i])
                    if(params.roleDelete[i]=="false"){
                        roleInstance = Role.findByAuthority(params.roleName[i])
                        UserRole.create(userInstance,roleInstance ,true)
                    }
                }

            }



        }
        withFormat {
			html {
				if(userInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(userInstance.version > version) {
							
							userInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'user.label', default: 'User')] as Object[], "Another user has updated this User while you were editing")
							render(view:"edit", model:[userInstance:userInstance])
							return
						}
					}
					userInstance.properties = params
					if(!userInstance.hasErrors() && userInstance.save(flush: true)) {
						flash.message = "${message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])}"
						redirect(action: "show", id:userInstance.id)
					}
					else {
						render(view: "edit", model:[userInstance:userInstance])
					}
				}
				else {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(userInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(userInstance.version > version) {
							render "User has been updated by another user" as XML
						}
					}
					userInstance.properties = params
					if(!userInstance.hasErrors() && userInstance.save(flush: true)) {
						userInstance as XML
					}
					else {
						render "User not valid" as XML
					}
				}
				else {
					render "User not found with id ${params.id}" as XML
				}
			}
			json {
				if(userInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(userInstance.version > version) {
							response.status = 409
						}
					}
					userInstance.properties = params
					if(!userInstance.hasErrors() && userInstance.save(flush: true)) {
						response.status = 200
						if(params.callback) {
							render "${params.callback}(${userInstance as JSON})"
						}
						else {
							render "${userInstance as JSON}"
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
        def userInstance = User.get(params.id)
//		userInstance.updatedBy = springSecurityService.principal.username
        withFormat {
			html {
				if(userInstance) {
					try {
						userInstance.deleteFlag = "Y";
						userInstance.save(flush:true);
                        flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
                        redirect(action: "list")
                    }
                    catch (org.springframework.dao.DataIntegrityViolationException e) {
                        flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
                        redirect(action: "show", id: params.id)
                    }
                }
                else {
                    flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
                    redirect(action: "list")
                }
			}
			xml {
				if(params.id && userInstance) {
					try {
						userInstance.deleteFlag = "Y";
						userInstance.save(flush:true);
						render "User ${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "User ${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "User not found with id ${params.id}" as XML
				}
			}
			json {
				if(params.id && userInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(userInstance.version > version) {
							response.status = 409
						}
					}
					try {
						userInstance.deleteFlag = "Y";
						userInstance.save(flush:true)
						response.status = 204
						if(params.callback) {
							render "${params.callback}(${userInstance as JSON})"
						}
						else {
							render "${userInstance as JSON}"
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
		def userInstance = User.get(params.id)
		withFormat {
			html {
				if(userInstance) {
					try {
						UserRole.removeAll(userInstance)
                        userInstance.delete(flush: true)

						flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
						redirect(action: "list")
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
						redirect(action: "show", id: params.id)
					}
				}
				else {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
					redirect(action: "list")
				}
			}
			xml {
				if(params.id && userInstance) {
					try {
						userInstance.delete(flush:true)
						render "User ${params.id} deleted" as XML
					}
					catch (org.springframework.dao.DataIntegrityViolationException e) {
						render "User ${params.id} could not be deleted" as XML
					}
				}
				else {
				  render "User not found with id ${params.id}" as XML
				}
			}
			json {
				if(params.id && userInstance) {
					if(params.version) {
						def version = params.version.toLong()
						if(userInstance.version > version) {
							response.status = 409
						}
					}
					try {
						userInstance.delete(flush:true)
						response.status = 204
						if(params.callback) {
							render "${params.callback}(${userInstance as JSON})"
						}
						else {
							render "${userInstance as JSON}"
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
		def listData = User.findAll(params)
		def totalRecord=User.count()

		
		listData.each{list <<[it.id,it.username,it.password,it.accountExpired,it.accountLocked,it.enabled]}

		def data = ["iTotalRecords": totalRecord,"iTotalDisplayRecords": totalRecord,"aaData":list]
		render data as JSON
	}

	String getColumnToField (String index)
	{
		if ( index == '0' ) return "id";
					else if ( index == '1' ) return "username";
					else if ( index == '2' ) return "password";
					else if ( index == '3' ) return "accountExpired";
					else if ( index == '4' ) return "accountLocked";
					else if ( index == '5' ) return "enabled";
					
	}
	
	private def sendValidationFailedResponse(callback, userInstance, status)
	{
		response.status = status
		if(callback) {
			render contentType: "application/json", callback({
				errors {
					userInstance?.errors?.fieldErrors?.each {
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
					userInstance?.errors?.fieldErrors?.each {
						err ->
							field(err.field)
							message(g.message(error:err))
					}
				}
			}
		}
	}
}
