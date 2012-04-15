
<%@ page import="com.teravin.catalogue.maintenance.UnitType" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main2" />
        <g:set var="entityName" value="${message(code: 'unitType.label', default: 'UnitType')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'unitType.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'unitType.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'unitType.description.label', default: 'Description')}" />
                        
                     %{--       <g:sortableColumn property="idx" title="${message(code: 'unitType.idx.label', default: 'Idx')}" />  --}%
                        
                            <g:sortableColumn property="createdBy" title="${message(code: 'unitType.createdBy.label', default: 'Created By')}" />
                        
                            <g:sortableColumn property="dateCreated" title="${message(code: 'unitType.dateCreated.label', default: 'Date Created')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${unitTypeInstanceList}" status="i" var="unitTypeInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${unitTypeInstance.id}">${fieldValue(bean: unitTypeInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: unitTypeInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: unitTypeInstance, field: "description")}</td>
                        
                       %{--     <td>${fieldValue(bean: unitTypeInstance, field: "idx")}</td>  --}%
                        
                            <td>${fieldValue(bean: unitTypeInstance, field: "createdBy")}</td>
                        
                            <td><g:formatDate date="${unitTypeInstance.dateCreated}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${unitTypeInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
