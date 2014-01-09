//process the table data
function createXmlHttpRequest(){
	var xmlreq=false;
	if(window.XMLHttpRequest){
		xmlreq=new XMLHttpRequest();
		
	}else if(window.ActiveXObject){
		try{
			xmlreq=new ActiveXObject("Msxml2.XMLHTTP");
		}catch(e1){
			try{
				xmlreq=new ActiveXObject("Microsoft.XMLHTTP");
			}catch(e2){
			//alert("fail");
			}
		}
	}
	return xmlreq;
} 

//获取当前时间
function curentTime(){ 
    var now = new Date();
    var month = now.getMonth() + 1;     //月
    var day = now.getDate();            //日
    var hh = now.getHours();            //时
    var mm = now.getMinutes();          //分
    var ss = now.getSeconds();			//秒
    var clock="";

    if(month < 10)
        month = "0"+month;
    if(day < 10)
        day = "0"+day
    if(hh < 10)
        hh = "0"+hh;
    if (mm < 10) 
    	mm = "0"+mm;
    if (ss < 10) 
    	ss = "0"+ss;
    
    clock=month+day+hh+mm+ss;
    return clock;
}

//保存任务信息到数据库
function saveTaskValue(){
	var taskId=parseInt(curentTime());
	var taskName=document.getElementById("taskName").value;
	var taskAmount=document.getElementById("taskAmount").value;
	var taskPerson=checkResult("person");
	var taskTable="";
	var taskStartId=document.getElementById("taskStartId").value;
	var taskFinishId=document.getElementById("taskFinishId").value;
	var taskNowId=taskStartId;
	var taskDescribe=document.getElementById("taskDescribe").value;
	var taskFlag=false;
	
	var tag=document.getElementById("tabContent");
	if(tag.getAttribute("value")==1)
		taskTable="stamp";
	else if(tag.getAttribute("value")==2)
		taskTable="groups";
	
	var taskDetail=getTableDetail(taskTable);
	alert(taskDetail);
	
	var request = createXmlHttpRequest();
	request.open("post","SaveDataServlet?table=task&taskId="+taskId+"&taskName="+taskName+"&taskAmount="+taskAmount+"&taskPerson="+taskPerson+"&taskTable="+taskTable+"&taskStartId="+taskStartId+"&taskFinishId="+taskFinishId+"&taskNowId="+taskNowId+"&taskFlag="+taskFlag+"&taskDescribe="+taskDescribe+"&taskDetail="+taskDetail);
	
	request.send();
	request.onreadystatechange = function(){
		if(request.readyState==4){
			if(request.status==200){
				var value = request.responseText;
				if(value){
					alert("任务生成成功");
				}
				else{
					alert("任务生成失败");
				}
			}
		}
	}
}

//获取数据表内信息
function getTableDetail(tableName){
	var tab=document.getElementById(tableName);
	var tabAttribute;
	var row=tab.rows.length;
	var tabDetail="";
	
	for(var i=1; i<row; i++){
		tabAttribute=tab.rows[i].cells[0].innerHTML;
		tabDetail += tabAttribute + ":" + checkResult(tabAttribute) + "\n";
	}
	return tabDetail;
}

//获得被选择人员姓名
function checkResult(name){
	  var obj=document.getElementsByName(name);
	  //取到对象数组后，我们来循环检测它是不是被选中    
	  var s='';    
	  for(var i=0; i<obj.length; i++){    
	    if(obj[i].checked) 
	    	s += obj[i].value + " ";//如果选中，将value添加到变量s中    
	  }    
	  //那么现在来检测s的值就知道选中的复选框的值了    
	  if(s=="")
		  alert("Nothing is selected!");
	  return s;
}

//删除任务条目
function deleteTaskValue(taskId){
	var request = createXmlHttpRequest();
	request.open("post","DeleteDataServlet?taskId="+taskId);
	request.send();
	request.onreadystatechange = function(){
		if(request.readyState==4){
			if(request.status==200){
				var value = request.responseText;
				if(value){
					alert("任务删除成功");
				}
				else{
					alert("任务删除失败");
				}
			}
		}
	}
}

//刷新任务列表
function freshTaskList(){
	var request = createXmlHttpRequest();
	request.open("post","QueryDataServlet?type=all");
	request.send();
	request.onreadystatechange = function(){
		if(request.readyState==4){
			if(request.status==200){
				var value = request.responseText;
				if(value){
					alert("任务删除成功");
				}
				else{
					alert("任务删除失败");
				}
			}
		}
	}
}

