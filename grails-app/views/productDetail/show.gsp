
<%@ page import="com.teravin.catalogue.Product" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'product.label', default: 'Product')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.code.label" default="Code" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "code")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.model.label" default="Model" /></td>
                            
                            <td valign="top" class="value"><g:link controller="model" action="show" id="${productInstance?.model?.id}">${productInstance?.model?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <!-- tr class="prop">
                            <td valign="top" class="name"><g:message code="product.productType.label" default="Product Type" /></td>
                            
                            <td valign="top" class="value"><g:link controller="productType" action="show" id="${productInstance?.productType?.id}">${productInstance?.productType?.encodeAsHTML()}</g:link></td>
                            
                        </tr 
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.color.label" default="Color" /></td>
                            
                            <td valign="top" class="value"><g:link controller="color" action="show" id="${productInstance?.color?.id}">${productInstance?.color?.encodeAsHTML()}</g:link></td>
                            
                        </tr  -->
                    <tr><td colspan=2><table>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.width.label" default="Width" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "width")}</td>
                            <td valign="top" class="name"><g:message code="product.length.label" default="Length" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "length")}</td>
                            <td valign="top" class="name"><g:message code="product.estLoad.label" default="Est Load" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "estLoad")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.height.label" default="Height" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "height")}</td>
                            <td valign="top" class="name"><g:message code="product.seatHeight.label" default="Seat Height" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "seatHeight")}</td>
                            <td valign="top" class="name"><g:message code="product.cbm.label" default="Cbm" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "cbm")}</td>
                            
                            
                        </tr>
                    </table></td></tr>
                   
                    <tr><td colspan=2>
                       	<div>
            				<table class="materialTbl">
            					<thead>
            						 <th valign="top" class="name" >
		                                    <label for="product"><g:message code="productDetail.material.label" default="Materials" /></label>
		                                </th>
		                               <th valign="top" class="name" >
		                                    <label for="product"><g:message code="productDetail.material.unitType.label" default="Unit Type" /></label>
		                                </th>
		                                <th valign="top" class="name" >
		                                    <label for="product"><g:message code="productDetail.material.index.label" default="Index" /></label>
		                                </th>
		                                <th valign="top" class="name" >
		                                    <label for="product"><g:message code="productDetail.material.price.label" default="Price" /></label>
		                                </th>
            					</thead>
            					<tbody>
            						<g:each in="${materialList}" status="i" var="materialInstance">
            							<tr >
            								
            								<td>${materialInstance.material.name}</td>
            								<td>${materialInstance.material.unitType.name}</td>
            								<td>${materialInstance.idxx}</td>
            								<td>${materialInstance.price}</td>
            							</tr>
            						</g:each>
            					</tbody>
            				</table>
            			</div>
                       	</td></tr>
                       	<tr><td colspan=2>
                       	<div>
            				<table class="AccesoriesTbl">
            					<thead>
            						 <th valign="top" class="name" >
		                                    <label for="product"><g:message code="productDetail.material.label" default="Accesories" /></label>
		                                </th>
		                               <th valign="top" class="name" >
		                                    <label for="product"><g:message code="productDetail.material.unitType.label" default="Unit Type" /></label>
		                                </th>
		                                <th valign="top" class="name" >
		                                    <label for="product"><g:message code="productDetail.material.index.label" default="Index" /></label>
		                                </th>
		                                <th valign="top" class="name" >
		                                    <label for="product"><g:message code="productDetail.material.price.label" default="Price" /></label>
		                                </th>
            					</thead>
            					<tbody>
            						<g:each in="${accesoriesList}" status="i" var="accesoriesInstance">
            							<tr >
            								
            								<td>${accesoriesInstance.material.name}</td>
            								<td>${accesoriesInstance.material.unitType.name}</td>
            								<td>${accesoriesInstance.idxx}</td>
            								<td>${accesoriesInstance.price}</td>
            							</tr>
            						</g:each>
            					</tbody>
            				</table>
            			</div>
                       	</td></tr>
                       	<tr><td colspan=2>
                       	<div>
            				<table class="MiscellaneousTbl">
            					<thead>
            						 <th valign="top" class="name" >
		                                    <label for="product"><g:message code="productDetail.material.label" default="Miscellaneous" /></label>
		                                </th>
		                               <th valign="top" class="name" >
		                                    <label for="product"><g:message code="productDetail.material.unitType.label" default="Unit Type" /></label>
		                                </th>
		                                <th valign="top" class="name" >
		                                    <label for="product"><g:message code="productDetail.material.index.label" default="Index" /></label>
		                                </th>
		                                <th valign="top" class="name" >
		                                    <label for="product"><g:message code="productDetail.material.price.label" default="Price" /></label>
		                                </th>
            					</thead>
            					<tbody>
            						<g:each in="${miscellaneousList}" status="i" var="miscellaneousInstance">
            							<tr >
            								
            								<td>${miscellaneousInstance.material.name}</td>
            								<td>${miscellaneousInstance.material.unitType.name}</td>
            								<td>${miscellaneousInstance.idxx}</td>
            								<td>${miscellaneousInstance.price}</td>
            							</tr>
            						</g:each>
            					</tbody>
            				</table>
            			</div>
                       	</td></tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.idx.label" default="Idx" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "idx")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.createdBy.label" default="Created By" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "createdBy")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${productInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.updatedBy.label" default="Updated By" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "updatedBy")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${productInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.deleteFlag.label" default="Delete Flag" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "deleteFlag")}</td>
                            
                        </tr>
                    
                      
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${productInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
