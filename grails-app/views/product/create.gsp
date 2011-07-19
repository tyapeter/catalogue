

<%@ page import="com.teravin.catalogue.Product" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'product.label', default: 'Product')}" />
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
            <g:hasErrors bean="${productInstance}">
            <div class="errors">
                <g:renderErrors bean="${productInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="code"><g:message code="product.code.label" default="Code" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'code', 'errors')}">
                                    <g:textField name="code" value="${productInstance?.code}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="model"><g:message code="product.model.label" default="Model" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'model', 'errors')}">
                                    <g:select name="model.id" from="${com.teravin.catalogue.Model.list()}" optionKey="id" value="${productInstance?.model?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="productType"><g:message code="product.productType.label" default="Product Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'productType', 'errors')}">
                                    <g:select name="productType.id" from="${com.teravin.catalogue.ProductType.list()}" optionKey="id" value="${productInstance?.productType?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="color"><g:message code="product.color.label" default="Color" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'color', 'errors')}">
                                    <g:select name="color.id" from="${com.teravin.catalogue.maintenance.Color.list()}" optionKey="id" value="${productInstance?.color?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="width"><g:message code="product.width.label" default="Width" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'width', 'errors')}">
                                    <g:textField name="width" value="${fieldValue(bean: productInstance, field: 'width')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="height"><g:message code="product.height.label" default="Height" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'height', 'errors')}">
                                    <g:textField name="height" value="${fieldValue(bean: productInstance, field: 'height')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="length"><g:message code="product.length.label" default="Length" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'length', 'errors')}">
                                    <g:textField name="length" value="${fieldValue(bean: productInstance, field: 'length')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="seatHeight"><g:message code="product.seatHeight.label" default="Seat Height" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'seatHeight', 'errors')}">
                                    <g:textField name="seatHeight" value="${fieldValue(bean: productInstance, field: 'seatHeight')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="estLoad"><g:message code="product.estLoad.label" default="Est Load" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'estLoad', 'errors')}">
                                    <g:textField name="estLoad" value="${fieldValue(bean: productInstance, field: 'estLoad')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="cbm"><g:message code="product.cbm.label" default="Cbm" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'cbm', 'errors')}">
                                    <g:textField name="cbm" value="${fieldValue(bean: productInstance, field: 'cbm')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="idx"><g:message code="product.idx.label" default="Idx" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'idx', 'errors')}">
                                    <g:textField name="idx" value="${fieldValue(bean: productInstance, field: 'idx')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="createdBy"><g:message code="product.createdBy.label" default="Created By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'createdBy', 'errors')}">
                                    <g:textField name="createdBy" maxlength="50" value="${productInstance?.createdBy}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="updatedBy"><g:message code="product.updatedBy.label" default="Updated By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'updatedBy', 'errors')}">
                                    <g:textField name="updatedBy" maxlength="50" value="${productInstance?.updatedBy}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="deleteFlag"><g:message code="product.deleteFlag.label" default="Delete Flag" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'deleteFlag', 'errors')}">
                                    <g:textField name="deleteFlag" value="${productInstance?.deleteFlag}" />
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
