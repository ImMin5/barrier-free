<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <c:set var="url" value="<%=request.getContextPath()%>" />
    
    <style>
    .disImg{
    }
    .disImg>h1{
    	position: relative;
	    top: 199px;
	    left: 25%;
	    font-size: 30px;
    }
    .disImg>img{
    	position: relative;
	    top: 217px;
	    left: 25%;
	    width: 50%;
	    height: 100%;
    }
    .disImg>h3{
    	position: relative;
   		top: 225px;
	    left: 25%;
	    font-size: 15px;
    }
    .disImg>h3>a{
    	
    	text-decoration:none
    }
    .disImg>h3>a:hover{
    	text-decoration:none
    }
    </style>
    
</head>
<body>

<div class="disImg">
<h1>🚀 공공요금 감면 🚀</h1>
<img src="../../img/discount/discount.png">
<h3>👉 자세한 사항은 - <a href="http://www.mohw.go.kr">http://www.mohw.go.kr</a></h1>
</div>
<div style="width: 100px; height:300px"></div>
</body>
</html>