<link rel="stylesheet" href="${url}/css/board.css">


   <div id="bo__table" class="bo__table">
   <h1 class="bd__title">👇 나의 게시글 👇</h1>
   <form method="post" action="${url}/board/boardList/edit/${bvo.no}" id="boardFrm" class="bd__Frm">
            <table>
                <tr>
                    <th class="bd__tb__sub">제목</th>
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
            <input class="bo__btn__m" type="submit" value="수정">
            <input class="bo__btn__mb" type="button" value="목록으로" onclick="location.href='${url}/board/boardList'">
        </form>
    </div>