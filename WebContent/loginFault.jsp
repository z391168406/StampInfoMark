<%@ page language="java" contentType="text/html; charset=utf-8" import="version1.servlet.*"
    pageEncoding="utf-8"%>
    
<%    
String path = request.getContextPath();    
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";    
pageContext.setAttribute("basePath",basePath);    
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>login</title>
<link href="css/1.css" rel="stylesheet" type="text/css" />
<link href="css/3.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="login.js"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script type="text/javascript" src="js/md5andbase64.js"></script>
<script type="text/javascript" src="js/base64.js"></script>
<%-- <%
  String encode=loginServlet.validationCode;
  System.out.println(encode+"yh");
%> --%>
<script type="text/javascript" >
function refreshCode(imgObj) {
	if (!imgObj) {
		imgObj = document.getElementById("validationCode");
	}
	var index = imgObj.src.indexOf("?");
	if(index != -1) {
		var url = imgObj.src.substring(0,index + 1);
		imgObj.src = url + Math.random();
	} else {
		imgObj.src = imgObj.src + "?" + Math.random();
	}
}

function login(f){
	
	/* var email_in=document.getElementById("username").value;
	var pw_in=document.getElementById("password").value;
	var code_in=document.getElementById("testCode").value; */
	/* var pw=hex_md5("test");
	var pw_4=encode64(pw);
	alert(pw_4); */
	//alert(pw1);
	
	

    return false;
	
	
	
}
	
</script>



</head>
<body>
<div class="enterBg">
	<div class="enterBox">
		<div class="enterHeader clearFix"></div>
		<div class="enterContent">
			<h3>
			<span class="login_title">登录</span><div class="login_title" style id="msg">您填写的用户名或密码错误</div>
			</h3>
			<div class="enterMain clearFix">
				<form method="post" id="myform" action="loginClServlet">
				<!-- <form onsubmit="return login(this)"> -->
					
					<div class="main_left" data='enter'>
						
						 <ul class="infoBox">
						 	<li>
						 		<em>账号：</em>
						 		<label for="username"><input type="text" id="username" autocomplete="off" 
						 		       name="email" placeholder="邮箱" value="" />@software.nju.edu.cn</label>
						 	</li>
						 	<li>
						 		<em>密码：</em>
						 		<label for="password">
						 		<input type="password" id="password" autocomplete="off"
                                                             name="password"/>
						 		</label>
						 	</li>
						 	<%-- <li>
						 		<em>验证码：</em>
						 		<label for="testCode">
						 		<input type="text" id="testCode" autocomplete="off"
                                                                 name="identifyingCode" class="testCode"/>
						 		</label>
						 		<img id="validationCode" alt="验证码图片" title="验证码图片" src="<%=path %>/loginServlet" onclick="refreshCode(this)" />
						 		<a id="aRecode" href="javascript:void(0);" onclick="refreshCode()">换一张</a>
						 	</li> --%>
				
						 </ul>
						 
                         <div class="proBox">
                            <input  type="submit" value="登录"  style="width:50px;height:25px" />
                         </div>
					
					
					</div>
				
				<!-- </form> -->
				</form>
			</div>
		</div>
	</div>

</div>
</body>
</html>