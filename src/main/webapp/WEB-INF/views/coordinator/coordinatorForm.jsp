<link rel="stylesheet" href="${url}/css/board.css">

<script>
    $(function() {
        $("#btn_submit").on("click",function() {
        
          
             var url = "${url}/admin/coordinator/form";
             var data = $("#coordinatorFrm").serialize();
             
              $.ajax({
                 url : url,
                 type : "POST",
                 dataType : "JSON",
                 data : data,
                 success : function(result) {
                    alert(result);
                    window.location.href = "${url}/admin/coordinator"
                 },
                 error : function(error){
                    console.log(error.responseJSON);
                    alert(error.responseJSON.msg);
                    window.location.href = error.responseJSON.redirect;
                 }
                 
            
           });
        });
    
     });
    
    </script>
    
</head>
<body>
    <div id="#b__table" >
        <h1 class="bf__title">π μ½λλ€μ΄ν° λ±λ‘ πββοΈ</h1>
       <form id="coordinatorFrm" class="bf__container" >
        	<input type="hidden" value="board_write" name="command">
        
            <table class="bf__table">
                <tr>
                    <th>μ΄λ©μΌ</th>
                    <td><input type="email" name="email"  placeholder="μ΄λ©μΌμ μλ ₯ν΄μ£ΌμΈμ" value="sdf@naver.com"></td>
                </tr>
                <tr>
                    <th>μ νλ²νΈ</th>
                    <td><input type="text" name="tel" placeholder="μ νλ²νΈλ₯Ό μλ ₯ν΄μ£ΌμΈμ" value="010-1223-1233"></td>
                </tr>
                <tr>
                    <th>μκ°</th>
                    <td><textarea cols="100" rows="30"  name="coo_info" id="content" style="padding: 10px">ex) μ λ κ²½λ ₯ 10λμ°¨ μ μ£Ό μ½λλ€μ΄ν° μλλ€. νΈμνκ³  μ¦κ±°μ΄ μ¬νμ΄ λ  μ μλλ‘ μ΅μ μ λ€νκ² μ΅λλ€.</textarea></td>
                </tr>
                <tr>
                    <th>μ°κ²° λ§ν¬</th>
                    <td><input type="text" name="link" value="www.naver.com" placeholder="url μ£Όμλ₯Ό λ¨κ²¨μ£ΌμΈμ(SNS, μ€νμ±νλ±)"></textarea></td>
                </tr>
                <tr>
                    <th>μμ΄λ</th>
                    <td><input type="text" name="coo_userid" id="userid" value="goguma2" placeholder="μ μν μμ΄λλ₯Ό μλ ₯ν΄μ£ΌμΈμ"></td>
                </tr>
            </table>
            <input class="bo__btn__wa" type="button" id="btn_submit" value="λ±λ‘">
            <input class="bo__btn__wa" type="button" value="μ·¨μ" onclick="location.href='${url}/admin/coordinator'">
    	</form>
    </div>
