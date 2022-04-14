<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="url" value="<%=request.getContextPath()%>" /> 

<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">	
<link rel="stylesheet" href="${url }css/id.css">


<script>
$(document).on('click','#findId',function(event){
	event.preventDefault();
	var date_birth = $("#userbirth").val();
	var username = $("#username").val();
	
	$.ajax({
        url:'${url}/infoid',
        type:'POST',
        data: {
        	username:username,
        	date_birth:date_birth
        },
        dataType : "json",

        success:function(data){
  			if(data.userid =="" || typeof data.userid =="undefined"){
  				alert("회원정보와 일치하는 아이디가 없습니다.")
  			}else{
  				alert(username+"님의 아이디는"+" "+data.userid+" "+"입니다.");
  			}
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
				
				<li><img id=findidlogo src="${url }/img/member/bf_logo_findid.png"></li>
				
			 	<li><input type="text" name="username" id="username" placeholder="성함을 입력해주세요."/></li>
			 	<li><input type="text" name="date_birth" id="userbirth" placeholder="생년월일을 입력해주세요. (예: 980121)"/></li>
			 	<button id="findId">아이디찾기</button>
			 	
			</ul>
			<div id="line"><hr/></div>
			<div class="forgotpwd">
               비밀번호를 잊으셨나요? <a href="${url }/infopwd"> 비밀번호찾기 </a>
            </div>
           
		</form>
	</div>
</div>
 <hr/>
