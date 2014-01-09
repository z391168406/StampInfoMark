<%@ page language="java" contentType="text/html; charset=GBK" import="java.util.*,version1.model.*" pageEncoding="GBK"%>

<%    
String path = request.getContextPath();    
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";    
pageContext.setAttribute("basePath",basePath);    
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" language="javascript" content="text/javascript; charset=GBK">
    <title>���񷢲�����</title>
    <link href="bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="bootstrap/css/bootstrap-theme.css" rel="stylesheet">
    <script src="bootstrap/js/jquery-1.10.2.min.js"></script>
    <script src="bootstrap/js/bootstrap.js"></script>
    <script src="js/myFunction.js"></script>
    <script src="js/secondFunction.js"></script>
    <style type="text/css">
      body {
        padding-top: 60px;
        padding-bottom: 40px;
      }
      .login_header_container{
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
  <script>
  	function changeValue(num){
		var tag=document.getElementById("tabContent");
		tag.setAttribute("value",num);
	}
  </script>
<%
//ȡ��Ҫ��ʾ��������Ϣ
GoodsBeanBO gbb= new GoodsBeanBO();
TaskBean[] tb=new TaskBean[50];
for(int i=0;i<50;i++){
	tb[i]=new TaskBean();
}
tb=gbb.queryTaskData("all");
out.println("<script type=\"text/javascript\">");
out.println("window.onload=function(){");
for(int i=0;i<tb.length && tb[i]!=null;i++){
	out.println("generateTaskLists(" + tb[i].getTaskId() + ",'" + tb[i].getTaskName() + "'," + tb[i].getTaskAmount() + ",'" + tb[i].getTaskPerson() + "','" + tb[i].getTaskTable() + "','" + tb[i].getTaskStartId() + "','" + tb[i].getTaskFinishId() + "','" + tb[i].getTaskFlag() + "','" + tb[i].getTaskDescribe() + "','" + tb[i].getTaskDetail() + "');");
}
out.println("};");
out.println("</script>");
%>

  <body>   
    <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <a class="navbar-brand" href="#"><span class="glyphicon glyphicon-home"></span>&nbsp;��Ϣ�޸����񷢲�ƽ̨</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li>
              <a href="user.jsp"><i><u>�л����û�����</u></i></a>
            </li>
            <li>
              <a href="login.jsp"><i><u>ע��</u></i></a>
            </li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>

    <div class="container">
      <div class="row">      
        <div class="col-xs-3">
          <h3>�������ƽ̨</h3>
          <hr/>
          <div>
          	<table id="tableAttribute">
	          	<tr>
	          		<td width=40%>
	          	  		<h4 style="text-align:left;">�������ƣ�</h4>
	          	  	</td>
	          	  	<td width=60%>
          	  			<input class="form-control" type="text" id="taskName" placeholder="��������">
          	  		</td>
          	    </tr>
	          	<tr>
		          	<td>
		          	  <h4 style="text-align:left;">����������</h4>
		          	</td>
		          	<td>
		          	  <input class="form-control" type="text" id="taskAmount" placeholder="��������">
		          	</td>
	          	</tr>
	          	<tr>
		          	<td>
		          	  <h4 style="text-align:left;">����ʼID��</h4>
		          	</td>
		          	<td>
		          	  <input class="form-control" type="text" id="taskStartId" placeholder="����ʼID" >
		          	</td>
	          	</tr>
	          	<tr>
		          	<td>
		          	  <h4 style="text-align:left;">�������ID��</h4>
		          	</td>
		          	<td>
		          	  <input class="form-control" type="text" id="taskFinishId" placeholder="�������ID">
		          	</td>
	          	</tr>
	            <tr>
	            <tr>
	          		<td>
	          	  		<h4 style="text-align:left;">����������</h4>
	          	  	</td>
          	    </tr>
	          	<tr>
	          		<td colspan="2">
	          	  		<textarea class="form-control" cols="50" rows="3" id="taskDescribe" placeholder="�����뱾����������..."></textarea>
	          	  	</td>
	          	</tr>
	      	</table>
          </div>
          <div>
	          <h4 style="text-align:left;">��Ա�б�</h4>
	          <table class="table table-condensed" id="tablePerson">
	                <tr>
	                  <th>��Ա</th>
	                  <th>ѡ��</th>
	                  <th>��Ա</th>
	                  <th>ѡ��</th>
	                </tr>
	                <tr>
	                  <td>������</td>
	                  <td><input type="checkbox" name="person" value="������MF1332095"></td>
	                  <td>�ƶ���</td>
	                  <td><input type="checkbox" name="person" value="�ƶ���MF1332017"></td>
	                </tr>
	                <tr>
	                  <td>��쿿�</td>
	                  <td><input type="checkbox" name="person" value="��쿿�MF1332032"></td>
	                  <td>����</td>
	                  <td><input type="checkbox" name="person" value="����MF1332033"></td>
	                </tr>
	                <tr>
	                  <td>��˹</td>
	                  <td><input type="checkbox" name="person" value="��˹MF1332041"></td>
	                  <td>���۳�</td>
	                  <td><input type="checkbox" name="person" value="���۳�MF1332052"></td>
	                </tr>
	                <tr>
	                  <td>���Ĵ�</td>
	                  <td><input type="checkbox" name="person" value="���Ĵ�MF1332073"></td>
	                  <td>������</td>
	                  <td><input type="checkbox" name="person" value="������MF1332074"></td>
	                </tr>
	                <tr>
	                  <td>����Դ</td>
	                  <td><input type="checkbox" name="person" value="����ԴMF1332077"></td>
	                  <td>���</td>
	                  <td><input type="checkbox" name="person" value="���MF1332078"></td>
	                </tr>
	                <tr>
	                  <td>����ͽ</td>
	                  <td><input type="checkbox" name="person" value="����ͽMF1332079"></td>
	                  <td>����</td>
	                  <td><input type="checkbox" name="person" value="����MF1332080"></td>
	                </tr>
	                <tr>
	                  <td>Ҧ��</td>
	                  <td><input type="checkbox" name="person" value="Ҧ��MF1332083"></td>
	                  <td>��־��</td>
	                  <td><input type="checkbox" name="person" value="��־��MF1332091"></td>
	                </tr>
	          </table>
        	</div>
        </div>
        
         <div class="col-xs-3" value="1" id="tabContent">
          <h4 style="text-align:left;">���ݿ��б�</h4>
          <ul class="nav nav-tabs">
            <li><a href="#tableDB1" data-toggle="tab" onclick="changeValue(1)">Stamp</a></li>
            <li><a href="#tableDB2" data-toggle="tab" onclick="changeValue(2)">Groups</a></li>
          </ul>

          <!-- Tab panes -->
          <div class="tab-content">
            <div class="tab-pane active" id="tableDB1">
              <table class="table table-condensed" id="stamp">
                <tr>
                  <th>����</th>
                  <th>ֻ��</th>
                  <th>�޸�</th>
                  <th>����</th>
                </tr>
                <tr>
                  <td>StampId</td>
                  <td><input type="checkbox" name="StampId" value="OnlyRead" onclick="controlChoice('OnlyRead','StampId')"></td>
                  <td><input type="checkbox" name="StampId" value="Modify" onclick="controlChoice('Modify','StampId')"></td>
                  <td><input type="checkbox" name="StampId" value="Hide" onclick="controlChoice('Hide','StampId')"></td>
                </tr>
                <tr>
                  <td>StampCountry</td>
                  <td><input type="checkbox" name="StampCountry" value="OnlyRead" onclick="controlChoice('OnlyRead','StampCountry')"></td>
                  <td><input type="checkbox" name="StampCountry" value="Modify" onclick="controlChoice('Modify','StampCountry')"></td>
                  <td><input type="checkbox" name="StampCountry" value="Hide" onclick="controlChoice('Hide','StampCountry')"></td>
                </tr>
                <tr>
                  <td>StampYear</td>
                  <td><input type="checkbox" name="StampYear" value="OnlyRead" onclick="controlChoice('OnlyRead','StampYear')"></td>
                  <td><input type="checkbox" name="StampYear" value="Modify" onclick="controlChoice('Modify','StampYear')"></td>
                  <td><input type="checkbox" name="StampYear" value="Hide" onclick="controlChoice('Hide','StampYear')"></td>
                </tr>
                <tr>
                  <td>StampPeriod</td>
                  <td><input type="checkbox" name="StampPeriod" value="OnlyRead" onclick="controlChoice('OnlyRead','StampPeriod')"></td>
                  <td><input type="checkbox" name="StampPeriod" value="Modify" onclick="controlChoice('Modify','StampPeriod')"></td>
                  <td><input type="checkbox" name="StampPeriod" value="Hide" onclick="controlChoice('Hide','StampPeriod')"></td>
                </tr>
                <tr>
                  <td>StampInGroupId</td>
                  <td><input type="checkbox" name="StampInGroupId" value="OnlyRead" onclick="controlChoice('OnlyRead','StampInGroupId')"></td>
                  <td><input type="checkbox" name="StampInGroupId" value="Modify" onclick="controlChoice('Modify','StampInGroupId')"></td>
                  <td><input type="checkbox" name="StampInGroupId" value="Hide" onclick="controlChoice('Hide','StampInGroupId')"></td>
                </tr>
                <tr>
                  <td>StampIdInPeriod</td>
                  <td><input type="checkbox" name="StampIdInPeriod" value="OnlyRead" onclick="controlChoice('OnlyRead','StampIdInPeriod')"></td>
                  <td><input type="checkbox" name="StampIdInPeriod" value="Modify" onclick="controlChoice('Modify','StampIdInPeriod')"></td>
                  <td><input type="checkbox" name="StampIdInPeriod" value="Hide" onclick="controlChoice('Hide','StampIdInPeriod')"></td>
                </tr>
                <tr>
                  <td>StampIdInGroup</td>
                  <td><input type="checkbox" name="StampIdInGroup" value="OnlyRead" onclick="controlChoice('OnlyRead','StampIdInGroup')"></td>
                  <td><input type="checkbox" name="StampIdInGroup" value="Modify" onclick="controlChoice('Modify','StampIdInGroup')"></td>
                  <td><input type="checkbox" name="StampIdInGroup" value="Hide" onclick="controlChoice('Hide','StampIdInGroup')"></td>
                </tr>
                <tr>
                  <td>StampInGroupTitle</td>
                  <td><input type="checkbox" name="StampInGroupTitle" value="OnlyRead" onclick="controlChoice('OnlyRead','StampInGroupTitle')"></td>
                  <td><input type="checkbox" name="StampInGroupTitle" value="Modify" onclick="controlChoice('Modify','StampInGroupTitle')"></td>
                  <td><input type="checkbox" name="StampInGroupTitle" value="Hide" onclick="controlChoice('Hide','StampInGroupTitle')"></td>
                </tr>
                <tr>
                  <td>StampTitle</td>
                  <td><input type="checkbox" name="StampTitle" value="OnlyRead" onclick="controlChoice('OnlyRead','StampTitle')"></td>
                  <td><input type="checkbox" name="StampTitle" value="Modify" onclick="controlChoice('Modify','StampTitle')"></td>
                  <td><input type="checkbox" name="StampTitle" value="Hide" onclick="controlChoice('Hide','StampTitle')"></td>
                </tr>
                <tr>
                  <td>StampDate</td>
                  <td><input type="checkbox" name="StampDate" value="OnlyRead" onclick="controlChoice('OnlyRead','StampDate')"></td>
                  <td><input type="checkbox" name="StampDate" value="Modify" onclick="controlChoice('Modify','StampDate')"></td>
                  <td><input type="checkbox" name="StampDate" value="Hide" onclick="controlChoice('Hide','StampDate')"></td>
                </tr>
                <tr>
                  <td>StampType</td>
                  <td><input type="checkbox" name="StampType" value="OnlyRead" onclick="controlChoice('OnlyRead','StampType')"></td>
                  <td><input type="checkbox" name="StampType" value="Modify" onclick="controlChoice('Modify','StampType')"></td>
                  <td><input type="checkbox" name="StampType" value="Hide" onclick="controlChoice('Hide','StampType')"></td>
                </tr>
                <tr>
                  <td>StampValue</td>
                  <td><input type="checkbox" name="StampValue" value="OnlyRead" onclick="controlChoice('OnlyRead','StampValue')"></td>
                  <td><input type="checkbox" name="StampValue" value="Modify" onclick="controlChoice('Modify','StampValue')"></td>
                  <td><input type="checkbox" name="StampValue" value="Hide" onclick="controlChoice('Hide','StampValue')"></td>
                </tr>
                <tr>
                  <td>StampSize</td>
                  <td><input type="checkbox" name="StampSize" value="OnlyRead" onclick="controlChoice('OnlyRead','StampSize')"></td>
                  <td><input type="checkbox" name="StampSize" value="Modify" onclick="controlChoice('Modify','StampSize')"></td>
                  <td><input type="checkbox" name="StampSize" value="Hide" onclick="controlChoice('Hide','StampSize')"></td>
                </tr>
                <tr>
                  <td>StampDesigner</td>
                  <td><input type="checkbox" name="StampDesigner" value="OnlyRead" onclick="controlChoice('OnlyRead','StampDesigner')"></td>
                  <td><input type="checkbox" name="StampDesigner" value="Modify" onclick="controlChoice('Modify','StampDesigner')"></td>
                  <td><input type="checkbox" name="StampDesigner" value="Hide" onclick="controlChoice('Hide','StampDesigner')"></td>
                </tr>
                <tr>
                  <td>StampPublisher</td>
                  <td><input type="checkbox" name="StampPublisher" value="OnlyRead" onclick="controlChoice('OnlyRead','StampPublisher')"></td>
                  <td><input type="checkbox" name="StampPublisher" value="Modify" onclick="controlChoice('Modify','StampPublisher')"></td>
                  <td><input type="checkbox" name="StampPublisher" value="Hide" onclick="controlChoice('Hide','StampPublisher')"></td>
                </tr>
                <tr>
                  <td>StampUrl</td>
                  <td><input type="checkbox" name="StampUrl" value="OnlyRead" onclick="controlChoice('OnlyRead','StampUrl')"></td>
                  <td><input type="checkbox" name="StampUrl" value="Modify" onclick="controlChoice('Modify','StampUrl')"></td>
                  <td><input type="checkbox" name="StampUrl" value="Hide" onclick="controlChoice('Hide','StampUrl')"></td>
                </tr>
                <tr>
                  <td>StampLocalAddress</td>
                  <td><input type="checkbox" name="StampLocalAddress" value="OnlyRead" onclick="controlChoice('OnlyRead','StampLocalAddress')"></td>
                  <td><input type="checkbox" name="StampLocalAddress" value="Modify" onclick="controlChoice('Modify','StampLocalAddress')"></td>
                  <td><input type="checkbox" name="StampLocalAddress" value="Hide" onclick="controlChoice('Hide','StampLocalAddress')"></td>
                </tr>
                <tr>
                  <td>StampOthers</td>
                  <td><input type="checkbox" name="StampOthers" value="OnlyRead" onclick="controlChoice('OnlyRead','StampOthers')"></td>
                  <td><input type="checkbox" name="StampOthers" value="Modify" onclick="controlChoice('Modify','StampOthers')"></td>
                  <td><input type="checkbox" name="StampOthers" value="Hide" onclick="controlChoice('Hide','StampOthers')"></td>
                </tr>
              </table>
            </div>

            <div class="tab-pane" id="tableDB2">
              <table class="table table-condensed" id="groups">
                <tr>
                  <th>����</th>
                  <th>ֻ��</th>
                  <th>�޸�</th>
                  <th>����</th>
                </tr>
                <tr>
                  <td>GroupId</td>
                  <td><input type="checkbox" name="GroupId" value="OnlyRead" onclick="controlChoice('OnlyRead','GroupId')"></td>
                  <td><input type="checkbox" name="GroupId" value="Modify" onclick="controlChoice('Modify','GroupId')"></td>
                  <td><input type="checkbox" name="GroupId" value="Hide" onclick="controlChoice('Hide','GroupId')"></td>
                </tr>
                <tr>
                  <td>GroupCountry</td>
                  <td><input type="checkbox" name="GroupCountry" value="OnlyRead" onclick="controlChoice('OnlyRead','GroupCountry')"></td>
                  <td><input type="checkbox" name="GroupCountry" value="Modify" onclick="controlChoice('Modify','GroupCountry')"></td>
                  <td><input type="checkbox" name="GroupCountry" value="Hide" onclick="controlChoice('Hide','GroupCountry')"></td>
                </tr>
                <tr>
                  <td>GroupTitle</td>
                  <td><input type="checkbox" name="GroupTitle" value="OnlyRead" onclick="controlChoice('OnlyRead','GroupTitle')"></td>
                  <td><input type="checkbox" name="GroupTitle" value="Modify" onclick="controlChoice('Modify','GroupTitle')"></td>
                  <td><input type="checkbox" name="GroupTitle" value="Hide" onclick="controlChoice('Hide','GroupTitle')"></td>
                </tr>
                <tr>
                  <td>GroupTag</td>
                  <td><input type="checkbox" name="GroupTag" value="OnlyRead" onclick="controlChoice('OnlyRead','GroupTag')"></td>
                  <td><input type="checkbox" name="GroupTag" value="Modify" onclick="controlChoice('Modify','GroupTag')"></td>
                  <td><input type="checkbox" name="GroupTag" value="Hide" onclick="controlChoice('Hide','GroupTag')"></td>
                </tr>
                <tr>
                  <td>GroupStampNum</td>
                  <td><input type="checkbox" name="GroupStampNum" value="OnlyRead" onclick="controlChoice('OnlyRead','GroupStampNum')"></td>
                  <td><input type="checkbox" name="GroupStampNum" value="Modify" onclick="controlChoice('Modify','GroupStampNum')"></td>
                  <td><input type="checkbox" name="GroupStampNum" value="Hide" onclick="controlChoice('Hide','GroupStampNum')"></td>
                </tr>
                <tr>
                  <td>GroupFromDate</td>
                  <td><input type="checkbox" name="GroupFromDate" value="OnlyRead" onclick="controlChoice('OnlyRead','GroupFromDate')"></td>
                  <td><input type="checkbox" name="GroupFromDate" value="Modify" onclick="controlChoice('Modify','GroupFromDate')"></td>
                  <td><input type="checkbox" name="GroupFromDate" value="Hide" onclick="controlChoice('Hide','GroupFromDate')"></td>
                </tr>
                <tr>
                  <td>GroupFinishDate</td>
                  <td><input type="checkbox" name="GroupFinishDate" value="OnlyRead" onclick="controlChoice('OnlyRead','GroupFinishDate')"></td>
                  <td><input type="checkbox" name="GroupFinishDate" value="Modify" onclick="controlChoice('Modify','GroupFinishDate')"></td>
                  <td><input type="checkbox" name="GroupFinishDate" value="Hide" onclick="controlChoice('Hide','GroupFinishDate')"></td>
                </tr>
                <tr>
                  <td>GroupOthers</td>
                  <td><input type="checkbox" name="GroupOthers" value="OnlyRead" onclick="controlChoice('OnlyRead','GroupOthers')"></td>
                  <td><input type="checkbox" name="GroupOthers" value="Modify" onclick="controlChoice('Modify','GroupOthers')"></td>
                  <td><input type="checkbox" name="GroupOthers" value="Hide" onclick="controlChoice('Hide','GroupOthers')"></td>
                </tr>
              </table>
            </div>
          </div>
          <div class="submit-button" style="text-align:right;">
	        <button type="submit" class="btn btn-primary btn-large" onclick="saveTaskValue()">��������</button>
	      </div>
        </div>
      
        <div class="col-xs-6">
          <div>
	          <h4>�����б�</h4>
	          <table class="table table-striped" id="taskList" style="text-align:center;">
                <tr>
                  <th style="text-align:center;">����ID</th>
                  <th style="text-align:center;">��������</th>
                  <th style="text-align:center;">�������ݱ�</th>
                  <th style="text-align:center;">�����ʶ</th>
                  <th style="text-align:center;">����</th>
                </tr>
              </table>
              
              <div class="submit-button" style="text-align:right;">
	        	<button type="submit" class="btn btn-primary btn-large" onclick="window.location.href='admin.jsp'">ˢ�������б�</button>
	      	  </div>
          </div>
        </div>
      </div> 
    </div>
  </body>
</html>