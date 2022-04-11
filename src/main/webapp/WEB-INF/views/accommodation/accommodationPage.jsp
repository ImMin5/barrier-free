<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
AccommodationDAO dao = new AccommodationDAO();
List<AccommodationVO> ac = dao.selectAll();
pageContext.setAttribute("ac", ac);
%>
<c:set var="url" value="<%=request.getContextPath()%>" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${url}/css/accommodationstyle.css"
	type="text/css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js">
	
</script>
</head>
<div class='container'>
	<div id=aList>
		<h1>숙박 정보</h1>
		<hr />
		<table border="1">
			<tr>
				<th>이름</th>
				<th>주소</th>
				<th>별점</th>
			</tr>
			<c:forEach var="aboard" items="${ac}">
				<tr>
					<td>${ }</td>
					<td>${ }</td>
					<td>${ }</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div id='aimagecontainer'>
		<img src="#" height="300" width="500">
		<table>
			<tr>
				<th>이름</th>
				<th>주소</th>
				<th>전화번호</th>
				<th>홈페이지</th>
				<th>소개</th>
			</tr>
			<c:forEach var="aboard2" items="${ac}">
				<tr>
					<td>${ }</td>
					<td>${ }</td>
					<td>${ }</td>
					<td>${ }</td>
					<td>${ }</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>