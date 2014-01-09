<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="java.util.*" %>
<%@ page import="version1.model.*" %>
<%    
String path = request.getContextPath();    
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";    
pageContext.setAttribute("basePath",basePath); 
%>
<%
//取出要显示的信息
GroupsBean gb=new GroupsBean();
gb=(GroupsBean)request.getAttribute("goodInfo");
int taskId=Integer.parseInt(request.getAttribute("taskId").toString());
String taskNowId=request.getAttribute("taskNowId").toString();
String taskFinishId=request.getAttribute("taskFinishId").toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
    <title>信息标注工具</title>
    <link href="bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="bootstrap/css/bootstrap-theme.css" rel="stylesheet">
    <script src="bootstrap/js/jquery-1.10.2.min.js"></script>
    <script src="bootstrap/js/bootstrap.js"></script>
    <script src="js/myFunction.js"></script>
    <style type="text/css">
      body {
        padding-top: 60px;
        padding-bottom: 40px;
      }
      .header_container{
        border-bottom: 1px dashed #6FAF44;
        margin-bottom: 30px;
        padding-bottom: 20px;
        text-align: center;
      }
      .submit-button{
        margin-left: auto;
        margin-right: auto;
        text-align: center;
      }
    </style>
  </head>
<%
	String username=null;
	Cookie[] cookies = request.getCookies();
	if(cookies!=null){
		String name=null;
		for(int i=0;i<cookies.length;i++){
			Cookie c=cookies[i];
			if(c.getName().equalsIgnoreCase("email")){
				username=c.getValue();
			}
		}	
	}else{
		response.sendRedirect("login.jsp");
	}
	String[] user=username.split("@");
%>
  <body>
    <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <a class="navbar-brand" href="#"><span class="glyphicon glyphicon-home"></span>&nbsp;信息修改任务发布平台</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li>
              <a><i><u>欢迎您！<%=user[0]%></u></i></a>
            </li>
            <li>
              <a href="user.jsp"><i><u>退出任务</u></i></a>
            </li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>

    <div class="container">
		<h2 class="text-center">信息标注工具</h2>
		<hr>
		<div class="row">
			<form class="form-horizontal" role="form">
			  <div class="form-group">
			    <label class="col-sm-1 control-label">GroupId：</label>
			    <div class="col-sm-2">
			      <p class="form-control-static"><%=gb.getGroupId() %></p>
			    </div>
			    <label class="col-sm-2 control-label">GroupCountry：</label>
			    <div class="col-sm-1">
			      <p class="form-control-static"><%=gb.getGroupCountry() %></p>
			    </div>
			    <label class="col-sm-2 control-label">GroupStampNum：</label>
			    <div class="col-sm-1">
			      <input type="text" id="groupStampNum" class="form-control" value="<%=gb.getGroupStampNum() %>">
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">GroupTitle：</label>
			    <div class="col-sm-4">
			      <input type="text" id="groupTitle" class="form-control" value="<%=gb.getGroupTitle() %>">
			    </div>
			    <label class="col-sm-2 control-label">GroupTag：</label>
			    <div class="col-sm-3">
			      <input type="text" id="groupTag" class="form-control"  value="<%=gb.getGroupTag() %>">
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">GroupFromDate：</label>
			    <div class="col-sm-3">
			      <input type="text" id="groupFromDate" class="form-control"  value="<%=gb.getGroupFromDate() %>">
			    </div>
			    <label class="col-sm-2 control-label">GroupFinishDate：</label>
			    <div class="col-sm-3">
			      <input type="text" id="groupFinishDate" class="form-control" value="<%=gb.getGroupFinishDate() %>">
			    </div>
			  </div>
			  <div class="form-group">
				 <label class="col-sm-2 control-label">GroupOthers：</label>
			  </div>
			  <div class="form-group">
			 	 <label><%=gb.getGroupOthers() %></label>
			  </div>
			</form>
			<div class="submit-button" style="text-align:right;">
        		<button type="submit" class="btn btn-primary btn-large" onclick="saveGroupsData('<%=taskId %>','<%=taskNowId %>','<%=taskFinishId %>','<%=gb.getGroupId()%>')">NEXT</button>
      	  	</div>
		  </div>
		</div>
    </div>
  </body>
</html>