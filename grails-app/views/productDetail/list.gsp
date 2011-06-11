
<%@ page import="com.teravin.catalogue.ProductDetail" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'productDetail.label', default: 'ProductDetail')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'productDetail.id.label', default: 'Id')}" />
                        
                            <th><g:message code="productDetail.product.label" default="Product" /></th>
                        
                            <th><g:message code="productDetail.material.label" default="Material" /></th>
                        
                            <th><g:message code="productDetail.unitType.label" default="Unit Type" /></th>
                        
                            <g:sortableColumn property="price" title="${message(code: 'productDetail.price.label', default: 'Price')}" />
                        
                            <g:sortableColumn property="idxx" title="${message(code: 'productDetail.idxx.label', default: 'Idxx')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${productDetailInstanceList}" status="i" var="productDetailInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${productDetailInstance.id}">${fieldValue(bean: productDetailInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: productDetailInstance, field: "product")}</td>
                        
                            <td>${fieldValue(bean: productDetailInstance, field: "material")}</td>
                        
                            <td>${fieldValue(bean: productDetailInstance, field: "unitType")}</td>
                        
                            <td>${fieldValue(bean: productDetailInstance, field: "price")}</td>
                        
                            <td>${fieldValue(bean: productDetailInstance, field: "idxx")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${productDetailInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
