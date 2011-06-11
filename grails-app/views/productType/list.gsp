
<%@ page import="com.teravin.catalogue.ProductType" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'productType.label', default: 'ProductType')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'productType.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'productType.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'productType.description.label', default: 'Description')}" />
                        
                            <g:sortableColumn property="idx" title="${message(code: 'productType.idx.label', default: 'Idx')}" />
                        
                            <g:sortableColumn property="createdBy" title="${message(code: 'productType.createdBy.label', default: 'Created By')}" />
                        
                            <g:sortableColumn property="dateCreated" title="${message(code: 'productType.dateCreated.label', default: 'Date Created')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${productTypeInstanceList}" status="i" var="productTypeInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${productTypeInstance.id}">${fieldValue(bean: productTypeInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: productTypeInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: productTypeInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: productTypeInstance, field: "idx")}</td>
                        
                            <td>${fieldValue(bean: productTypeInstance, field: "createdBy")}</td>
                        
                            <td><g:formatDate date="${productTypeInstance.dateCreated}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${productTypeInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
