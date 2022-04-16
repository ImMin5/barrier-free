<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<style>
	.co__button{
  		color: orange;
   	 	width: 200px;
   	 	height: 100px;
    	font-size: 20px;
    	font-weight: bold;
    	text-align: center;
    	background-color: white;
    	border: 3px solid gray;
	}
	.co__button:hover {
  		background-color: orange;
  		color: white;
	}
</style>
<title>barrier-free JEJU</title>
</head>
<body>
	<input type="button" class="co__button" onclick="alert('잠시만 기다려주세요')" value="코디네이터 연결">
</body>
</html>

