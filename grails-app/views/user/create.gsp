

<%@ page import="com.teravin.catalogue.security.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main2" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/index2.gsp')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${userInstance}">
            <div class="errors">
                <g:renderErrors bean="${userInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="username"><g:message code="user.username.label" default="Username" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'username', 'errors')}">
                                    <g:textField name="username" value="${userInstance?.username}" />
                                </td>
                            </tr>
                        
                            %{--<tr class="prop">--}%
                                %{--<td valign="top" class="name">--}%
                                    %{--<label for="password"><g:message code="user.password.label" default="Password" /></label>--}%
                                %{--</td>--}%
                                %{--<td valign="top" class="value ${hasErrors(bean: userInstance, field: 'password', 'errors')}">--}%
                                   %{--<input type="password" id="password" name="password" value="${userInstance.password?.encodeAsHTML()}"/>--}%
                                %{--</td>--}%
                            %{--</tr>--}%
                        	<tr class="prop">
                                <td valign="top" class="name" colspan="2">
                                	
                                    <table id="roleTbl" >
                                    	<thead>
                                    		<tr>
				                                <th valign="top" class="name" >
				                                    <label for="product"><g:message code="user.Roles.label" default="Roles" /></label>
				                                </th>
				                                 
				                            </tr>
			                            </thead >
                                    	<g:each in="${roleList}" status="i" var="material" class="value ${hasErrors(bean: roleList, field: 'roleList', 'errors')} >
	                                    	<tbody id="roles${i}">
	                                    		<!-- Role -->
					                        	
			                    				<tr>
			                    					<td width="10%">
			                                    		<g:textField class="roleName" name="roleName" id="roleName${i}" value="${role}" />
			                                		</td>
			                                		<td>
			                                		
			                                		</td>
			                                		<td width="10%">
			                                		<g:if test="${i == 0}">		                                		
				                                    		&nbsp;		                                    	
			                                    	</g:if>
			                                    	<g:else>
			                                    		<input type="button" class="ui-icon ui-icon-trash" value="Remove" onclick="removeRole(${i })"/>
			                                    	</g:else>
			                                    	</td>
			                    				</tr>
											</tbody>
										</g:each>	
		                    			<tfoot>
		                    			<tr class="prop">
			                                <td valign="top" class="name" colspan="2">
			                                    <input type="button" value="${message(code: 'default.button.add.label')}" default="Add Role" onclick="addRole()"/>
			                                	 <script type="text/javascript">
													var roleCount = ${roleList?.size()} + 0;
													var roleId;
													var idOfRoleTextBox;
													$(document).ready(function(){
														$('.roleName').live('keyup.autocomplete', function(){
															$(this).autocomplete({
																source: function( request, response ) {
																	var url = "${createLink(url: [controller: 'role', action: 'getRoleLikeAuthority'])}";
																	$.ajax({
																		url: url,
																		dataType: "json",
																		data: { name: request.term },
																		success: function( data ) {
																			
																			response( $.map( data, function( item ) {
																				roleID=item.id;
																				return {
																					label: item.authority,
																					value: item.authority,
																					id: item.id
																				   																				}
																			}));
																		}
																	});
																},
																minLength: 1,
																delay: 20,
																select: function(event, ui) {
																	
																	
															         $("#roleID"+idOfRoleTextBox).val(ui.item.id);
																	 
																	
															  }
																							
															});
														});
													
														
													});
										
													function addRole() {
														var htmlId = "role" + roleCount;
														var templateHtml = "<tbody id='" + htmlId + "'>\n";
														templateHtml += "<tr>";
														templateHtml += "<input type='hidden' name='roleID'  value='' id='roleID" + roleCount + "'/>\n";
														templateHtml += "<td width='10%'><input type='text' onFocus='setIdOfRoleTextBox("+roleCount+")' class='roleName' name='roleName'  value='' id='roleName" + roleCount + "'/></td>\n";
														templateHtml += "<td width='10%'><input class='ui-icon ui-icon-trash' type='button' value='Remove' onclick='removeRole("+roleCount+")'/></td>\n";
                                                        templateHtml += "</tr>\n";
														templateHtml += "</tbody>\n";
														$("#roleTbl").append(templateHtml);
														roleCount++;
													}
													function setIdOfRoleTextBox(idx)
													{
														this.idOfRoleTextBox = idx;

													}

													function removeRole(idx) {

														$("#role"+idx+"").remove()

													}


										</script>
			                                </td>
			                            </tr>
			                            </tfoot>
                                    </table>

                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="accountExpired"><g:message code="user.accountExpired.label" default="Account Expired" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'accountExpired', 'errors')}">
                                    <g:checkBox name="accountExpired" value="${userInstance?.accountExpired}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="accountLocked"><g:message code="user.accountLocked.label" default="Account Locked" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'accountLocked', 'errors')}">
                                    <g:checkBox name="accountLocked" value="${userInstance?.accountLocked}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="enabled"><g:message code="user.enabled.label" default="Enabled" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'enabled', 'errors')}">
                                    <g:checkBox name="enabled" value="${userInstance?.enabled}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="passwordExpired"><g:message code="user.passwordExpired.label" default="Password Expired" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'passwordExpired', 'errors')}">
                                    <g:checkBox name="passwordExpired" value="${userInstance?.passwordExpired}" />
                                </td>
                            </tr>

                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
