<link rel="stylesheet" href="${$}/css/board.css">


   <div id="#b__table">
   <form method="post" action="${url}/board/boardList/form/" id="boardFrm">
            <table>
                <tr>
                    <th>제목</th>
                    <td>${bvo.subject}</td>
                </tr>
                <tr>
                    <th>아이디</th>
                    <td>${bvo.userid}</td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td>${bvo.content}</td>
                </tr>
            </table>
            <input class="btn" type="submit" value="수정">
            <input class="btn" type="button" value="삭제" onclick="javascript:history.back()">
        </form>
    </div>
    
