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

//��ȡ��ǰʱ��
function curentTime(){ 
    var now = new Date();
    var month = now.getMonth() + 1;     //��
    var day = now.getDate();            //��
    var hh = now.getHours();            //ʱ
    var mm = now.getMinutes();          //��
    var ss = now.getSeconds();			//��
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

//����������Ϣ�����ݿ�
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
					alert("�������ɳɹ�");
				}
				else{
					alert("��������ʧ��");
				}
			}
		}
	}
}

//��ȡ���ݱ�����Ϣ
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

//��ñ�ѡ����Ա����
function checkResult(name){
	  var obj=document.getElementsByName(name);
	  //ȡ�����������������ѭ��������ǲ��Ǳ�ѡ��    
	  var s='';    
	  for(var i=0; i<obj.length; i++){    
	    if(obj[i].checked) 
	    	s += obj[i].value + " ";//���ѡ�У���value��ӵ�����s��    
	  }    
	  //��ô���������s��ֵ��֪��ѡ�еĸ�ѡ���ֵ��    
	  if(s=="")
		  alert("Nothing is selected!");
	  return s;
}

//ɾ��������Ŀ
function deleteTaskValue(taskId){
	var request = createXmlHttpRequest();
	request.open("post","DeleteDataServlet?taskId="+taskId);
	request.send();
	request.onreadystatechange = function(){
		if(request.readyState==4){
			if(request.status==200){
				var value = request.responseText;
				if(value){
					alert("����ɾ���ɹ�");
				}
				else{
					alert("����ɾ��ʧ��");
				}
			}
		}
	}
}

//ˢ�������б�
function freshTaskList(){
	var request = createXmlHttpRequest();
	request.open("post","QueryDataServlet?type=all");
	request.send();
	request.onreadystatechange = function(){
		if(request.readyState==4){
			if(request.status==200){
				var value = request.responseText;
				if(value){
					alert("����ɾ���ɹ�");
				}
				else{
					alert("����ɾ��ʧ��");
				}
			}
		}
	}
}

//�ڹ���ҳ������һ�������б�
function generateTaskLists(taskId,taskName,taskAmount,taskPerson,taskTable,taskStartId,taskFinishId,taskFlag,taskDescribe,taskDetail){
	var table = document.getElementById("taskList");
	table.innerHTML+="<tr>\n" + "<td>" + taskId + "</td>\n" + "<td>" + taskPerson + "</td>\n" + "<td>" + taskTable + "</td>\n" + "<td>" + taskFlag + "</td>\n" + "<td>\n" +
		 "<button class=\"btn btn-link\" data-toggle=\"modal\" data-target=\"#myModal" + taskId + "\">����</button>\n" +
		 "<button class=\"btn btn-link\" onclick=\"deleteTaskValue(" + taskId + ")\">ɾ��</button>\n" + "</td>\n" + "</tr>\n" +
		 "<div class=\"modal fade\" id=\"myModal" + taskId + "\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"myModalLabel\" aria-hidden=\"true\">\n" +
		 "<div class=\"modal-dialog\">\n" + "<div class=\"modal-content\">\n" + "<div class=\"modal-header\">\n" + 
		 "<button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">&times;</button>\n" + 
		 "<h4 class=\"modal-title\" id=\"myModalLabel\">��������</h4>\n" + "</div>" + "<div class=\"modal-body\">\n" +
		 "<h5 style=\"text-align:left;\">����ID��" + taskId + "</h5>\n" + "<h5 style=\"text-align:left;\">�������ƣ�" + taskName + "</h5>\n" + "<h5 style=\"text-align:left;\">����������" + taskAmount + "</h5>" +
		 "<h5 style=\"text-align:left;\">�������ˣ�" + taskPerson + "</h5>" + "<h5 style=\"text-align:left;\">�������ݱ�" + taskTable + "</h5>" + "<h5 style=\"text-align:left;\">�����ʾ��" + taskFlag + "</h5>" +
		 "<h5 style=\"text-align:left;\">������ʼID��" + taskStartId + "</h5>\n" + "<h5 style=\"text-align:left;\">�������ID��" + taskFinishId + "</h5>\n" + "<h5 style=\"text-align:left;\">����������" + taskDescribe + "</h5>\n" +
		 "<h5 style=\"text-align:left;\">����ϸ�ڣ�" + taskDetail + "</h5>\n" + "</div>\n" + "<div class=\"modal-footer\">\n" + "<button type=\"button\" class=\"btn btn-default\" data-dismiss=\"modal\">�ر�</button>\n" +
		 "</div>\n" + "</div>\n" + "</div>\n"+ "</div>\n";
}

tasks=new Array(1);
tasks[0]=new Array(1,"name",100,"person","table","startId","finishId","flag","describe","detail");

//���������б���
function addTask(taskId,taskName,taskAmount,taskPerson,taskTable,taskStartId,taskFinishId,taskNowId,taskFlag,taskDescribe,taskDetail){
	var task=new Array(taskId,taskName,taskAmount,taskPerson,taskTable,taskStartId,taskFinishId,taskNowId,taskFlag,taskDescribe,taskDetail);
	tasks.push(task);
}

