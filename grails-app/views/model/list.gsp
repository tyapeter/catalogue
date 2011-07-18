
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
                        
                            <g:sortableColumn property="width" title="${message(code: 'model.width.label', default: 'Width')}" />
                        
                            <g:sortableColumn property="height" title="${message(code: 'model.height.label', default: 'height')}" />
                            
                             <g:sortableColumn property="imageFile" title="${message(code: 'model.imageFile.label', default: 'Image File')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${modelInstanceList}" status="i" var="modelInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${modelInstance.id}">${fieldValue(bean: modelInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: modelInstance, field: "code")}</td>
                        
                            <td>${fieldValue(bean: modelInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: modelInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: modelInstance, field: "width")}</td>
                        
                            <td>${fieldValue(bean: modelInstance, field: "height")}</td>
                            
                            <td><img src="${createLinkTo(dir:'images', file: modelInstance.id+'.jpg' )}" /> </td>
                        
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