//在管理页面生成一条任务列表
function generateTaskLists(taskId,taskName,taskAmount,taskPerson,taskTable,taskStartId,taskFinishId,taskFlag,taskDescribe,taskDetail){
	var table = document.getElementById("taskList");
	table.innerHTML+="<tr>\n" + "<td>" + taskId + "</td>\n" + "<td>" + taskPerson + "</td>\n" + "<td>" + taskTable + "</td>\n" + "<td>" + taskFlag + "</td>\n" + "<td>\n" +
		 "<button class=\"btn btn-link\" data-toggle=\"modal\" data-target=\"#myModal" + taskId + "\">详情</button>\n" +
		 "<button class=\"btn btn-link\" onclick=\"deleteTaskValue(" + taskId + ")\">删除</button>\n" + "</td>\n" + "</tr>\n" +
		 "<div class=\"modal fade\" id=\"myModal" + taskId + "\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"myModalLabel\" aria-hidden=\"true\">\n" +
		 "<div class=\"modal-dialog\">\n" + "<div class=\"modal-content\">\n" + "<div class=\"modal-header\">\n" + 
		 "<button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">&times;</button>\n" + 
		 "<h4 class=\"modal-title\" id=\"myModalLabel\">任务详情</h4>\n" + "</div>" + "<div class=\"modal-body\">\n" +
		 "<h5 style=\"text-align:left;\">任务ID：" + taskId + "</h5>\n" + "<h5 style=\"text-align:left;\">任务名称：" + taskName + "</h5>\n" + "<h5 style=\"text-align:left;\">任务数量：" + taskAmount + "</h5>" +
		 "<h5 style=\"text-align:left;\">任务负责人：" + taskPerson + "</h5>" + "<h5 style=\"text-align:left;\">任务数据表：" + taskTable + "</h5>" + "<h5 style=\"text-align:left;\">任务标示：" + taskFlag + "</h5>" +
		 "<h5 style=\"text-align:left;\">任务起始ID：" + taskStartId + "</h5>\n" + "<h5 style=\"text-align:left;\">任务结束ID：" + taskFinishId + "</h5>\n" + "<h5 style=\"text-align:left;\">任务描述：" + taskDescribe + "</h5>\n" +
		 "<h5 style=\"text-align:left;\">任务细节：" + taskDetail + "</h5>\n" + "</div>\n" + "<div class=\"modal-footer\">\n" + "<button type=\"button\" class=\"btn btn-default\" data-dismiss=\"modal\">关闭</button>\n" +
		 "</div>\n" + "</div>\n" + "</div>\n"+ "</div>\n";
}

tasks=new Array(1);
tasks[0]=new Array(1,"name",100,"person","table","startId","finishId","flag","describe","detail");

//增加任务列表缓存
function addTask(taskId,taskName,taskAmount,taskPerson,taskTable,taskStartId,taskFinishId,taskNowId,taskFlag,taskDescribe,taskDetail){
	var task=new Array(taskId,taskName,taskAmount,taskPerson,taskTable,taskStartId,taskFinishId,taskNowId,taskFlag,taskDescribe,taskDetail);
	tasks.push(task);
}

//得到任务列表缓存中信息
function getTask(i,j){
	var task=tasks[i];
	return task[j];
}

//在个人页面生成一条任务列表
function generateTaskList(i,taskId,taskPerson,taskTable,taskFlag){
	var table = document.getElementById("taskList");
	i+=1;
	table.innerHTML+="<tr>\n" + "<td>" + taskId + "</td>\n" + "<td>" + taskPerson + "</td>\n" + "<td>" + taskTable + "</td>\n" + "<td>" + taskFlag + "</td>\n" + "<td>\n" +
		 "<button class=\"btn btn-link\" onclick=\"generateTaskDetail("+i+")\">详情</button>\n" +
		 "<button class=\"btn btn-link\" onclick=\"deleteTaskValue(" + taskId + ")\">删除</button>\n" + "</td>\n" + "</tr>\n";
}

