<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="../../css/home.css">

    <main class="main">
        <!--==================== HOME ====================-->
        <section class="home" id="home">
            <img src="../../img/home/jeju_01.jpg" alt="" class="home__img">

            <div class="home__container container grid">
                <div class="home__data">
                    <span class="home__data-subtitle">누구에게나 좋은 여행</span>
                    <h1 class="home__data-title">Barrier-free<br><b>JEJU</b></h1>
                    <a href="#" class="button">무장애 여행이란?</a>

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
                    <h2 class="section__title about__title">방문하기 편안한<br>아름다운 제주 해변 🌊🌊</h2>
                    <p class="about__description"> 편안한 나만의 여행을 위한 <br> 계획을 짜보세요
                    </p>
                    <a href="#" class="button">제주 여행 지도 보러가기</a>
                </div>

                <div class="about__img">
                    <div class="about__img-overlay">
                        <img src="../../img/home/jeju_beach_01.jpg" alt="" class="about__img-one">
                    </div>

                    <div class="about__img-overlay">
                        <img src="../../img/home/jeju_beach_02.jpg" alt="" class="about__img-two">
                    </div>
                </div>
            </div>
        </section>

        <!--==================== DISCOVER ====================-->
        <section class="discover section" id="discover">
            <h2 class="section__title"> 🏠 눈뜨면 바다가 보이는 🏠 <br /> 오션뷰 숙소</h2>
            <div class="discover__container container swiper-container">
                <div class="swiper-wrapper">
                    <!--==================== DISCOVER 1 ====================-->
                    <div class="discover__card swiper-slide">
                        <img src="../../img/home/discover1.jpg" alt="" class="discover__img">
                        <div class="discover__data">
                            <h2 class="discover__title">숙소1</h2>
                            <span class="discover__description">#장애인주차구역 #엘리베이터 #공항근처</span>
                        </div>
                    </div>
                    <!--==================== DISCOVER 2 ====================-->
                    <div class="discover__card swiper-slide">
                        <img src="../../img/home/discover2.jpg" alt="" class="discover__img">
                        <div class="discover__data">
                            <h2 class="discover__title">숙소2</h2>
                            <span class="discover__description">#장애인주차구역 #엘리베이터 #공항근처</span>
                        </div>
                    </div>
                    <!--==================== DISCOVER 3 ====================-->
                    <div class="discover__card swiper-slide">
                        <img src="../../img/home/discover3.jpg" alt="" class="discover__img">
                        <div class="discover__data">
                            <h2 class="discover__title">숙소3</h2>
                            <span class="discover__description">#장애인주차구역 #엘리베이터 #공항근처</span>
                        </div>
                    </div>
                    <!--==================== DISCOVER 4 ====================-->
                    <div class="discover__card swiper-slide">
                        <img src="../../img/home/discover4.jpg" alt="" class="discover__img">
                        <div class="discover__data">
                            <h2 class="discover__title">숙소4</h2>
                            <span class="discover__description">#장애인주차구역 #엘리베이터 #공항근처</span>
                        </div>
                    </div>

                </div>
            </div>

        </section>



        <!--==================== PLACES ====================-->
        <section class="place section" id="place">
            <h2 class="section__title">👍 베프가 추천하는 👍</h2>

            <div class="place__container container grid">
                <!-- ==================== PLACES CARD 1==================== -->
                <div class="place__card">
                    <img src="../../img/home/place1.jpg" alt="" class="place__img">
                    <div class="place__content">
                        <span class="place__rating">
                            <i class="ri-star-line place__rating-icon"></i>
                            <span class="place__rating-number">4.8</span>
                        </span>

                        <div class="place__data">
                            <h3 class="place__title">우도</h3>
                            <span class="place__subtitle">관광지</span>
                            <span class="place__price">#여유</span>
                        </div>
                    </div>

                    <button class="button button--flex place__button">
                        <i class="ri-arrow-right-line"></i>
                    </button>
                </div>

                <!--==================== PLACES CARD 2====================-->
                <div class="place__card">
                    <img src="../../img/home/place2.jpg" alt="" class="place__img">
                    <div class="place__content">
                        <span class="place__rating">
                            <i class="ri-star-line place__rating-icon"></i>
                            <span class="place__rating-number">5.0</span>
                        </span>

                        <div class="place__data">
                            <h3 class="place__title">마라도</h3>
                            <span class="place__subtitle">관광지</span>
                            <span class="place__price">#편안한</span>
                        </div>
                    </div>

                    <button class="button button--flex place__button">
                        <i class="ri-arrow-right-line"></i>
                    </button>
                </div>

                <!--==================== PLACES CARD 3====================-->
                <div class="place__card">
                    <img src="../../img/home/place3.jpg" alt="" class="place__img">
                    <div class="place__content">
                        <span class="place__rating">
                            <i class="ri-star-line place__rating-icon"></i>
                            <span class="place__rating-number">4.9</span>
                        </span>

                        <div class="place__data">
                            <h3 class="place__title">마리나호텔 제주</h3>
                            <span class="place__subtitle">숙박</span>
                            <span class="place__price">#호캉스</span>
                        </div>
                    </div>

                    <button class="button button--flex place__button">
                        <i class="ri-arrow-right-line"></i>
                    </button>
                </div>

                <!--==================== PLACES CARD 4====================-->
                <div class="place__card">
                    <img src="../../img/home/place4.jpg" alt="" class="place__img">
                    <div class="place__content">
                        <span class="place__rating">
                            <i class="ri-star-line place__rating-icon"></i>
                            <span class="place__rating-number">4.8</span>
                        </span>

                        <div class="place__data">
                            <h3 class="place__title">제주공항</h3>
                            <span class="place__subtitle">편의시설</span>
                            <span class="place__price">#여행의시작</span>
                        </div>
                    </div>

                    <button class="button button--flex place__button">
                        <i class="ri-arrow-right-line"></i>
                    </button>
                </div>

                <!--==================== PLACES CARD 5====================-->
                <div class="place__card">
                    <img src="../../img/home/place5.jpg" alt="" class="place__img">
                    <div class="place__content">
                        <span class="place__rating">
                            <i class="ri-star-line place__rating-icon"></i>
                            <span class="place__rating-number">4.8</span>
                        </span>

                        <div class="place__data">
                            <h3 class="place__title">천제연폭포</h3>
                            <span class="place__subtitle">관광지</span>
                            <span class="place__price">#시원한</span>
                        </div>
                    </div>

                    <button class="button button--flex place__button">
                        <i class="ri-arrow-right-line"></i>
                    </button>
                </div>
            </div>



            <!--==================== SUBSCRIBE ====================-->
            <section class="subscribe section">
                <div class="subscribe__bg">
                    <div class="subscribe__container container">
                        <h2 class="section__title subscribe__title"> 혼자 여행다니기 불편하신가요? <br> 코디네이터와 함께 편안하게!</h2>
                        <p class="subscribe__description">제주 여행 전문 코디네이터와 함께다니면 편안한 여행이 될 수 있어요.
                        </p>
                        <div class=" sub_btn">
                            <button class="button">
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
           <script src="../../js/home/scrollreveal.min.js"></script>

            <!--=============== SWIPER JS ===============-->
           <script src="../../js/home/swiper-bundle.min.js"></script>

            <!--=============== MAIN JS ===============-->
            <script src="../../js/home/main.js"></script>
         </section>
     </main>
        