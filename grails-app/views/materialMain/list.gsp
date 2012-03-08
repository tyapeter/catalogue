
<%@ page import="com.teravin.catalogue.MaterialMain" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main2" />
        <g:set var="entityName" value="${message(code: 'materialMain.label', default: 'MaterialMain')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'materialMain.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'materialMain.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="code" title="${message(code: 'materialMain.code.label', default: 'Code')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'materialMain.description.label', default: 'Description')}" />
                        
                            <g:sortableColumn property="idx" title="${message(code: 'materialMain.idx.label', default: 'Idx')}" />
                        
                            <g:sortableColumn property="createdBy" title="${message(code: 'materialMain.createdBy.label', default: 'Created By')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${materialMainInstanceList}" status="i" var="materialMainInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${materialMainInstance.id}">${fieldValue(bean: materialMainInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: materialMainInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: materialMainInstance, field: "code")}</td>
                        
                            <td>${fieldValue(bean: materialMainInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: materialMainInstance, field: "idx")}</td>
                        
                            <td>${fieldValue(bean: materialMainInstance, field: "createdBy")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${materialMainInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
