<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>map</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <c:set var="url" value="<%=request.getContextPath()%>" />
    <link rel="stylesheet" href="${url}/css/mapstyle.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a4370da25b2b005f46ac559243f9b721"></script>
</head>

<body>
    <div id="listWrap">
        <!-- 리스트 -->
        <div id="list">
            <!-- 리스트 버튼 -->
            <div class="topBotton">
                <button id="list_btn" class="listbutton">목록</button>
                <button id="planner_btn" class="planbutton">플래너</button>
            </div>
            <!-- 검색 -->
            <div class="searchFrmWrap">
                <div id="searchFrm">
                    <input type="text" name="searchWord" id="searchWord" />
                    <input type="button" value="장소검색" id="searchWordSubmit" />
                </div>
            </div>
            <!-- 리스트 내용 -->
            <div class="listContentWrap" id="listContentWrap">
                
            </div>
        </div>
        <!-- 지도 -->
        <div class="map_wrap">
            <div id="map" style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
            <!-- 지도타입 컨트롤 div 입니다 -->
            <div class="custom_typecontrol radius_border">
                <span id="btnRoadmap" class="selected_btn" onclick="setMapType('roadmap')">지도</span>
                <span id="btnSkyview" class="btn" onclick="setMapType('skyview')">스카이뷰</span>
            </div>
            <!-- 지도 확대, 축소 컨트롤 div 입니다 -->
            <div class="custom_zoomcontrol radius_border">
                <span onclick="zoomIn()"><img src="../../img/map/map_18.png" alt="확대"></span> <span
                    onclick="zoomOut()"><img src="../../img/map/map_19.png" alt="축소"></span>
            </div>
        </div>
    </div>
