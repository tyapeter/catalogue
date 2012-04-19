<head>
<meta name='layout' content='main' />
<title>Login</title>
<style type='text/css' media='screen'>
#login {
	margin:15px 0px; padding:0px;
	text-align:center;
}
#login .inner {
	width:260px;
	margin:0px auto;
	text-align:left;
	padding:10px;
	border-top:1px dashed #499ede;
	border-bottom:1px dashed #499ede;
	background-color:#EEF;
}
#login .inner .fheader {
	padding:4px;margin:3px 0px 3px 0;color:#2e3741;font-size:14px;font-weight:bold;
}
#login .inner .cssform p {
	clear: left;
	margin: 0;
	padding: 5px 0 8px 0;
	padding-left: 105px;
	border-top: 1px dashed gray;
	margin-bottom: 10px;
	height: 1%;
}
#login .inner .cssform input[type='text'] {
	width: 120px;
}
#login .inner .cssform label {
	font-weight: bold;
	float: left;
	margin-left: -105px;
	width: 100px;
}
#login .inner .login_message {color:red;}
#login .inner .text_ {width:120px;}
#login .inner .chk {height:12px;}
</style>
</head>

<body>
	<div id='login'>
		<div class='inner'>
			<g:if test='${flash.message}'>
			<div class='login_message'>${flash.message}</div>
			</g:if>
			<div class='fheader'>Please Login..</div>
                <table>
			%{--<form action='${postUrl}' method='POST' id='loginForm' class='cssform' autocomplete='off'>--}%
				%{--<p>--}%
                <tr>
                    <td>
					<label for='username'>Login ID</label></td>
					<td><input type='text' class='text_' name='j_username' id='username' /></td>
                </tr>
				%{--</p>--}%
				%{--<p>--}%
            <tr>
                <td><label for='password'>Password</label></td>
				<td><input type='password' class='text_' name='j_password' id='password' /></td>
             </tr>
				%{--</p>--}%
				%{--<p>--}%
                    <tr>
					    <td><label for='remember_me'>Remember me</label></td>
					    <td><input type='checkbox' class='chk' name='${rememberMeParameter}' id='remember_me'
					<g:if test='${hasCookie}'>checked='checked'</g:if> /></td>
                    </tr>
				%{--</p>--}%
				%{--<p>--}%
                    <tr>
					    <td colspan=2><input type='submit' id="loginButton" value='Login' /></td>
                    </tr>
				%{--</p>--}%
			%{--</form>--}%
                </table>
		</div>
	</div>
<script type='text/javascript'>
<!--
//(function(){
//	document.forms['loginForm'].elements['j_username'].focus();
//})();
// -->
    $('#loginButton').click(function(){
        %{--var url = "${createLink(url: [controller: 'login', action: 'auth'])}";--}%
        var url= '${request.contextPath}/j_spring_security_check'
        $.ajax({
            url: url,
            type: "post",
            dataType: "json",
            callback: "myCallback",
            cache:false,
            data: {  j_username: $('#username').val(), j_password:  $('#password').val()},
            success: function( data ) {
//                1. ROLE_USER,2 ROLE_CUSTOMER,3 ROLE_STAFF,4 ROLE_MANAGEMENT, 5 ROLE_ADMIN
                if(data.success == true ){

                   if(data.role=='ROLE_MANAGEMENT' || data.role=='ROLE_ADMIN')
                        window.location="/catalogue/backOffice";
                    else
                        window.location="/catalogue/";

                }
//                response( $.map( data, function( item ) {
////                    materialId=item.id;
//                    return {
//
//                    }
//                }));
            }
        });

    });
</script>
</body>
