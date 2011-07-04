

<%@ page import="com.teravin.catalogue.Accesories" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'accesories.label', default: 'Accesories')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${accesoriesInstance}">
            <div class="errors">
                <g:renderErrors bean="${accesoriesInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="accesories.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: accesoriesInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" maxlength="100" value="${accesoriesInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="accesories.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: accesoriesInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" cols="40" rows="5" value="${accesoriesInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="idx"><g:message code="accesories.idx.label" default="Idx" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: accesoriesInstance, field: 'idx', 'errors')}">
                                    <g:textField name="idx" value="${fieldValue(bean: accesoriesInstance, field: 'idx')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="createdBy"><g:message code="accesories.createdBy.label" default="Created By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: accesoriesInstance, field: 'createdBy', 'errors')}">
                                    <g:textField name="createdBy" maxlength="50" value="${accesoriesInstance?.createdBy}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="updatedBy"><g:message code="accesories.updatedBy.label" default="Updated By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: accesoriesInstance, field: 'updatedBy', 'errors')}">
                                    <g:textField name="updatedBy" maxlength="50" value="${accesoriesInstance?.updatedBy}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="deleteFlag"><g:message code="accesories.deleteFlag.label" default="Delete Flag" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: accesoriesInstance, field: 'deleteFlag', 'errors')}">
                                    <g:textField name="deleteFlag" value="${accesoriesInstance?.deleteFlag}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="price"><g:message code="accesories.price.label" default="Price" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: accesoriesInstance, field: 'price', 'errors')}">
                                    <g:textField name="price" value="${fieldValue(bean: accesoriesInstance, field: 'price')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="unitType"><g:message code="accesories.unitType.label" default="Unit Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: accesoriesInstance, field: 'unitType', 'errors')}">
                                    <g:select name="unitType.id" from="${com.teravin.catalogue.maintenance.UnitType.list()}" optionKey="id" value="${accesoriesInstance?.unitType?.id}"  />
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
