
<%@ page import="com.teravin.catalogue.maintenance.Kurs" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main2" />
        <g:set var="entityName" value="${message(code: 'kurs.label', default: 'Kurs')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="kurs.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: kursInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="kurs.name.label" default="Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: kursInstance, field: "name")}</td>
                            
                        </tr>
                    	 <tr class="prop">
                            <td valign="top" class="name"><g:message code="kurs.kursValue.label" default="Kurs Value" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: kursInstance, field: "kursValue")}</td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="kurs.description.label" default="Description" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: kursInstance, field: "description")}</td>
                            
                        </tr>
                    %{--
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="kurs.idx.label" default="Idx" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: kursInstance, field: "idx")}</td>
                            
                        </tr>
                    --}%
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="kurs.createdBy.label" default="Created By" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: kursInstance, field: "createdBy")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="kurs.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${kursInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="kurs.updatedBy.label" default="Updated By" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: kursInstance, field: "updatedBy")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="kurs.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${kursInstance?.lastUpdated}" /></td>
                            
                        </tr>
                      %{--
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="kurs.deleteFlag.label" default="Delete Flag" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: kursInstance, field: "deleteFlag")}</td>
                            
                        </tr>
                    --}%
                       
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${kursInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
