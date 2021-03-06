
<%@ page import="com.teravin.catalogue.Product" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'product.label', default: 'Product')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'product.id.label', default: 'Id')}" />
                        
                            <th><g:message code="product.model.label" default="Model" /></th>
                        
                            <th><g:message code="product.productType.label" default="Product Type" /></th>
                        
                            <th><g:message code="product.color.label" default="Color" /></th>
                        
                            <g:sortableColumn property="width" title="${message(code: 'product.width.label', default: 'Width')}" />
                        
                            <g:sortableColumn property="heigth" title="${message(code: 'product.heigth.label', default: 'Heigth')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${productInstanceList}" status="i" var="productInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${productInstance.id}">${fieldValue(bean: productInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: productInstance, field: "model")}</td>
                        
                            <td>${fieldValue(bean: productInstance, field: "productType")}</td>
                        
                            <td>${fieldValue(bean: productInstance, field: "color")}</td>
                        
                            <td>${fieldValue(bean: productInstance, field: "width")}</td>
                        
                            <td>${fieldValue(bean: productInstance, field: "heigth")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${productInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
