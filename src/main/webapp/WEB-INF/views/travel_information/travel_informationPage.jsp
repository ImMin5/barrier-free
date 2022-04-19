
<c:set var="url" value="<%=request.getContextPath()%>" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${url}/css/travelinfostyle.css"
	type="text/css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js">
	
</script>
</head>
<div class='container'>
	<div id=tList>
		<h1>여행지 정보</h1>
		<hr />
		<table border="1">
			<tr>
				<th>여행지</th>
				<th>위치</th>
				<th>별점</th>
			</tr>
			<c:forEach var="tboard" items="${ti}">
				<tr>
				
				</tr>
			</c:forEach>
		</table>
	</div>
	<div id='timagecontainer'>
		<img src="#" height="300" width="500">
		<table>
			<tr>
				<th>여행지</th>
				<th>주소</th>
				<th>전화번호</th>
				<th>홈페이지</th>
				<th>소개</th>
			</tr>
			<c:forEach var="tboard2" items="${ac}">
				<tr>
	
				</tr>
			</c:forEach>
		</table>
	</div>
</div>