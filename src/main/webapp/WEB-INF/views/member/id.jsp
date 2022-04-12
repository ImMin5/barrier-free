<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="url" value="<%=request.getContextPath()%>" />

<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">	
<link rel="stylesheet" href="${url }css/id.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<script>
$(document).on('click','#findId',function(){
	var name = $('#username').val();
 	var birth = $('#userbirth').val();
 	

 	var postData = {'username' : name , 'userbirth' : birth };

	$.ajax({
        url:'/infoid',
        type:'POST',
        data: postData,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType : "json",

        success:function(result){
  			console.log(result);
  			console.log(result.msg);
  			

        },
        error: function (error){

        	alert('정보를 다시 입력해주시길 바랍니다.' );
        	
        }
    });
});

</script>

<div>
	<hr/>
	<div id="findid">
	
		<form id="findidFrm">
			<ul>
				
				<li><img id=findidlogo src="${url }/img/bf_logo_findid.png"></li>
				
			 	<li><input type="text" name="username" id="username" placeholder="성함을 입력해주세요."/></li>
			 	<li><input type="text" name="userbirth" id="userbirth" placeholder="생년월일을 입력해주세요. (예: 980121)"/></li>
			 	<button id="findId">아이디찾기</button>
			 	
			</ul>
			<div id="line"><hr/></div>
			<div class="forgotpwd">
                <a href="${url }/infopwd">비밀번호를 잊으셨나요? </a>
            </div>
           
		</form>
	</div>
</div>
 <hr/>
