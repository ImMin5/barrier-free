<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="url" value="<%=request.getContextPath()%>" />

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
		<c:forEach var="vo" items="${boardList}">
		<thead class="board_thead">
		<tr>
			<th>No</th>
			<th>제목</th>
		</tr>
		</thead>
		<tbody>
			<tr>
				<td>${vo.board.no }</td>
				<td class="bo__subject"><a href="${url}/board/boardList/${vo.board.no}"> ${vo.board.subject} </a></td>
			</tr>		
		<tr>
        	<c:if test="${vo.reply != null}">
        		<td>${vo.reply.no}</td>
        		<td><a href="${url}/board/boardList/${vo.reply.no}">[RE]${vo.reply.subject}</a></td>
        		<td> ${vo.reply.userid}</td>
        	</c:if>
        </tr>
		</tbody>
			
		</c:forEach>
	</table>
	

</div>	