
<script>
    $(function() {
        $("#btn_submit").on("click",function() {
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
             var url = "${url}/amdin/coordinator/form";
             var data = $("#boardFrm").serialize();
             
              $.ajax({
                 url : url,
                 type : "POST",
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
</head>
<body>
    <div id="#b__table" >
        <h1 class="bf__title">🙆 코디네이터 등록 🙆‍♂️</h1>
       <form id="boardFrm" class="bf__container" >
        	<input type="hidden" value="board_write" name="command">
        
            <table class="bf__table">
                <tr>
                    <th>이메일</th>
                    <td><input type="email" name="email" id="email" placeholder="이메일을 입력해주세요" value="sdf@naver.com"></td>
                </tr>
                <tr>
                    <th>전화번호</th>
                    <td><input type="text" name="tel" placeholder="전화번호를 입력해주세요" value="010-1223-1233"></td>
                </tr>
                <tr>
                    <th>소개</th>
                    <td><textarea cols="100" rows="30"  name="coo_info" id="content" style="padding: 10px">ex) 저는 경력 10년차 제주 코디네이터 입니다. 편안하고 즐거운 여행이 될 수 있도록 최선을 다하겠습니다.</textarea></td>
                </tr>
                <tr>
                    <th>연결 링크</th>
                    <td><input type="text" name="link" value="www.naver.com" placeholder="url 주소를 남겨주세요(SNS, 오픈채팅등)"></textarea></td>
                </tr>
                <tr>
                    <th>아이디</th>
                    <td><input type="text" name="coo_userid" id="userid" value="goguma2" placeholder="접속한 아이디를 입력해주세요"></td>
                </tr>
            </table>
            <input class="bo__btn__w" type="button" id="btn_submit" value="등록">
            <input class="bo__btn__w" type="button" value="취소" onclick="location.href='${url}/admin/boardList'">
    	</form>
    </div>

