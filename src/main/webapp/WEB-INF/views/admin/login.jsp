<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="url" value="<%=request.getContextPath()%>" />
	
 <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">	
 <link rel="stylesheet" href="${url }css/login.css">
 <script src="/js/login.js"></script>
  <div id="login">
 		

        <div id="log">
		
		
		<form method="post"  action="${url}/admin" id="logFrm" onsubmit="return logFormCheck()">
		<ul>
			<li><a href="#"><img src="${url }/img/bf_logo-01.png"></a></li>
			<li><input type ="text" name="userid" id="userid" placeholder="아이디"/></li>
			<li id="pwd"><input type="password" name="userpassword" id="userpwd" placeholder="비밀번호" /></li>
			<li><input id="button" type="button" value="로그인" onclick="logFormCheck()"/>
			
		</ul>
			<div id="line"><hr/></div>
		</form>
		
	</div>
</div>
<hr/>
