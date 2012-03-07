

<%@ page import="com.teravin.catalogue.Material" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main2" />
        <g:set var="entityName" value="${message(code: 'material.label', default: 'Material')}" />
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
            <g:hasErrors bean="${materialInstance}">
            <div class="errors">
                <g:renderErrors bean="${materialInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${materialInstance?.id}" />
                <g:hiddenField name="version" value="${materialInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="material.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: materialInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" maxlength="100" value="${materialInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="code"><g:message code="material.code.label" default="Code" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: materialInstance, field: 'code', 'errors')}">
                                    <g:textField name="code" maxlength="100" value="${materialInstance?.code}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="material.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: materialInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" cols="40" rows="5" value="${materialInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="idx"><g:message code="material.idx.label" default="Idx" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: materialInstance, field: 'idx', 'errors')}">
                                    <g:textField name="idx" value="${fieldValue(bean: materialInstance, field: 'idx')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="idxx"><g:message code="material.idxx.label" default="Idxx" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: materialInstance, field: 'idxx', 'errors')}">
                                    <g:textField name="idxx" value="${fieldValue(bean: materialInstance, field: 'idxx')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="createdBy"><g:message code="material.createdBy.label" default="Created By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: materialInstance, field: 'createdBy', 'errors')}">
                                    <g:textField name="createdBy" maxlength="50" value="${materialInstance?.createdBy}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="updatedBy"><g:message code="material.updatedBy.label" default="Updated By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: materialInstance, field: 'updatedBy', 'errors')}">
                                    <g:textField name="updatedBy" maxlength="50" value="${materialInstance?.updatedBy}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="deleteFlag"><g:message code="material.deleteFlag.label" default="Delete Flag" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: materialInstance, field: 'deleteFlag', 'errors')}">
                                    <g:textField name="deleteFlag" value="${materialInstance?.deleteFlag}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="isAccesories"><g:message code="material.isAccesories.label" default="Is Accesories" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: materialInstance, field: 'isAccesories', 'errors')}">
                                    <g:textField name="isAccesories" value="${materialInstance?.isAccesories}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="materialCategory"><g:message code="material.materialCategory.label" default="Material Category" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: materialInstance, field: 'materialCategory', 'errors')}">
                                    <g:select name="materialCategory.id" from="${com.teravin.catalogue.MaterialCategory.list()}" optionKey="id" value="${materialInstance?.materialCategory?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="price"><g:message code="material.price.label" default="Price" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: materialInstance, field: 'price', 'errors')}">
                                    <g:textField name="price" value="${fieldValue(bean: materialInstance, field: 'price')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="type"><g:message code="material.type.label" default="Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: materialInstance, field: 'type', 'errors')}">
                                    <g:textField name="type" value="${materialInstance?.type}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="unitType"><g:message code="material.unitType.label" default="Unit Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: materialInstance, field: 'unitType', 'errors')}">
                                    <g:select name="unitType.id" from="${com.teravin.catalogue.maintenance.UnitType.list()}" optionKey="id" value="${materialInstance?.unitType?.id}"  />
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
