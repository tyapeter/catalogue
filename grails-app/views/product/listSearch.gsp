
<%@ page import="com.teravin.catalogue.Product" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'product.label', default: 'Product')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
       <div class="body">
            <h1>List Search</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'product.id.label', default: 'Id')}" />
                        
                         
                        
                            <th><g:message code="product.name.label" default="Name" /></th>
                            
                            <th><g:message code="product.model.label" default="Model" /></th>
                           
                            <th><g:message code= "product.width.label" default= "Width" /></th>
                        	<th><g:message code= "product.Height.label" default= "Height" /></th>
                        	<th><g:message code= "product.Length.label" default= "Length" /></th>
                        	<th><g:message code= "product.width.label" default= "Seat Width" /></th>
                        	<th><g:message code= "product.Height.label" default= "Seat Height" /></th>
                        	<th><g:message code= "product.Length.label" default= "Seat Length" /></th>
                        	<th><g:message code= "product.width.label" default= "Packing Width" /></th>
                        	<th><g:message code= "product.Height.label" default= "Packing Height" /></th>
                        	<th><g:message code= "product.Length.label" default= "Packing Length" /></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${productInstanceList}" status="i" var="productInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${productInstance.id}">${fieldValue(bean: productInstance, field: "id")}</g:link></td>
                        
                         
                            
                            <td>${fieldValue(bean: productInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: productInstance, field: "model")}</td>
                            
                            <td>${fieldValue(bean: productInstance, field: "width")}</td>
                            <td>${fieldValue(bean: productInstance, field: "height")}</td>
                            <td>${fieldValue(bean: productInstance, field: "length")}</td>
                             <td>${fieldValue(bean: productInstance, field: "seatWidth")}</td>
                            <td>${fieldValue(bean: productInstance, field: "seatHeight")}</td>
                            <td>${fieldValue(bean: productInstance, field: "seatLength")}</td>
                            <td>${fieldValue(bean: productInstance, field: "packingWidth")}</td>
                            <td>${fieldValue(bean: productInstance, field: "packingHeight")}</td>
                            <td>${fieldValue(bean: productInstance, field: "packingLength")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
           
        </div>
    </body>
</html>
