<link rel="stylesheet" href="${url}/css/board.css">
   <div id="bo__table" class="bo__table">
        <c:if test="${is_notice == true}">
        	<h1 class="bd__title">🚩 공지사항 🚩</h1> 
        </c:if>
        <c:if test="${is_notice == null}">
        	<h1 class="bd__title">👇 나의 게시글 👇</h1>   
        </c:if>
      

   <form method="post" action="${url}/board/boardList/${bvo.no}/edit" id="boardFrm" class="bd__Frm">
            <table>
            	
                <tr>
                	<input type="hidden" name="no" value="${bvo.no}">
                	<input type="hidden" name="userid" value="${bvo.userid}">
                	<input type="hidden" name="subject" value="${bvo.subject}">
                    <th class="bd__tb__sub">제목</th>
                    <c:if test="${bvo != null && bvoReply == null}">
                       <td>${bvo.subject}</td>
                    </c:if>
                    <c:if test="${bvoReply != null}">
                       <td>${bvoReply.subject}</td>
                    </c:if>
                </tr>
                <c:if test="${bvoReply != null }">
                   <tr>
                      <th>문의 작성자</th>
                      <td>${bvo.userid}</td>
                   </tr>
                </c:if>
                <c:if test="${bvoReply == null }">
                   <tr>
                      <th>작성자</th>
                      <td>${bvo.userid}</td>
                   </tr>
                </c:if>
                <tr>
                    <th>문의 내용</th>
                    <td>${bvo.content}</td>
                </tr>
                <c:if test="${bvoReply != null }">
                   <tr>
                       <th>답변 내용</th>
                       <td>${bvoReply.content}</td>
                   </tr>
                </c:if>
                 
            </table>
            <c:if test="${adminStatus == 'Y'}">
            	<input class="bo__btn__m" id="reply_btn" type="button" onclick="location.href='${url}/admin/boardList/formReply/${bvo.no}'" value="답변하기">
            </c:if>
            <c:if test="${adminStatus != 'Y' }">
               <input class="bo__btn__m" type="submit" value="수정">
            </c:if>
            <c:if test="${adminStatus == 'Y' }">
           		<input class="bo__btn__mb" type="button" value="목록으로" onclick="location.href='${url}/admin/boardList'">
            </c:if>
             <c:if test="${adminStatus == null }">
           		<input class="bo__btn__mb" type="button" value="목록으로" onclick="location.href='${url}/board/boardList'">
            </c:if>
           
            
        </form>
    </div>