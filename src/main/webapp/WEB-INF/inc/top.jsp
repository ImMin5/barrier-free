<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
 <c:set var="url" value="<%=request.getContextPath()%>"></c:set>
 
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!--=============== FAVICON ===============-->
    <link rel="shortcut icon" href="../../img/home/favicon.ico" type="image/x-icon">

    <!--=============== REMIXICONS ===============-->
    <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">

    <!--=============== SWIPER CSS ===============-->
    <link rel="stylesheet" href="../../css/swiper-bundle.min.css">

	<!--=============== jQuery library ===============-->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>     
	
	<!--=============== CSS ===============-->
	<link rel="stylesheet" href="../../css/top.css">
    
    <title>Barrier-free JEJU</title>
</head>

<body>
    <header class="header" id="header">
        <nav class="nav container">
            <div class="logo">
                <a href="#"><img src="${$}/img/bf_logo-01.svg" width="60%"></a>
            </div>

            <div class="nav__menu" id="nav-menu">
                <ul class="nav__list">
                    <li class="nav__item">
                        <a href="#" class="nav__link active-link">무장애여행</a>
                        <div class="dropdown-content">
                            <a href="#">무장애여행 소개</a>
                        </div>
                    </li>
                    <li class="nav__item">
                        <a href="#" class="nav__link">여행정보</a>
                        <div class="dropdown-content">
                            <a href="#">숙박정보</a>
                            <a href="#">이동수단 안내</a>
                            <a href="#">여행지 정보</a>
                            <a href="#">제주 지도</a>
                        </div>
                    </li>
                    <li class="nav__item">
                        <a href="#" class="nav__link">할인정보</a>
                        <div class="dropdown-content">
                            <a href="#">이동수단별 혜택</a>
                            <a href="#">관광지별 혜택</a>
                        </div>
                    </li>
                    <li class="nav__item">
                        <a href="#" class="nav__link">커뮤니티</a>
                        <div class="dropdown-content">
                            <a href="#">공지/문의사항</a>
                            <a href="#">코디네이터 연결</a>
                            <a href="#">건의할래요</a>
                        </div>
                    </li>
                </ul>

                <div class="nav__dark">
                    <!-- Theme change button -->
                    <span class="change-theme-name">Dark mode</span>
                    <i class="ri-moon-line change-theme" id="theme-button" style="color: rgb(126, 126, 126);"></i>
                </div>

                <i class="ri-close-line nav__close" id="nav-close"></i>
            </div>

            <div class="nav__toggle" id="nav-toggle">
                <i class="ri-function-line" style="color:green"></i>
            </div>
        </nav>
    </header>