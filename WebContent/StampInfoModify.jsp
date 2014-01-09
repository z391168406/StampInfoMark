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
StampBean sb=new StampBean();
sb=(StampBean)request.getAttribute("goodInfo");
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
		
		    <div class="col-xs-3">
			    <label control-label">StampImage：</label>
			    <div>
			      <img src="<%=sb.getStampLocalAddress()%>.jpg" width="146" height="167" />
			    </div>
		    </div>
		    
			<div class="col-xs-9">
				<form class="form-horizontal" role="form">
				  <div class="form-group">
				    <label class="col-sm-1 control-label">StampId：</label>
				    <div class="col-sm-2">
				      <p class="form-control-static"><%=sb.getStampId() %></p>
				    </div>
				    <label class="col-sm-2 control-label">StampCountry：</label>
				    <div class="col-sm-1">
				      <p class="form-control-static"><%=sb.getStampCountry() %></p>
				    </div>
				    <label class="col-sm-2 control-label">StampYear：</label>
				    <div class="col-sm-1">
				      <p class="form-control-static"><%=sb.getStampYear() %></p>
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">StampInGroupId：</label>
				    <div class="col-sm-2">
				      <p class="form-control-static"><%=sb.getStampInGroupId() %></p>
				    </div>
				    <label class="col-sm-2 control-label">StampPeriod：</label>
				    <div class="col-sm-2">
				      <p class="form-control-static"><%=sb.getStampPeriod() %></p>
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">StampIdInPeriod：</label>
				    <div class="col-sm-2">
				      <p class="form-control-static"><%=sb.getStampIdInPeriod() %></p>
				    </div>
				    <label class="col-sm-2 control-label">StampIdInGroup：</label>
				    <div class="col-sm-2">
				      <p class="form-control-static"><%=sb.getStampIdInGroup() %></p>
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">StampInGroupTitle：</label>
				    <div class="col-sm-4">
				      <input type="text" id="stampInGroupTitle" class="form-control" value="<%=sb.getStampInGroupTitle() %>">
				    </div>
				    <label class="col-sm-2 control-label">StampTitle：</label>
				    <div class="col-sm-4">
				      <input type="text" id="stampTitle" class="form-control" value="<%=sb.getStampTitle() %>">
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">StampDate：</label>
				    <div class="col-sm-4">
				      <input type="text" id="stampDate" class="form-control" value="<%=sb.getStampDate() %>">
				    </div>
				    <label class="col-sm-2 control-label">StampType：</label>
				    <div class="col-sm-4">
				      <input type="text" id="stampType" class="form-control" value="<%=sb.getStampType() %>">
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">StampValue：</label>
				    <div class="col-sm-4">
				      <input type="text" id="stampValue" class="form-control" value="<%=sb.getStampValue() %>">
				    </div>
				    <label class="col-sm-2 control-label">StampSize：</label>
				    <div class="col-sm-4">
				      <input type="text" id="stampSize" class="form-control" value="<%=sb.getStampSize() %>">
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">StampDesigner：</label>
				    <div class="col-sm-4">
				      <input type="text" id="stampDesigner" class="form-control" value="<%=sb.getStampDesigner() %>">
				    </div>
				    <label class="col-sm-2 control-label">StampPublisher：</label>
				    <div class="col-sm-4">
				      <input type="text" id="stampPublisher" class="form-control" value="<%=sb.getStampPublisher() %>">
				    </div>
				  </div>
				  <div class="form-group">
					 <label class="col-sm-2 control-label">StampOthers：</label>
				  </div>
				  <div class="form-group">
				 	 <label><%=sb.getStampOthers() %></label>
				  </div>
				</form>
				<div class="submit-button" style="text-align:right;">
	        		<button type="submit" class="btn btn-primary btn-large" onclick="saveStampData('<%=taskId %>','<%=taskNowId %>','<%=taskFinishId %>','<%=sb.getStampId()%>')">NEXT</button>
	      	  	</div>
			</div>
		</div>
    </div>
  </body>
</html>