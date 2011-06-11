

<%@ page import="com.teravin.catalogue.ProductDetail" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'productDetail.label', default: 'ProductDetail')}" />
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
            <g:hasErrors bean="${productDetailInstance}">
            <div class="errors">
                <g:renderErrors bean="${productDetailInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${productDetailInstance?.id}" />
                <g:hiddenField name="version" value="${productDetailInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="product"><g:message code="productDetail.product.label" default="Product" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productDetailInstance, field: 'product', 'errors')}">
                                    <g:select name="product.id" from="${com.teravin.catalogue.Product.list()}" optionKey="id" value="${productDetailInstance?.product?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="material"><g:message code="productDetail.material.label" default="Material" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productDetailInstance, field: 'material', 'errors')}">
                                    <g:select name="material.id" from="${com.teravin.catalogue.Material.list()}" optionKey="id" value="${productDetailInstance?.material?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="unitType"><g:message code="productDetail.unitType.label" default="Unit Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productDetailInstance, field: 'unitType', 'errors')}">
                                    <g:select name="unitType.id" from="${com.teravin.catalogue.maintenance.UnitType.list()}" optionKey="id" value="${productDetailInstance?.unitType?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="price"><g:message code="productDetail.price.label" default="Price" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productDetailInstance, field: 'price', 'errors')}">
                                    <g:textField name="price" value="${fieldValue(bean: productDetailInstance, field: 'price')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="idxx"><g:message code="productDetail.idxx.label" default="Idxx" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productDetailInstance, field: 'idxx', 'errors')}">
                                    <g:textField name="idxx" value="${fieldValue(bean: productDetailInstance, field: 'idxx')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="isPriceOverwrite"><g:message code="productDetail.isPriceOverwrite.label" default="Is Price Overwrite" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productDetailInstance, field: 'isPriceOverwrite', 'errors')}">
                                    <g:textField name="isPriceOverwrite" value="${productDetailInstance?.isPriceOverwrite}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="idx"><g:message code="productDetail.idx.label" default="Idx" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productDetailInstance, field: 'idx', 'errors')}">
                                    <g:textField name="idx" value="${fieldValue(bean: productDetailInstance, field: 'idx')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="createdBy"><g:message code="productDetail.createdBy.label" default="Created By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productDetailInstance, field: 'createdBy', 'errors')}">
                                    <g:textField name="createdBy" maxlength="50" value="${productDetailInstance?.createdBy}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="updatedBy"><g:message code="productDetail.updatedBy.label" default="Updated By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productDetailInstance, field: 'updatedBy', 'errors')}">
                                    <g:textField name="updatedBy" maxlength="50" value="${productDetailInstance?.updatedBy}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="deleteFlag"><g:message code="productDetail.deleteFlag.label" default="Delete Flag" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productDetailInstance, field: 'deleteFlag', 'errors')}">
                                    <g:textField name="deleteFlag" value="${productDetailInstance?.deleteFlag}" />
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
