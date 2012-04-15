<html>
    <head>
        <title><g:layoutTitle default="Catalogue" /></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        <link rel="stylesheet" href="${resource(dir:'css/ui-lightness',file:'jquery-ui-1.8.14.custom.css')}" />
     	<link type="text/css" href="${resource(dir:'css/menu',file:'menu.css')}" rel="stylesheet" />
		<script type="text/javascript" src="${resource(dir:'css/menu',file:'jquery.js')}"></script>
		<script type="text/javascript" src="${resource(dir:'css/menu',file:'menu.js')}"></script>
        <script type="text/javascript" language="javascript" src="${resource(dir:'js',file:'jquery-1.5.1.min.js')}"></script>
        <script type="text/javascript" language="javascript" src="${resource(dir:'js',file:'jquery-ui-1.8.14.custom.min.js')}"></script>
        <g:layoutHead />
        <g:javascript library="application" />
        <style type="text/css">
		div#menu {
		    top:65px;
		    width:700px;
		    margin: 0 auto;
		}
		div#copyright { display: none; }
	</style> 
    </head>
    <body>
		  

        <div id="spinner" class="spinner" style="display:none;">
            <img src="${resource(dir:'images',file:'spinner.gif')}" alt="${message(code:'spinner.alt',default:'Loading...')}" />
        </div>
       
		<div id="menu">
			<ul class="menu">
				<li><g:link action="list" controller="productDetail"><span>PRODUCT         </span></g:link>	</li>
				<li><a href="#" CLASS="parent"><span>MODEL</span></a>
					<div><ul>
							<li><g:link action="list" controller="model"><span>MODEL         </span></g:link></li>
							<li><g:link action="list" controller="modelCategory"><span>MODEL CATEGORY</span></g:link></li>
					</ul></div>
				</li>
				<li  ><a href="#"  class="parent"><span>MAINTENANCE</span></a>
					<div><ul>
						<li><g:link action="list" controller="user"><span>USER  &nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;  &nbsp;  </span></g:link></li>
						<li><g:link action="list" controller="color"><span>COLOR  &nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;  &nbsp;  </span></g:link></li>
						<li><g:link action="list" controller="unitType"><span>UNIT TYPE</span></g:link></li>
						<li><g:link action="list" controller="kurs"><span>KURS</span></g:link></li>
						<li><a href="#" CLASS="parent"><span>MATERIAL</span></a>
							<div><ul>
									<li><g:link action="list" controller="material"><span>MATERIAL         </span></g:link></li>
									<li><g:link action="list" controller="materialCategory"><span>MATERIAL CATEGORY</span></g:link></li>
									<li><g:link action="list" controller="materialMain"><span>MATERIAL MAIN</span></g:link></li>
								%{--	<li><g:link action="list" controller="materialType"><span>MATERIAL TYPE    </span></g:link></li> --}%
							</ul></div>
						</li>
					</ul></div >
				</li>
				
				
				
				
			</ul>
	</div>

        <div id="grailsLogo"><a href="http://grails.org"><img src="${resource(dir:'images',file:'grails_logo.png')}" alt="Grails" border="0" /></a></div>
        
	  	<g:layoutBody />
		<div id="copyright">Copyright &copy; 2011 <a href="http://apycom.com/">Apycom jQuery Menus</a></div>
       
		
    </body>
</html>
