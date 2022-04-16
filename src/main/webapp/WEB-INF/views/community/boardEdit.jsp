<link rel="stylesheet" href="${$}/css/board.css">

<script>
   $(function() {
      $("#boardFrm").submit(function() {
         if ($("#subject").val() == "") {
            alert("글 제목을 입력하세요");
            return false;
         }
         if ($("#userid").val() == "") {
             alert("접속하신 아이디를 입력하세요");
             return false;
          }
         if ($("#content").val() == "") {
             alert("내용을 입력하세요");
             return false;
          }

 	  });
	});
</script>
  
   <div id="#b__table">
        <h2>게시글 작성</h2>
        <form method="post" action="${url}/board/boardList" id="boardFrm">
        	<input type="hidden" value="board_write" name="command">
            <table>
                <tr>
                    <th>제목</th>
                    <td><input type="text" name="subject" id="subject"></td>
                </tr>
                <tr>
                    <th>아이디</th>
                    <td><input type="text" name="userid" id="userid" placeholder="접속한 ID로 입력하세요"></td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td><textarea cols="100" rows="30"  name="content" id="content"></textarea></td>
                </tr>
            </table>
            <input class="btn" type="submit" value="등록">
            <input class="btn" type="reset" value="다시작성하기">
            <input class="btn" type="button" value="취소" onclick="javascript:history.back()">
        </form>
    </div>
    
