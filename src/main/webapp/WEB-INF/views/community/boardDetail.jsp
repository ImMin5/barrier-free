<link rel="stylesheet" href="${url}/css/board.css">
   <div id="bo__table" class="bo__table">
        <c:if test="${is_notice == true}">
        	<h1 class="bd__title">π© κ³΅μ§μ¬ν­ π©</h1> 
        </c:if>
        <c:if test="${is_notice == null}">
        	<h1 class="bd__title">π λμ κ²μκΈ π</h1>   
        </c:if>
      

   <form method="post" action="${url}/board/boardList/${bvo.no}/edit" id="boardFrm" class="bd__Frm">
            <table>
            	
                <tr>
                	<input type="hidden" name="no" value="${bvo.no}">
                	<input type="hidden" name="userid" value="${bvo.userid}">
                	<input type="hidden" name="subject" value="${bvo.subject}">
                    <th class="bd__tb__sub">μ λͺ©</th>
                    <c:if test="${bvo != null && bvoReply == null}">
                       <td>${bvo.subject}</td>
                    </c:if>
                    <c:if test="${bvoReply != null}">
                       <td>${bvoReply.subject}</td>
                    </c:if>
                </tr>
                <c:if test="${bvoReply != null }">
                   <tr>
                      <th>λ¬Έμ μμ±μ</th>
                      <td>${bvo.userid}</td>
                   </tr>
                </c:if>
                <c:if test="${bvoReply == null }">
                   <tr>
                      <th>μμ±μ</th>
                      <td>${bvo.userid}</td>
                   </tr>
                </c:if>
                <tr>
                    <th>λ¬Έμ λ΄μ©</th>
                    <td>${bvo.content}</td>
                </tr>
                <c:if test="${bvoReply != null }">
                   <tr>
                       <th>λ΅λ³ λ΄μ©</th>
                       <td>${bvoReply.content}</td>
                   </tr>
                </c:if>
                 
            </table>
            <c:if test="${adminStatus == 'Y'}">
            	<input class="bo__btn__m" id="reply_btn" type="button" onclick="location.href='${url}/admin/boardList/formReply/${bvo.no}'" value="λ΅λ³νκΈ°">
            </c:if>
            <c:if test="${adminStatus != 'Y' }">
               <input class="bo__btn__m" type="submit" value="μμ ">
            </c:if>
            <c:if test="${adminStatus == 'Y' }">
           		<input class="bo__btn__mb" type="button" value="λͺ©λ‘μΌλ‘" onclick="location.href='${url}/admin/boardList'">
            </c:if>
             <c:if test="${adminStatus == null }">
           		<input class="bo__btn__mb" type="button" value="λͺ©λ‘μΌλ‘" onclick="location.href='${url}/board/boardList'">
            </c:if>
           
            
        </form>
    </div>