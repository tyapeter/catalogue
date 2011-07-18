
<%@ page import="com.teravin.catalogue.Miscellaneous" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'miscellaneous.label', default: 'Miscellaneous')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'miscellaneous.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'miscellaneous.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'miscellaneous.description.label', default: 'Description')}" />
                        
                            <g:sortableColumn property="idx" title="${message(code: 'miscellaneous.idx.label', default: 'Idx')}" />
                        
                            <g:sortableColumn property="createdBy" title="${message(code: 'miscellaneous.createdBy.label', default: 'Created By')}" />
                        
                            <g:sortableColumn property="dateCreated" title="${message(code: 'miscellaneous.dateCreated.label', default: 'Date Created')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${miscellaneousInstanceList}" status="i" var="miscellaneousInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${miscellaneousInstance.id}">${fieldValue(bean: miscellaneousInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: miscellaneousInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: miscellaneousInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: miscellaneousInstance, field: "idx")}</td>
                        
                            <td>${fieldValue(bean: miscellaneousInstance, field: "createdBy")}</td>
                        
                            <td><g:formatDate date="${miscellaneousInstance.dateCreated}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${miscellaneousInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
