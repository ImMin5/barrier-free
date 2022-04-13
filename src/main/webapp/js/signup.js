
function memberCheck(){
	let userid = document.getElementById("userid");
	if(userid.value==''){
		alert("아이디를 입력해주세요.");
		userid.focus();
		return false;
	}
	
	if(document.getElementById("idchk").value=='N'){
		alert("사용할 수 없는 아이디 입니다.")
		return false;
	}
	
	
	let userpwd = document.getElementById("userpwd");
	let userpwd2 = document.getElementById("userpwd2");
	if(userpwd.value=='' || userpwd2.value==''){
		alert("비밀번호를 입력해주세요.");
		userpwd.focus();
		return false;
	}
	if(userpwd.value!=userpwd2.value){
		alert("비밀번호가 일치하지 않습니다.")
		userpwd.focus();
		return false;
	}
	
	let username = document.querySelector("#username");
	if(username.value==''){
		alert("성함을 입력해주세요.")
		username.focus();
		return false;
	}
	

	let userbirth = document.querySelector("#userbirth");
	if(userbirth.value==''){
		alert("생년월일을 입력해주세요.")
		userbirth.focus();
		return false;
	}
	
	let birth = document.querySelector("#userbirth").value;
		
	reg = /^[0-9]{2}[01][0-9][0-3][0-9]$/
	if(!reg.test(birth)){
		alert("생년월일을 예시에 맞게 입력해주세요.(예: 980121)");
		document.getElementById("userbirth").focus();
		return false;
	}

    let answer = document.querySelector("#answer");
	if(answer.value==''){
		alert("비밀번호 찾기 답변을 입력해주세요.")
		answer.focus();
		return false;
	}
	
	let chk = document.querySelector("#termcheck").checked;
	if(!chk){
		alert("약관에 동의해 주세요.")
		return false;
	}
	

	
}