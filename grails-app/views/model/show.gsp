
<%@ page import="com.teravin.catalogue.Model" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main2" />
        <g:set var="entityName" value="${message(code: 'model.label', default: 'Model')}" />
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
                            <td valign="top" class="name"><g:message code="model.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: modelInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="model.code.label" default="Code" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: modelInstance, field: "code")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="model.name.label" default="Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: modelInstance, field: "name")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="model.description.label" default="Description" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: modelInstance, field: "description")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="model.width.label" default="Width" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: modelInstance, field: "width")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="model.height.label" default="height" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: modelInstance, field: "height")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="model.length.label" default="Length" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: modelInstance, field: "length")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="model.seatWidth.label" default="Seat Width" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: modelInstance, field: "seatWidth")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="model.seatHeight.label" default="seat Height" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: modelInstance, field: "seatHeight")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="model.seatLength.label" default="seat Length" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: modelInstance, field: "seatLength")}</td>
                            
                        </tr>
                    	
                    	<tr class="prop">
                            <td valign="top" class="name"><g:message code="model.packingWidth.label" default="Packing Width" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: modelInstance, field: "packingWidth")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="model.packingHeight.label" default="packing Height" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: modelInstance, field: "packingHeight")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="model.packingLength.label" default="packing Length" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: modelInstance, field: "packingLength")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="model.estLoad.label" default="Est Load" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: modelInstance, field: "estLoad")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="model.cbm.label" default="Cbm" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: modelInstance, field: "cbm")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="model.idx.label" default="Idx" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: modelInstance, field: "idx")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="model.createdBy.label" default="Created By" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: modelInstance, field: "createdBy")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="model.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${modelInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="model.updatedBy.label" default="Updated By" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: modelInstance, field: "updatedBy")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="model.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${modelInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="model.deleteFlag.label" default="Delete Flag" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: modelInstance, field: "deleteFlag")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="model.imageFile.label" default="Image File" /></td>
                            <td><img src="${createLinkTo(dir:'images', file: modelInstance.id+'.jpg' )}" /> </td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="model.modelCategory.label" default="Model Category" /></td>
                            
                            <td valign="top" class="value"><g:link controller="modelCategory" action="show" id="${modelInstance?.modelCategory?.id}">${modelInstance?.modelCategory?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${modelInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
