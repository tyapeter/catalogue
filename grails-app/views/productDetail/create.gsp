

<%@ page import="com.teravin.catalogue.ProductDetail" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
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
           
            <g:form action="save" >
                <div class="dialog">
                	
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="productDetail.product.model"><g:message code="productDetail.product.model.label" default="Model" /></label>
                                </td>
                            	<td valign="top" class="value ${hasErrors(bean: productDetailInstance, field: 'product.model', 'errors')}">
                                    <g:textField class="modelName" name="modelName" id="modelName" value="" size="30"/>
                                    <g:hiddenField name="modelID"  value="" />
                                </td>
                        	</tr>
                        	
                        	<script type="text/javascript">
                        		var offset=0;
                        		var page=0;
                        		var max=5;
                        		var maxpage;
                        		var modelArrayTemp = new Array();
                        		$(document).ready(function(){
			                        	$("#modelDialog").dialog({
			            					autoOpen: false,
			            					height: 550,
			            					width: 500,
			            					modal: true,
			            					title: 'Search Model',
			            					open: function() {
			            						
			            					},
			            					buttons: {
			            						"First":function(){
			            							var url = "${createLink(url: [controller: 'model', action: 'getModelLikeName'])}";
			            							$.ajax({
			            								url: url,
			            								type:"POST",
			            							    dataType: "json",
			            								data: { name: $('#modelNameSearch').val() ,offset:0,max:max},
			            								success: function( data ) {
				            								  var options = "";
				            					 			  
				            				                  var i = 0;
				            				                  var model = data[0]
				            				                  while( model[i] != null ){
				            										if(i % 2 ==0 || i==0){
				            											options += "<tr >";
				            									
				            											options +='<td align=center><table ><tr><td align=center><img width =100 height=100 src="/catalogue/images/'+ (( model[i]['id'] != null ) ? (model[i]['id']) : ('')) +'.jpg" /></td>';
				            											options += "<tr><td align=center ><input  value='" + (( model[i]['code'] != null ) ? (model[i]['code']) : ('')) + ' - ' + (( model[i]['name'] != null ) ? (model[i]['name']) : (''))
				            											+"' type='submit' id=modelID"+model[i]['id']+" onclick='saveModelId("+model[i]['id']+")' /></td></tr></table>";
				            									    }else{
				            									    	options +='<td align=center><table ><tr><td align=center><img width =100 height=100 src="/catalogue/images/'+ (( model[i]['id'] != null ) ? (model[i]['id']) : ('')) +'.jpg" /></td>';
				            											options += "<tr><td align=center ><input  value='" + (( model[i]['code'] != null ) ? (model[i]['code']) : ('')) + ' - ' + (( model[i]['name'] != null ) ? (model[i]['name']) : (''))
				            											+"' type='submit' id=modelID"+model[i]['id']+" onclick='saveModelId("+model[i]['id']+")' /></td></tr></table>";
				            									    }
				            										if( i==max)
				            											options += "</tr >";
				            										modelArrayTemp[model[i]['id']]=model[i];	
				            										i++;
				            										
				            					                 }
				            				                  $("#searchModelResult").html(options); 
				            								}
				            							});
				            				          
				            						},
				            					"Next":function(){
				            						var url = "${createLink(url: [controller: 'model', action: 'getModelLikeName'])}";
				            						
				            						if(page*max < maxpage)
				            							page++;
				            						else
					            						page=page;
				            						
			            							$.ajax({
			            								url: url,
			            								type:"POST",
			            							    dataType: "json",
			            								data: { name: $('#modelNameSearch').val() ,offset:page*max,max:max},
			            								success: function( data ) {
				            								  var options = "";
				            					 			  
				            				                  var i = 0;
				            				                  var model = data[0]
				            				                  while( model[i] != null ){
				            										if(i % 2 ==0 || i==0){
				            											options += "<tr >";
				            									
				            											options +='<td align=center><table ><tr><td align=center><img width =100 height=100 src="/catalogue/images/'+ (( model[i]['id'] != null ) ? (model[i]['id']) : ('')) +'.jpg" /></td>';
				            											options += "<tr><td align=center ><input  value='" + (( model[i]['code'] != null ) ? (model[i]['code']) : ('')) + ' - ' + (( model[i]['name'] != null ) ? (model[i]['name']) : (''))
				            											+"' type='submit' id=modelID"+model[i]['id']+" onclick='saveModelId("+model[i]['id']+")' /></td></tr></table>";
				            									    }else{
				            									    	options +='<td align=center><table ><tr><td align=center><img width =100 height=100 src="/catalogue/images/'+ (( model[i]['id'] != null ) ? (model[i]['id']) : ('')) +'.jpg" /></td>';
				            											options += "<tr><td align=center ><input  value='" + (( model[i]['code'] != null ) ? (model[i]['code']) : ('')) + ' - ' + (( model[i]['name'] != null ) ? (model[i]['name']) : (''))
				            											+"' type='submit' id=modelID"+model[i]['id']+" onclick='saveModelId("+model[i]['id']+")' /></td></tr></table>";
				            									    }
				            										if( i==max)
				            											options += "</tr >";
				            										modelArrayTemp[model[i]['id']]=model[i];	
				            										i++;
				            										
				            					                 }
				            				                  $("#searchModelResult").html(options); 
				            				                  
				            								}
				            							});
					            					},
					            				"Prev":function(){
													var url = "${createLink(url: [controller: 'model', action: 'getModelLikeName'])}";
				            						
				            						if(page != 0)
				            							page--;
				            						
			            							$.ajax({
			            								url: url,
			            								type:"POST",
			            							    dataType: "json",
			            								data: { name: $('#modelNameSearch').val() ,offset:page*max,max:max},
			            								success: function( data ) {
				            								  var options = "";
				            					 			  
				            				                  var i = 0;
				            				                  var model = data[0]
				            				                  while( model[i] != null ){
				            										if(i % 2 ==0 || i==0){
				            											options += "<tr >";
				            									
				            											options +='<td align=center><table ><tr><td align=center><img width =100 height=100 src="/catalogue/images/'+ (( model[i]['id'] != null ) ? (model[i]['id']) : ('')) +'.jpg" /></td>';
				            											options += "<tr><td align=center ><input  value='" + (( model[i]['code'] != null ) ? (model[i]['code']) : ('')) + ' - ' + (( model[i]['name'] != null ) ? (model[i]['name']) : (''))
				            											+"' type='submit' id=modelID"+model[i]['id']+" onclick='saveModelId("+model[i]['id']+")' /></td></tr></table>";
				            									    }else{
				            									    	options +='<td align=center><table ><tr><td align=center><img width =100 height=100 src="/catalogue/images/'+ (( model[i]['id'] != null ) ? (model[i]['id']) : ('')) +'.jpg" /></td>';
				            											options += "<tr><td align=center ><input  value='" + (( model[i]['code'] != null ) ? (model[i]['code']) : ('')) + ' - ' + (( model[i]['name'] != null ) ? (model[i]['name']) : (''))
				            											+"' type='submit' id=modelID"+model[i]['id']+" onclick='saveModelId("+model[i]['id']+")' /></td></tr></table>";
				            									    }
				            										if( i==max)
				            											options += "</tr >";
				            										modelArrayTemp[model[i]['id']]=model[i];	
				            										i++;
				            										
				            					                 }
				            				                  $("#searchModelResult").html(options); 
				            				                  
				            								}
				            							});
						            				},
						            			"Last":function(){
													var url = "${createLink(url: [controller: 'model', action: 'getModelLikeName'])}";
				            						
				            						page=maxpage;
				            						
			            							$.ajax({
			            								url: url,
			            								type:"POST",
			            							    dataType: "json",
			            								data: { name: $('#modelNameSearch').val() ,offset:page*max,max:max},
			            								success: function( data ) {
				            								  var options = "";
				            					 			  
				            				                  var i = 0;
				            				                  var model = data[0]
				            				                  while( model[i] != null ){
				            										if(i % 2 ==0 || i==0){
				            											options += "<tr >";
				            									
				            											options +='<td align=center><table ><tr><td align=center><img width =100 height=100 src="/catalogue/images/'+ (( model[i]['id'] != null ) ? (model[i]['id']) : ('')) +'.jpg" /></td>';
				            											options += "<tr><td align=center ><input  value='" + (( model[i]['code'] != null ) ? (model[i]['code']) : ('')) + ' - ' + (( model[i]['name'] != null ) ? (model[i]['name']) : (''))
				            											+"' type='submit' id=modelID"+model[i]['id']+" onclick='saveModelId("+model[i]['id']+")' /></td></tr></table>";
				            									    }else{
				            									    	options +='<td align=center><table ><tr><td align=center><img width =100 height=100 src="/catalogue/images/'+ (( model[i]['id'] != null ) ? (model[i]['id']) : ('')) +'.jpg" /></td>';
				            											options += "<tr><td align=center ><input  value='" + (( model[i]['code'] != null ) ? (model[i]['code']) : ('')) + ' - ' + (( model[i]['name'] != null ) ? (model[i]['name']) : (''))
				            											+"' type='submit' id=modelID"+model[i]['id']+" onclick='saveModelId("+model[i]['id']+")' /></td></tr></table>";
				            									    }
				            										if( i==max)
				            											options += "</tr >";
				            										modelArrayTemp[model[i]['id']]=model[i];	
				            										i++;
				            										
				            					                 }
				            				                  $("#searchModelResult").html(options); 
				            				                  
				            								}
				            							});
							            			}
			            					},
			            					close: function() {
			            						
			            					}
			            				});

                        		});		
                        		$( "#model-dialog:ui-dialog" ).dialog( "destroy" );
                        		$('.modelName')
                                .click(function() {
                                    $('#modelDialog').dialog('open');
                                });	
                        		$('.modelNameSearch')
                                .click(function() {
                                	var url = "${createLink(url: [controller: 'model', action: 'getModelLikeName'])}";
									$.ajax({
										url: url,
										dataType: "json",
										data: { name: request.term },
										success: function( data ) {
											response( $.map( data, function( item ) {
												return {
													label: item.name,
													value: item.name,
													id: item.id,
													index:item.idxx,
													price:item.price,
												    unit:item.unitType.id
												}
											}));
										}
									});
                                });		
										</script>
							<tr class="prop">
	                                <td valign="top" class="name">
	                                    <label for="productDetail.product.model.modelCategory"><g:message code="productDetail.product.model.modelCategory" default="ModelCategory" /></label>
	                                </td>
	                              	<td valign="top" class="value ${hasErrors(bean: productDetailInstance, field: 'product.model', 'errors')}">
	                                    <g:textField class="modelCategory" name="modelCategory" id="modelCategory" value="" size="30"/>
	                                    
	                                </td>
                        	</tr>				
							 <tr class="prop">
	                                <td valign="top" class="name" colspan=2>
	                                  <table>
	                                  	<tr>
		                                  	<td><label for="width"><g:message code="model.width.label" default="Width" /></label></td>
		                                  	 <td valign="top" class="value ${hasErrors(bean: modelInstance, field: 'width', 'errors')}">
	                                    			<g:textField id='modelWidth' name='modelWidth' class='modelWidth' value="${fieldValue(bean: modelInstance, field: 'width')}" />
	                                		</td>
	                                		
	                                		<td><label for="length"><g:message code="model.length.label" default="Length" /></label></td>
		                                  	 <td valign="top" class="value ${hasErrors(bean: modelInstance, field: 'length', 'errors')}">
	                                    			<g:textField id='modelLength' name='modelLength' class='modelLength'  value="${fieldValue(bean: modelInstance, field: 'length')}" />
	                                		</td>
	                                		
	                                		<td><label for="EstLoad"><g:message code="model.estLoad.label" default="Est Load" /></label></td>
		                                  	 <td valign="top" class="value ${hasErrors(bean: modelInstance, field: 'estLoad', 'errors')}">
	                                    			<g:textField id='modelEstLoad' name='modelEstLoad' class='modelEstLoad'  value="${fieldValue(bean: modelInstance, field: 'modelEstLoad')}" />
	                                		</td>
	                                  	</tr>
	                                  	<tr>
		                                  	<td><label for="height"><g:message code="model.height.label" default="height" /></label></td>
		                                  	 <td valign="top" class="value ${hasErrors(bean: modelInstance, field: 'height', 'errors')}">
	                                    			<g:textField id='modelHeight' name='modelHeight' class='modelHeight' value="${fieldValue(bean: modelInstance, field: 'height')}" />
	                                		</td>
	                                		
	                                		<td><label for="seatHeight"><g:message code="model.seatHeight.label" default="Seat Height" /></label></td>
		                                  	 <td valign="top" class="value ${hasErrors(bean: modelInstance, field: 'height', 'errors')}">
	                                    			<g:textField id='modelSeatHeight' name='modelSeatHeight' class='modelSeatHeight'  value="${fieldValue(bean: modelInstance, field: 'height')}" />
	                                		</td>
	                                		
	                                		<td><label for="cbm"><g:message code="model.cbm.label" default="CBM" /></label></td>
		                                  	 <td valign="top" class="value ${hasErrors(bean: modelInstance, field: 'cbm', 'errors')}">
	                                    			<g:textField id='modelCbm' name='modelCbm' class='modelCbm'  value="${fieldValue(bean: modelInstance, field: 'modelCbm')}" />
	                                		</td>
	                                  	</tr>
	                                  </table>
	                                    
	                                </td>
                        	</tr>	
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
                                <td valign="top" class="name" colspan="2">
                                	
                                    <table id="materialTbl" >
                                    	<thead>
                                    		<tr>
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
				                            </tr>
			                            </thead >
                                    	<g:each in="${materialList}" status="i" var="materials">
                                    	<tbody id="material${i}">
                                    		<!-- Material -->
				                        	
		                    				<tr>
		                    					<td width="90%">
		                                    		<g:textField class="materialName" name="materialName" id="materialName${i}" value="${material}" size="30"/>
		                                		</td>
		                                		<td></td>
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
		                    			<tfoot>
		                    			<tr class="prop">
			                                <td valign="top" class="name" colspan="2">
			                                    <input type="button" value="${message(code: 'default.button.add.label')}" default="Add Material" onclick="addMaterial()"/>
			                                	 <script type="text/javascript">
													var materialCount = ${materialList?.size()} + 0;
													var materialId;
													var idOfMaterialTextBox;
													$(document).ready(function(){
														$('.materialName').live('keyup.autocomplete', function(){
															$(this).autocomplete({
																source: function( request, response ) {
																	var url = "${createLink(url: [controller: 'material', action: 'getMaterialLikeName'])}";
																	$.ajax({
																		url: url,
																		dataType: "json",
																		data: { name: request.term },
																		success: function( data ) {
																			
																			response( $.map( data, function( item ) {
																				materialId=item.id;
																				return {
																					label: item.name,
																					value: item.name,
																					id: item.id,
																					index:item.idxx,
																					price:item.price,
																				    unit:item.unitType.id
																				}
																			}));
																		}
																	});
																},
																minLength: 2,
																delay: 50,
																select: function(event, ui) {
																	var url = "${createLink(url: [controller: 'unitType', action: 'getUnitTypeById'])}";
																	$.ajax({
																		url: url,
																		dataType: "json",
																		data: { id: ui.item.unit },
																		success: function( data ) {
																			 
																			 $("#materialUnitType"+idOfMaterialTextBox).val( data['name'] );
																			 	
																		}
																	});
																	
															         $("#materialIndex"+idOfMaterialTextBox).val(ui.item.index);
																	 $("#materialPrice"+idOfMaterialTextBox).val(ui.item.price);
																	 $("#materialID"+idOfMaterialTextBox).val(ui.item.id);
															  }
																							
															});
														});
													
														
													});
										
													
										
													function addMaterial() {
														var htmlId = "material" + materialCount;
														var templateHtml = "<tbody id='" + htmlId + "'>\n";
														templateHtml += "<tr>";
														templateHtml += "<input type='hidden' name='materialID'  value='' id='materialID" + materialCount + "'/></td>\n";
														templateHtml += "<td width='60%'><input type='text' onFocus='setIdOfMaterialTextBox("+materialCount+")' class='materialName' name='materialName' size='30' value='' id='materialName" + materialCount + "'/></td>\n";
														templateHtml += "<td width='10%'><input type='text' name='materialUnit' size='15' value='' id='materialUnitType" + materialCount + "'/></td>\n"
														templateHtml += "<td width='10%'><input type='text' name='materialIndex' size='15' value='' id='materialIndex" + materialCount + "'/></td>\n"
														templateHtml += "<td width='10%'><input type='text'  name='materialPrice' size='15' value='' id='materialPrice" + materialCount + "'/></td>\n"
														templateHtml += "<td width='10%'><input class='ui-icon ui-icon-trash' type='button' value='Remove' onclick='removeMaterial("+materialCount+")'/></td>\n";
														
														templateHtml += "</tr>\n";
														templateHtml += "</tbody>\n";
														$("#materialTbl").append(templateHtml);
														materialCount++;
													}
													function setIdOfMaterialTextBox(idx)
													{
														this.idOfMaterialTextBox = idx;

													}
													
													function removeMaterial(idx) {
														$("#material"+idx+"").remove()
													}
									
										</script>
			                                </td>
			                            </tr>
			                            </tfoot>
                                    </table>
                                   
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name" colspan="2">
                                	
                                    <table id="accesoriesTbl" >
                                    	<thead>
                                    		<tr>
				                                <th valign="top" class="name" >
				                                    <label for="productDetail"><g:message code="productDetail.accesories.label" default="Accesories" /></label>
				                                </th>
				                               <th valign="top" class="name" >
				                                    <label for="productDetail"><g:message code="productDetail.accesories.unitType.label" default="Unit Type" /></label>
				                                </th>
				                                <th valign="top" class="name" >
				                                    <label for="productDetail"><g:message code="productDetail.accesories.index.label" default="Index" /></label>
				                                </th>
				                                <th valign="top" class="name" >
				                                    <label for="productDetail"><g:message code="productDetail.accesories.price.label" default="Price" /></label>
				                                </th>
				                            </tr>
			                            </thead >
                                    	<g:each in="${accesoriesList}" status="i" var="accesoriess">
                                    	<tbody id="accesories${i}">
                                    	
				                        	
		                    				<tr>
		                    					<td width="90%">
		                                    		<g:textField class="accesoriesName" name="accesoriesName" id="accesoriesName${i}" value="${accesories}" size="30"/>
		                                		</td>
		                                		<td></td>
		                                		<td width="10%">
		                                		<g:if test="${i == 0}">		                                		
			                                    		&nbsp;		                                    	
		                                    	</g:if>
		                                    	<g:else>
		                                    		<input type="button" class="ui-icon ui-icon-trash" value="Remove" onclick="removeAccesories(${i })"/>
		                                    	</g:else>
		                                    	</td>
		                    				</tr>
										</tbody>
										
		                    			</g:each>
		                    			<tfoot>
		                    			<tr class="prop">
			                                <td valign="top" class="name" colspan="2">
			                                    <input type="button" value="${message(code: 'default.button.add.label')}" default="Add Accesories" onclick="addAcc()"/>
			                                	 <script type="text/javascript">
													var accesoriesCount = ${accesoriesList?.size()} + 0;
													var accId;
													var idOfAccTextBox;
													$(document).ready(function(){
														$('.accesoriesName').live('keyup.autocomplete', function(){
															$(this).autocomplete({
																source: function( request, response ) {
																	var url = "${createLink(url: [controller: 'accesories', action: 'getAccesoriesLikeName'])}";
																	$.ajax({
																		url: url,
																		dataType: "json",
																		data: { name: request.term },
																		success: function( data ) {
																			
																			response( $.map( data, function( item ) {
																				accId=item.id;
																				return {
																					label: item.name,
																					value: item.name,
																					id: item.id,
																					index:item.idx,
																					price:item.price,
																					unit:item.unitType.id
																				}
																			}));
																		}
																	});
																},
																minLength: 2,
																delay: 50,
																select: function(event, ui) {
																	var url = "${createLink(url: [controller: 'unitType', action: 'getUnitTypeById'])}";
																	$.ajax({
																		url: url,
																		dataType: "json",
																		data: { id: ui.item.unit },
																		success: function( data ) {
																			 
																			 $("#accesoriesUnitType"+idOfAccTextBox).val( data['name'] );
																			 	
																		}
																	});
																	
															         $("#accesoriesIndex"+idOfAccTextBox).val(ui.item.index);
																	 $("#accesoriesPrice"+idOfAccTextBox).val(ui.item.price);
																	 $("#accesoriesID"+idOfAccTextBox).val(ui.item.id);
															  }
																							
															});
														});
													
														
													});
													function addAcc() {
														var htmlId = "accesories" + accesoriesCount;
														var templateHtml = "<tbody id='" + htmlId + "'>\n";
														templateHtml += "<tr>";
														templateHtml += "<input type='hidden' name='accesoriesID'  value='' id='accesoriesID" + accesoriesCount + "'/></td>\n";
														templateHtml += "<td width='70%'><input type='text' onFocus='setIdOfAccTextBox("+accesoriesCount+")' class='accesoriesName' name='accesoriesName' size='30' value='' id='accesoriesName" + accesoriesCount + "'/></td>\n";
														templateHtml += "<td width='10%'><input type='text' name='accesoriesUnitType' size='15' value='' id='accesoriesUnitType" + accesoriesCount + "'/></td>\n"
														templateHtml += "<td width='10%'><input type='text' name='accesoriesIndex' size='15' value='' id='accesoriesIndex" + accesoriesCount + "'/></td>\n"
														templateHtml += "<td width='10%'><input type='text'  name='accesoriesPrice' size='15' value='' id='accesoriesPrice" + accesoriesCount + "'/></td>\n"
														templateHtml += "<td width='10%'><input class='ui-icon ui-icon-trash' type='button' value='Remove' onclick='removeAcc("+accesoriesCount+")'/></td>\n";
														
														templateHtml += "</tr>\n";
														templateHtml += "</tbody>\n";
														$("#accesoriesTbl").append(templateHtml);
														accesoriesCount++;
													}
													function setIdOfAccTextBox(idx)
													{
														this.idOfAccTextBox = idx;

													}
													
													function removeAcc(idx) {
														$("#accesories"+idx+"").remove()
													}
									
											</script>
			                                </td>
			                            </tr>
			                            </tfoot>
                                    </table>
                                   
                                </td>
                            </tr>
                        	
                           <tr class="prop">
                                <td valign="top" class="name" colspan="2">
                                	
                                    <table id="miscellaneousTbl" >
                                    	<thead>
                                    		<tr>
				                                <th valign="top" class="name" >
				                                    <label for="productDetail"><g:message code="productDetail.miscellaneous.label" default="Miscellaneous" /></label>
				                                </th>
				                               <th valign="top" class="name" >
				                                    <label for="productDetail"><g:message code="productDetail.miscellaneous.unitType.label" default="Unit Type" /></label>
				                                </th>
				                                <th valign="top" class="name" >
				                                    <label for="productDetail"><g:message code="productDetail.miscellaneous.index.label" default="Index" /></label>
				                                </th>
				                                <th valign="top" class="name" >
				                                    <label for="productDetail"><g:message code="productDetail.miscellaneous.price.label" default="Price" /></label>
				                                </th>
				                            </tr>
			                            </thead >
                                    	<g:each in="${miscellaneousList}" status="i" var="miscellaneouss">
                                    	<tbody id="miscellaneous${i}">
                                    	
				                        	
		                    				<tr>
		                    					<td width="90%">
		                                    		<g:textField class="miscellaneousName" name="miscellaneousName" id="miscellaneousName${i}" value="${miscellaneous}" size="30"/>
		                                		</td>
		                                		<td></td>
		                                		<td width="10%">
		                                		<g:if test="${i == 0}">		                                		
			                                    		&nbsp;		                                    	
		                                    	</g:if>
		                                    	<g:else>
		                                    		<input type="button" class="ui-icon ui-icon-trash" value="Remove" onclick="removeMiscellaneous(${i })"/>
		                                    	</g:else>
		                                    	</td>
		                    				</tr>
										</tbody>
										
		                    			</g:each>
		                    			<tfoot>
		                    			<tr class="prop">
			                                <td valign="top" class="name" colspan="2">
			                                    <input type="button" value="${message(code: 'default.button.add.label')}" default="Add Miscellaneous" onclick="addMisc()"/>
			                                	 <script type="text/javascript">
													var miscellaneousCount = ${miscellaneousList?.size()} + 0;
													var miscId;
													var idOfMiscTextBox;
													$(document).ready(function(){
														$('.miscellaneousName').live('keyup.autocomplete', function(){
															$(this).autocomplete({
																source: function( request, response ) {
																	var url = "${createLink(url: [controller: 'miscellaneous', action: 'getMiscellaneousLikeName'])}";
																	$.ajax({
																		url: url,
																		dataType: "json",
																		data: { name: request.term },
																		success: function( data ) {
																			
																			response( $.map( data, function( item ) {
																				accId=item.id;
																				return {
																					label: item.name,
																					value: item.name,
																					id: item.id,
																					index:item.idx,
																					price:item.price,
																					unit:item.unitType.id
																				}
																			}));
																		}
																	});
																},
																minLength: 2,
																delay: 50,
																select: function(event, ui) {
																	var url = "${createLink(url: [controller: 'unitType', action: 'getUnitTypeById'])}";
																	$.ajax({
																		url: url,
																		dataType: "json",
																		data: { id: ui.item.unit },
																		success: function( data ) {
																			 
																			 $("#miscellaneousUnitType"+idOfMiscTextBox).val( data['name'] );
																			 	
																		}
																	});
																	
															         $("#miscellaneousIndex"+idOfMiscTextBox).val(ui.item.index);
																	 $("#miscellaneousPrice"+idOfMiscTextBox).val(ui.item.price);
																	 $("#miscellaneousID"+idOfMiscTextBox).val(ui.item.id);
															  }
																							
															});
														});
													
													
													});
										
													
										
													function addMisc() {
														var htmlId = "miscellaneous" + miscellaneousCount;
														var templateHtml = "<tbody id='" + htmlId + "'>\n";
														templateHtml += "<tr>";
														templateHtml += "<input type='hidden' name='miscellaneousID'  value='' id='miscellaneousID" + miscellaneousCount + "'/></td>\n";
														templateHtml += "<td width='70%'><input type='text' onFocus='setIdOfMiscTextBox("+miscellaneousCount+")' class='miscellaneousName' name='miscellaneousName' size='30' value='' id='miscellaneousName" + miscellaneousCount + "'/></td>\n";
														templateHtml += "<td width='10%'><input type='text' name='miscellaneousUnitType' size='15' value='' id='miscellaneousUnitType" + miscellaneousCount + "'/></td>\n"
														templateHtml += "<td width='10%'><input type='text' name='miscellaneousIndex' size='15' value='' id='miscellaneousIndex" + miscellaneousCount + "'/></td>\n"
														templateHtml += "<td width='10%'><input type='text'  name='miscellaneousPrice' size='15' value='' id='miscellaneousPrice" + miscellaneousCount + "'/></td>\n"
														templateHtml += "<td width='10%'><input class='ui-icon ui-icon-trash' type='button' value='Remove' onclick='removeMisc("+miscellaneousCount+")'/></td>\n";
														
														templateHtml += "</tr>\n";
														templateHtml += "</tbody>\n";
														$("#miscellaneousTbl").append(templateHtml);
														miscellaneousCount++;
													}
													function setIdOfMiscTextBox(idx)
													{
														this.idOfMiscTextBox = idx;

													}
													function removeMisc(idx) {
														$("#miscellaneous"+idx+"").remove()
													}
								
										</script>
			                                </td>
			                            </tr>
			                            </tfoot>
                                    </table>
                                   
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
        <div id="modelDialog" title="Search Model">
        		<div>
				<fieldset>
					<label for="Model">Search Model</label>
					<g:textField type="text" name="modelNameSearch" id="modelNameSearch" class="text ui-widget-content ui-corner-all" />
				</fieldset>
				</div>		
				<div >
					<table id="searchModelResult" align=center >
					
					</table>
					
				</div>		
				<div id="paging">
				
				</div>
		</div>
		<script type="text/javascript">
       		$('#modelNameSearch')
               .change(function() {
               	var url = "${createLink(url: [controller: 'model', action: 'getModelLikeName'])}";
              	modelArrayTemp = new Array();
				$.ajax({
					url: url,
					type:"POST",
				    dataType: "json",
					data: { name: $('#modelNameSearch').val() },
					success: function( data ) {
					  var options = "";
		 			  
	                  var i = 0;
	                  var model = data[0]
	                  
	                  while( model[i] != null ){
						if(i % 2 ==0 || i==0){
							options += "<tr >";
					
							options +='<td align=center><table ><tr><td align=center><img width =100 height=100 src="/catalogue/images/'+ (( model[i]['id'] != null ) ? (model[i]['id']) : ('')) +'.jpg" /></td>';
							options += "<tr><td align=center ><input  value='" + (( model[i]['code'] != null ) ? (model[i]['code']) : ('')) + ' - ' + (( model[i]['name'] != null ) ? (model[i]['name']) : (''))
							+"' type='submit' id=modelID"+model[i]['id']+" onclick='saveModelId("+model[i]['id']+")' /></td></tr></table>";
					    }else{
					    	options +='<td align=center><table ><tr><td align=center><img width =100 height=100 src="/catalogue/images/'+ (( model[i]['id'] != null ) ? (model[i]['id']) : ('')) +'.jpg" /></td>';
							options += "<tr><td align=center ><input  value='" + (( model[i]['code'] != null ) ? (model[i]['code']) : ('')) + ' - ' + (( model[i]['name'] != null ) ? (model[i]['name']) : (''))
							+"' type='submit' id=modelID"+model[i]['id']+" onclick='saveModelId("+model[i]['id']+")' /></td></tr></table>";
					    }
						if( i==max)
							options += "</tr >";
						modelArrayTemp[model[i]['id']]=model[i];	
						i++;
						
	                 }
	                 
	                  $("#searchModelResult").html(options); 
	                  maxpage=Math.round((((data[1] != null ) ? (data[1]) : (0)))/max);
	 				
					}
				});
           });	
         	function saveModelId(idx) {
				$('#modelDialog').dialog('close');
				$("#modelName").val($("#modelID"+idx).val());
				$("#modelID").val(idx);
			  	var url = "${createLink(url: [controller: 'modelCategory', action: 'getModelCategory'])}";
			  	var modelTemp = modelArrayTemp[idx];
			  	var modelCategoryId =  modelTemp['modelCategory']['id'];
			  
			  	$.ajax({
					url: url,
					type:"POST",
				    dataType: "json",
					data: { id:modelCategoryId },
					success: function( data ) {
					  $("#modelCategory").val(data['name']);
					  $("#modelWidth").val(modelTemp['width']);
					  $("#modelLength").val(modelTemp['length']);
					  $("#modelEstLoad").val(modelTemp['estLoad']);
					  $("#modelHeight").val(modelTemp['height']);
					  $("#modelSeatHeight").val(modelTemp['seatHeight']);
					  $("#modelCbm").val(modelTemp['cbm']);
	                }
	              
				});
			}
		</script>
    </body>
</html>
