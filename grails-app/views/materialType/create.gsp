

<%@ page import="com.teravin.catalogue.MaterialType" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'materialType.label', default: 'MaterialType')}" />
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
            <g:hasErrors bean="${materialTypeInstance}">
            <div class="errors">
                <g:renderErrors bean="${materialTypeInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="materialType.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: materialTypeInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" maxlength="100" value="${materialTypeInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="materialType.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: materialTypeInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" cols="40" rows="5" value="${materialTypeInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="idx"><g:message code="materialType.idx.label" default="Idx" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: materialTypeInstance, field: 'idx', 'errors')}">
                                    <g:textField name="idx" value="${fieldValue(bean: materialTypeInstance, field: 'idx')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="createdBy"><g:message code="materialType.createdBy.label" default="Created By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: materialTypeInstance, field: 'createdBy', 'errors')}">
                                    <g:textField name="createdBy" maxlength="50" value="${materialTypeInstance?.createdBy}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="updatedBy"><g:message code="materialType.updatedBy.label" default="Updated By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: materialTypeInstance, field: 'updatedBy', 'errors')}">
                                    <g:textField name="updatedBy" maxlength="50" value="${materialTypeInstance?.updatedBy}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="deleteFlag"><g:message code="materialType.deleteFlag.label" default="Delete Flag" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: materialTypeInstance, field: 'deleteFlag', 'errors')}">
                                    <g:textField name="deleteFlag" value="${materialTypeInstance?.deleteFlag}" />
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
