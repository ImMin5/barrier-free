<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!--=============== FAVICON ===============-->
    <link rel="shortcut icon" href="../../img/home/favicon.png" type="image/png">

    <!--=============== REMIXICONS ===============-->
    <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">

    <!--=============== SWIPER CSS ===============-->
    <link rel="stylesheet" href="../../css/swiper-bundle.min.css">

    <!--=============== CSS ===============-->
    <link rel="stylesheet" href="../../css/home.css">

    <title>Test</title>
</head>

<body>
    <header class="header" id="header">
        <nav class="nav container">
            <div class="logo">
                <a href="#"><img src="../../img/bf_logo-03.svg" width="60%"></a>
            </div>

            <div class="nav__menu" id="nav-menu">
                <ul class="nav__list">
                    <li class="nav__item">
                        <a href="#home" class="nav__link active-link">무장애여행</a>
                        <ul>
                            <li><a href="#">무장애여행 소개</a></li>
                        </ul>
                    </li>
                    <li class="nav__item">
                        <a href="#about" class="nav__link">여행정보</a>
                        <ul>
                            <li><a href="#">숙박정보</a></li>
                            <li><a href="#">이동수단 안내</a></li>
                            <li><a href="#">여행지 정보</a></li>
                            <li><a href="#">지도</a></li>
                        </ul>
                    </li>
                    <li class="nav__item">
                        <a href="#discover" class="nav__link">할인정보</a>
                        <ul>
                            <li><a href="#">이동수단별 혜택</a></li>
                            <li><a href="#">관광지별 혜택</a></li>
                        </ul>
                    </li>
                    <li class="nav__item">
                        <a href="#place" class="nav__link">커뮤니티</a>
                        <ul>
                            <li><a href="#">공지/문의사항</a></li>
                            <li><a href="#">코디네이터 연결</a></li>
                            <li><a href="#">건의할래요</a></li>
                        </ul>
                    </li>
                </ul>

                <div class="nav__dark">
                <!-- Theme change button -->
                <span class="change-theme-name">Dark mode</span>
                        <i class="ri-moon-line change-theme" id="theme-button"></i>
                    </div>

                <i class="ri-close-line nav__close" id="nav-close"></i>
            </div>

            <div class="nav__toggle" id="nav-toggle">
                <i class="ri-function-line"></i>
            </div>
        </nav>
    </header>