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
<link href="css/2.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="login.js"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>

<%-- <%
  String encode=loginServlet.validationCode;
  System.out.println(encode+"yh");
%> --%>


</head>
<body>
<div class="enterBg">
	<div class="enterBox">
		<div class="enterHeader clearFix"></div>
		<div class="enterContent">
			<h3>
			<span class="login_title">登录</span>
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