
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.88.1">

    <link rel="canonical" href="https://getbootstrap.com/docs/5.1/examples/carousel/">

    


<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <!-- Favicons -->
<link rel="apple-touch-icon" href="/docs/5.1/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
<link rel="manifest" href="/docs/5.1/assets/img/favicons/manifest.json">
<link rel="mask-icon" href="/docs/5.1/assets/img/favicons/safari-pinned-tab.svg" color="#7952b3">
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon.ico">
<meta name="theme-color" content="#7952b3">
<link rel="stylesheet" href="${url}/css/transportationView.css" type="text/css" />
</head>
<body>
<main>

  <div id="myCarousel" class="carousel slide" data-bs-ride="carousel">
    <div class="carousel-indicators">
      <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
      <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
      <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
    </div>
    <div class="carousel-inner">
      <div class="carousel-item active">
         <img src="../../img/transportation/plane2.jpg"/>
        <div class="container">
          <div class="carousel-caption text-start">
            <h1>비행기 정보</h1>
            <p>제주도에서 출발, 도착하는 비행기 관련 정보를 찾아보세요.</p>
            <p><a class="btn btn-lg btn-primary" href="/transportation/plane">비행기 정보로 이동</a></p>
          </div>
        </div>
      </div>
      <div class="carousel-item">
         <img src="../../img/transportation/bus2.jpg"/>
        <div class="container">
          <div class="carousel-caption">
            <h1>버스 정보</h1>
            <p>저상버스가 다니는 노선을 확인 해보세요.</p>
            <p><a class="btn btn-lg btn-primary" href="/transportation/bus">버스 정보로 이동</a></p>
          </div>
        </div>
      </div>
      <div class="carousel-item">
        <img src="../../img/transportation/taxi2.jpg"/>

        <div class="container">
          <div class="carousel-caption text-end">
            <h1>택시 정보</h1>
            <p>택시 예약관련 정보를 확인해보세요.</p>
            <p><a class="btn btn-lg btn-primary" href="/transportation/taxi">택시 정보로 이동</a></p>
          </div>
        </div>
      </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#myCarousel" data-bs-slide="next">
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Next</span>
    </button>
  </div>


  <!-- Marketing messaging and featurettes
  ================================================== -->
  <!-- Wrap the rest of the page in another container to center all the content. -->

  <div class="container marketing">

    <!-- Three columns of text below the carousel -->
    <div class="row">
      <div class="col-lg-4">
         <img src="../../img/transportation/plane3.png" width="140" height="140"/>
        <h2>비행기</h2>
        <p>비행기 정보 보러가기</p>
        <p><a class="btn btn-secondary" href="/transportation/plane">View details &raquo;</a></p>
      </div><!-- /.col-lg-4 -->
      <div class="col-lg-4">
         <img src="../../img/transportation/bus3.png" width="140" height="140"/>
        <h2>버스</h2>
        <p>제주도 버스 정보 보러가기</p>
        <p><a class="btn btn-secondary" href="/transportation/bus">View details &raquo;</a></p>
      </div><!-- /.col-lg-4 -->
      <div class="col-lg-4">
         <img src="../../img/transportation/taxi3.png" width="140" height="140"/>
        <h2>택시</h2>
        <p>택시 정보 보러가기</p>
        <p><a class="btn btn-secondary" href="/transportation/taxi">View details &raquo;</a></p>
      </div><!-- /.col-lg-4 -->
    </div><!-- /.row -->


    <!-- START THE FEATURETTES -->

    <hr class="featurette-divider">

    <div class="row featurette">
      <div class="col-md-7">
        <h2 class="featurette-heading">비행기 타고<span class="text-muted"><br/>제주도로 놀러오세요~ </span></h2>
        <p class="lead">Jeju</p>
      </div>
      <div class="col-md-5">
        <img src="../../img/transportation/plane1.jpg"/>

      </div>
    </div>

    <hr class="featurette-divider">

    <div class="row featurette">
      <div class="col-md-7 order-md-2">
        <h2 class="featurette-heading">버스타고<span class="text-muted"><br/> 제주도 한 바퀴</span></h2>
        <p class="lead">저상버스를 이용해보세요</p>
      </div>
      <div class="col-md-5 order-md-1">
        <img src="../../img/transportation/bus1.jpg"/>
      </div>
    </div>

    <hr class="featurette-divider">

    <div class="row featurette">
      <div class="col-md-7">
        <h2 class="featurette-heading">택시로 떠나볼까요? <span class="text-muted"><br/>Let's Go.</span></h2>
        <p class="lead">Jeju Taxi</p>
      </div>
      <div class="col-md-5">
        <img src="../../img/transportation/taxi1.jpg" width="600" height="600">

      </div>
    </div>

    <hr class="featurette-divider">

    <!-- /END THE FEATURETTES -->

  </div>
</main>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
      
  </body>
</html>