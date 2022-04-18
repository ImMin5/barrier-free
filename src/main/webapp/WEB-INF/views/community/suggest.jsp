
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<link rel="stylesheet" href="${url}/css/suggest.css">

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

<div class="suggest__title">
	<h1> 📄 건의할래요 📄</h1>
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
        		<td>${vo.subject}</td>
        		<td>${vo.userid}</td>
        </tr>
        </c:forEach>
 		<c:forEach var="vo" items="${boardList}">
         <tr>
            <td>${vo.board.no}</td>
            <td class="bo__subject"><a href="${url}/board/boardList/${vo.board.no}"> ${vo.board.subject} </a></td>
            <td>${vo.board.userid}</td>
        </tr>

        <tr>
        	<c:if test="${vo.reply != null}">
        		<td>${vo.reply.no}</td>
        		<td><a href="${url}/board/boardList/${vo.reply.no}">[RE]${vo.reply.subject}</a></td>
        		<td> ${vo.reply.userid}</td>
        	</c:if>
        </tr>
        </c:forEach> 
    </tbody>
</table>


<div class="bo__container">
	<button class="bo__btn__w" type="submit" onclick="location.href='${url}/suggest/suggestWrite'">글 작성</button>
	<div class="bo__n__page">
		현재 페이지 ${pvo.pageNo}/ ${pvo.totalPage }
	</div>
	