//在个人页面生成一条任务的详情
function generateTaskDetail(i){
	var table = document.getElementById("taskDetail");
	table.innerHTML="<div class=\"form-group\">\n" + "<label class=\"col-sm-3 control-label\">任务ID：</label>\n" + "<div class=\"col-sm-9\">\n" + "<p class=\"form-control-static\">" + getTask(i,0) +"</p>\n" + "</div>\n" + "</div>\n" +
					"<div class=\"form-group\">\n" + "<label class=\"col-sm-3 control-label\">任务名称：：</label>\n" + "<div class=\"col-sm-9\">\n" + "<p class=\"form-control-static\">" + getTask(i,1) +"</p>\n" + "</div>\n" + "</div>\n" + 
					"<div class=\"form-group\">\n" + "<label class=\"col-sm-3 control-label\">任务数量：</label>\n" + "<div class=\"col-sm-9\">\n" + "<p class=\"form-control-static\">" + getTask(i,2) +"</p>\n" + "</div>\n" + "</div>\n" + 
					"<div class=\"form-group\">\n" + "<label class=\"col-sm-3 control-label\">任务负责人：</label>\n" + "<div class=\"col-sm-9\">\n" + "<p class=\"form-control-static\">" + getTask(i,3) +"</p>\n" + "</div>\n" + "</div>\n" + 
					"<div class=\"form-group\">\n" + "<label class=\"col-sm-3 control-label\">任务数据表：</label>\n" + "<div class=\"col-sm-9\">\n" + "<p class=\"form-control-static\">" + getTask(i,4) +"</p>\n" + "</div>\n" + "</div>\n" + 
					"<div class=\"form-group\">\n" + "<label class=\"col-sm-3 control-label\">任务起始ID：</label>\n" + "<div class=\"col-sm-9\">\n" + "<p class=\"form-control-static\">" + getTask(i,5) +"</p>\n" + "</div>\n" + "</div>\n" + 
					"<div class=\"form-group\">\n" + "<label class=\"col-sm-3 control-label\">任务结束ID：</label>\n" + "<div class=\"col-sm-9\">\n" + "<p class=\"form-control-static\">" + getTask(i,6) +"</p>\n" + "</div>\n" + "</div>\n" + 
					"<div class=\"form-group\">\n" + "<label class=\"col-sm-3 control-label\">任务标识：</label>\n" + "<div class=\"col-sm-9\">\n" + "<p class=\"form-control-static\">" + getTask(i,8) +"</p>\n" + "</div>\n" + "</div>\n" + 
					"<div class=\"form-group\">\n" + "<label class=\"col-sm-3 control-label\">任务描述：</label>\n" + "<div class=\"col-sm-9\">\n" + "<p class=\"form-control-static\">" + getTask(i,9) +"</p>\n" + "</div>\n" + "</div>\n" + 
					"<div class=\"form-group\">\n" + "<label class=\"col-sm-3 control-label\">任务细节：</label>\n" + "<div class=\"col-sm-9\">\n" + "<p class=\"form-control-static\">" + getTask(i,10) +"</p>\n" + "</div>\n" + "</div>\n" + 
					"<div class=\"submit-button\" style=\"text-align:right;\">\n" + "<a href=\"ShowGoodsClServlet?table=" + getTask(i,4) + "&taskId=" + getTask(i,0) + "&taskNowId=" + getTask(i,7) + "&taskFinishId=" + getTask(i,6) + "\"><h3><strong><u>去做任务</u></strong></h3></a>\n" + "</div>\n";										
}

//保存邮票信息
function saveStampData(taskId,taskNowId,taskFinishId,id){
	var stampId = id;
	var stampInGroupTitle = document.getElementById("stampInGroupTitle").value;
	var stampTitle = document.getElementById("stampTitle").value;
	var stampDate = document.getElementById("stampDate").value;
	var stampType = document.getElementById("stampType").value;
	var stampValue = document.getElementById("stampValue").value;
	var stampSize = document.getElementById("stampSize").value;
	var stampDesigner = document.getElementById("stampDesigner").value;
	var stampPublisher = document.getElementById("stampPublisher").value;
	//将数据传入后台
	var request = createXmlHttpRequest();
	request.open("post","SaveDataServlet?table=stamp&stampInGroupTitle="+stampInGroupTitle+"&stampDate="+stampDate+"&stampId="+stampId+"&stampTitle="+stampTitle+"&stampType="+stampType+"&stampValue="+stampValue+"&stampSize="+stampSize+"&stampDesigner="+stampDesigner+"&stampPublisher="+stampPublisher);
	request.send();
	request.onreadystatechange = function(){
		if(request.readyState==4){
			if(request.status==200){
				var value = request.responseText;
				if(value){
					window.location.href="ShowGoodsClServlet?table=stamp&taskId=" + taskId + "&taskNowId=" + taskNowId + "&taskFinishId=" + taskFinishId;	
				}
				else{
					alert("stamp信息保存失败");
				}
			}
		}
	}
}

//保存Groups信息
function saveGroupsData(taskId,taskNowId,taskFinishId,id){
	var groupId = id;
	var groupTitle = document.getElementById("groupTitle").value;
	var groupTag = document.getElementById("groupTag").value;
	var groupStampNum = document.getElementById("groupStampNum").value;
	var groupFromDate = document.getElementById("groupFromDate").value;
	var groupFinishDate = document.getElementById("groupFinishDate").value;
	//将数据传入后台
	var request = createXmlHttpRequest();
	request.open("post","SaveDataServlet?table=groups&groupTitle="+groupTitle+"&groupTag="+groupTag+"&groupId="+groupId+"&groupStampNum="+groupStampNum+"&groupFromDate="+groupFromDate+"&groupFinishDate="+groupFinishDate);
	request.send();
	request.onreadystatechange = function(){
		if(request.readyState==4){
			if(request.status==200){
				var value = request.responseText;
				if(value){
					window.location.href="ShowGoodsClServlet?table=groups&taskId=" + taskId + "&taskNowId=" + taskNowId + "&taskFinishId=" + taskFinishId;	
				}
				else{
					alert("groups信息保存失败");
				}
			}
		}
	}
}