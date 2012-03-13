
<%@ page import="com.teravin.catalogue.Product" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main2" />
        <g:set var="entityName" value="${message(code: 'product.label', default: 'Product')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/index2.gsp')}"><g:message code="default.home.label"/></a></span>
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
                            <td valign="top" class="name"><g:message code="product.name.label" default="Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "name")}</td>
                            
                        </tr>
                         <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.name.label" default="Code" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "code")}</td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.model.label" default="Model" /></td>
                            
                            <td valign="top" class="value"><g:link controller="model" action="show" id="${productInstance?.model?.id}">${productInstance?.model?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    	<tr class="prop">
                            <td valign="top" class="name"><g:message code="product.modelCategory.label" default="Model Category" /></td>
                            
                            <td valign="top" class="value"><g:link controller="modelCategory" action="show" id="${productInstance?.model?.modelCategory.id}">${productInstance?.model?.modelCategory?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                         <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.materialMain.label" default="Material Main" /></td>
                            
                            <td valign="top" class="value"><g:link controller="color" action="show" id="${productInstance?.materialMain?.id}">${productInstance?.materialMain?.encodeAsHTML()}</g:link></td>
                            
                        </tr >
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.color.label" default="Color" /></td>
                            
                            <td valign="top" class="value"><g:link controller="color" action="show" id="${productInstance?.color?.id}">${productInstance?.color?.encodeAsHTML()}</g:link></td>
                            
                        </tr >
                    <tr><td colspan=2><table>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.width.label" default="Width" /></td>
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "width")}</td>
                            
                            <td valign="top" class="name"><g:message code="product.height.label" default="Height" /></td>
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "height")}</td>
                            
                            <td valign="top" class="name"><g:message code="product.length.label" default="Length" /></td>
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "length")}</td>
                            
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.seatWidth.label" default="Seat Width" /></td>
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "seatWidth")}</td>
                            
                            <td valign="top" class="name"><g:message code="product.seatHeight.label" default="Seat Height" /></td>
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "seatHeight")}</td>
                            
                            <td valign="top" class="name"><g:message code="product.seatLength.label" default="Seat Length" /></td>
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "seatLength")}</td>
                            
                           
                            
                        </tr>
                         	
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.packingWidth.label" default="Packing Width" /></td>
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "packingWidth")}</td>
                            
                            <td valign="top" class="name"><g:message code="product.packingHeight.label" default="Packing Height" /></td>
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "packingHeight")}</td>
                            
                            <td valign="top" class="name"><g:message code="product.packingLength.label" default="Packing Length" /></td>
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "packingLength")}</td>
                            
                          
                            
                        </tr>
                         <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.estLoad.label" default="Est Load" /></td>
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "estLoad")}</td>
                            <td valign="top" class="name"><g:message code="product.totalCubic.label" default="Total Cubic" /></td>
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "totalCubic")}</td>
                            <td valign="top" class="name"><g:message code="product.cbm.label" default="Cbm" /></td>
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "cbm")}</td>
                      
                        </tr>
                         <tr class="prop">
                            <td valign="top" class="name"><g:message code="product.Total Weight.label" default="Total Weight" /></td>
                            <td valign="top" class="value" colspan=5>${fieldValue(bean: productInstance, field: "totalWeight")}</td>
                            
                      
                        </tr>
                    </table></td></tr>
                    		<g:if test="${productInstance.imagePathFront!=null}" >
	                    		 <tr class="prop">
	                            	<td valign="top" class="name"><g:message code="product.imageFront.label" default="Image Front" /></td>
	                            	<td><img src="${createLinkTo(dir:'images', file: productInstance.code+'.jpg' )}" /> </td>
	                        	</tr>
                        	</g:if>
                        	<g:else >
                        	<tr class="prop">
                            	<td valign="top" class="name"><g:message code="product.imageFront.label" default="Image Front" /></td>
                            	<td><img src="${createLinkTo(dir:'images', file: productInstance.model.id+'.jpg' )}" /> </td>
                        	</tr>
                        	</g:else>
                        	<g:if test="${productInstance.imagePathSide!=null}" >
                        	<tr class="prop">
                            	<td valign="top" class="name"><g:message code="product.imageSide.label" default="Image Side" /></td>
                            	<td><img src="${createLinkTo(dir:'images', file: productInstance.code+'-side.jpg' )}" /> </td>
                        	</tr>
                        	</g:if>
                        	<g:else >
                        	<tr class="prop">
                            	<td valign="top" class="name"><g:message code="product.imageSide.label" default="Image Side" /></td>
                            	<td><img src="${createLinkTo(dir:'images', file: 'no-file.gif' )}" /> </td>
                        	</tr>
                        	</g:else>
                    		<tr class="prop">
                                <td valign="top" class="name">
                                    <g:message code="product.index.label" default="Index " />
                                </td>
                                <td valign="top" class="value">
                                    ${fieldValue(bean: productInstance, field: 'idxx')}
                                </td>
                            </tr>
                        	<tr class="prop">
                                <td valign="top" class="name">
                                    <g:message code="product.index.label" default="Index USD " />
                                </td>
                                
                                <td valign="top" class="value">
                                    <script type="text/javascript">
                                    	var index;
	                                    index    =  ${productInstance.idxx}
	                                  	var indexVal = parseFloat(index.toString().replace(/,/g, ''));
	                                  	var indexUsd = parseFloat(indexVal) / parseFloat(${kursValue});
	                                    document.write(indexUsd);
	                                </script>
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <g:message code="product.indexPricing.label" default="Index Costing" />
                                </td>
                                <td valign="top" class="value }">
                                   ${fieldValue(bean: productInstance, field: 'indexPricing')}
                                </td>
                            </tr>
                        	<tr class="prop">
                                <td valign="top" class="name">
                                    <g:message code="product.index.label" default="Index Costing USD " />
                                </td>
                                
                                <td valign="top" class="value">
                                    <script type="text/javascript">
                                    	var index;
	                                    index    =  ${productInstance.indexPricing}
	                                  	var indexVal = parseFloat(index.toString().replace(/,/g, ''));
	                                  	var indexUsd = parseFloat(indexVal) / parseFloat(${kursValue});
	                                    document.write(indexUsd);
	                                </script>
                                </td>
                            </tr>
                              <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="price"><g:message code="product.price.label" default="Price" /></label>
                                </td>
                                <td valign="top" class="value">
                                   ${fieldValue(bean: productInstance, field: 'price')}
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="baseCost">
                                  <g:message code="product.baseCost.label" default="Base Cost" />
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'price', 'errors')}">
                                   ${fieldValue(bean: productInstance, field: 'baseCost')}
                                </td>
                            </tr>
                    <tr><td colspan=2>
                       	<div>
            				<table class="materialTbl">
            					<thead>
            						 <th valign="top" class="name" >
		                                    <label for="product"><g:message code="productDetail.material.label" default="Materials" /></label>
		                                </th>
		                                <th valign="top" class="name" >
		                                    <label for="product"><g:message code="productDetail.material.unit.label" default="Unit" /></label>
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
            								<td>${materialInstance.unit}</td>
            								<td>${materialInstance.material.unitType.name}</td>
            								<td>${materialInstance.idxx}</td>
            								<td> <script type="text/javascript">document.write(parseFloat(${materialInstance.unit})*parseFloat(${materialInstance.price}))</script></td>
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
			                                    <label for="productDetail"><g:message code="productDetail.accesories.unit.label" default="Unit" /></label>
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
            								<td>${accesoriesInstance.unit}</td>
            								<td>${accesoriesInstance.material.unitType.name}</td>
            								<td>${accesoriesInstance.idxx}</td>
            								<td> <script type="text/javascript">document.write(parseFloat(${accesoriesInstance.unit})*parseFloat(${accesoriesInstance.price}))</script></td>
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
		                                    <label for="product"><g:message code="productDetail.unit" default="Unit" /></label>
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
            								<td>${miscellaneousInstance.unit}</td>
            								<td>${miscellaneousInstance.material.unitType.name}</td>
            								<td>${miscellaneousInstance.idxx}</td>
            								<td><script type="text/javascript">document.write(parseFloat(${miscellaneousInstance.unit})*parseFloat(${miscellaneousInstance.price}))</script></td>
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
                            <td valign="top" class="name"><g:message code="product.description.label" default="Description" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: productInstance, field: "description")}</td>
                            
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
