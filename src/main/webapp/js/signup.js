
function memberCheck(){
	let userid = document.getElementById("userid");
	if(userid.value==''){
		alert("아이디를 입력해주세요");
		userid.focus();
		return false;
	}
	
	if(document.getElementById("idchk").value=='N'){
		alert("아이디 중복검사 먼저 해주세요")
		return false;
	}
	
	
	let userpwd = document.getElementById("userpwd");
	let userpwd2 = document.getElementById("userpwd2");
	if(userpwd.value=='' || userpwd2.value==''){
		alert("비밀번호를 입력해주세요");
		userpwd.focus();
		return false;
	}
	if(userpwd.value!=userpwd2.value){
		alert("비밀번호가 일치하지 않습니다.")
		userpwd.focus();
		return false;
	}

	let userbirth = document.querySelector("#userbirth");
	if(userbirth.value==""){
		alert("생년월일을 입력해주세요")
		userbirth.focus();
		return false;
	}

    let answer = document.querySelector("#answer");
	if(answer.value==""){
		alert("비밀번호 찾기 답변을 입력해주세요.")
		answer.focus();
		return false;
	}
	
}