//�õ������б�������Ϣ
function getTask(i,j){
	var task=tasks[i];
	return task[j];
}

//�ڸ���ҳ������һ�������б�
function generateTaskList(i,taskId,taskPerson,taskTable,taskFlag){
	var table = document.getElementById("taskList");
	i+=1;
	table.innerHTML+="<tr>\n" + "<td>" + taskId + "</td>\n" + "<td>" + taskPerson + "</td>\n" + "<td>" + taskTable + "</td>\n" + "<td>" + taskFlag + "</td>\n" + "<td>\n" +
		 "<button class=\"btn btn-link\" onclick=\"generateTaskDetail("+i+")\">����</button>\n" +
		 "<button class=\"btn btn-link\" onclick=\"deleteTaskValue(" + taskId + ")\">ɾ��</button>\n" + "</td>\n" + "</tr>\n";
}

//�ڸ���ҳ������һ�����������
function generateTaskDetail(i){
	var table = document.getElementById("taskDetail");
	table.innerHTML="<div class=\"form-group\">\n" + "<label class=\"col-sm-3 control-label\">����ID��</label>\n" + "<div class=\"col-sm-9\">\n" + "<p class=\"form-control-static\">" + getTask(i,0) +"</p>\n" + "</div>\n" + "</div>\n" +
					"<div class=\"form-group\">\n" + "<label class=\"col-sm-3 control-label\">�������ƣ���</label>\n" + "<div class=\"col-sm-9\">\n" + "<p class=\"form-control-static\">" + getTask(i,1) +"</p>\n" + "</div>\n" + "</div>\n" + 
					"<div class=\"form-group\">\n" + "<label class=\"col-sm-3 control-label\">����������</label>\n" + "<div class=\"col-sm-9\">\n" + "<p class=\"form-control-static\">" + getTask(i,2) +"</p>\n" + "</div>\n" + "</div>\n" + 
					"<div class=\"form-group\">\n" + "<label class=\"col-sm-3 control-label\">�������ˣ�</label>\n" + "<div class=\"col-sm-9\">\n" + "<p class=\"form-control-static\">" + getTask(i,3) +"</p>\n" + "</div>\n" + "</div>\n" + 
					"<div class=\"form-group\">\n" + "<label class=\"col-sm-3 control-label\">�������ݱ�</label>\n" + "<div class=\"col-sm-9\">\n" + "<p class=\"form-control-static\">" + getTask(i,4) +"</p>\n" + "</div>\n" + "</div>\n" + 
					"<div class=\"form-group\">\n" + "<label class=\"col-sm-3 control-label\">������ʼID��</label>\n" + "<div class=\"col-sm-9\">\n" + "<p class=\"form-control-static\">" + getTask(i,5) +"</p>\n" + "</div>\n" + "</div>\n" + 
					"<div class=\"form-group\">\n" + "<label class=\"col-sm-3 control-label\">�������ID��</label>\n" + "<div class=\"col-sm-9\">\n" + "<p class=\"form-control-static\">" + getTask(i,6) +"</p>\n" + "</div>\n" + "</div>\n" + 
					"<div class=\"form-group\">\n" + "<label class=\"col-sm-3 control-label\">�����ʶ��</label>\n" + "<div class=\"col-sm-9\">\n" + "<p class=\"form-control-static\">" + getTask(i,8) +"</p>\n" + "</div>\n" + "</div>\n" + 
					"<div class=\"form-group\">\n" + "<label class=\"col-sm-3 control-label\">����������</label>\n" + "<div class=\"col-sm-9\">\n" + "<p class=\"form-control-static\">" + getTask(i,9) +"</p>\n" + "</div>\n" + "</div>\n" + 
					"<div class=\"form-group\">\n" + "<label class=\"col-sm-3 control-label\">����ϸ�ڣ�</label>\n" + "<div class=\"col-sm-9\">\n" + "<p class=\"form-control-static\">" + getTask(i,10) +"</p>\n" + "</div>\n" + "</div>\n" + 
					"<div class=\"submit-button\" style=\"text-align:right;\">\n" + "<a href=\"ShowGoodsClServlet?table=" + getTask(i,4) + "&taskId=" + getTask(i,0) + "&taskNowId=" + getTask(i,7) + "&taskFinishId=" + getTask(i,6) + "\"><h3><strong><u>ȥ������</u></strong></h3></a>\n" + "</div>\n";										
}

//������Ʊ��Ϣ
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
	//�����ݴ����̨
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
					alert("stamp��Ϣ����ʧ��");
				}
			}
		}
	}
}

//����Groups��Ϣ
function saveGroupsData(taskId,taskNowId,taskFinishId,id){
	var groupId = id;
	var groupTitle = document.getElementById("groupTitle").value;
	var groupTag = document.getElementById("groupTag").value;
	var groupStampNum = document.getElementById("groupStampNum").value;
	var groupFromDate = document.getElementById("groupFromDate").value;
	var groupFinishDate = document.getElementById("groupFinishDate").value;
	//�����ݴ����̨
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
					alert("groups��Ϣ����ʧ��");
				}
			}
		}
	}
}