<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="url" value="<%=request.getContextPath()%>" />

<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">	
<link rel="stylesheet" href="${url }/css/myreview.css" />
<div id="contents">
			<section class="mypage-box">
				<h1>마이 페이지</h1>
				
<nav class="lnb-box">
					<a href="${url }/mypage" >나의 정보</a>
					<a href="${url }/mypage/myreview" >나의 리뷰</a>
					<a href="#" >나의 문의 사항</a>
					<a href="#" >나의 플래너</a>

				</nav>
</section>
</div>			
<div class="myreview-box">
	<table>
		<c:forEach var="vo" items="${review }">
		<thead class="review_thead" >
		
		<tr>
			
			<td>여행지</td>
			
		</tr>
		</thead>
		<tbody>
			
			<tr class="review_tr">
				<td>
					<th>${vo.write_date }</th>
					<th><img src="${url }/img/map/map_01.png">${vo.score }</th>
				</td>
			</tr>
			<tr>
				<td>${vo.content }</td>
			</tr>
			</c:forEach>
		</tbody>
	
	</table>

</div>