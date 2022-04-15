<<<<<<< HEAD
	function logFormCheck(){
=======
	function logFormCheck(){ 
>>>>>>> e164e9eb165a26e6fae1a0c21b9616ac77bfe6e4

		var id = document.getElementById("userid");
		if(document.getElementById("userid").value==""){
			alert("아이디를 입력하세요.")	;
			id.focus();
			return false;
		}
		if(document.querySelector("#userpwd").value==""){
			alert("비밀번호를 입력하세요.");
			document.querySelector("#userpwd").focus();
			return false;
		}
	 
		document.getElementById("logFrm").submit();
	}
