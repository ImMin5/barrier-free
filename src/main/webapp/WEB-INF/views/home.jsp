<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="../../css/home.css">

    <main class="main">
        <!--==================== HOME ====================-->
        <section class="home" id="home">
            <img src="../../img/home/jeju_03.jpg" alt="" class="home__img">

            <div class="home__container container grid">
                <div class="home__data">
                    <span class="home__data-subtitle">누구에게나 좋은 여행</span>
                    <h1 class="home__data-title">Barrier-free<br><b>JEJU</b></h1>
                    <a href="/intro" class="button">무장애 여행이란?</a>

                </div>

                <div class="home__info">
                    <div>
                        <span class="home__info-title">BEST 6 제주</span>
                        <a href="" class="button button--flex button--link home__info-button">
                            More <i class="ri-arrow-right-line"></i>
                        </a>
                    </div>

                    <div class="home__info-overlay">
                        <img src="../../img/home/jeju_02.jpg" alt="" class="home__info-img">
                    </div>
                </div>
            </div>
        </section>

        <!--==================== ABOUT ====================-->
        <section class="about section" id="about">
            <div class="about__container container grid">
                <div class="about__data">
                    <h2 class="section__title about__title"> 아름다운 제주 해변과 함께 🌊🌊</h2>
                    <p class="about__description"> 편안한 여행을 위한 <br> 계획을 짜보세요
                    </p>
                    <a href="/mapView" class="button">제주 여행 지도 보러가기</a>
                </div>

                <div class="about__img">
                    <div class="about__img-overlay">
                        <img src="${$}/img/home/jeju.jpeg" alt="" class="about__img-one">
                    </div>
                </div>
            </div>
        </section>

        <!--==================== DISCOVER ====================-->
        <section class="discover section" id="discover">
            <h2 class="section__title"> 🏠 머무르기 편안한 🏠 </h2>
            <div class="discover__container container swiper-container">
                <div class="swiper-wrapper">           
                    <!--==================== DISCOVER 3 ====================-->
                    <c:forEach var="vo" items="${accomoList}">
                    <div class="discover__card swiper-slide">
                        <img src="${vo.get('firstimage')}" alt="" class="discover__img">

                        <div class="discover__data">
                            <a href="${url}/accommodation"><h2 class="discover__title">${vo.get('title')}</h2></a>
                            <span class="discover__description">${vo.get('addr1')}</span>
                        </div>
                    </div>
                    </c:forEach>
                </div>
            </div>

        </section>



        <!--==================== PLACES ====================-->
        <section class="place section" id="place">
            <h2 class="section__title">👍 베프가 추천하는 👍</h2>

            <div class="place__container container grid">
                <!-- ==================== PLACES CARD 1==================== -->
                <c:forEach var="vo" items="${tourList}">
                <div class="place__card">
                    <img src="${vo.get('firstimage')}" alt="" class="place__img">
                    <div class="place__content">
                        <span class="place__rating">
                            <i class="ri-star-line place__rating-icon"></i>
                            <span class="place__rating-number">${vo.get('avgScore')}</span>
                        </span>

                        <div class="place__data">
                            <h3 class="place__title">${vo.get('title')}</h3>
                            <span class="place__subtitle">${vo.get('addr1')}</span>
                        </div>
                    </div>

                    <button class="button button--flex place__button" type="button" onclick="location.href='${url}/travel_information'">
                        <i class="ri-arrow-right-line"></i>
                    </button>
                </div>
                </c:forEach>
                </div>
        </section>
            <!--==================== SUBSCRIBE ====================-->
            <section class="subscribe section">
                <div class="subscribe__bg">
                    <div class="subscribe__container container">
                        <h2 class="section__title subscribe__title"> 혼자 여행다니기 불편하신가요? <br> 코디네이터와 함께 편안하게!</h2>
                        <p class="subscribe__description">제주 여행 전문 코디네이터와 함께 안전하고 편안한 여행을 즐겨보세요!
                        </p>
                        <div class=" sub_btn">
                            <button class="button" onclick="window.open('/coordinator')">
                                코디네이터 연결
                            </button>
                        </div>
                    </div>
                </div>
            </section>
            
            
            <!--=============== SCROLL UP ===============-->
            <a href="#" class="scrollup" id="scroll-up">
                <i class="ri-arrow-up-line scrollup__icon"></i>
            </a>

            <!--=============== SCROLL REVEAL ===========-->
           <script src="${url}/js/home/scrollreveal.min.js"></script>

            <!--=============== SWIPER JS ===============-->
           <script src="${url}/js/home/swiper-bundle.min.js"></script>

            <!--=============== MAIN JS ===============-->
            <script src="${url}/js/home/main.js"></script>
         </section>
     </main>
        