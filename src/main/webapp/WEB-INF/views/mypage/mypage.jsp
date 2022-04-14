<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="url" value="<%=request.getContextPath()%>" />

<link rel="stylesheet" href="${url }css/mypage.css">
<div id="contents">
			<section class="mypage-box">
				<h1>마이 페이지</h1>
				
<nav class="lnb-box">
					<a href="#" >나의 정보</a>
					<a href="#" >나의 리뷰</a>
					<a href="#" >나의 문의 사항</a>
					<a href="#" >나의 플래너</a>

				</nav>
	
<div class="info-box">
	<div class="order-box modify">		
					<form name="myform" method="post" target="dataFrame">
					<div class="con">
						<div class="fl w-50">
							<h3>고구마님의 정보</h3>
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
											<input type="password" class="input__style input__size2" name="MemberPassword2" maxlength="16" placeholder="비밀번호를 한번 더 입력해주세요.">
											<span class="caution">&nbsp;비밀번호를 한번 더 입력해주세요.</span>
										</td>
									</tr>
									<tr>
										<th>*&nbsp;&nbsp;생년월일</th>
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
									</tr>
									
								</tbody>
							</table>
						</div>
						<div class="btn-area">
						<a class="btn__style2" href="">회원탈퇴</a>
						<a class="btn__style1" href="" onclick="updateform">정보수정</a>
						</div>
					</div>
					</form>
					</div>
				


</div>				
		</section>
</div>				