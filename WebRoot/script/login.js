
function regSubmit(){
 	var username = document.getElementById("username");
	username = username.value;
	var account = document.getElementById("account");
	account = account.value;
	var describe = document.getElementById("describe");
	describe = describe.value;
	var pwd1 = document.getElementById("password");
	pwd1 = pwd1.value;
	var pwd2 = document.getElementById("password2")
	pwd2 = pwd2.value;
	if(username != "" && account != "" &&
		describe != "" && pwd1 != ""){
		if(pwd1 != pwd2){
			alert("两次输入的密码不一致");
			return false;
		}
		else{
			return true;
		}
	}
	else{
		alert("请补全所有信息");
		return false;
	}
}

function registerOnload(statue){
}

function loginOnSubmit(){
	var account = document.getElementById("account");
	account = account.value;
	var pwd1 = document.getElementById("password");
	pwd1 = pwd1.value;
	if(account == "" || pwd1 == ""){
		alert("账号密码不能为空");
		return false;
	}
	return true;
}