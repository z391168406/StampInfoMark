<%@ page language="java" contentType="text/html; charset=GBK" import="java.util.*,version1.model.*" pageEncoding="GBK"%>
    
<%    
String path = request.getContextPath();    
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";    
pageContext.setAttribute("basePath",basePath);    
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
    <title>任务发布工具</title>
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
<%
//取出要显示的任务信息
GoodsBeanBO gbb= new GoodsBeanBO();
TaskBean[] tb=new TaskBean[50];
for(int i=0;i<50;i++){
	tb[i]=new TaskBean();
}
tb=gbb.queryTaskData(user[0]);
out.println("<script type=\"text/javascript\">");
out.println("window.onload=function(){");
for(int i=0;i<tb.length && tb[i]!=null;i++){
	out.println("addTask(" + tb[i].getTaskId() + ",'" + tb[i].getTaskName() + "'," + tb[i].getTaskAmount() + ",'" + tb[i].getTaskPerson() + "','" + tb[i].getTaskTable() + "','" + tb[i].getTaskStartId() + "','" + tb[i].getTaskFinishId() + "','" + tb[i].getTaskNowId() + "','" + tb[i].getTaskFlag() + "','" + tb[i].getTaskDescribe() + "','" + tb[i].getTaskDetail() + "');");
	out.println("generateTaskList(" + i  + "," + tb[i].getTaskId() + ",'" + tb[i].getTaskPerson() + "','" + tb[i].getTaskTable() + "','" + tb[i].getTaskFlag() + "');");
}
out.println("};");
out.println("</script>");
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
              <a href="login.jsp"><i><u>注销</u></i></a>
            </li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>

    <div class="container">
      
      <div class="row">
        <div class="col-xs-2 header-container">
          <h3>个人任务平台</h3>
          <hr/>
          <button type="button" class="btn btn-primary btn-large">我的任务
          </button>
        </div>

        <div class="col-xs-4">
          <div>
	          <h4>任务列表</h4>
	          <table class="table table-striped" id="taskList" style="text-align:center;">
                <tr>
                  <th style="text-align:center;">任务ID</th>
                  <th style="text-align:center;">任务负责人</th>
                  <th style="text-align:center;">任务数据表</th>
                  <th style="text-align:center;">任务标识</th>
                  <th style="text-align:center;">操作</th>
                </tr>
              </table>
              
              <div class="submit-button" style="text-align:right;">
	        	<button type="submit" class="btn btn-primary btn-large" onclick="window.location.href='user.jsp'">刷新任务列表</button>
	      	  </div>
          </div>
        </div>
        
        <div class="col-xs-6">
        	<div>
        		<h4>任务详情</h4>
          		<form class="form-horizontal" role="form" id="taskDetail">
				</form>
	        </div>
        </div>
      </div> 
    </div>
  </body>
</html>