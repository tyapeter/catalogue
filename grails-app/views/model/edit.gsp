

<%@ page import="com.teravin.catalogue.Model" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'model.label', default: 'Model')}" />
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
            <g:hasErrors bean="${modelInstance}">
            <div class="errors">
                <g:renderErrors bean="${modelInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post"  enctype="multipart/form-data">
                <g:hiddenField name="id" value="${modelInstance?.id}" />
                <g:hiddenField name="version" value="${modelInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="code"><g:message code="model.code.label" default="Code" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: modelInstance, field: 'code', 'errors')}">
                                    <g:textField name="code" maxlength="100" value="${modelInstance?.code}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="model.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: modelInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" maxlength="100" value="${modelInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="model.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: modelInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" cols="40" rows="5" value="${modelInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="width"><g:message code="model.width.label" default="Width" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: modelInstance, field: 'width', 'errors')}">
                                    <g:textField name="width" value="${fieldValue(bean: modelInstance, field: 'width')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="height"><g:message code="model.height.label" default="height" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: modelInstance, field: 'height', 'errors')}">
                                    <g:textField name="height" value="${fieldValue(bean: modelInstance, field: 'height')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="length"><g:message code="model.length.label" default="Length" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: modelInstance, field: 'length', 'errors')}">
                                    <g:textField name="length" value="${fieldValue(bean: modelInstance, field: 'length')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="seatHeight"><g:message code="model.seatHeight.label" default="Seat Height" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: modelInstance, field: 'seatHeight', 'errors')}">
                                    <g:textField name="seatHeight" value="${fieldValue(bean: modelInstance, field: 'seatHeight')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="estLoad"><g:message code="model.estLoad.label" default="Est Load" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: modelInstance, field: 'estLoad', 'errors')}">
                                    <g:textField name="estLoad" value="${fieldValue(bean: modelInstance, field: 'estLoad')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="cbm"><g:message code="model.cbm.label" default="Cbm" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: modelInstance, field: 'cbm', 'errors')}">
                                    <g:textField name="cbm" value="${fieldValue(bean: modelInstance, field: 'cbm')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="idx"><g:message code="model.idx.label" default="Idx" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: modelInstance, field: 'idx', 'errors')}">
                                    <g:textField name="idx" value="${fieldValue(bean: modelInstance, field: 'idx')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="createdBy"><g:message code="model.createdBy.label" default="Created By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: modelInstance, field: 'createdBy', 'errors')}">
                                    <g:textField name="createdBy" maxlength="50" value="${modelInstance?.createdBy}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="updatedBy"><g:message code="model.updatedBy.label" default="Updated By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: modelInstance, field: 'updatedBy', 'errors')}">
                                    <g:textField name="updatedBy" maxlength="50" value="${modelInstance?.updatedBy}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="deleteFlag"><g:message code="model.deleteFlag.label" default="Delete Flag" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: modelInstance, field: 'deleteFlag', 'errors')}">
                                    <g:textField name="deleteFlag" value="${modelInstance?.deleteFlag}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="imageFile"><g:message code="model.imageFile.label" default="Image File" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: modelInstance, field: 'imageFile', 'errors')}">
                                    <input type="file" id="imageFile" name="imageFile" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="modelCategory"><g:message code="model.modelCategory.label" default="Model Category" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: modelInstance, field: 'modelCategory', 'errors')}">
                                    <g:select name="modelCategory.id" from="${com.teravin.catalogue.ModelCategory.list()}" optionKey="id" value="${modelInstance?.modelCategory?.id}"  />
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
