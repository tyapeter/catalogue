
<%@ page import="com.teravin.catalogue.ModelCategory" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main2" />
        <g:set var="entityName" value="${message(code: 'modelCategory.label', default: 'ModelCategory')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'modelCategory.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'modelCategory.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="code" title="${message(code: 'modelCategory.code.label', default: 'Code')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'modelCategory.description.label', default: 'Description')}" />
                        
                            <g:sortableColumn property="idx" title="${message(code: 'modelCategory.idx.label', default: 'Idx')}" />
                        
                            <g:sortableColumn property="createdBy" title="${message(code: 'modelCategory.createdBy.label', default: 'Created By')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${modelCategoryInstanceList}" status="i" var="modelCategoryInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${modelCategoryInstance.id}">${fieldValue(bean: modelCategoryInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: modelCategoryInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: modelCategoryInstance, field: "code")}</td>
                        
                            <td>${fieldValue(bean: modelCategoryInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: modelCategoryInstance, field: "idx")}</td>
                        
                            <td>${fieldValue(bean: modelCategoryInstance, field: "createdBy")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${modelCategoryInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
