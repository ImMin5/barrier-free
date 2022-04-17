<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="url" value="<%=request.getContextPath()%>" />

<link rel="stylesheet" href="${url }/css/delete.css" />

<script type="text/javascript">
	$(document).ready(function(e){
		$('#secession').click(function(){
			
			//패스워드 입력 확인
			if($('#userpassword').val() == ''){
				alert("패스워드를 입력해 주세요.");
				$('#userpassword').focus();
				return false;
			}else if($('#userpassword2').val() == ''){
				alert("패스워드를 입력해 주세요.");
				$('#userpassword2').focus();
				return false;
			}
			
			//입력한 패스워드가 같은지 체크
			if($('#userpassword2').val() != $('#userpassword').val()){
				alert("패스워드가 일치하지 않습니다.");
				$('#userpassword2').focus();
				return false;
			}
			
			
			return false;
			//패스워드 맞는지 확인
			if(confirm("정말 삭제하시겠습니까?")){
				var userpassword = $("#userpassword").val();
			$.ajax({
				url: '${url}/mypage/delete',
				type: "DELETE",
				data:{
					userpassword : userpassword,
				},
				success: function(data){
					alert(data.msg);
				},
				error: function(){
					alert("서버 에러.");
				}
			});
			}else{
				return false;
			}
		});
	});
</script>

<div>
	<h1>회원탈퇴</h1>
	<hr />
	<div id="deleteacc">
	<form id="deleteaccFrm"  name="delFrm" id="delFrm" >
		
		<ul>
			<li><img id="deletelogo" src="#"></li>
			
				<li><input type="password" name="userpassword" id="userpassword"></li>
			
		
				
				<li><input type="password" name="userpassword" id="userpassword2"></li>
				<button id="secession">탈퇴하기</button>
				
		</ul>
	</form>
	
	</div>
	
</div>
<hr/>