
<%@ page import="com.teravin.catalogue.maintenance.Kurs" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main2" />
        <g:set var="entityName" value="${message(code: 'kurs.label', default: 'Kurs')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'kurs.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'kurs.name.label', default: 'Name')}" />
                        	
                        	<g:sortableColumn property="kursValue" title="${message(code: 'kurs.value.label', default: 'Kurs Value')}" />
                        	
                            <g:sortableColumn property="description" title="${message(code: 'kurs.description.label', default: 'Description')}" />
                        
                             %{-- <g:sortableColumn property="idx" title="${message(code: 'kurs.idx.label', default: 'Idx')}" /> --}%
                        
                            <g:sortableColumn property="createdBy" title="${message(code: 'kurs.createdBy.label', default: 'Created By')}" />
                        
                            <g:sortableColumn property="dateCreated" title="${message(code: 'kurs.dateCreated.label', default: 'Date Created')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${kursInstanceList}" status="i" var="kursInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${kursInstance.id}">${fieldValue(bean: kursInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: kursInstance, field: "name")}</td>
                            
                              <td>${fieldValue(bean: kursInstance, field: "kursValue")}</td>
                        
                            <td>${fieldValue(bean: kursInstance, field: "description")}</td>
                        
                            %{--<td>${fieldValue(bean: kursInstance, field: "idx")}</td>--}%
                        
                            <td>${fieldValue(bean: kursInstance, field: "createdBy")}</td>
                        
                            <td><g:formatDate date="${kursInstance.dateCreated}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${kursInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
