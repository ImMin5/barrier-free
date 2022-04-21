<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
 <c:set var="url" value="<%=request.getContextPath()%>"></c:set>
 
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!--=============== FAVICON ===============-->
    <link rel="shortcut icon" href="${url}/img/home/favicon.ico" type="image/x-icon">

    <!--=============== REMIXICONS ===============-->
    <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">

    <!--=============== SWIPER CSS ===============-->
    <link rel="stylesheet" href="${url}/css/swiper-bundle.min.css">

	<!--=============== jQuery library ===============-->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>     
	
	<!--=============== CSS ===============-->
	<link rel="stylesheet" href="${url}/css/top.css">
    
    <!--=============== text - reader ===============-->
    <script src="/js/ai_api.js"></script>
    
    <title>Barrier-free JEJU</title>
</head>

<body>
            
<!--------- 일반 아이디로 로그인 ----------->   
<c:if test="${adminStatus == null}">
    <header class="header" id="header">
        <nav class="nav container">
            <div class="logo">
                <a href="/"><img src="${url}/img/bf_logo-01.svg" width="60%"></a>
            </div>
            
            <div class="nav__menu" id="nav-menu">
                <ul class="nav__list">
                    <li class="nav__item">
                        <a href="/intro" class="nav__link active-link">무장애여행</a>
                        <div class="dropdown-content">
                            <a href="/intro">무장애여행 소개</a>
                        </div>
                    </li>
                    <li class="nav__item">
                        <a href="#" class="nav__link">여행정보</a>
                        <div class="dropdown-content">
                            <a href="/travel_information">여행지 정보</a>
                            <a href="/accommodation">숙박 정보</a>
                            <a href="/transportation/bus">이동수단 안내</a>
                            <a href="/mapView">제주 지도</a>
                        </div>
                    </li>
                    <li class="nav__item">
                        <a href="/discountView" class="nav__link">할인정보</a>
                        <div class="dropdown-content">
                            <a href="/discountDetailView">관광지별 혜택</a>
                            <a href="/discountDetailView">이동수단별 혜택</a>
                        </div>
                    </li>
                    <li class="nav__item">
                        <a href="#" class="nav__link">커뮤니티</a>
                        <div class="dropdown-content">
                            <a href="/board/boardList">공지/문의사항</a>
                            <a href="/coordinator">코디네이터 연결</a>
                            <a href="/suggest">건의할래요</a>
                        </div>
                    </li>
                </ul>
				
		<div class="main__top">
			<div class="main__loginSign">
				   <c:if test="${logId == null}">
   					   <a href="${url}/login" class="main__login">login</a>
  					   <a href="${url}/signup" class="main__signup">Sign-up</a>
 				  </c:if>
 				 <c:if test="${logId != null }">
 				 	<div class="main__logId"><b>${logId}</b>님 환영합니다🙇‍♀️</div>
    				<a href="${url}/logout" class="main__login">Logout</a>
   					<a href="${url}/mypage/myplanner" class="main__signup">My-page</a>
  				 </c:if>
			</div>
        </div>
     </nav>
 </header>
 </c:if>
   
 <!--------- 관리자 아이디로 로그인 ----------->
 <c:if test="${adminStatus != null}">
     <header class="header" id="header" style="background-color: #ffe8cb">
        <nav class="nav container">
        
            <div class="logo">
                <a href="/"><img src="${url}/img/bf_logo-01.svg" width="60%"></a>
            </div>
            
           	<div class="main__loginSign__a">
 			 	 <c:if test="${logId != null }">
 		 		<div class="main__logId__a"><b>${logId}</b>님 반갑습니다🙇‍♀️</div>
    			<a href="${url}/logout" class="main__login__a">Logout</a>
  			   </c:if>
			</div>
			
                <ul class="nav__list">
                    <li class="nav__item">
                        <a href="${url}/admin/memberList" class="nav__link active-link" style="margin-left: 30px; color">회원관리</a>
                    </li>
                    <li class="nav__item">
                        <a href="${url}/admin/discountManage" class="nav__link active-link" style="margin-left: 30px">할인정보</a>
                          <div class="dropdown-content">
                            <a href="${url}/admin/discountManage">할인정보 목록</a>
                            <a href="${url}/admin/discountManage">할인정보 등록</a>
                          </div>
                    </li>
                    <li class="nav__item">
                        <a href="${url}/admin/boardList" class="nav__link active-link" style="margin-left: 30px">공지/문의</a>
                    	  <div class="dropdown-content">
                            <a href="${url}/admin/boardList">공지/문의 목록</a>
                            <a href="${url}/board/boardList/form">공지 등록</a>
                          </div>
                    </li>
                    <li class="nav__item">
                        <a href="${url}/admin/coordinator" class="nav__link active-link" style="margin-left: 30px">코디네이터</a>                        
                    	  <div class="dropdown-content">
                            <a href="${url}/admin/coordinator">코디네이터 목록</a>
                            <a href="${url}/admin/coordinator/form">코디 등록</a>
                          </div>
                    </li>
                </ul>
   		</nav>
  	 </header>
</c:if>  