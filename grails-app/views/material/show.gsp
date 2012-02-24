
<%@ page import="com.teravin.catalogue.Material" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main2" />
        <g:set var="entityName" value="${message(code: 'material.label', default: 'Material')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/index2.gsp')}"><g:message code="default.home.label"/></a></span>
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
                            <td valign="top" class="name"><g:message code="material.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: materialInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="material.name.label" default="Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: materialInstance, field: "name")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="material.description.label" default="Description" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: materialInstance, field: "description")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="material.idx.label" default="Idx" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: materialInstance, field: "idx")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="material.createdBy.label" default="Created By" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: materialInstance, field: "createdBy")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="material.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${materialInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="material.updatedBy.label" default="Updated By" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: materialInstance, field: "updatedBy")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="material.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${materialInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="material.deleteFlag.label" default="Delete Flag" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: materialInstance, field: "deleteFlag")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="material.idxx.label" default="Idxx" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: materialInstance, field: "idxx")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="material.isAccesories.label" default="Is Accesories" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: materialInstance, field: "isAccesories")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="material.materialCategory.label" default="Material Category" /></td>
                            
                            <td valign="top" class="value"><g:link controller="materialCategory" action="show" id="${materialInstance?.materialCategory?.id}">${materialInstance?.materialCategory?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="material.price.label" default="Price" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: materialInstance, field: "price")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="material.type.label" default="Type" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: materialInstance, field: "type")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="material.unitType.label" default="Unit Type" /></td>
                            
                            <td valign="top" class="value"><g:link controller="unitType" action="show" id="${materialInstance?.unitType?.id}">${materialInstance?.unitType?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${materialInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
