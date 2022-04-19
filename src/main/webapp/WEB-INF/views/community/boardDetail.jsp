<link rel="stylesheet" href="${url}/css/board.css">


   <div id="bo__table" class="bo__table">
   <h1 class="bd__title">👇 나의 게시글 👇</h1>
   <form method="post" action="${url}/board/boardList/edit/${bvo.no}" id="boardFrm" class="bd__Frm">
            <table>
                <tr>
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
            <c:if test="${bvoReply == null }">
               <input class="bo__btn__m" type="submit" value="수정">
            </c:if>
            
            <input class="bo__btn__mb" type="button" value="목록으로" onclick="location.href='${url}/board/boardList'">
        </form>
    </div>