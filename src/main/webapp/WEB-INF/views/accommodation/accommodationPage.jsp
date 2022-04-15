<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="url" value="<%=request.getContextPath()%>" />

<title>Insert title here</title>
<link rel="stylesheet" href="${url}/css/accommodationstyle.css"
	type="text/css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<div class="container">
		<p class="main_tit">
			<strong>무장애 관광지</strong> 찾기
		</p>

		<form name="sch_form" id="sch_form" method="get" action="/"
			onsubmit="return goSearch();">
			<input type="hidden" name="menucode" value="20100"> <input
				type="hidden" name="tmenu" value="vacationland"> <input
				type="hidden" name="orderby" value="reg_date">

			<div class="check_box">
				<p>
					<strong>관광약자 편의시설</strong>을 선택하세요!
				</p>
				<ul>
					<li><input type="checkbox" name="s_gt10[]" id="check01"
						value="1" class="icon1"> <label for="check01"><span>장애인화장실</span></label>
					</li>
					<li><input type="checkbox" name="s_gt10[]" id="check02"
						value="2" class="icon2"> <label for="check02"><span>엘리베이터</span></label>
					</li>
					<li><input type="checkbox" name="s_gt10[]" id="check03"
						value="3" class="icon3"> <label for="check03"><span>장애인
								주차장</span></label></li>
					<li><input type="checkbox" name="s_gt10[]" id="check04"
						value="4" class="icon4"> <label for="check04"><span>경사로</span></label>
					</li>
					<li><input type="checkbox" name="s_gt10[]" id="check05"
						value="5" class="icon5"> <label for="check05"><span>지하철</span></label>
					</li>
					<li><input type="checkbox" name="s_gt10[]" id="check06"
						value="6" class="icon6"> <label for="check06"><span>버스정류장</span></label>
					</li>
					<li><input type="checkbox" name="s_gt10[]" id="check07"
						value="7" class="icon7"> <label for="check07"><span>휠체어
								대여</span></label></li>
					<li><input type="checkbox" name="s_gt10[]" id="check08"
						value="8" class="icon8"> <label for="check08"><span>촉지도식
								안내판 설치</span></label></li>
					<li><input type="checkbox" name="s_gt10[]" id="check09"
						value="9" class="icon9"> <label for="check09"><span>오디오
								가이드</span></label></li>
					<li><input type="checkbox" name="s_gt10[]" id="check10"
						value="10" class="icon10"> <label for="check10"><span>아기돌봄/수유실</span></label>
					</li>
					<li><input type="checkbox" name="s_gt10[]" id="check11"
						value="11" class="icon11"> <label for="check11"><span>무장애
								객실</span></label></li>
					<li><input type="checkbox" name="s_gt10[]" id="check12"
						value="12" class="icon12"> <label for="check12"><span>유아차
								대여</span></label></li>
				</ul>
			</div>
			<div class="form_box">
				<span> <label for="areaForm">지역</label> <select
					name="s_local" id="s_local">
						<option value="" selected="">전체</option>
						<option value="제주시">제주시</option>
						<option value="조천읍">조천읍</option>
						<option value="구좌읍">구좌읍</option>
						<option value="성산읍">성산읍</option>
						<option value="표선면">표선면</option>
						<option value="남원읍">남원읍</option>
						<option value="서귀포시">서귀포시</option>
						<option value="중문">중문</option>
						<option value="안덕면">안덕면</option>
						<option value="대정읍">대정읍</option>
						<option value="한경면">한경면</option>
						<option value="한림읍">한림읍</option>
						<option value="애월읍">애월읍</option>
				</select>

				</span> <span> <label for="keywordForm">키워드</label> <select
					name="s_type" id="s_type">
						<option value="" selected="">전체</option>
						<option value="subject">이름</option>
						<option value="content">내용</option>
				</select>
				</span> <span> <input type="text" name="s_key" id="s_key"
					class="sch_input" title="검색어 입력" value="" maxlength="20"
					placeholder="검색어를 입력해주세요.">
				</span> <span><button type="submit">검색</button></span>
			</div>

		</form>

	</div>
	<div class='acontainer'>
		<form method="get" action="/accommodation" id="accommoList">
			<div id=aList>
				<h1>숙박 정보</h1>
				<hr />
				<table border="1">
					<tr>
						<th>이름</th>
						<th>주소</th>
						<th>별점</th>
					</tr>

				</table>
				<div>
					<form method="get" action="/accommodation" id="asearchFrm">
						<select name="searchKey">
							<option value="name">이름</option>
							<option value="address">주소</option>
						</select> <input type="text" name="searchWord" id="searchWord" /> <input
							type="submit" value="Search" />
					</form>
				</div>
			</div>
			<div id='aimagecontainer'>
				<img src="#" height="300" width="500">
				<table>
					<tr>
						<th>이름</th>
						<th>주소</th>
						<th>전화번호</th>
						<th>홈페이지</th>
						<th>소개</th>
					</tr>

				</table>
			</div>
		</form>
	</div>
</body>
