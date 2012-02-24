
<%@ page import="com.teravin.catalogue.maintenance.Color" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main2" />
        <g:set var="entityName" value="${message(code: 'color.label', default: 'Color')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'color.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'color.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'color.description.label', default: 'Description')}" />
                        
                            <g:sortableColumn property="idx" title="${message(code: 'color.idx.label', default: 'Idx')}" />
                        
                            <g:sortableColumn property="createdBy" title="${message(code: 'color.createdBy.label', default: 'Created By')}" />
                        
                            <g:sortableColumn property="dateCreated" title="${message(code: 'color.dateCreated.label', default: 'Date Created')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${colorInstanceList}" status="i" var="colorInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${colorInstance.id}">${fieldValue(bean: colorInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: colorInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: colorInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: colorInstance, field: "idx")}</td>
                        
                            <td>${fieldValue(bean: colorInstance, field: "createdBy")}</td>
                        
                            <td><g:formatDate date="${colorInstance.dateCreated}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${colorInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