</body>
<script>
    let jobj;
    let positions = [];
    let markers = []; // 지도에 표시된 마커 객체를 가지고 있을 배열입니다
    let contents = [];
    let map;
    let clickedOverlay = null;
    let pageNo = 1;
    let pageCount = 2;
    let searchWord = "";

    //오버레이를 저장할 리스트 생성
    let overlayList = [];
    //플래너 정보 저장

    let tag = ""; //초기화
    //지금 창이 리스트인지 아닌지 구분하는 변수
    let flag_plan = false;

    //지도 타입
    let currentTypeId;

    $(function () {
        // 웹페이지 로딩시 시작.
        load_map();
        get_jObj();

        // 검색하는 스크립트  
        searchWord = $("#searchWord").val();
        $("#searchWordSubmit").on("click", function (event) {
            event.preventDefault();
            if ($("#searchWord").val() == "") {
                alert("검색어를 입력하세요.");
                return false;
            }
            if ($("#searchWord").val() != '') {
                searchWord = $("#searchWord").val();
                get_jObj(pageNo, pageCount, searchWord);
            }
        });

        //이벤트 대기중인 함수 등 
        //목록으로 이동
        $("#list_btn").on("click", function () {
            if (flag_plan) {
                console.log("목록 이동");
                remove_planList();
                flag_plan = false;
                
                $(this).css("background", "#FAA631")
                $(this).css("color", "#FFFFFF")
                $("#planner_btn").css("background", "#F2F2F2")
                $("#planner_btn").css("color", "#000000")  
            }
        });
     	// F2F2F2 - 회색
        // FAA631 - 주황
        // 024d09 - 초록
        //$("#list_btn").hover(function(){
        	//$(this).removeClass('or')
            //$(this).removeClass('gray')
            //$(this).addClass('green')
        //}, function() {
        	//$(this).css("background","#FAA631");
        	
        	//$(this).removeClass('green')
        	//$(this).removeClass('gray')
        	//$(this).addClass('or')
        //});
        
        //플래너로 이동
        $("#planner_btn").on("click", function () {
            if (!flag_plan) {
                console.log("플래너");
                add_planList();
                remove_tourList();
                flag_plan = true;
                $(this).css("background", "#FAA631")
                $(this).css("color", "#FFFFFF")
                $("#list_btn").css("background", "#F2F2F2")
                $("#list_btn").css("color", "#000000")                
            }
        });
        //$("#planner_btn").hover(function(){
            //$(this).css("background","#024d09");
            //$(this).removeClass('or')
            //$(this).removeClass('gray')
            //$(this).addClass('green')
            
        //}, function() {
        	//$(this).css("background","#024d09");
        	//$(this).addClass('gray')
        	//$(this).removeClass('or')
        	//$(this).removeClass('green')
        //});
        
        // 순서 찾아보기- 카카오 api document 확인해보기!!!
        // 지도 확대 ----------------------------------------------------------//
        // 지도타입 컨트롤의 지도 또는 스카이뷰 버튼을 클릭하면 호출되어 지도타입을 바꾸는 함수입니다
        function setMapType(maptype) {
            var changeMaptype;

            console.log("맵타입" + maptype);
            var roadmapControl = document.getElementById('btnRoadmap');
            var skyviewControl = document.getElementById('btnSkyview');
            if (maptype === 'roadmap') {
                map.setMapTypeId(kakao.maps.MapTypeId.ROADMAP);
                roadmapControl.className = 'selected_btn';
                skyviewControl.className = 'btn';
            } else {
                map.setMapTypeId(kakao.maps.MapTypeId.HYBRID);
                skyviewControl.className = 'selected_btn';
                roadmapControl.className = 'btn';
            }
        }
        // 지도 확대, 축소 컨트롤에서 확대 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
        function zoomIn() {
            map.setLevel(map.getLevel() - 1);
        }

        // 지도 확대, 축소 컨트롤에서 축소 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
        function zoomOut() {
            map.setLevel(map.getLevel() + 1);
        }
    });////// $(function) end
    
    //플래너 생성
    function add_planList() {
    	// $(".searchFrmWrap").after(`
    	var plantag=`    		   
    		<!-- 나의 플랜 이름 -->
			<div class="myplanName">
				<span>
           			<img alt="" src="../../img/map/map_18.png" >
           			플랜 제목
           		</span>
				<form method="get" action="#" id="myplanNameFrm">
					<input type="text" name="planName" id="planName"/>
					<input type="submit" value="제목등록" id="planNameSubmit"/>
				</form>
			</div>
			<!-- 플랜추가 -->
            <div class="planList">
           		<span>
           			<img alt="" src="../../img/map/map_18.png" >
           			출발 날짜
           		</span>
           		<form method="post" action="" id="datefrm">
           			<input type="date" id="input_date" value="2022-01-31"/>
           			<input type="submit" id="input_submit" onclick="input()" value="날짜등록"/>
           		</form>
           		<!-- <input type="text" id="thedate" class="hasDatepicker" onchange="updateDate()" /> -->
            	<button class="companion" >동행자 추가 +</button>
            </div>
            <!-- 리스트 내용 -->
            <div class="plan_listContentWrap">
                <div class="plan_listContent">
                	<div class="plan_days">(----넘버링으로 바꾸기----)</div>
	                <h1>제주동문시장</h1>
	                <ul>
	                    <li>주소: 제주 제주시 관덕로14길 20</li>
	                    <li>싱싱한 농수산물, 의류, 잡화 등을 판매하는 역사가 오래된 실내 시장입니다.</li>
	                </ul>
                </div>
                <div class="plan_listCancelbutton">
	                <button class="plan_listCancel" >취소</button>
	                <input type="submit" id="plan_listSave" onclick="#" value="저장"/>
                </div>
            </div>
        `;//);
        //alert(plantag);
        console.log("플래너 선택");
        $('#listContentWrap').html(plantag);
    }

    //플래너 제거
    function remove_planList() {
        $(".planList").remove();
        get_jObj(1, 2, "");
    }
    //리스트 제거 
    function remove_tourList() {
        $(".tourlistContents").remove();
    }
    //오버레이 제거
    function remove_overlay() {
        for (var i = 0; i < overlayList.length; i++) {
            overlayList[i].setMap(null);
        }
    }
    //마커 제거 
    function remove_marker() {
        for (var i = 0; i < markers.length; i++) {
            console.log(markers[i]);
            markers[i].setMap(null);
        }
        markers = [];
        positions = [];
    }

    //맵 리스트 불러오기   
    function get_jObj() {
        var url = "${url}/mapInfo?pageNo=" + pageNo + "&pageCount=" + pageCount + "&searchWord=" + searchWord;
        $.ajax({
            url: url,
            type: "POST",
            success: function (data) {
                //데이터 갱신
                console.log(JSON.parse(data));
                jobj = JSON.parse(data);
                remove_marker();
                show_map();
                make_list();
                console.log(jobj);
            },
            error: function (error) {
            }
        })
    }

    //리스트 만들기
    function make_list() {
        tag = '<ul class="listContent" id="listContent">';
        jobj.forEach(item => {//"""템플릿 리터럴""", jsp에서는 중괄호 한번 더, forEach/innerHTML 더 찾아보기
            tag += `<div class="tourlistContents">
                <a><img class="listImg" src=${'${item.firstimage}'}></a>
                <h1>${'${item.title}'}</h1>
                <li class="item_f">${'${item.addr1}'}</li>
                <li class="item_s scroll">${'${item.overview}'}</li>
                <div class="listSubInfoWrap">
                    <div class="listSubInfo">
                        <img class="listSubInfoImg" src="../../img/map/map_07.png">
                        <span>${'${item.likeCount}'}</span>
                        // 좋아요 카운트 추가하기
                    </div>
                    <div class="listSubInfo">
                        <img class="listSubInfoImg" src="../../img/map/map_08.png">
                        <span>${'${item.heartCount}'}</span>
                    </div>
                    <div class="listSubInfo">
                        <img class="listSubInfoImg" src="../../img/map/map_09.png">
                        <span>${'${item.avgScore}'}(${'${item.reviewCount}'})</span>
                    </div>
                    </div>
            </div>`
        });
        tag+= "</ul>";
        //alert(tag);
        
        //Document.getElementById("").innerHTML = tag;
        $("#listContentWrap").html(tag);
    }

    //지도를 불러오는 함수
    function load_map() {
        console.log("load map");
        mapContainer = document.getElementById('map'), // 지도를 표시할 div 
            mapOption = {
                center: new kakao.maps.LatLng(33.451475, 126.570528), // 지도의 중심좌표
                level: 8 // 지도의 확대 레벨
            };
        map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니
    }

    //지도에 표시 하는 함수
    function show_map() {
        console.log("지도 시작");
        var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";

        // 마커 이미지의 이미지 크기 입니다
        const imageSize = new kakao.maps.Size(24, 35);
        // 마커 이미지를 생성합니다    
        const markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

        //console.log("마커 생성");
        for (let index = 0; index < jobj.length; index++) {
            //console.log("마커 생성1");
            positions.push({
                title: jobj[index].title,
             	// 수정 자리
                img:jobj[index].firstimage,
                ellipsis:jobj[index].addr1,
                latlng: new kakao.maps.LatLng(jobj[index].mapy, jobj[index].mapx)
            })
            /*
            const marker = new kakao.maps.Marker({
                    map: map, // 마커를 표시할 지도
                    position: new kakao.maps.LatLng(jobj[index].mapy, jobj[index].mapx),
                    title : jobj[index].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
                    clickable: true,
                    image : markerImage // 마커 이미지
                });
            */
            //마커 저장
        }
        //console.log("마커 생성2");
        for (let index = 0; index < positions.length; index++) {
            let data = positions[index];
            displayMarker(data);
        }
        // Draw Overlay Over Marker
        function displayMarker(data) {
            //console.log("마커 그리기");
            var marker = new kakao.maps.Marker({
                map: map,
                title: data.title,
                position: data.latlng
            });

            // Overlay
            var overlay = new kakao.maps.CustomOverlay({
                yAnchor: 3,
                position: marker.getPosition()
            });
            
          	//마커 위에 커스텀오버레이 콘텐츠 Dom으로 구현 시작
			var Customcontent = document.createElement('div');
			Customcontent.className = "wrap";

			var info = document.createElement('div');
			info.className = "info"			
			Customcontent.appendChild(info);

			//커스텀오버레이 타이틀
			var contentTitle = document.createElement("div");
			contentTitle.className = "title"
			contentTitle.innerHTML = data.title;
			info.appendChild(contentTitle);

			//커스텀오버레이 닫기 버튼
			var closeBtn = document.createElement("div");
			closeBtn.className = "close";
			closeBtn.setAttribute("title","닫기");
			closeBtn.onclick = function() { overlay.setMap(null); };
			contentTitle.appendChild(closeBtn);

			var bodyContent = document.createElement("div");
			bodyContent.className = "body";
			info.appendChild(bodyContent);

			var imgDiv = document.createElement("div");
			imgDiv.className = "img";
			bodyContent.appendChild(imgDiv);

			//커스텀오버레이 이미지
			var imgContent = document.createElement("img");
			//imgContent.innerHTML = data.img;
			imgContent.setAttribute("src", data.img);
			imgContent.setAttribute("width", "70");
			imgContent.setAttribute("heigth", "70");
			imgDiv.appendChild(imgContent);

			var descContent = document.createElement("div");
			descContent.className = "desc"
			bodyContent.appendChild(descContent);

			//커스텀오버레이 주소			
			var addressContent = document.createElement("div");
			addressContent.className = "ellipsis";
			addressContent.innerHTML = data.ellipsis;
			console.log(data.addr1);
			console.log(data.title);
			descContent.appendChild(addressContent);

			//커스텀오버레이 상세정보
			var address2Content = document.createElement("div");
			address2Content.className = "jibun ellipsis";
			addressContent.innerHTML = data.addr1;
			descContent.appendChild(address2Content);

			var LinkDiv = document.createElement("div");
			descContent.appendChild(LinkDiv);

			//커스텀오버레이 링크
			var LinkContent = document.createElement("a");
			
			LinkContent.className = "link";
			LinkContent.target="_blank";
			LinkContent.href="https://www.naver.com/";
			LinkContent.appendChild(document.createTextNode("홈페이지"));
			LinkDiv.appendChild(LinkContent);
			//마커 위에 커스텀오버레이 콘텐츠 Dom으로 구현 끝
            
            //CustomOverlay.setContent(Customcontent);
            overlay.setContent(Customcontent);

            //오버레이 저장
            overlayList.push(overlay);
            markers.push(marker);
            kakao.maps.event.addListener(marker, 'click', function () {
                // 이전의 Overlay for문을 돌려서 setmap(null);
                for (var i = 0; i < overlayList.length; i++) {
                    console.log(overlayList[i]);
                    overlayList[i].setMap(null);
                }
                overlay.setMap(map);
            });
        }
    }
</script>
</html>