<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="url" value="<%=request.getContextPath()%>" />

<title>Insert title here</title>
<link rel="stylesheet" href="${url}/css/accommodationstyle.css"
	type="text/css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	$(function(){//검색
		var searchWord = $("#searchWord").val();
		$("#sch_form").submit(function(){
			if($("#searchWord").val()==""){
				alert("검색어를 입력하세요.");
				return false;
			}
			if($("#searchWord").val() != ''){
				window.location.href = "${url}/accommodation?pageNo=1&pageCount=8&sigungucode=&searchWord=" + searchWord;
			}
		});
	});
	
	
</script>
</head>
<body>
	<div class="main_con2">
		<div class="container">
			<p class="main_tit">
				<strong>무장애 관광지</strong> 찾기
			</p>

			<form name="sch_form" id="sch_form" method="get" action="#">

				<div class="check_box">
					<p>
						<strong>관광약자 편의시설</strong> 선택 검색
					</p>
					<ul>
						<li><input type="checkbox" id="check01" value="1"
							class="icon1"> <label for="check01"><span>장애인화장실</span></label>
						</li>
						<li><input type="checkbox" id="check02" value="2"
							class="icon2"> <label for="check02"><span>엘리베이터</span></label>
						</li>
						<li><input type="checkbox" id="check03" value="3"
							class="icon3"> <label for="check03"><span>장애인주차장</span></label>
						</li>
						<li><input type="checkbox" id="check04" value="4"
							class="icon4"> <label for="check04"><span>경사로</span></label>
						</li>
						<li><input type="checkbox" id="check05" value="5"
							class="icon5"> <label for="check05"><span>안내견 출입</span></label>
						</li>
						<li><input type="checkbox" id="check06" value="6"
							class="icon6"> <label for="check06"><span>버스정류장</span></label>
						</li>
						<li><input type="checkbox" id="check07" value="7"
							class="icon7"> <label for="check07"><span>휠체어
									대여</span></label></li>
						<li><input type="checkbox" id="check08" value="8"
							class="icon8"> <label for="check08"><span>촉지도식
									안내판</span></label></li>
						<li><input type="checkbox" id="check09" value="9"
							class="icon9"> <label for="check09"><span>오디오
									가이드</span></label></li>
						<li><input type="checkbox" id="check10" value="10"
							class="icon10"> <label for="check10"><span>아기돌봄/수유실</span></label>
						</li>
						<li><input type="checkbox" id="check11" value="11"
							class="icon11"> <label for="check11"><span>무장애
									객실</span></label></li>
						<li><input type="checkbox" id="check12" value="12"
							class="icon12"> <label for="check12"><span>유아차
									대여</span></label></li>
					</ul>
				</div>
				<div class="form_box">
					<span> 
						<label for="areaForm">지역</label> 
						<select name="sigunguCode" id="sigunguCode">
							<option value="" selected="">전체</option>
								<c:forEach var="area" items="${areaList}">
									<option>${area.get("name")}</option>
								</c:forEach>
						</select>
					</span> 
					<span> <label for="keywordForm">키워드</label> 
						<select name="contentTypeId" id="contentTypeId">
							<option value="" selected="">전체</option>
							<option value="12">관광지</option>
							<option value="14">문화시설</option>
							<option value="38">쇼핑</option>
							<option value="14">문화시설</option>
					</select>
					</span> <span> <input type="text" name="searchWord" id="searchWord"
						title="검색어 입력" value="" maxlength="20" placeholder="검색어를 입력해주세요.">
					</span> <span>
						<button type="submit">검색</button>
					</span>
				</div>

			</form>
		</div>
	</div>
	<div class="child-page-listing">

		<h2>여행 정보</h2>

		<div class="grid-container">
			<c:forEach var="vo" items="${tourList}">
			<article class="location-listing">

				<a class="location-title" href="/travel_information/${vo.get('contentid')}">${vo.get("title")}</a>

				<div class="location-image">
					<a href="#"> <img src="${vo.get('firstimage')}"></a>		
				</div>
				<div>
					<p>${vo.get("title")}</p>
					<p>${vo.get("addr1")}</p>			
				</div>
				<br/>
				<div class="review-content">

					</div>
			</article>
			</c:forEach>
			</div>
		<!-- end grid container -->
		</div>

	
	<!-- 페이징 -->

</body>
