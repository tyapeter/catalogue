
<%@ page import="com.teravin.catalogue.Model" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'model.label', default: 'Model')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'model.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="code" title="${message(code: 'model.code.label', default: 'Code')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'model.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'model.description.label', default: 'Description')}" />
                        
                            <g:sortableColumn property="idx" title="${message(code: 'model.idx.label', default: 'Idx')}" />
                        
                            <g:sortableColumn property="createdBy" title="${message(code: 'model.createdBy.label', default: 'Created By')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${modelInstanceList}" status="i" var="modelInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${modelInstance.id}">${fieldValue(bean: modelInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: modelInstance, field: "code")}</td>
                        
                            <td>${fieldValue(bean: modelInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: modelInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: modelInstance, field: "idx")}</td>
                        
                            <td>${fieldValue(bean: modelInstance, field: "createdBy")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${modelInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
