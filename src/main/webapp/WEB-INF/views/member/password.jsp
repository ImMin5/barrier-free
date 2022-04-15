<<<<<<< HEAD

=======
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="url" value="<%=request.getContextPath()%>" />  
>>>>>>> e164e9eb165a26e6fae1a0c21b9616ac77bfe6e4

<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">	
<link rel="stylesheet" href="${url }css/password.css">


<script>
$(document).on('click','#findPwd',function(event){
	event.preventDefault();
	var userid = $("#userid").val();
	var question = $("#question").val();
	var answer = $("#answer").val();
	
	$.ajax({
        url:'${url}/infopwd',
        type:'POST',
        data: {
        	userid:userid,
        	question:question,
       		answer:answer
        },
        dataType : "json",

        success:function(data){
        	console.log(data);
  			if(data.newpassword =="" || typeof data.newpassword =="undefined"){
  				alert("일치하는 정보가 없습니다.")
  			}else{
  				alert(userid+"님의 비밀번호는 "+data.newpassword+"로 초기화되었습니다.\n반드시 로그인 후 비밀번호를 변경해주세요!");
  				location.href=data.redirect;
  			}
  			
        },
        error: function (error){
			
        	alert('정보를 다시 입력해주시길 바랍니다.' );
        	
        }
    });
});

</script>

<div>
	<hr/>
	<div id="findid">
	
		<form id="findidFrm">
			<ul>
				
<<<<<<< HEAD
				<li><img id=findidlogo src="${url }/img/bf_logo_password.png"></li>
=======
				<li><img id=findidlogo src="${url }/img/member/bf_logo_password.png"></li>
>>>>>>> e164e9eb165a26e6fae1a0c21b9616ac77bfe6e4
				
			 	<li><input type="text" name="userid" id="userid" placeholder="아이디를 입력해주세요."/></li>
                    <select name="question" id="question">
                        <optgroup label="비밀번호 찾기 질문을 선택해주세요">
<<<<<<< HEAD
                            <option value="q1">자신의 인생 좌우명은?</option>
                            <option value="q2">자신의 보물 제1호는?</option>
                            <option value="q3">가장 기억에 남는 선생님 성함은?</option>
                            <option value="q4">가장 생각나는 친구 이름은?</option>
                            <option value="q5">인상 깊게 읽은 책 이름은?</option>
                            <option value="q6">내가 좋아하는 캐릭터는?</option>
                            <option value="q7">어릴 적 별명은?</option>
=======
                            <option value="자신의 인생 좌우명은?">자신의 인생 좌우명은?</option>
                            <option value="자신의 보물 제1호는?">자신의 보물 제1호는?</option>
                            <option value="가장 기억에 남는 선생님 성함은?">가장 기억에 남는 선생님 성함은?</option>
                            <option value="가장 생각나는 친구 이름은?">가장 생각나는 친구 이름은?</option>
                            <option value="인상 깊게 읽은 책 이름은?">인상 깊게 읽은 책 이름은?</option>
                            <option value="내가 좋아하는 캐릭터는?">내가 좋아하는 캐릭터는?</option>
                            <option value="어릴 적 별명은?">어릴 적 별명은?</option>
>>>>>>> e164e9eb165a26e6fae1a0c21b9616ac77bfe6e4
                        </optgroup>
                    </select>
                    <li><input type="text" name="answer" id="answer" placeholder="비밀번호 찾기 답변을 입력해주세요." /></li>
			 	<button id="findPwd">비밀번호 찾기</button>
			 	
			</ul>
			<div id="line"><hr/></div>
			<div class="forgotpwd">
                아이디를 잊으셨나요?<a href="${url }/infoid"> 아이디 찾기 </a>
            </div>
           
		</form>
	</div>
</div>
 <hr/>
