<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="${$}/css/board.css">
   

   
    <div id="b__table">
    	<h2>공지/문의사항</h2>
    	<table>
    		<tr>
    			<td colspan="3" style="border:white;text-align:right;"><a href="/board/boardList/form">글 작성하기</a></td>
    		</tr>
    		<tr>
    			<th>글번호</th>
    			<th>글제목</th>
    			<th>작성자</th>

    		</tr>
			<c:forEach var="vo" items="${boardList}">
				<tr>
					<td>${vo.no}</td>
					<td><a href="/board/boardList/${vo.no}">${vo.subject}</a></td>
					<td>${vo.userid}</td>
				</tr>				
			</c:forEach>
    	</table>
    
    <div class="pageInfo_wrap" >
        <div class="pageInfo_area">
        	<ul id="pageInfo" class="pageInfo">
        	
        	 <!-- 각 번호 페이지 버튼 -->
                <c:forEach var="pvo" begin="${pvo.startPage}" end="${pvo.startPage}">
                    <li class="pageInfo_btn"><a href="${pvo.num}">${pvo.num}</a></li>
                </c:forEach>
 			</ul>
        </div>
    </div>
    	
	    
</div>