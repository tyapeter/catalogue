
<%@ page import="com.teravin.catalogue.Accesories" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'accesories.label', default: 'Accesories')}" />
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
                            <td valign="top" class="name"><g:message code="accesories.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: accesoriesInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="accesories.name.label" default="Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: accesoriesInstance, field: "name")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="accesories.description.label" default="Description" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: accesoriesInstance, field: "description")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="accesories.idx.label" default="Idx" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: accesoriesInstance, field: "idx")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="accesories.createdBy.label" default="Created By" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: accesoriesInstance, field: "createdBy")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="accesories.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${accesoriesInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="accesories.updatedBy.label" default="Updated By" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: accesoriesInstance, field: "updatedBy")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="accesories.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${accesoriesInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="accesories.deleteFlag.label" default="Delete Flag" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: accesoriesInstance, field: "deleteFlag")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="accesories.materialCategory.label" default="Material Category" /></td>
                            
                            <td valign="top" class="value"><g:link controller="materialCategory" action="show" id="${accesoriesInstance?.materialCategory?.id}">${accesoriesInstance?.materialCategory?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="accesories.price.label" default="Price" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: accesoriesInstance, field: "price")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="accesories.unitType.label" default="Unit Type" /></td>
                            
                            <td valign="top" class="value"><g:link controller="unitType" action="show" id="${accesoriesInstance?.unitType?.id}">${accesoriesInstance?.unitType?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${accesoriesInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
