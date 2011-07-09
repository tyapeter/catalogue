

<%@ page import="com.teravin.catalogue.ProductDetail" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="mai 	n" />
        <g:set var="entityName" value="${message(code: 'productDetail.label', default: 'ProductDetail')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${productDetailInstance}">
            <div class="errors">
                <g:renderErrors bean="${productDetailInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:javascript library="jquery" plugin="jquery"/>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="product"><g:message code="productDetail.product.label" default="Product" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productDetailInstance, field: 'product', 'errors')}">
                                    <g:select name="product.id" from="${com.teravin.catalogue.Model.list()}" optionKey="id" value="${productDetailInstance?.product?.model?.id}"  />
                                </td>
                            </tr>
                        	<!-- Material -->
                        	<tr class="prop">
                                <td valign="top" class="name" colspan=2>
                                    <label for="product"><g:message code="productDetail.material.label" default="Materials" /></label>
                                </td>
                               
                            </tr>
                        	<tr class="prop">
                                <td valign="top" class="name" colspan="2">
                                    <table id="materialTbl">
                                    	<g:each in="${materialList}" status="i" var="materials">
                                    	<tbody id="material${i}">
		                    				<tr>
		                    					<td width="90%">
		                                    		<g:textField class="materialName" name="materialName" id="materialName${i}" value="${material}" size="30"/>
		                                		</td>
		                                		<td width="10%">
		                                		<g:if test="${i == 0}">		                                		
			                                    		&nbsp;		                                    	
		                                    	</g:if>
		                                    	<g:else>
		                                    		<input type="button" class="ui-icon ui-icon-trash" value="Remove" onclick="removeMaterial(${i })"/>
		                                    	</g:else>
		                                    	</td>
		                    				</tr>
										</tbody>
		                    			</g:each>
                                    </table>
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name" colspan="2">
                                    <input type="button" value="${message(code: 'default.button.add.label')}" default="Add Material" onclick="addMaterial()"/>
                                </td>
                            </tr>
                        	 <script type="text/javascript">
										var materialCount = ${materialList?.size()} + 0;
										$(document).ready(function(){
											$('.materialName').live('keyup.autocomplete', function(){
												$(this).autocomplete({
													source: function( request, response ) {
														var url = "${createLink(url: [controller: 'material', action: 'getMaterialLikeName'])}";
														$.ajax({
															url: url,
															dataType: "jsonp",
															data: { name: request.term },
															success: function( data ) {
																response( $.map( data, function( item ) {
																	return {
																		label: item.name,
																		value: item.name,
																		aa: item.id
																	}
																}));
															}
														});
													},
													minLength: 2,
													delay: 2000
												});
											});
										
											$('.materialName').live("blur", function(){
												var id = ($(this).attr('id'));
												id = id.replace("materialName","");
												var duplicate = false;
												var oval
												for(var i = 0; i<materialCount;i++){
													if(i != id){
														oval = $("#materialName" + i).val();
														if((oval != null) && (oval == $(this).val())){
															duplicate = true;
															break;
														}
													}
												}
												if(duplicate == true){
													alert("material exist");
													$(this).val("");
												}
										  	});
										  
										});
							
										
							
										function addMaterial() {
											var htmlId = "material" + materialCount;
											var templateHtml = "<tbody id='" + htmlId + "'>\n";
											templateHtml += "<tr>";
											templateHtml += "<td width='90%'><input type='text' class='materialName' name='materialName' size='30' value='' id='roleName" + materialCount + "'/></td>\n";
											//templateHtml += "<input type='hidden' name='roleID' value='' id='roleID" + roleCount + "'/></td>\n";
											templateHtml += "<td width='10%'><input class='ui-icon ui-icon-trash' type='button' value='Remove' onclick='removeMaterial("+materialCount+")'/></td>\n";
											templateHtml += "</tr>\n";
											templateHtml += "</tbody>\n";
											$("#materialTbl").append(templateHtml);
											materialCount++;
										}
							
										function removeMaterial(idx) {
											$("#material"+idx+"").remove()
										}
						
							</script>
                        	
                        	<!-- 
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="material"><g:message code="productDetail.material.label" default="Material" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productDetailInstance, field: 'material', 'errors')}">
                                    <g:select name="material.id" from="${com.teravin.catalogue.Material.list()}" optionKey="id" value="${productDetailInstance?.material?.id}"  />
                                </td>
                            </tr>
                         -->
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="unit"><g:message code="productDetail.unit.label" default="Unit" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productDetailInstance, field: 'unit', 'errors')}">
                                    <g:textField name="unit" value="${fieldValue(bean: productDetailInstance, field: 'unit')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="price"><g:message code="productDetail.price.label" default="Price" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productDetailInstance, field: 'price', 'errors')}">
                                    <g:textField name="price" value="${fieldValue(bean: productDetailInstance, field: 'price')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="idxx"><g:message code="productDetail.idxx.label" default="Idxx" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productDetailInstance, field: 'idxx', 'errors')}">
                                    <g:textField name="idxx" value="${fieldValue(bean: productDetailInstance, field: 'idxx')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="isPriceOverwrite"><g:message code="productDetail.isPriceOverwrite.label" default="Is Price Overwrite" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productDetailInstance, field: 'isPriceOverwrite', 'errors')}">
                                    <g:textField name="isPriceOverwrite" value="${productDetailInstance?.isPriceOverwrite}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="idx"><g:message code="productDetail.idx.label" default="Idx" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productDetailInstance, field: 'idx', 'errors')}">
                                    <g:textField name="idx" value="${fieldValue(bean: productDetailInstance, field: 'idx')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="createdBy"><g:message code="productDetail.createdBy.label" default="Created By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productDetailInstance, field: 'createdBy', 'errors')}">
                                    <g:textField name="createdBy" maxlength="50" value="${productDetailInstance?.createdBy}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="updatedBy"><g:message code="productDetail.updatedBy.label" default="Updated By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productDetailInstance, field: 'updatedBy', 'errors')}">
                                    <g:textField name="updatedBy" maxlength="50" value="${productDetailInstance?.updatedBy}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="deleteFlag"><g:message code="productDetail.deleteFlag.label" default="Delete Flag" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productDetailInstance, field: 'deleteFlag', 'errors')}">
                                    <g:textField name="deleteFlag" value="${productDetailInstance?.deleteFlag}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
