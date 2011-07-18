

<%@ page import="com.teravin.catalogue.Miscellaneous" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'miscellaneous.label', default: 'Miscellaneous')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${miscellaneousInstance}">
            <div class="errors">
                <g:renderErrors bean="${miscellaneousInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${miscellaneousInstance?.id}" />
                <g:hiddenField name="version" value="${miscellaneousInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="miscellaneous.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: miscellaneousInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" maxlength="100" value="${miscellaneousInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="miscellaneous.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: miscellaneousInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" cols="40" rows="5" value="${miscellaneousInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="idx"><g:message code="miscellaneous.idx.label" default="Idx" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: miscellaneousInstance, field: 'idx', 'errors')}">
                                    <g:textField name="idx" value="${fieldValue(bean: miscellaneousInstance, field: 'idx')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="createdBy"><g:message code="miscellaneous.createdBy.label" default="Created By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: miscellaneousInstance, field: 'createdBy', 'errors')}">
                                    <g:textField name="createdBy" maxlength="50" value="${miscellaneousInstance?.createdBy}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="updatedBy"><g:message code="miscellaneous.updatedBy.label" default="Updated By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: miscellaneousInstance, field: 'updatedBy', 'errors')}">
                                    <g:textField name="updatedBy" maxlength="50" value="${miscellaneousInstance?.updatedBy}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="deleteFlag"><g:message code="miscellaneous.deleteFlag.label" default="Delete Flag" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: miscellaneousInstance, field: 'deleteFlag', 'errors')}">
                                    <g:textField name="deleteFlag" value="${miscellaneousInstance?.deleteFlag}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="price"><g:message code="miscellaneous.price.label" default="Price" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: miscellaneousInstance, field: 'price', 'errors')}">
                                    <g:textField name="price" value="${fieldValue(bean: miscellaneousInstance, field: 'price')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="unitType"><g:message code="miscellaneous.unitType.label" default="Unit Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: miscellaneousInstance, field: 'unitType', 'errors')}">
                                    <g:select name="unitType.id" from="${com.teravin.catalogue.maintenance.UnitType.list()}" optionKey="id" value="${miscellaneousInstance?.unitType?.id}"  />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
