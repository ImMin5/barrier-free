<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap');
    </style>
    <title>Barrier-Free JEJU</title>
    <style>
        *{
            margin: 0;
            padding: 0;
        }
        .logo{
            position: fixed;
            left: 100px;
            top: 50px;
        }
        ul{
            position: relative;
            display: block;
            margin: auto;
            top: 100px;
            list-style: none;
            text-align: center;
        }
        .mainMenu li {
            display: inline-block;
            font-size: 25px;
            font-family: 'Noto Sans KR', sans-serif;
            margin: 0px 120px;
            
        }
        a{
            text-decoration: none;
            color: black;
        }
        a:hover{
            color: green;
        }

    </style>
</head>
<body>
    <div class="header">
        <div class="logo">
            <a href="#"><img src="/img/bf_logo-01.svg" width="90%"></a>
        </div>
        <div id="menu">
            <ul>
                <li><a href="#">무장애여행</a>
                    <ul>
                        <li><a href="#">무장애여행 소개</a></li>
                    </ul>
                </li>
                <li><a href="#">여행정보</a>
                    <ul>
                        <li><a href="#">숙박정보</a></li>
                        <li><a href="#">이동수단 안내</a></li>
                        <li><a href="#">여행지 정보</a></li>
                        <li><a href="#">지도</a></li>
                    </ul>
                </li>
                <li><a href="#">할인정보</a>
                    <ul>
                        <li><a href="#">이동수단별 혜택</a></li>
                        <li><a href="#">관광지별 혜택</a></li>
                    </ul>
                </li>
                <li><a href="#">커뮤니티</a>
                    <ul>
                        <li><a href="#">공지/문의사항</a></li>
                        <li><a href="#">코디네이터 연결</a></li>
                        <li><a href="#">건의사항</a></li>
                    </ul>
                </li>
            </ul>
        </div>
</body>
</html>