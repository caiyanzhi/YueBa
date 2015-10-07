function editUser(edit){
	document.location = "./editUser.jsp?type="+edit;//1：编辑资料，2：修改密码
}

function backHome(){
	document.location = "./home.jsp";
}

function checkTwoPassword(){
	var pwd1 = document.getElementById("password");
	pwd1 = pwd1.value;
	var pwd2 = document.getElementById("password2")
	pwd2 = pwd2.value;
	var oldPwd = document.getElementById("oldpassword");
	oldPwd  = oldPwd.value;
	if(oldPwd == "" || pwd1 == "" || pwd2 == ""){
		alert("请补全密码");
		return false;
	}
	else if(pwd1 != pwd2){
		alert("两次输入密码不一致");
		return false;
	}
	else{
		return true;
	}
}

function checkNewInfo(){
	var describe = document.getElementById("describe");
	describe = describe.value;
	var username = document.getElementById("username")
	username = username.value;
	if(describe != "" && username != ""){
		return true;
	}
	else{
		alert("请补全信息");
		return false;
	}
}