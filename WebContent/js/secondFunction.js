//数据表复选框选择控制
function controlChoice(checkValue,checkName){
	var checkObj=document.getElementsByName(checkName);
	if(checkValue=="Hide"){
		for(var i=0;i<checkObj.length;i++){
			if(checkObj[i].value=="Hide"){
				if(checkObj[i].checked==true){
					for(var j=0;j<checkObj.length;j++){
						if(checkObj[j].value!="Hide"){
							checkObj[j].checked=false;
							checkObj[j].disabled=true;
						}
					}
				}
				else{
					for(var j=0;j<checkObj.length;j++){
						if(checkObj[j].value!="Hide"){
							checkObj[j].disabled=false;
						}
					}
				}
			}
		}
	}
	else if(checkValue=="OnlyRead"){
		for(var i=0;i<checkObj.length;i++){
			if(checkObj[i].value=="OnlyRead"){
				if(checkObj[i].checked==true){
					for(var j=0;j<checkObj.length;j++){
						if(checkObj[j].value=="Modify"){
							checkObj[j].checked=false;
							checkObj[j].disabled=true;
						}
					}
				}
				else{
					for(var j=0;j<checkObj.length;j++){
						if(checkObj[j].value=="Modify"){
							checkObj[j].disabled=false;
						}
					}
				}
			}
		}
	}
}