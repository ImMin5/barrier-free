<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="url" value="<%=request.getContextPath()%>" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${url}/css/accommodationstyle.css" type="text/css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js">
</script>
</head>
<div class='container'>
	<div id=aList>
		<h1>숙박 정보</h1>
		<hr/>
        <li>이름</li>
        <li>주소</li>
        <li>전화번호</li>
		
	
		</form>
	</div>
	<div>
		<ul>
			<c:forEach var="vo" items="${accomoList}">
				<li>${vo.get("title")}</li>
				<li>${vo.get("addr1")}</li>
				<li>${vo.get("contentid")}</li>
				<c:if test="${vo.has('tel')}">
					<li>${vo.get("tel")}</li>
				</c:if>
			</c:forEach>
			
		</ul>
	</div>
</div>