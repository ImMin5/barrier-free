<link rel="stylesheet" href="${$}/css/board.css">
  
   <div id="#b__table">
        <h2>게시글 작성</h2>
        <form method="post" action="/board/boardList/">
        	<input type="hidden" value="board_write" name="command">
            <table>
                <tr>
                    <th>제목 *</th>
                    <td><input type="text" name="subject" id="subject"></td>
                </tr>
                <tr>
                    <th>아이디 *</th>
                    <td>${bvo.userid}</td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td><textarea cols="100" rows="30" name="content"></textarea></td>
                </tr>
            </table>
            <input class="btn" type="submit" value="등록">
            <input class="btn" type="reset" value="다시작성하기">
            <input class="btn" type="button" value="취소" onclick="javascript:history.back()">
        </form>
    </div>