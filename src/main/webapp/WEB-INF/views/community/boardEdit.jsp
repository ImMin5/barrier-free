<link rel="stylesheet" href="${url}/css/board.css">

<script>
$(function() {
    $("#btn_edit").on("click",function() {
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
       
       
    $(function(){
           var url = "${url}/board/boardList";
           var data = $("#boardFrm").serialize();
        $.ajax({
           url : url,
           type : "put",
           dataType : "JSON",
           data : data,
           success : function(result) {
              alert(result.msg);
              window.location.href = result.redirect;
           },
           error : function(error){
              console.log(error.responseJSON);
              alert(error.responseJSON.msg);
              window.location.href = error.responseJSON.redirect;
           }
        });
 	   });
	 });
   });
 $(function() {
    $("#btn_delete").on("click",function() {
        $(function(){
            var url = "${url}/board/boardList";
            var data = $("#boardFrm").serialize()
         $.ajax({
            url : url,
            type : "DELETE",
            dataType : "JSON",
            data : data,
            success : function(result) {
               alert(result.msg);
               window.location.href = result.redirect;
            },
            error : function(error){
               console.log(error.responseJSON);
               alert(error.responseJSON.msg);
               window.location.href = error.responseJSON.redirect;
            }
            
        }) ; 
        });
    });
 });
			
</script>
  
<div id="#b__table">
        <h1 class="bf__title">👇 게시글 수정 👇</h1>
        <form id="boardFrm" name="boardFrm" class="bf__container">
        	<input type="hidden" value=${bvo.no} name="no">
        	<input type="hidden" value="board_write" name="command">
            <table>
                <tr>
                    <th>제목</th>
                    <td><input type="text" name="subject" id="subject" value="${bvo.subject}"></td>
                </tr>
                <tr>
                    <th>아이디</th>
                    <td><input type="text" name="userid" id="userid" value="${bvo.userid}"></td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td><textarea cols="100" rows="30"  name="content" id="content">${bvo.content}</textarea></td>
                </tr>
            </table>
            <input class="bo__btn__w" type="button" id="btn_edit" value="글 작성">
            <input class="bo__btn__w" type="button" id="btn_delete" value="삭제하기">
            <input class="bo__btn__w" type="button" value="취소" onclick="javascript:history.back()">
        </form>
    </div> 