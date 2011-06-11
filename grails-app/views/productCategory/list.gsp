
<%@ page import="com.teravin.catalogue.ProductCategory" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'productCategory.label', default: 'ProductCategory')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'productCategory.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'productCategory.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'productCategory.description.label', default: 'Description')}" />
                        
                            <g:sortableColumn property="idx" title="${message(code: 'productCategory.idx.label', default: 'Idx')}" />
                        
                            <g:sortableColumn property="createdBy" title="${message(code: 'productCategory.createdBy.label', default: 'Created By')}" />
                        
                            <g:sortableColumn property="dateCreated" title="${message(code: 'productCategory.dateCreated.label', default: 'Date Created')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${productCategoryInstanceList}" status="i" var="productCategoryInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${productCategoryInstance.id}">${fieldValue(bean: productCategoryInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: productCategoryInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: productCategoryInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: productCategoryInstance, field: "idx")}</td>
                        
                            <td>${fieldValue(bean: productCategoryInstance, field: "createdBy")}</td>
                        
                            <td><g:formatDate date="${productCategoryInstance.dateCreated}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${productCategoryInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
