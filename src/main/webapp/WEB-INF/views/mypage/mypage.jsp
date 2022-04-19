<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="url" value="<%=request.getContextPath()%>" />

<<<<<<< HEAD
<link rel="stylesheet" href="${url }css/mypage.css">
=======
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">	
<link rel="stylesheet" href="${url }css/mypage.css">
<script>
 $(function(){
	$("#member_edit_btn").on("click",function(){
		if($("#userpassword").val()==''){
			alert("비밀번호를 입력후 수정하세요.");
			return false;
		}
		if($("#userpassword").val() != $("#userpassword2").val()){
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		}


			if(confirm("회원정보를 수정하시겠습니까?")){
				var userpassword = $("#userpassword").val();
				var birth = $("#date_birth").attr('data-date_birth');
				var question = $("#question").val();
				var answer = $("#answer").val();
				var grade = $("#grade").val();
				
			$.ajax({
				url: '${url}/mypage',
				type: "PUT",
				data:{
					userpassword : userpassword,
					date_birth : birth,
					question : question,
					answer : answer,
					grade : grade,
				},
				success: function(data){
					console.log(data)
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
>>>>>>> 1d3bb46e8d46820b47dcef0877a99da4f273eb62
<div id="contents">
			<section class="mypage-box">
				<h1>마이 페이지</h1>
				
<nav class="lnb-box">
<<<<<<< HEAD
					<a href="#" >나의 정보</a>
					<a href="#" >나의 리뷰</a>
					<a href="#" >나의 문의 사항</a>
					<a href="#" >나의 플래너</a>
=======
					<a href="${url }/mypage/myplanner" >나의 플래너</a>
					<a href="${url }/mypage/myreview" >나의 리뷰</a>
					<a href="${url }/mypage/myqna" >나의 문의 사항</a>   
					<a href="${url }/mypage" >나의 정보</a>
>>>>>>> 1d3bb46e8d46820b47dcef0877a99da4f273eb62

				</nav>
	
<div class="info-box">
<<<<<<< HEAD
	<div class="order-box modify">		
					<form name="myform" method="post" target="dataFrame">
					<div class="con">
						<div class="fl w-50">
							<h3>고구마님의 정보</h3>
=======
	<div class="box modify">		
					<form id="mFrm" name="myform" onsubmit="return memberCheck()" >
					<div class="con">
						<div class="fl w-50">
							<h3>📝<a class="username">${mvo.username }</a>님의 정보📝</h3>
							
>>>>>>> 1d3bb46e8d46820b47dcef0877a99da4f273eb62
							<table class="member__table">
								<caption class="hidden">아이디,이름,비밀번호,생년월일 테이블</caption>
								<tbody>
									<!--tr>
										<th>*&nbsp;&nbsp;회원유형</th>
										<td>
											hdm1234
										</td>
									</tr-->
									<tr>
										<th>*&nbsp;&nbsp;아이디</th>
										<td>
											goguma
										</td>
									</tr>
									<tr>
										<th>*&nbsp;&nbsp;이름</th>
										<td>고구마</td>
									</tr>
									<tr>
										<th class="vt">*&nbsp;&nbsp;비밀번호</th>
										<td>
											<input type="password" id="MemberPassword" name="MemberPassword" maxlength="16" placeholder="영문/숫자/특수문자 조합 8~16자 조합으로 입력해주세요." class="input__style input__size2">
											&nbsp;<em id="pwResult" style="color:#cc3333; font-style:normal; font-family:dotum; font-size:12px;"></em>&nbsp;<span class="caution">&nbsp;8 - 16자 이상 : 영문, 숫자 조합</span>
										</td>
									</tr>
									<tr class="vt">
										<th>*&nbsp;&nbsp;비밀번호 확인</th>
										<td>
<<<<<<< HEAD
											<input type="password" class="input__style input__size2" name="MemberPassword2" maxlength="16" placeholder="비밀번호를 한번 더 입력해주세요.">
											<span class="caution">&nbsp;비밀번호를 한번 더 입력해주세요.</span>
=======
											<input type="password" id="userpassword2" class="input_style" name="userpassword2"  placeholder="비밀번호를 다시 입력해주세요.">
											<span class="caution">&nbsp;</span>
>>>>>>> 1d3bb46e8d46820b47dcef0877a99da4f273eb62
										</td>
									</tr>
									<tr>
										<th>*&nbsp;&nbsp;생년월일</th>
<<<<<<< HEAD
										<td>1998-01-29</td>
									</tr>
									<tr>
										<th>*&nbsp;&nbsp;비밀번호 찾기 질문</th>
										<td>자신의 인생 좌우명은?</td>
									</tr>
									<tr>
										<th>*&nbsp;&nbsp;비밀번호 찾기 답변</th>
										<td>테스트</td>
									</tr>
									<tr>
										<th>&nbsp;&nbsp;장애 정도</th>
										<td>다음에 입력하기</td>
=======
										<td id="date_birth" data-date_birth="${mvo.date_birth}">${mvo.date_birth}</td>
									</tr>
									<tr>
										<th>*&nbsp;&nbsp;비밀번호 찾기 질문</th>
										<td>
					                    <select name="question" id="question" data-question="${mvo.question }" value="${mvo.question }">
					                        <optgroup label="비밀번호 찾기 질문을 선택해주세요">
					                            <option value="자신의 인생 좌우명은?">자신의 인생 좌우명은?</option>
					                            <option value="자신의 보물 제1호는?">자신의 보물 제1호는?</option>
					                            <option value="가장 기억에 남는 선생님 성함은?">가장 기억에 남는 선생님 성함은?</option>
					                            <option value="가장 생각나는 친구 이름은?">가장 생각나는 친구 이름은?</option>
					                            <option value="인상 깊게 읽은 책 이름은?">인상 깊게 읽은 책 이름은?</option>
					                            <option value="내가 좋아하는 캐릭터는?">내가 좋아하는 캐릭터는?</option>
					                            <option value="어릴 적 별명은?">어릴 적 별명은?</option>
					                        </optgroup>
					                    </select>
					                    </td>
									</tr>
									<tr>
										<th>*&nbsp;&nbsp;비밀번호 찾기 답변</th>
										<td>
										<input type="text" id="answer" class="input_style" name="answer" data-answer="${mvo.answer }" value="${mvo.answer }" placeholder="비밀번호 찾기 답변을 입력해주세요." >
										</td>
									</tr>
									<tr>
									<th>&nbsp;&nbsp;장애 정도</th>
									<td><select name="grade" id="grade" data-grade="${mvo.grade }" value=${mvo.grade }>
                      					<optgroup label="맞춤 할인 정보 제공을 위해 선택해주세요">
                       				      <option value=5>다음에 입력하기</option>
                            			  <option value=1>1등급</option>
                            			  <option value=2>2등급</option>
                            			  <option value=3>3등급</option>
                                          <option value=4>4등급</option>
                        				</optgroup>
                        
                    					</select>
                    				</td>
>>>>>>> 1d3bb46e8d46820b47dcef0877a99da4f273eb62
									</tr>
									
								</tbody>
							</table>
						</div>
						<div class="btn-area">
<<<<<<< HEAD
						<a class="btn__style2" href="">회원탈퇴</a>
						<a class="btn__style1" href="" onclick="updateform">정보수정</a>
=======
						<input id="member_edit_btn" type="button" value="수정하기"/>
						<a class="btn__style2" href="${url }/mypage/delete" >&nbsp;회원탈퇴&nbsp; </a>
>>>>>>> 1d3bb46e8d46820b47dcef0877a99da4f273eb62
						</div>
					</div>
					</form>
					</div>
				


</div>				
		</section>
</div>				