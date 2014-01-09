

function checkSelect(id){
	
	var imgclick=document.getElementById(id);
	var divselect=document.getElementById(id+"div");
	var padding1=imgclick.style.padding;
	//alert(padding1);
	if(imgclick.value=="false"){
		
		try{
			imgclick.setAttribute("style","width:145px;padding:"+padding1+";") ; 
			imgclick.value="true";
			divselect.style.backgroundColor="RGB(255,0,0)";
			//alert(imgclick.value);
		}catch(e){
			alert("img1 error");
		}
	}else{
		try{
			imgclick.setAttribute("style","width:145px;padding:"+padding1+";") ; 
			imgclick.value="false";
			divselect.style.backgroundColor="#FFFFFF";
		}catch(e){
			alert("img2 error");
		}
	}
	
}

function Selectall(){
	var cb=document.getElementById("cball");
	var imgs=document.getElementsByName("showed");
	if(cb.checked==true){
		for(var i=0;i<imgs.length;i++){
			imgs[i].value="false";
			var id=imgs[i].id;
			checkSelect(id);
			
	
		}
		
	}else{
		for(var i=0;i<imgs.length;i++){
			imgs[i].value="true";
			var id=imgs[i].id;
			checkSelect(id);
			
		}
	}
} 



function nextItem(s_id,email){
	
	//var username=a;
	//要比较的邮票id
	//var s_id=1;
	//将选中的数据传给数据库
	var data="";
	var imgall=document.getElementsByName("showed");
	for(var j=0;j<imgall.length;j++){
		if(imgall[j].value=="true"){
			data=data+imgall[j].id+",";
		}
	}
	if(data!=""){
		//alert(data);
		var request_check=createXmlHttpRequest();
		request_check.open("post","Selectstamp.do?selectedstamp="+data+"&s_id="+s_id+"&email="+email);
		request_check.send();
		request_check.onreadystatechange=function(){
			if(request_check.readyState==4){
				if(request_check.status==200){
					var value=request_check.responseText;
					if(value=="true"){
						//如果在后面加_self则不会打开新页面
						window.open("index.jsp","_self");
						//alert("success");
						/* var request_nextpage=createXmlHttpRequest_1();
						request_nextpage.open("post","NextPageServlet?u="+data+"&s_id="+s_id);
						request_nextpage.send();
						request_nextpage.onreadystatechange=function(){
							if(request_nextpage.readyState==4){
								if(request_nextpage.status==200){
									var value1=request_nextpage.responseText;
									if(value1=="true"){
										
									}else{
										alert("fail1");
									}
								}
							}
							
						} */
						
					}else{
						alert("fail");
					}
					
				}
				
			}
		}
		
	}else{
		window.open("index.jsp","_self");
	}
	
	
}



//通过id得到对象
function $(id) {
    return document.getElementById(id);
}


//声明一个包含img和title的div
function addDiv(img_id,img_url,img_height,imgWidth) {
    //数组下标的随机值---要改为从数据库中获得数据
    //var ran = Math.round(Math.random() * (imgArray.length - 1));
    //title层
    var img_id_rec=img_id;
    var img_url_rec="stamp_img/"+img_url;
    var paddingUp=(220-parseInt(img_height))/2;
    //内部img
    var img = document.createElement("img");
    img.alt = "";
    img.name="showed";
    img.id=img_id_rec;
   
    img.src=img_url_rec;
    img.style.width = imgWidth;
    //img.style.marginTop=(220-parseInt(img_height))/2+"px";
    img.style.padding=paddingUp+"px 27px";
    img.value="false";
  
    
    //包含img的层
    var div = document.createElement("div");
    div.className = "content";
    div.id=img_id_rec+"div";
    div.appendChild(img);
    img.onclick=function(){checkSelect(img_id_rec);}
    
    return div;
}

function addDivRow(rownow){
	var rn=rownow;
	var small_div = document.createElement("div");
	small_div.innerHTML =rn;
	
	var div_r = document.createElement("div");
	div_r.className = "content1";
	div_r.appendChild(small_div);
	return div_r;
}



//从服务器获得数据
function addData(rowNow,nowData,rowCount,imgWidth,div1,div2,div3,div4,divrow,nextpage,dataNum){
	try{
		
		var request_showedData=createXmlHttpRequest();
    	request_showedData.open("post","getFourData?sd="+nowData);
    	request_showedData.send();
    	request_showedData.onreadystatechange=function(){
			if(request_showedData.readyState==4){
				if(request_showedData.status==200){
					var value_showedData=request_showedData.responseText;
					
					var stampArr=value_showedData.split("|");
					
					//alert(dataNum+","+rowCount);
					if(rowNow<=rowCount){
						try{
							var div_row=addDivRow(rowNow);
							divrow.appendChild(div_row);
							rowNow=rowNow+1;
							
							if(stampArr[0]!=""){
    							var dataArr_0=stampArr[0].split(",");
    							var div_1=addDiv(dataArr_0[0],dataArr_0[1],dataArr_0[2],imgWidth);
    							div1.appendChild(div_1);
    						}else{
    							//var div_1=addDiv("error","fail.jpg");
    						}
    						if(stampArr[1]!=""){
    							var dataArr_1=stampArr[1].split(",");
    							var div_2=addDiv(dataArr_1[0],dataArr_1[1],dataArr_1[2],imgWidth);
    							div2.appendChild(div_2);
    						}else{
    							//var div_2=addDiv("error","fail.jpg");
    						}
    						if(stampArr[2]!=""){
    							var dataArr_2=stampArr[2].split(",");
    							var div_3=addDiv(dataArr_2[0],dataArr_2[1],dataArr_2[2],imgWidth);
    							div3.appendChild(div_3);
    						}else{
    							//var div_3=addDiv("error","fail.jpg");
    						}
    						if(stampArr[3]!=""){
    							var dataArr_3=stampArr[3].split(",");
    							var div_4=addDiv(dataArr_3[0],dataArr_3[1],dataArr_3[2],imgWidth);
    							div4.appendChild(div_4);
    						}else{
    							
    						}
							
							setTimeout(function () {
			                	if(nowData<(dataNum-4)){
    			                	
    			                	 addData(rowNow,nowData+4,rowCount,imgWidth,div1,div2,div3,div4,divrow,nextpage,dataNum);
    			                 }else{
    			                	
    			                	 nextpage.style.display="block";
    			                 }
			                 
			                  }, 500);
						
						}catch(e){
						
						}
					}
					
				}
				
			}
		} 
	}catch(e){
		alert("error");
	}
	//nowData=nowData+4;
	//return value_showedData;
}