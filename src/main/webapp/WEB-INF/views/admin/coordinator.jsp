<link rel="stylesheet" href="${url}/css/board.css">


<script>
  /*  $(function(){
      $(document).on("click","button[name=edit_btn]",function(){
         $(this).attr("name", "save_btn");
         $(this).text("저장");
      });
      
      $(document).on("click","button[name=save_btn]",function(){
         var userid = $(this).attr("data-userid");
         $(this).attr("name", "edit_btn");
         $(this).text("수정");
         
         var username = $("#"+userid+"_username").val();
         var userpassword = $("#"+userid+"_userpassword").val();
         var grade = $("#"+userid+"_grade").val();
         var grade_member = $("#"+userid+"_grade_member").val();
         var question = $("#"+userid+"_question").val();
         var answer = $("#"+userid+"_answer").val();
         var date_create = $("#"+userid+"_date_create").val();
         var date_birth = $("#"+userid+"_write_date ").val();
         
         $.ajax({
            url:"${url}/admin/memberList",
            type : "PUT",
            data :{
               userid : userid ,
               username : username,
               userpassword : userpassword,
               grade : grade,
               grade_member : grade_member, 
               question : question,
               answer : answer,
               date_create : date_create,
               date_birth : write_date,
               
            },success : function(msg){
               alert(msg);
            },error : function(e){
               alert(e.responseJSON.error +"\n" +e.responseJSON.message + "\nstatus : " +e.responseJSON.status );
            }   
         })
         console.log(userid);
         
      });
      
      $(document).on("click","button[name=delet_btn]",function(){
			if(confirm("정말 삭제하시겠습니까?")){
				var userid = $(this).attr("data-userid");
				var userpassword = $(this).attr("data-userpassword");
			$.ajax({
				url: '${url}/admin/memberList',
				type: "DELETE",
				data:{
					userid : userid,
					userpassword : userpassword,
				},
				success: function(data){
					alert(data);
					location.reload();
				},
				error: function(){
					alert("서버 에러.");
				}
			});
			}else{
				return false;
			}
      });
   }); */
</script>
</head>
<body>
    <div class="bo__title" style="margin-bottom:50px">
        <h1>코디네이터</h1>
    </div>
    
    <table class="bo__table">
        <thead>
           <tr>
                <th>email</th>
                <th>tel</th>
                <th>coo_info</th>
                <th>link</th>
                <th>write_date</th>
                <th>coo_userid</th>                              
           </tr>
        </thead>
        <tbody class="bd_t" id="bd_t">
        	<c:forEach var="vo" items="${coordiList}">
        		<tr>
        			<td>${vo.email}</td>
        			<td>${vo.tel}</td>
        			<td>${vo.coo_userid}</td>
        			<td>${vo.link}</td>
        			<td>${vo.write_date}</td>
        			<td>${vo.coo_userid}</td>
        		</tr>
        	</c:forEach>
        </tbody>
    </table>
  
    
    <div class="bo__container">
       
    </div>