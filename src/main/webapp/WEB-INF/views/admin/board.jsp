
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<link rel="stylesheet" href="${url}/css/board.css">

<script>
	$(function(){
		$("#searchFrm").submit(function(){
			if($("#searchWord").val()== ""){
				alert("검색어를 입력하세요");
				return false;
			}
		});
	});

</script>

<div class="bo__title">
	<h1> 📄 공지/문의 사항 📄</h1>
</div>


<!-- 검색 -->
<div class="bo__tatble__top">
	<form method="get" action="" id="searchFrm">
		<select name="searchKey" class="bo__search">
			<option value="subject">제목</option>
			<option value="content">글 내용</option>
			<option value="userid">작성자</option>
		</select>
		<input type="text" name="searchWord" id="searchWord"/>
		<input type="submit" value="Search" class="bo__btn"/>
		<button class="bo__btn__w" type="button" onclick="location.href='${url}/admin/boardList/form'">공지등록</button>
		
	</form>
</div>

<table class="bo__table">
    <thead>
       <tr>
            <th>No</th>
            <th>제목</th>
            <th>작성자</th>
         </tr>
    </thead>
    <tbody class="bd_t" id="bd_t">
     	<c:forEach var="vo" items="${noticeList}">
        <tr class="bo__notice">
        		<td >공지</td>
        		<td><a href="${url}/admin/boardList/${vo.no}">${vo.subject}</a></td>
        		<td>${vo.userid}</td>
        </tr>
        </c:forEach>
 		<c:forEach var="vo" items="${boardList}">
         <tr>
            <td>${vo.board.no}</td>
            <td class="bo__subject"><a href="${url}/admin/boardList/${vo.board.no}"> ${vo.board.subject} </a></td>
            <td>${vo.board.userid}</td>
        </tr>

        <tr>
        	<c:if test="${vo.reply != null}">
        		<td>↪</td>
        		<td><a href="${url}/admin/boardList/${vo.reply.no}/reply">[RE]${vo.reply.subject}</a></td>
        		<td> ${vo.reply.userid}</td>
        	</c:if>
        </tr>
        </c:forEach> 
    </tbody>
</table>


<div class="bo__container">
	<div class="bo__n__page">
		현재 페이지 ${pvo.pageNo}/ ${pvo.totalPage }
	</div>
	
	<!-- 페이징 -->
	<ul class="paging">
		<!-- 이전페이지 -->
		<c:if test="${pvo.pageNo==1 }">
		<li>prev</li>
		</c:if>
		<c:if test="${pvo.pageNo>1 }">
		<li><a href="${url}/board/boardList?pageNo=${pvo.pageNo-1}<c:if test='${pvo.searchWord!=null}'>&searchWord=${pvo.searchWord}</c:if>">prev</a></li>
		</c:if>
		<!-- 페이지 번호  -->
		<c:forEach var="p" begin="${pvo.startPage}" end="${pvo.startPage+pvo.onePageCount-1}">
			<!-- 총 페이지수 보다 출력할 페이지 번호가 작을 때 -->
			<c:if test ="${p <= pvo.totalPage}">
				<c:if test="${p==pvo.pageNo }">
					<li style="font-size= 20px"><a href="${url}/board/boardList?pageNo=${p}">${p}</a></li>
				</c:if>
				<c:if test="${p!=pvo.pageNo }">
					<li><a href=${url}/board/boardList?pageNo=${p}<c:if test='${pvo.searchWord!=null}'>&searchWord=${pvo.searchWord}</c:if>>${p}</a></li>
				</c:if>
			</c:if>
		</c:forEach>
		<!-- 다음 페이지  -->
		<c:if test="${pvo.pageNo == pvo.totalPage }">
			<li>next</li>
		</c:if>
		<c:if test="${pvo.pageNo < pvo.totalPage }">
			<li><a href="${url}/board/boardList?pageNo=${pvo.pageNo+1}<c:if test='${pvo.searchWord!=null}'>&searchWord=${pvo.searchWord}</c:if>">next</a></li>
		</c:if>
	</ul>
</div>

