

<%@ page import="com.teravin.catalogue.Product" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main2" />
        <g:set var="entityName" value="${message(code: 'product.label', default: 'Product')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/index2.gsp')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${productInstance}">
            <div class="errors">
                <g:renderErrors bean="${productInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" enctype="multipart/form-data" >
                <g:hiddenField name="id" value="${productInstance?.id}" />
                <g:hiddenField name="version" value="${productInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        	<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="product.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'name', 'errors')}">
                                    <g:textField id="name" name="name" class="name" maxlength="100" value="${fieldValue(bean: productInstance, field: 'name')}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for=productInstance.model"><g:message code="productInstance.model.label" default="Model" /></label>
                                </td>
                            	<td valign="top" class="value ${hasErrors(bean: productInstance, field: 'product.model.name', 'errors')}">
                                    <g:textField class="modelName" name="modelName" id="modelName" value="${productInstance.model.name }" size="30"/>
                                    <g:hiddenField name="modelID"  value="${productInstance.model.id }" />
                                    <g:hiddenField name="modelCode"  value="${productInstance.model.code }" />
                                    <g:hiddenField name="modelCategoryCode"  value="${productInstance.model.modelCategory.code }" />
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
	                              	<td valign="top" class="value ${hasErrors(bean: productInstance, field: 'product.model.modelCategory.name', 'errors')}">
	                                    <g:textField class="modelCategory" name="modelCategory" id="modelCategory" value="${productInstance.model.modelCategory.name }" size="30"/>
	                                    
	                                </td>
                        	</tr>		
                        	<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="materialmain"><g:message code="product.materialMain.label" default="Material Main" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'materialMain', 'errors')}">
                                    <g:select name="materialMain.id" from="${com.teravin.catalogue.MaterialMain.findAllByDeleteFlag('N')}" optionKey="id" value="${productInstance?.materialMain?.id}"  />
                                </td>
                                
                            </tr>		
							 <tr class="prop">
	                                <td valign="top" class="name" colspan=2>
	                                  <table>
	                                  	<tr>
		                                  	<td><label for="width"><g:message code="productInstance.width.label" default="Width" /></label></td>
		                                  	 <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'width', 'errors')}">
	                                    			<g:textField id='width' name='width' class='width' onChange='calculateTotalCubic()' value="${fieldValue(bean: productInstance, field: 'width')}" />
	                                		</td>
	                                		
	                                		<td><label for="height"><g:message code="productInstance.height.label" default="height" /></label></td>
		                                  	 <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'height', 'errors')}">
	                                    			<g:textField id='height' name='height' class='modelHeight' onChange='calculateTotalCubic()' value="${fieldValue(bean: productInstance, field: 'height')}" />
	                                		</td>
	                                		
	                                		<td><label for="length"><g:message code="productInstance.length.label" default="Length" /></label></td>
		                                  	 <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'length', 'errors')}">
	                                    			<g:textField id='length' name='length' class='modelLength' onChange='calculateTotalCubic()' value="${fieldValue(bean: productInstance, field: 'length')}" />
	                                		</td>
	                                		
	                                		
	                                  	</tr>
	                                  	<tr>
		                                  	<td><label for="seatWidth"><g:message code="productInstance.seatWidth.label" default="Seat Width" /></label></td>
		                                  	 <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'seatWidth', 'errors')}">
	                                    			<g:textField id='seatWidth' name='seatWidth' class='width' value="${fieldValue(bean: productInstance, field: 'seatWidth')}" />
	                                		</td>
	                                		
	                                		<td><label for="seatHeight"><g:message code="productInstance.seatHeight.label" default="seat Height" /></label></td>
		                                  	 <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'seatHeight', 'errors')}">
	                                    			<g:textField id='seatHeight' name='seatHeight' class='seatHeight' value="${fieldValue(bean: productInstance, field: 'seatHeight')}" />
	                                		</td>
	                                		
	                                		<td><label for="seatLength"><g:message code="productInstance.seatLength.label" default="Seat Length" /></label></td>
		                                  	 <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'seatLength', 'errors')}">
	                                    			<g:textField id='seatLength' name='seatLength' class='seatLength'  value="${fieldValue(bean: productInstance, field: 'seatLength')}" />
	                                		</td>
	                                		
	                                		
	                                  	</tr>
	                                  	<tr>
		                                  	<td><label for="packingWidth"><g:message code="productInstance.packingWidth.label" default="Packing Width" /></label></td>
		                                  	 <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'packingWidth', 'errors')}">
	                                    			<g:textField id='packingWidth' name='packingWidth' class='packingWidth' value="${fieldValue(bean: productInstance, field: 'packingWidth')}" />
	                                		</td>
	                                		
	                                		<td><label for="packingHeight"><g:message code="productInstance.packingHeight.label" default="Packing Height" /></label></td>
		                                  	 <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'packingHeight', 'errors')}">
	                                    			<g:textField id='packingHeight' name='packingHeight' class='seatHeight' value="${fieldValue(bean: productInstance, field: 'packingHeight')}" />
	                                		</td>
	                                		
	                                		<td><label for="packingLength"><g:message code="productInstance.packingLength.label" default="Packing Length" /></label></td>
		                                  	 <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'packingLength', 'errors')}">
	                                    			<g:textField id='packingLength' name='packingLength' class='packingLength'  value="${fieldValue(bean: productInstance, field: 'packingLength')}" />
	                                		</td>
	                                		
	                                		
	                                  	</tr>
	                                  	<tr>
		                                  	
	                                		<td><label for="estLoad"><g:message code="productInstance.estLoad.label" default="Est Load" /></label></td>
		                                  	 <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'estLoad', 'errors')}">
	                                    			<g:textField id='estLoad' name='estLoad' class='estLoad'  value="${fieldValue(bean: productInstance, field: 'estLoad')}" />
	                                		</td>
	                                		<td><label for="seatHeight"><g:message code="productInstance.totalCubic.label" default="Total Cubic" /></label></td>
		                                  	 <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'totalCubic', 'errors')}">
	                                    			<g:textField id='totalCubic' name='totalCubic' class='totalCubic'  value="${fieldValue(bean: productInstance, field: 'totalCubic')}" />
	                                		</td>
	                                		<td><label for="cbm"><g:message code="productInstance.cbm.label" default="CBM" /></label></td>
		                                  	 <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'cbm', 'errors')}">
	                                    			<g:textField id='cbm' name='cbm' class='cbm'  value="${fieldValue(bean: productInstance, field: 'cbm')}" />
	                                		</td>
	                                  	</tr>
	                                  	<tr>
		                            		<td><label for="totalWeight"><g:message code="productInstance.totalWeight.label" default="Total Weight" /></label></td>
		                                  	 <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'totalWeight', 'errors')}" colspan="5">
	                                    			<g:textField id='totalWeight' name='totalWeight' class='totalWeight'  value="${fieldValue(bean: productInstance, field: 'totalWeight')}" />
	                                		</td>
	                                		
	                                  	</tr>
	                                  </table>
	                                    
	                                </td>
                        	</tr>
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
                        	
                           	 <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="imageFront"><g:message code="product.imageFront.label" default="Image Front" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'imageFront', 'errors')}">
                                    <input type="file" id="imageFront" name="imageFront" />
                                </td>
                            </tr>
                            
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
                                    <label for="imageSide"><g:message code="product.imageSide.label" default="Image Side" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'imageSide', 'errors')}">
                                    <input type="file" id="imageSide" name="imageSide" />
                                </td>
                            </tr>
                        	 <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="color"><g:message code="product.color.label" default="Color" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'color', 'errors')}">
                                    <g:select name="color.id" from="${com.teravin.catalogue.maintenance.Color.findAllByDeleteFlag('N')}" optionKey="id" value="${fieldValue(bean: productInstance, field: 'color.id')}"  />
                                </td>
                            </tr>
                        
                           <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="idxx"><g:message code="product.index.label" default="Index" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'idxx', 'errors')}">
                                    <g:textField name="idxx" id="idxx" value="${fieldValue(bean: productInstance, field: 'idxx')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="indexPricing"><g:message code="product.indexPricing.label" default="Index Pricing" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'indexPricing', 'errors')}">
                                    <g:textField name="indexPricing" value="${fieldValue(bean: productInstance, field: 'indexPricing')}" />
                                </td>
                            </tr>
                        
                              <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="price"><g:message code="product.price.label" default="Price" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'price', 'errors')}">
                                    <g:textField name="price" value="${fieldValue(bean: productInstance, field: 'price')}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="baseCost">
                                    <label for="baseCost"><g:message code="product.baseCost.label" default="Base Cost" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'price', 'errors')}">
                                    <g:textField name="baseCost" value="${fieldValue(bean: productInstance, field: 'baseCost')}" />
                                </td>
                            </tr>
                            <!-- tr class="prop">
                                <td valign="top" class="name">
                                    <label for="idx"><g:message code="product.idx.label" default="Index" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'idx', 'errors')}">
                                    <g:textField name="idx" value="${fieldValue(bean: productInstance, field: 'idx')}" />
                                </td>
                            </tr --!>
                        <tr class="prop">
                                <td valign="top" class="name" colspan="2">
                                	
                                    <table id="materialTbl" >
                                    	<thead>
                                    		<tr>
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
				                                    <label for="productDetail"><g:message code="productDetail.material.index.label" default="Index" /></label>
				                                </th>
				                               <th valign="top" class="name" >
				                                    <label for="product"><g:message code="productDetail.material.price.label" default="Price" /></label>
				                                </th>
				                            </tr>
			                            </thead >
                                    	<g:each in="${materialList}" status="i" var="materialInstance" class="value ${hasErrors(bean: materialList, field: 'materialList', 'errors')} >
                                    	<tbody id="materialInstance${i}">
                                    		<!-- Material -->
				                        	
		                    				<tr>
		                    					<td >
		                    						<g:hiddenField class="materialID" name="materialID" id="materialID${i}" value="${materialInstance.material.id}"/>
		                    						<g:hiddenField class="materialSubtotal" name="materialSubtotal" id="materialSubtotal${i}" value="${materialInstance.material.id}"/>
		                    						<g:hiddenField class="materialDelete" name="materialDelete" id="materialDelete${i}" value="false"/>
		                    						<g:hiddenField class="productDetailInstance" name="productDetailInstance" id="productDetailInstance${i}" value="${materialInstance.id}"/>
		                    					   <g:textField onFocus='setIdOfMaterialTextBox(${i})' class="materialName" name="materialName" id="materialName${i}" value="${materialInstance.material.name}" />
		                                		</td>
		                                		<td >
		                    						<g:textField class="materialUnit" onChange='calculateMaterialPriceItem(${i})' name="materialUnit" id="materialUnit${i}" value="${materialInstance.unit}" />
		                                		</td>
		                                		<td >
		                    						<g:textField class="materialUnitType" name="materialUnitType" id="materialUnitType${i}" value="${materialInstance.material.unitType.name}" />
		                                		</td>
		                                		<td >
		                    						<g:textField class="materialIndex" name="materialIndex" id="materialIndex${i}" value="${materialInstance.idxx}" />
		                                		</td>
		                                		<td >
		                    						<g:hiddenField class="materialPrice" name="materialPrice" id="materialPrice${i}" value="${materialInstance.price}" />
		                    						<g:textField class="materialSubTotal" name="materialSubTotal" id="materialSubTotal${i}" onChange='calculateMaterialIndexItem(${i})' />
		                                		</td>
		                                		<td >
		                                		
		                                    		<input type="button" class="ui-icon ui-icon-trash" value="Remove" onclick="removeMaterial(${i})"/>
		                                    	
		                                    	</td>
		                    				</tr>
										</tbody>
										 	<script type="text/javascript">
				                        		var subtotal = parseFloat(${materialInstance.price})* parseFloat(${materialInstance.unit});
				                        		 $("#materialSubTotal${i}").val(subtotal);
				                        	</script>	
		                    			</g:each>
		                    			<tfoot>
		                    			<tr class="prop">
			                                <td valign="top" class="name" colspan="2">
			                                    <input type="button" value="${message(code: 'default.button.add.label')}" default="Add Material" onclick="addMaterial()"/>
			                                	 <script type="text/javascript">
													var materialCount = ${materialList?.size()} + 0;
													var materialId;
													var idOfMaterialTextBox;
													var oRed = '#F4A1A1';
													var oBlue = '#CDB4F6';
													$(document).ready(function(){
														$('.materialName').live('keyup.autocomplete', function(){
															$(this).autocomplete({
																source: function( request, response ) {
																	var url = "${createLink(url: [controller: 'material', action: 'getMaterialLikeNameAndMaterialCategoryIs'])}";
																	$.ajax({
																		url: url,
																		dataType: "json",
																		data: { name: request.term , materialTypeName: 'material'},
																		success: function( data ) {
																			
																			response( $.map( data, function( item ) {
																				materialId=item.id;
																				return {
																					label: item.name,
																					value: item.name,
																					id: item.id,
																					index:item.idxx,
																					price:item.price,
																				    unitType:item.unitType.id
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
																		data: { id: ui.item.unitType },
																		success: function( data ) {
																			 
																			 $("#materialUnitType"+idOfMaterialTextBox).val( data['name'] );
																			 	
																		}
																	});
																	
															         $("#materialIndex"+idOfMaterialTextBox).val(ui.item.index);
																	 $("#materialPrice"+idOfMaterialTextBox).val(ui.item.price );
																	 $("#materialID"+idOfMaterialTextBox).val(ui.item.id);
																	 $("#materialUnit"+idOfMaterialTextBox).val(1);
																	 $("#materialSubTotal"+idOfMaterialTextBox).val(ui.item.price * $("#materialUnit"+idOfMaterialTextBox).val());
																	 calculatePrice();
															  }
																							
															});
														});
													
														
													});
										
													
										
													function addMaterial() {
														var htmlId = "materialInstance" + materialCount;
														var templateHtml = "<tbody id='" + htmlId + "'>\n";
														templateHtml += "<tr>";
														templateHtml += "<input type='hidden' name='materialID'  value='' id='materialID" + materialCount + "'/>\n";
														templateHtml += "<input type='hidden' class='materialDelete' name='materialDelete' id='materialDelete" + materialCount + "' value='false'/>\n";
														templateHtml += "<td width='50%'>";
														templateHtml += "<input type='text' onFocus='setIdOfMaterialTextBox("+materialCount+")' class='materialName' name='materialName'  value='' id='materialName" + materialCount + "'/></td>\n";
														templateHtml += "<td width='10%'><input type='text' name='materialUnit' onChange='calculateMaterialPriceItem("+ materialCount+")'  value='' id='materialUnit" + materialCount + "'/></td>\n";
														templateHtml += "<td width='10%'><input type='text' name='materialUnitType'  value='' id='materialUnitType" + materialCount + "'/>\n";
														templateHtml += "<td width='10%'> <input name='materialIndex'  value='' id='materialIndex" + materialCount + "'/></td>\n";
														templateHtml += "<td width='10%'><input type='hidden'  name='materialPrice'   value='' id='materialPrice" + materialCount + "'/>"+
														"<input type='text'  name='materialSubTotal'  value='' id='materialSubTotal" + materialCount + "' onChange='calculateMaterialIndexItem("+materialCount+")'/></td>\n";
														templateHtml += "<input type='hidden' name='productMaterialIndex'  value='' id='productMaterialIndex" + materialCount + "'/></td>\n";
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
												
														$("#materialInstance"+idx+"").hide()
														$("#materialDelete"+idx+"").val("true")

														calculatePrice();
													}
													function calculateMaterialPriceItem(idx) {
														var newPriceProductItem; 
														//if($("#productMaterialIndex"+idx).val()!="" && $("#productMaterialIndex"+idx).val()!=undefined )
															newPriceProductItem = parseFloat($("#materialUnit"+idx+"").val()) * parseFloat( $("#materialPrice"+idx+"").val()) ;
														//else
															
														$("#materialSubTotal"+idx+"").val(newPriceProductItem);
														calculatePrice();
														
													}
													function calculateMaterialIndexItem(idx) {
														var productItemIndex =parseFloat($("#materialSubTotal"+idx).val()) / parseFloat($("#materialUnit"+idx).val());
														var indexTemp = parseFloat($("#materialIndex"+idx).val());
														if(productItemIndex < indexTemp){
															
															$("#materialIndex"+idx).css({"background-color": oRed});

														}else{
														
															$("#materialIndex"+idx).css({"background-color": oBlue});
														}
														$("#productMaterialIndex"+idx).val(productItemIndex);
														calculatePrice();
														
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
				                                    <label for="productDetail"><g:message code="productDetail.accesories.unit.label" default="Unit" /></label>
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
			                            
                                    	<g:each in="${accesoriesList}" status="i" var="accesoriesInstance">
                                    	<tbody id="accesories${i}">
                                    				
		                    				<tr>
		                    					<td ><g:hiddenField class="accesoriesID" name="accesoriesID" id="accesoriesID${i}" value="${accesoriesInstance.material.id}"/>
		                    						<g:hiddenField class="accesoriesDelete" name="accesoriesDelete" id="accesoriesDelete${i}" value="false" />
		                    						<g:hiddenField class="productDetailAccesoriesInstance" name="productDetailAccesoriesInstance" id="productDetailAccesoriesInstance${i}" value="${accesoriesInstance.id}"/>
		                                    		<g:textField onFocus='setIdOfAccTextBox(${i})' class="accesoriesName" name="accesoriesName" id="accesoriesName${i}" value="${accesoriesInstance.material.name}" />
		                                		</td>
		                                		<td >
		                    						<g:textField class="accesoriesUnit" name="accesoriesUnit" onChange='calculateAccPrice(${i})'  id="accesoriesUnit${i}" value="${accesoriesInstance.unit}" />
		                                		</td>
		                                	
		                                		<td >
		                    						<g:textField class="accesoriesUnitType" name="accesoriesUnitType"   id="accesoriesUnitType${i}" value="${accesoriesInstance.material.unitType.name}" />
		                                		</td>
		                                		<td >
		                    						<g:textField class="accesoriesIndex" name="accesoriesIndex" id="accesoriesIndex${i}" value="${accesoriesInstance.idxx}" />
		                                		</td>
		                                		<td >
		                                			<g:textField class="accesoriesSubTotal" name="accesoriesSubTotal" id="accesoriesSubTotal${i}" onChange='calculateAccIndexItem(${i})' />
		                    						<g:hiddenField class="accesoriesPrice" name="accesoriesPrice" id="accesoriesPrice${i}" value="${accesoriesInstance.price}" />
		                                		</td>
		                                		<td >
		                                		
		                                    		<input type="button" class="ui-icon ui-icon-trash" value="Remove" onclick="removeAcc(${i })"/>
		                                    	
		                                    	</td>
		                                		
		                    				</tr>
										</tbody>
										<script type="text/javascript">
				                        		var subtotal = parseFloat(${accesoriesInstance.price})* parseFloat(${accesoriesInstance.unit});
				                        		 $("#accesoriesSubTotal${i}").val(subtotal);
				                        	</script>	
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
																	var url = "${createLink(url: [controller: 'material', action: 'getMaterialLikeNameAndMaterialCategoryIsAccAndMat'])}";
																	$.ajax({
																		url: url,
																		dataType: "json",
																		data: { name: request.term , materialTypeName: 'accesories',materialTypeName2: 'material'},
																		success: function( data ) {
																			
																			response( $.map( data, function( item ) {
																				materialId=item.id;
																				return {
																					label: item.name,
																					value: item.name,
																					id: item.id,
																					index:item.idxx,
																					price:item.price,
																				    unitType:item.unitType.id
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
																		data: { id: ui.item.unitType },
																		success: function( data ) {
																			 
																			 $("#accesoriesUnitType"+idOfAccTextBox).val( data['name'] );
																			 	
																		}
																	});
																	
															         $("#accesoriesIndex"+idOfAccTextBox).val(ui.item.index);
																	 $("#accesoriesPrice"+idOfAccTextBox).val(ui.item.price);
																	 $("#accesoriesID"+idOfAccTextBox).val(ui.item.id);
																	 $("#accesoriesUnit"+idOfAccTextBox).val(1);
																	 $("#accesoriesSubTotal"+idOfAccTextBox).val(ui.item.price * $("#accesoriesUnit"+idOfAccTextBox).val());
																	 
																	calculatePrice();
															  }
																							
															});
														});
													
														
													});
													function addAcc() {
														var htmlId = "accesories" + accesoriesCount;
														var templateHtml = "<tbody id='" + htmlId + "'>\n";
														templateHtml += "<tr>";
														templateHtml += "<input type='hidden' name='accesoriesID'  value='' id='accesoriesID" + accesoriesCount + "'/>\n";
														templateHtml += "<input type='hidden' class='accesoriesDelete' name='accesoriesDelete' id='accesoriesDelete" + accesoriesCount + "' value='false'/>\n";
														templateHtml += "<td width='50%'><input type='text' onFocus='setIdOfAccTextBox("+accesoriesCount+")' class='accesoriesName' name='accesoriesName' value='' id='accesoriesName" + accesoriesCount + "'/></td>\n";
														
														templateHtml += "<td width='10%'><input type='text' name='accesoriesUnit' onChange='calculateAccPrice("+accesoriesCount+")'  value='' id='accesoriesUnit" + accesoriesCount + "'/></td>\n";
														templateHtml += "<td width='10%'><input type='text' name='accesoriesUnitType' value='' id='accesoriesUnitType" + accesoriesCount + "'/></td>\n";
														templateHtml += "<td width='10%'><input type='text' name='accesoriesIndex' value='' id='accesoriesIndex" + accesoriesCount + "'/></td>\n";
														templateHtml += "<td width='10%'><input type='hidden'  name='accesoriesPrice'  value='' id='accesoriesPrice" + accesoriesCount + "'/>\n";
														templateHtml += "<input type='text'  name='accesoriesSubTotal' value='' onChange='calculateAccIndexItem("+ accesoriesCount +")' id='accesoriesSubTotal" + accesoriesCount + "'/></td>\n";
														templateHtml += "<input type='hidden' name='productAccesoriesIndex'  value='' id='productAccesoriesIndex" + accesoriesCount + "'/></td>\n";
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
														$("#accesories"+idx+"").hide()
														$("#accesoriesDelete"+idx+"").val("true")
														//$("#accesories"+idx+"").remove();
														calculatePrice();
													}
													function calculateAccPrice(idx) {
														var newPriceProductItem; 
														//if($("#productAccesoriesIndex"+idx).val()!="" && $("#productAccesoriesIndex"+idx).val()!=undefined )
															newPriceProductItem = parseFloat($("#accesoriesUnit"+idx+"").val()) * parseFloat( $("#accesoriesPrice"+idx+"").val()) ;
														//else
															
														$("#accesoriesSubTotal"+idx+"").val(newPriceProductItem);
														calculatePrice();
														
													}
													function calculateAccIndexItem(idx) {
														var productItemIndex =parseFloat($("#accesoriesSubTotal"+idx).val()) / parseFloat($("#accesoriesUnit"+idx).val());
														var indexTemp = parseFloat($("#accesoriesIndex"+idx).val());
														if(productItemIndex < indexTemp){
															
															$("#accesoriesIndex"+idx).css({"background-color": oRed});

														}else{
														
															$("#accesoriesIndex"+idx).css({"background-color": oBlue});
														}
														$("#productAccesoriesIndex"+idx).val(productItemIndex);
														calculatePrice();
														
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
				                                    <label for="productDetail"><g:message code="productDetail.miscellaneous.unitType.label" default="Unit" /></label>
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
                                    	<g:each in="${miscellaneousList}" status="i" var="miscellaneousInstance">
                                    	<tbody id="miscellaneous${i}">
                                    	 	
		                    				<tr>
		                    					<td ><g:hiddenField class="miscellaneousID" name="miscellaneousID" id="miscellaneousID${i}" value="${miscellaneousInstance.material.id}"/>
		                    						<g:hiddenField class="miscellaneousDelete" name="miscellaneousDelete" id="miscellaneousDelete${i}" value="false"/>
		                    						<g:hiddenField class="productDetailMiscellaneousInstance" name="productDetailMiscellaneousInstance" id="productDetailMiscellaneousInstance${i}" value="${miscellaneousInstance.id}"/>
		                                    		<g:textField onFocus='setIdOfMiscTextBox(${i})' class="miscellaneousName" name="miscellaneousName" id="miscellaneousName${i}" value="${miscellaneousInstance.material.name}" />
		                                		</td>
		                                		<td >
		                    						<g:textField class="miscellaneousUnit" name="miscellaneousUnit"  onChange='calculateMiscPrice(${i})'  id="miscellaneousUnit${i}" value="${miscellaneousInstance.unit}" />
		                                		</td>
		                                		<td >
		                    						<g:textField class="miscellaneousUnitType" name="miscellaneousUnitType"   id="miscellaneousUnitType${i}" value="${miscellaneousInstance.material.unitType}" />
		                                		</td>
		                                		<td >
		                    						<g:textField class="miscellaneousIndex" name="miscellaneousIndex" id="miscellaneousIndex${i}" value="${miscellaneousInstance.idxx}" />
		                                		</td>
		                                		<td >
		                                			<g:textField class="miscellaneousSubTotal" name="miscellaneousSubTotal" id="miscellaneousSubTotal${i}" onChange='calculateMiscIndexItem(${i})' />
		                    						
		                    						<g:hiddenField class="miscellaneousPrice" name="miscellaneousPrice" id="miscellaneousPrice${i}" value="${miscellaneousInstance.price}" />
		                                		</td>
		                                		<td >
		                                		
		                                    		<input type="button" class="ui-icon ui-icon-trash" value="Remove" onclick="removeMisc(${i })"/>
		                                    	
		                                    	</td>
		                                		
		                    				</tr>
										</tbody>
											<script type="text/javascript">
				                        		var subtotal = parseFloat(${miscellaneousInstance.price})* parseFloat(${miscellaneousInstance.unit});
				                        		 $("#miscellaneousSubTotal${i}").val(subtotal);
				                        	</script>	
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
																	var url = "${createLink(url: [controller: 'material', action: 'getMaterialLikeNameAndMaterialCategoryIs'])}";
																	$.ajax({
																		url: url,
																		dataType: "json",
																		data: { name: request.term , materialTypeName: 'miscellaneous'},
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
																			 
																			 $("#miscellaneousUnitType"+idOfMiscTextBox).val( data['name'] );
																			 	
																		}
																	});
																	
															         $("#miscellaneousIndex"+idOfMiscTextBox).val(ui.item.index);
															         $("#miscellaneousUnit"+idOfMiscTextBox).val(1);
																	 $("#miscellaneousSubTotal"+idOfMiscTextBox).val(ui.item.price);
																	 $("#miscellaneousPrice"+idOfMiscTextBox).val(ui.item.price);
																	 $("#miscellaneousID"+idOfMiscTextBox).val(ui.item.id);
																	 $("#miscellaneousSubTotal"+idOfMiscTextBox).val(ui.item.price * $("#miscellaneousUnit"+idOfMiscTextBox).val());
																	 calculatePrice();
															  }
																							
															});
														});
													
													
													});
										
													
										
													function addMisc() {
														var htmlId = "miscellaneous" + miscellaneousCount;
														var templateHtml = "<tbody id='" + htmlId + "'>\n";
														templateHtml += "<tr>";
														templateHtml += "<input type='hidden' name='miscellaneousID'  value='' id='miscellaneousID" + miscellaneousCount + "'/></td>\n";
														templateHtml += "<td width='50%'><input type='text' onFocus='setIdOfMiscTextBox("+miscellaneousCount+")' class='miscellaneousName' name='miscellaneousName' value='' id='miscellaneousName" + miscellaneousCount + "'/></td>\n";
														templateHtml += "<input type='hidden' class='miscellaneousDelete' name='miscellaneousDelete' id='miscellaneousDelete" + miscellaneousCount + "' value='false'/>\n";
														templateHtml += "<td width='10%'><input type='text' name='miscellaneousUnit'  onChange='calculateMiscPrice("+miscellaneousCount+")' value='' id='miscellaneousUnit" + miscellaneousCount + "'/></td>\n";
														templateHtml += "<td width='10%'><input type='text' name='miscellaneousUnitType'  value='' id='miscellaneousUnitType" + miscellaneousCount + "'/></td>\n";
														templateHtml += "<td width='10%'><input type='text' name='miscellaneousIndex'  value='' id='miscellaneousIndex" + miscellaneousCount + "'/></td>\n";
														templateHtml += "<td width='10%'><input type='hidden'  name='miscellaneousPrice' value='' id='miscellaneousPrice" + miscellaneousCount + "'/>";
														templateHtml += "<input type='text'  name='miscellaneousSubTotal' value='' onChange='calculateMiscIndexItem("+ miscellaneousCount +")' id='miscellaneousSubTotal" + miscellaneousCount + "'/></td>\n";
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
														$("#miscellaneous"+idx+"").hide()
														$("#miscellaneousDelete"+idx+"").val("true")
														
														calculatePrice();
													}
													function calculateMiscPrice(idx) {
														var newMiscPriceProductItem = parseFloat($("#miscellaneousUnit"+idx+"").val()) * parseFloat( $("#miscellaneousPrice"+idx+"").val()) ;
													
														
														$("#miscellaneousSubTotal"+idx+"").val(newMiscPriceProductItem);
														
														calculatePrice();
														
													}
													function calculateMiscIndexItem(idx) {
														var productItemIndex =parseFloat($("#miscellaneousSubTotal"+idx).val()) / parseFloat($("#miscellaneousUnit"+idx).val());
														var indexTemp = parseFloat($("#miscellaneousIndex"+idx).val());
														if(productItemIndex < indexTemp){
															
															$("#miscellaneousIndex"+idx).css({"background-color": oRed});

														}else{
														
															$("#miscellaneousIndex"+idx).css({"background-color": oBlue});
														}
														$("#productMiscellaneousIndex"+idx).val(productItemIndex);
														calculatePrice();
														
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
                                  <label for="createdBy"><g:message code="product.createdBy.label" default="Created By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'createdBy', 'errors')}">
                                    <g:textField name="createdBy" maxlength="50" value="${productInstance?.createdBy}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="updatedBy"><g:message code="product.updatedBy.label" default="Updated By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'updatedBy', 'errors')}">
                                    <g:textField name="updatedBy" maxlength="50" value="${productInstance?.updatedBy}" />
                                </td>
                            </tr>
                        	<tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="product.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" cols="40" rows="5" value="${productInstance?.description}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="deleteFlag"><g:message code="product.deleteFlag.label" default="Delete Flag" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: productInstance, field: 'deleteFlag', 'errors')}">
                                    <g:textField name="deleteFlag" value="${productInstance?.deleteFlag}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
               <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
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
			var kurs=0 ;
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
					  $("#modelCategoryCode").val(data['code']);
					  $("#width").val(modelTemp['width']);
					  $("#length").val(modelTemp['length']);
					  $("#estLoad").val(modelTemp['estLoad']);
					  $("#height").val(modelTemp['height']);
					  $("#seatHeight").val(modelTemp['seatHeight']);
					  $("#seatLength").val(modelTemp['seatLength']);
					  $("#seatWidth").val(modelTemp['seatWidth']);
					  $("#packingHeight").val(modelTemp['packingHeight']);
					  $("#packingLength").val(modelTemp['packingLength']);
					  $("#packingWidth").val(modelTemp['packingWidth']);
					  $("#cbm").val(modelTemp['cbm']);
					  
					 calculateTotalCubic();
					 
	                }
	              
				});
			}
			function calculateTotalCubic() {
				var totalCubicTemp = parseFloat($("#width").val() ) * parseFloat($("#height").val()) * parseFloat($("#length").val()) / 1000000000;
				$("#totalCubic").val(parseFloat(totalCubicTemp));	
				calculateIndex();
			}
			function calculateIndex() {
				var indexModal = parseFloat($("#baseCost").val()) / parseFloat($("#totalWeight").val());
				
				var url = "${createLink(url: [controller: 'kurs', action: 'getKursUSD'])}";
				$.ajax({
					url: url,
					type:"POST",
				    dataType: "json",
					data: { id:1},
					success: function( data ) {
					  //$("#indexUSD").val(data[0]['kursValue']);
					  kurs=data[0]['kursValue'];
				    }
	              
				});
				
				
				$("#idxx").val(indexModal);
				var indexModalKurs = parseFloat(indexModal) / parseFloat(kurs);
			
				$("#indexUSD").val(indexModalKurs);
				//alert(""+indexModalKurs);		
			}
			function calculatePrice() {
				var priceTemp = 0;
				if(materialCount!=null && materialCount!="" && materialCount!=0){
					
				
					for(i=0;i<materialCount;i++){
							if($("#materialSubTotal"+i).val()!=null && $("#materialSubTotal"+i).val()!="" && $("#materialSubTotal"+i).val()!=undefined &&  $("#materialDelete"+i).val()== 'false' ){
								
								priceTemp = parseFloat($("#materialSubTotal"+i).val())+ parseFloat(priceTemp);			
								
							}
							
					}
					
					
				}
				//alert(accesoriesCount);
				if(accesoriesCount!=null && accesoriesCount!="" && accesoriesCount!=0){
					
					for(i=0;i<accesoriesCount;i++){
							if($("#accesoriesSubTotal"+i).val()!=null && $("#accesoriesSubTotal"+i).val()!="" && $("#accesoriesSubTotal"+i).val()!=undefined &&  $("#accesoriesDelete"+i).val()== 'false'){
								
								priceTemp = parseFloat($("#accesoriesSubTotal"+i).val())+ parseFloat(priceTemp);			
								
							}
							
					}
					
					
				}
				if(miscellaneousCount!=null && miscellaneousCount!="" && miscellaneousCount!=0){
					
					for(i=0;i<miscellaneousCount;i++){
							if($("#miscellaneousSubTotal"+i).val()!=null && $("#miscellaneousSubTotal"+i).val()!="" && $("#miscellaneousSubTotal"+i).val()!=undefined &&  $("#miscellaneousDelete"+i).val()== 'false'){
								
								priceTemp = parseFloat($("#miscellaneousSubTotal"+i).val())+ parseFloat(priceTemp);			
								
							}
							
					}
					
					
				}
				$("#baseCost").val(parseFloat(priceTemp));	
				
				$("#price").val( parseFloat($("#baseCost").val()) * 1.65 );
				calculateIndex();
				calculateIndexPricing();
			}
									
			function calculateIndexPricing() {
				var indexPricing = parseFloat($("#baseCost").val()) * 1.65 / parseFloat($("#totalWeight").val());
				$("#indexPricing").val(indexPricing);
				var indexPricingKurs = parseFloat(indexPricing) / parseFloat(kurs);
			
				$("#indexPricingUSD").val(indexPricingKurs);
				//alert(""+indexPricingKurs);
			}
			
		</script>
    </body>
</html>
 				