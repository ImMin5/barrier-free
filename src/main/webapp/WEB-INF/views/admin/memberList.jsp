<script>
	$(function(){
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
			var date_birth = $("#"+userid+"_date_birth").val();
			
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
					date_birth : date_birth,
					
				},success : function(msg){
					alert(msg);
				},error : function(e){
					alert(e.responseJSON.error +"\n" +e.responseJSON.message + "\nstatus : " +e.responseJSON.status );
				}	
			})
			console.log(userid);
		});
	});
</script>
<div style="margin:150px;">
<table>
	<tr>
		<td>userid</td>
		<td>username</td>
		<td>userpassword</td>
		<td>date_birth</td>
		<td>grade</td>
		<td>grade_member</td>
		<td>question</td>
		<td>answer</td>
		<td>data_create</td>
		<td>수정</td>
		<td>삭제</td>
	</tr>
	<c:forEach var="vo" items="${memberList}">
		<tr>
			<td>${vo.userid }</td>
			<td> <input type="text" id="${vo.userid }_username" value="${vo.username }"/></td>
			<td> <input type="text" id="${vo.userid }_userpassword" value="${vo.userpassword }"/></td>
			<td> <input type="text" id="${vo.userid }_date_birth" value="${vo.date_birth }"/></td>
			<td> <input type="text" id="${vo.userid }_grade" value="${vo.grade }"/></td>
			<td> <input type="text" id="${vo.userid }_grade_member" value="${vo.grade_member }"/></td>
			<td> <input type="text" id="${vo.userid }_question" value="${vo.question }"/></td>
			<td> <input type="text" id="${vo.userid }_answer" value="${vo.answer }"/></td>
			<td> <input type="text" value="${vo.date_create }" readonly></td>
			<td><button name="edit_btn" data-userid="${vo.userid}">수정</button></td>
			<td><button name="delet_btn" date-userid="${vo.userid}">삭제</button></td>
		</tr>
	</c:forEach>
	
	
</table>
		
</div>