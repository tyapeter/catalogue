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
      
    </head>
    <body>
	<style type="text/css">
		div#menu {
		    top:65px;
		    width:700px;
		    margin: 0 auto;
		}
		div#copyright { display: none; }
		
	#signInLogin .inner {
		width:250px;
		text-align:left;
		padding:2px;
		border-top:1px solid gray;
		border-bottom:1px solid gray;
		background-color:#fff;
	}
	#signInLogin .inner .fheader {
		padding:2px;margin:2px 0px 2px 0;color:#2e3741;font-size:12px;font-weight:bold;
	}
	#signInLogin .inner .cssform p {
		clear: left;
		margin: 0;
		padding: 1px 0 1px 0;
		padding-left: 105px;
		border-top: 1px solid gray;
		margin-bottom: 5px;
		height: 1%;
	}
	#signInLogin .inner .cssform input[type='text'] {
		width: 120px;
	}
	#signInLogin .inner .cssform label {
		font-weight: bold;
		float: left;
		margin-left: -105px;
		width: 100px;
	}
	#signInLogin .inner .login_message {color:red;}
	#signInLogin .inner .text_ {width:120px;}
	#signInLogin .inner .chk {height:12px;}
	</style>

        <div id="spinner" class="spinner" style="display:none;">
            <img src="${resource(dir:'images',file:'spinner.gif')}" alt="${message(code:'spinner.alt',default:'Loading...')}" />
        </div>
	<div class='signIn '>
		<a href="#"><span>Sign Up</span></a> &nbsp;&nbsp;<a href="#" id="signIn" ><span>Sign In</span></a>
	</div>
	
	<div id="menu">
		<ul class="menu">
			<li><a href="/catalogue/" class="parent"><span>Home</span></a>
				
			</li>
			<li  ><a href="#" id="materialsMenu" class="parent" name="materialsMenu"><span>Materials</span></a>
			</li>
			<li ><a href="#"><span>About Us</span></a></li>
			<li class="last">
			 
			</li>
		</ul>
		
	</div>
		<div id="searchwrapper">
				<g:form url="[action:'listSearch',controller:'product']" >
					<g:textField type="text" name="test" id="test" class="searchbox" />
					<input type="image" src="${resource(dir:'images',file:'searchBox/searchBoxBlankImage.jpg')}" class="searchbox_submit" value="" />
				</g:form>
			</div>
        <div id="grailsLogo"><a href="http://grails.org"><img src="${resource(dir:'images',file:'grails_logo.png')}" alt="Grails" border="0" /></a></div>
        <g:layoutBody />
	<div id="copyright">Copyright &copy; 2011 <a href="http://apycom.com/">Apycom jQuery Menus</a></div>
	<div id='signInLogin'>
		<div class='inner'>
			<g:if test='${flash.message}'>
			<div class='login_message'>${flash.message}</div>
			</g:if>
			<div class='fheader'>Sign In</div>
			<form url="[action:'auth',controller:'login']"  id='loginForm' class='cssform' autocomplete='off'>
				<p>
					<label for='username'>Login ID</label>
					<input type='text' class='text_' name='j_username' id='username' />
				</p>
				<p>
					<label for='password'>Password</label>
					<input type='password' class='text_' name='j_password' id='password' />
				</p>
				<p>
					<label for='remember_me'>Remember me</label>
					<input type='checkbox' class='chk' name='${rememberMeParameter}' id='remember_me'
					<g:if test='${hasCookie}'>checked='checked'</g:if> />
				</p>
				<p>
					<input type='submit' value='Login' />
				</p>
			</form>
		</div>
	</div>
	<script type="text/javascript">
			var markSign = 0;
			$('#signInLogin').hide();
       		$('#materialsMenu')
               .hover(function() {
               	var url = "${createLink(url: [controller: 'materialMain', action: 'getMaterialMenu'])}";
              	modelArrayTemp = new Array();
				$.ajax({
					url: url,
					type:"POST",
				    dataType: "json",
					data: { name:"%%" },
					success: function( data ) {
					
		 			  var i = 0;
	                  var x;
	                  var options = "";
	                  var materialCategoryMenu = data[0];
	                  var modelMenu= data[1];
	                  var materialMenuSize=data[2]
	                  var modelId ;
	                  var materialId;
	                  
					  options += "<div><ul>";
	                  while( materialCategoryMenu[i] != null ){
	                  	 materialCategoryName= materialCategoryMenu[i]['name'];
						 options += "<li><a href='#' class='parent'><span>"+ materialCategoryMenu[i]['name'] +"</span></a>";
						 if(modelMenu[i][0]!=null){
						  options += "<div><ul>";
						 }
						 x=0;
						 while(modelMenu[i][x]!=null){
						 	 modelId=modelMenu[i][x]['id'];
						 	 modelName=modelMenu[i][x]['name'];
						 	 materialId= materialCategoryMenu[i]['id'];
						 	 options += "<li><a href='/catalogue/productDetail/listFront?modelId="+modelId+"&materialCategoryId="+materialId+"&materialCategoryName="+materialCategoryName+"&modelName="+modelName+"'  ><span>"+ modelMenu[i][x]['name'] +"</span></a>";
						 	x++;
						 }
						 if(modelMenu[i][0]!=null){
						  options += "</ul></div>";
						 }
						 options +="</li>";	
						
						i++;
						
	                 }
	                  options += "</ul></div>";
	                  $("#materialsMenu").append(options); 
	              
	 				
					}
				});
           	});	
         	$('.signIn')
         		.click(function() {
               	if(markSign==0){
               		$('#signInLogin').show();
               		markSign=1;
               	}else
               	if(markSign==1){
               		$('#signInLogin').hide();
               		markSign=0;
               	}
				
           	});	
		</script>
    </body>
</html>

