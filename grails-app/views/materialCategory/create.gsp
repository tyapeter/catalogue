

<%@ page import="com.teravin.catalogue.MaterialCategory" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main2" />
        <g:set var="entityName" value="${message(code: 'materialCategory.label', default: 'MaterialCategory')}" />
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
            <g:hasErrors bean="${materialCategoryInstance}">
            <div class="errors">
                <g:renderErrors bean="${materialCategoryInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="materialCategory.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: materialCategoryInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" maxlength="100" value="${materialCategoryInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="materialCategory.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: materialCategoryInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" cols="40" rows="5" value="${materialCategoryInstance?.description}" />
                                </td>
                            </tr>
                        
                            %{--<tr class="prop">--}%
                                %{--<td valign="top" class="name">--}%
                                    %{--<label for="idx"><g:message code="materialCategory.idx.label" default="Idx" /></label>--}%
                                %{--</td>--}%
                                %{--<td valign="top" class="value ${hasErrors(bean: materialCategoryInstance, field: 'idx', 'errors')}">--}%
                                    %{--<g:textField name="idx" value="${fieldValue(bean: materialCategoryInstance, field: 'idx')}" />--}%
                                %{--</td>--}%
                            %{--</tr>--}%
                        
                            %{--<tr class="prop">--}%
                                %{--<td valign="top" class="name">--}%
                                    %{--<label for="createdBy"><g:message code="materialCategory.createdBy.label" default="Created By" /></label>--}%
                                %{--</td>--}%
                                %{--<td valign="top" class="value ${hasErrors(bean: materialCategoryInstance, field: 'createdBy', 'errors')}">--}%
                                    %{--<g:textField name="createdBy" maxlength="50" value="${materialCategoryInstance?.createdBy}" />--}%
                                %{--</td>--}%
                            %{--</tr>--}%
                        
                            %{--<tr class="prop">--}%
                                %{--<td valign="top" class="name">--}%
                                    %{--<label for="updatedBy"><g:message code="materialCategory.updatedBy.label" default="Updated By" /></label>--}%
                                %{--</td>--}%
                                %{--<td valign="top" class="value ${hasErrors(bean: materialCategoryInstance, field: 'updatedBy', 'errors')}">--}%
                                    %{--<g:textField name="updatedBy" maxlength="50" value="${materialCategoryInstance?.updatedBy}" />--}%
                                %{--</td>--}%
                            %{--</tr>--}%
                        
                            %{--<tr class="prop">--}%
                                %{--<td valign="top" class="name">--}%
                                    %{--<label for="deleteFlag"><g:message code="materialCategory.deleteFlag.label" default="Delete Flag" /></label>--}%
                                %{--</td>--}%
                                %{--<td valign="top" class="value ${hasErrors(bean: materialCategoryInstance, field: 'deleteFlag', 'errors')}">--}%
                                    %{--<g:textField name="deleteFlag" value="${materialCategoryInstance?.deleteFlag}" />--}%
                                %{--</td>--}%
                            %{--</tr>--}%
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="materialType"><g:message code="materialCategory.materialType.label" default="Material Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: materialCategoryInstance, field: 'materialType', 'errors')}">
                                    <g:select name="materialType.id" from="${com.teravin.catalogue.MaterialType.list()}" optionKey="id" value="${materialCategoryInstance?.materialType?.id}"  />
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
