<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="url" value="<%=request.getContextPath()%>" />
<!-- 



mypage 내정보를 맨밑으로 내리고 나의 플래너를 마이페이지 main 으로 설정하기 



 -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">	
<link rel="stylesheet" href="${url }css/mypage.css">
<script>
 $(function(){
	$("#mFrm").submit(function(){
		if($("#userpassword").val()==''){
			alert("비밀번호를 입력후 수정하세요.");
			return false;
		}
		if($("#userpassword").val() != $("#userpassword2").val()){
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		}


		return true;
		});	
	});
</script>
<div id="contents">
			<section class="mypage-box">
				<h1>마이 페이지</h1>
				
<nav class="lnb-box">
					<a href="${url }/mypage/myplanner" >나의 플래너</a>
					<a href="${url }/mypage/myreview" >나의 리뷰</a>
					<a href="${url }/mypage/myqna" >나의 문의 사항</a>
					<a href="${url }/mypage" >나의 정보</a>

				</nav>
	
<div class="info-box">
	<div class="box modify">		
					<form id="mFrm" name="myform" method="post" action="/mypage" onsubmit="return memberCheck()" >
					<div class="con">
						<div class="fl w-50">
							<h3><a class="username">${mvo.username }</a>님의 정보</h3>
							
							<table class="member__table">
								
								<tbody>
									<tr>
										<th>*&nbsp;&nbsp;아이디</th>
										<td>
											${mvo.userid }
										</td>
									</tr>
									<tr>
										<th>*&nbsp;&nbsp;이름</th>
										<td>${mvo.username }</td>
									</tr>
									<tr>
										<th class="vt">*&nbsp;&nbsp;비밀번호</th>
										<td>
											<input type="password" id="userpassword" name="userpassword"  placeholder="비밀번호를 입력해주세요" class="input_style">
											&nbsp;&nbsp;<span class="caution">&nbsp; </span>
										</td>
									</tr>
									<tr class="vt">
										<th>*&nbsp;&nbsp;비밀번호 확인</th>
										<td>
											<input type="password" id="userpassword2" class="input_style" name="userpassword2"  placeholder="비밀번호를 한번 더 입력해주세요.">
											<span class="caution">&nbsp;</span>
										</td>
									</tr>
									<tr>
										<th>*&nbsp;&nbsp;생년월일</th>
										<td>${mvo.date_birth}</td>
									</tr>
									<tr>
										<th>*&nbsp;&nbsp;비밀번호 찾기 질문</th>
										<td>${mvo.question }</td>
									</tr>
									<tr>
										<th>*&nbsp;&nbsp;비밀번호 찾기 답변</th>
										<td>${mvo.answer }</td>
									</tr>
									<tr>
									<th>&nbsp;&nbsp;장애 정도</th>
									<td><select name="grade" id="grade" value=${mvo.grade }>
                      					<optgroup label="맞춤 할인 정보 제공을 위해 선택해주세요">
                       				      <option value=5>다음에 입력하기</option>
                            			  <option value=1>1등급</option>
                            			  <option value=2>2등급</option>
                            			  <option value=3>3등급</option>
                                          <option value=4>4등급</option>
                        				</optgroup>
                        
                    					</select>
                    				</td>
									</tr>
									
								</tbody>
							</table>
						</div>
						
						<div class="btn-area">
						<input id="button" type="submit" value="수정하기"/>
						<a class="btn__style2" href="${url }/mypage/delete" >&nbsp;회원탈퇴&nbsp; </a>
						</div>
					</div>
					</form>
					</div>
				


</div>				
		</section>
</div>				
