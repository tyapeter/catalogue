
<%@ page import="com.teravin.catalogue.Product" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
       	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"> 
        
       
		<link rel="stylesheet" type="text/css" href="${resource(dir:'css/slider',file:'style.css')}" />
		<link rel="stylesheet" type="text/css" href="${resource(dir:'css/slider',file:'elastislide.css')}" />
        
        <g:set var="entityName" value="${message(code: 'product.label', default: 'Product')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <noscript>
			<style>
				.es-carousel ul{
					display:block;
				}
			</style>
		</noscript>
        <script id="img-wrapper-tmpl" type="text/x-jquery-tmpl">	
			<div class="rg-image-wrapper">
				{{if itemsCount > 1}}
					<div class="rg-image-nav">
						<a href="#" class="rg-image-nav-prev">Previous Image</a>
						<a href="#" class="rg-image-nav-next">Next Image</a>
					</div>
				{{/if}}
				<div class="rg-image"></div>
				<div class="rg-loading"></div>
				<div class="rg-caption-wrapper">
					<div class="rg-caption" style="display:none;">
						<p></p>
						<p2></p2>
					</div>
				</div>
			</div>
		</script>
        
    </head>
    <body>
       <script type="text/javascript" src="${resource(dir:'js/slider',file:'jquery-1.71.min.js')}"></script>
		<script type="text/javascript" src="${resource(dir:'js/slider',file:'jquery.tmpl.min.js')}"></script>
		<script type="text/javascript" src="${resource(dir:'js/slider',file:'jquery.easing.1.3.js')}"></script>
		<script type="text/javascript" src="${resource(dir:'js/slider',file:'jquery.elastislide.js')}"></script>
		<script type="text/javascript" src="${resource(dir:'js/slider',file:'gallery.js')}"> </script >
		
        <div class="body">
          
           
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div  class="information"> ${materialCategoryName} | ${modelName}  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp Sort by <g:link controller="productDetail" action="listFront" params="${[modelId:modelId,materialCategoryId:materialCategoryId,modelName:modelName,materialCategoryName:materialCategoryName,sort:'dateCreated',order:'desc']}" >Newest Collection </g:link> | <g:link controller="productDetail" action="listFront" params="${[modelId:modelId,materialCategoryId:materialCategoryId,modelName:modelName,materialCategoryName:materialCategoryName,sort:'pd.product.code',order:'asc']}" >Article No</g:link></div>
            
            <div class="container">
			
				<div class="content">
				
					<div id="rg-gallery" class="rg-gallery">
						<div class="rg-thumbs">
							<!-- Elastislide Carousel Thumbnail Viewer -->
							<div class="es-carousel-wrapper">
								<div class="es-nav">
									<span class="es-nav-prev">Previous</span>
									<span class="es-nav-next">Next</span>
								</div>
								<div class="es-carousel">
									<ul>
									 <g:each in="${productInstanceList}" status="i" var="productInstance">
								
										<li><a href="#"  >		
										<g:if test="${productInstance.imagePathFront!=null}" || test="${productInstance.imagePathFront!=''}" >
	                    		 			 <img  " src="/catalogue/images/${productInstance.code}.jpg" data-large="/catalogue/images/${productInstance.code}.jpg" alt="image${productInstance.id}" data-description1="${fieldValue(bean: productInstance, field: "code")} - ${fieldValue(bean: productInstance, field: "name")}, Material : ${productInstance.materialMain.name}" data-description2=" &nbsp; W: ${productInstance.width}  &nbsp; L: ${productInstance.length}  &nbsp; H: ${productInstance.height}" />
	                        			</g:if>
	                        			<g:else>
	                        				<img  " src="/catalogue/images/${productInstance.model.id}.jpg" data-large="/catalogue/images/${productInstance.model.id}.jpg" alt="image${productInstance.id}" data-description1="${fieldValue(bean: productInstance, field: "code")} - ${fieldValue(bean: productInstance, field: "name")}, Material : ${productInstance.materialMain.name}" data-description2=" &nbsp; W: ${productInstance.width}  &nbsp; L: ${productInstance.length}  &nbsp; H: ${productInstance.height}" />
	                        			</g:else>
	                        			</a>
	                        			</li>
																			
									</g:each>
									</ul>
									
								</div>
							</div>
							<!-- End Elastislide Carousel Thumbnail Viewer -->
						</div><!-- rg-thumbs -->
					</div><!-- rg-gallery -->
				</div><!-- content -->
		</div><!-- container -->
           
            <div >
                <table class='tableProduct'>
                   
                    <tbody>
                    <g:each in="${productInstanceList}" status="i" var="productInstance">
                    <g:if test="${i % 4 == 0}">
                        <tr >
                        	<td  width=200 >
                        	<table class='tableProduct'>
                        			<tr>
                        				<td align='center' class='product' >
                        				<g:if test="${productInstance.imagePathFront!=null}" >
	                    		 			<a href="#" onClick=setClassImageId(${i})><img  width =180 height=180 src="/catalogue/images/${productInstance.code}.jpg" /></a>
	                        			</g:if>
	                        			<g:else>
	                        				<a href="#"  onClick=setClassImageId(${i})><img  width =180 height=180 src="/catalogue/images/${productInstance.model.id}.jpg" /></a>
	                        			</g:else>
                        					
                        				</td>
                        			</tr>
                        			<tr>
                        				<td align='center' class='product'>
                        					${fieldValue(bean: productInstance, field: "code")} - ${fieldValue(bean: productInstance, field: "name")}
                        				</td>
                        			</tr>
                        			<tr>
                        				<td  class='product'>
                        					Material : ${productInstance.materialMain.name}
                        				</td>
                        			</tr>
                        			<tr>
                        				<td  class='product'>
                        					W: ${productInstance.width} L: ${productInstance.length} H: ${productInstance.height}
                        				</td>
                        			</tr>
                        	</table>
                        	</td>
                    	
                        </g:if>
                        <g:else>
                        	
                        	<td  width=200 align=center >
                        	<table align=center class='tableProduct' >
                        			<tr>
                        				<td  class='product'>
                        					<g:if test="${productInstance.imagePathFront!=null}" >
	                    		 				<a href="#" onClick=setClassImageId(${i})><img  width =180 height=180 src="/catalogue/images/${productInstance.code}.jpg" /></a>
	                        				</g:if>
	                        				<g:else>
	                        					<a href="#"  onClick=setClassImageId(${i})><img  width =180 height=180 src="/catalogue/images/${productInstance.model.id}.jpg" /></a>
	                        				</g:else>	
                        				</td>
                        			</tr>
                        			<tr>
                        				<td  class='product'>
                        					${fieldValue(bean: productInstance, field: "code")} - ${fieldValue(bean: productInstance, field: "name")}
                        				</td>
                        			</tr>
                        			<tr>
                        				<td  class='product'>
                        					Material : ${productInstance.materialMain.name}
                        				</td>
                        			</tr>
                        			<tr>
                        				<td  class='product'>
                        					W: ${productInstance.width} L: ${productInstance.length} H: ${productInstance.height}
                        				</td>
                        			</tr>
                        	</table>
                        	</td>
                        </g:else>
                        <g:if test="${i % 3 == 0 && i!=0 && i!=6}">
                        	</tr>
                        </g:if>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${productInstanceTotal}" params="${[modelId:modelId,materialCategoryId:materialCategoryId,modelName:modelName,materialCategoryName:materialCategoryName]}"  />
            </div>
        </div>
        
         <script type="text/javascript">
         	var imageId;
         
         	$rgGallery			= $('#rg-gallery');
	
			$esCarousel			= $rgGallery.find('div.es-carousel-wrapper');
			
			$items				= $esCarousel.find('ul > li');
			
			mode 				= 'carousel';
						
			current 			= imageId;
         	function setClassImageId(id) {
         			imageId=id;
         			var $item	= $items.eq(imageId);
         			var $loader	= $rgGallery.find('div.rg-loading').show();
					
					$items.removeClass('selected');
					$item.addClass('selected');
					 
					var $thumb		= $item.find('img'),
					largesrc		= $thumb.data('large'),
					title			= $thumb.data('description1');
					title2        	= $thumb.data('description2');

				
					$('<img/>').load( function() {
					
					$rgGallery.find('div.rg-image').empty().append('<img src="' + largesrc + '"/>');
					
					if( title )
						$rgGallery.find('div.rg-caption').show().children('p').empty().text( title );
					
					if( title2 )
						$rgGallery.find('div.rg-caption').show().children('p2').empty().text( title2 );

					$loader.hide();
					
					current	= $item.index();
					
					if( mode === 'carousel' ) {
						$esCarousel.elastislide( 'reload' );
						$esCarousel.elastislide( 'setCurrent', current );
					}
				
					anim	= false;
					
				}).attr( 'src', largesrc );
         	}
         	
    		
    		
    		</script>
    </body>
    	
    
</html>
