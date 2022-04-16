<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="url" value="<%=request.getContextPath()%>" />
<!-- 



mypage 내정보를 맨밑으로 내리고 나의 플래너를 마이페이지 main 으로 설정하기 



 -->
<link rel="stylesheet" href="${url }css/mypage.css">
<div id="contents">
			<section class="mypage-box">
				<h1>마이 페이지</h1>
				
<nav class="lnb-box">
					<a href="${url }/mypage" >나의 정보</a>
					<a href="${url }/mypage/myreview" >나의 리뷰</a>
					<a href="#" >나의 문의 사항</a>
					<a href="#" >나의 플래너</a>

				</nav>
	
<div class="info-box">
	<div class="box modify">		
					<form name="myform" method="post" acction="">
					<div class="con">
						<div class="fl w-50">
							<h3>${vo.username} 님의 정보</h3>
							
							<table class="member__table">
								
								<tbody>
									<tr>
										<th>*&nbsp;&nbsp;아이디</th>
										<td>
											${vo.member.userid }
										</td>
									</tr>
									<tr>
										<th>*&nbsp;&nbsp;이름</th>
										<td>${vo.username}</td>
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
											<input type="password" class="input_style" name="userpassword2"  placeholder="비밀번호를 한번 더 입력해주세요.">
											<span class="caution">&nbsp;</span>
										</td>
									</tr>
									<tr>
										<th>*&nbsp;&nbsp;생년월일</th>
										<td>${vo.date_birth}</td>
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
						<a class="btn__style1" href="" onclick="updateform">정보수정</a>
						<a class="btn__style2" href="${url }/mypage/delete" >회원탈퇴</a>
						</div>
					</div>
					</form>
					</div>
				


</div>				
		</section>
</div>				
