<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="url" value="<%=request.getContextPath()%>" />
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">	
<link rel="stylesheet" href="${url }/css/myqna.css">



<div id="contents">
			<section class="mypage-box">
			
				<h1>마이 페이지</h1>
				
<nav class="lnb-box">
					<a href="${url }/mypage/myplanner" >나의 플래너</a>
					<a href="${url }/mypage/myreview" >나의 리뷰</a>
					<a href="${url }/mypage/myqna" >나의 문의 사항</a>
					<a href="${url }/mypage" >나의 정보</a>

				</nav>
				
</section>
</div>
<div class="info-box">
	<table>
		
		<thead class="board_thead">
		<tr>
			<th>No</th>
			<th>제목</th>
		</tr>
		</thead>
		<c:forEach var="vo" items="${boardList}">
		<tbody>
			<tr>
				<td>${vo.board.no }</td>
				<td class="bo__subject"><a href="${url}/board/boardList/${vo.board.no}"> ${vo.board.subject} </a></td>
			</tr>		
		<tr>
        	<c:if test="${vo.reply != null}">
        		<td>↪</td>
        		<td><a href="${url}/board/boardList/${vo.reply.no}/reply">[RE]${vo.reply.subject}</a></td>
        	</c:if>
        </tr>
		</tbody>
			
		</c:forEach>
	</table>
				<div class="bo__n__page">
		
	</div>
	
	<!-- 페이징 -->
	<ul class="paging">
		<!-- 이전페이지 -->
		<c:if test="${pvo.pageNo==1 }">
		<li>◀</li>
		</c:if>
		<c:if test="${pvo.pageNo>1 }">
		<li><a href="${url}/mypage/myqna?pageNo=${pvo.pageNo-1}<c:if test='${pvo.searchWord!=null}'>&searchWord=${pvo.searchWord}</c:if>">◀</a></li>
		</c:if>
		<!-- 페이지 번호  -->
		<c:forEach var="p" begin="${pvo.startPage}" end="${pvo.startPage+pvo.onePageCount-1}">
			<!-- 총 페이지수 보다 출력할 페이지 번호가 작을 때 -->
			<c:if test ="${p <= pvo.totalPage}">
				<c:if test="${p==pvo.pageNo }">
					<li style="font-size= 20px"><a href="${url}/mypage/myqna?pageNo=${p}">${p}</a></li>
				</c:if>
				<c:if test="${p!=pvo.pageNo }">
					<li><a href=${url}/mypage/myqna?pageNo=${p}<c:if test='${pvo.searchWord!=null}'>&searchWord=${pvo.searchWord}</c:if>>${p}</a></li>
				</c:if>
			</c:if>
		</c:forEach>
		<!-- 다음 페이지  -->
		<c:if test="${pvo.pageNo == pvo.totalPage }">
			<li>▶</li>
		</c:if>
		<c:if test="${pvo.pageNo < pvo.totalPage }">
			<li><a href="${url}/mypage/myqna?pageNo=${pvo.pageNo+1}<c:if test='${pvo.searchWord!=null}'>&searchWord=${pvo.searchWord}</c:if>">▶</a></li>
		</c:if>
	</ul>

</div>	