
<%@ page import="com.teravin.catalogue.MaterialCategory" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main2" />
        <g:set var="entityName" value="${message(code: 'materialCategory.label', default: 'MaterialCategory')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/index2.gsp')}"><g:message code="default.home.label"/></a></span>
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'materialCategory.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'materialCategory.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'materialCategory.description.label', default: 'Description')}" />
                        
                            %{--<g:sortableColumn property="idx" title="${message(code: 'materialCategory.idx.label', default: 'Idx')}" />--}%
                        
                            <g:sortableColumn property="createdBy" title="${message(code: 'materialCategory.createdBy.label', default: 'Created By')}" />
                        
                            <g:sortableColumn property="dateCreated" title="${message(code: 'materialCategory.dateCreated.label', default: 'Date Created')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${materialCategoryInstanceList}" status="i" var="materialCategoryInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${materialCategoryInstance.id}">${fieldValue(bean: materialCategoryInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: materialCategoryInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: materialCategoryInstance, field: "description")}</td>
                        
                            %{--<td>${fieldValue(bean: materialCategoryInstance, field: "idx")}</td>--}%
                        
                            <td>${fieldValue(bean: materialCategoryInstance, field: "createdBy")}</td>
                        
                            <td><g:formatDate date="${materialCategoryInstance.dateCreated}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${materialCategoryInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
