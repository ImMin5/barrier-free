<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>map</title>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<c:set var="url" value="<%=request.getContextPath()%>" />
<link rel="stylesheet" href="${url}/css/mapstyle.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a4370da25b2b005f46ac559243f9b721"></script>
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
			<div class="listContentWrap ">
				<ul class="listContent" id="listContent"></ul>
			</div>
		</div>
		<!-- 지도 -->
		<div class="map_wrap">
			<div id="map"
				style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
			<!-- 지도타입 컨트롤 div 입니다 -->
			<div class="custom_typecontrol radius_border">
				<span id="btnRoadmap" class="selected_btn" onclick="setMapType('roadmap')">지도</span> 
				<span id="btnSkyview" class="btn" onclick="setMapType('skyview')">스카이뷰</span>
			</div>
			<!-- 지도 확대, 축소 컨트롤 div 입니다 -->
			<div class="custom_zoomcontrol radius_border">
				<span onclick="zoomIn()"><img src="../../img/map/map_18.png"
					alt="확대"></span> <span onclick="zoomOut()"><img
					src="../../img/map/map_19.png" alt="축소"></span>
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

let tag =""; //초기화
//지금 창이 리스트인지 아닌지 구분하는 변수
let flag_plan = false;

//지도 타입
let currentTypeId;

	$(function(){
		//1. 웹페이지 로딩시 시작.
		load_map();
		get_jObj();
		//검색하는 스크립트  
		searchWord = $("#searchWord").val();
		$("#searchWordSubmit").on("click", function(event){
			event.preventDefault();
			if($("#searchWord").val()==""){
				alert("검색어를 입력하세요.");
				return false;
			}
		    if($("#searchWord").val() != ''){
		    	searchWord = $("#searchWord").val();
		    	get_jObj(pageNo,pageCount,searchWord);
		    }
		});
		
		//이벤트 대기중인 함수등 
		//목록으로 이동
		$("#list_btn").on("click", function(){
			console.log("목록 이동"); 
			remove_planList();
		});
	
		$("#planner_btn").on("click",function(){
			console.log("플래너");
			add_planList();
			remove_tourList();
		});
	
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
	function add_planList(){
		$(".searchFrmWrap").after(`
			<div class="planList">
				<div class="planCalendar">
					<span><img alt="" src="../../img/map/map_18.png">출발날짜</span>
					<form method="post" action="" id="">
						<input type="date" id="input_date" value="2022-01-31"/>
						<input type="submit" id="input_submit" onclick="input()" value="확인"/>
						<input type="checkbox" id="arr_nextday" onclick="update_arr_nextday()"/>
					</form>
					<!-- <input type="text" id="thedate" class="hasDatepicker" onchange="updateDate()" /> -->
				</div>
				<button class="companion"></button>
			</div>`);
		
		console.log("플래너 선택");
	}
	//플래너 제거
	function remove_planList(){
		$(".planList").remove();
		get_jObj(1,2,"");
	}
	//리스트 제거 
	function remove_tourList(){
		$(".tourlistContents").remove();
	}
	//오버레이 제거
	function remove_overlay(){
		for(var i=0; i<overlayList.length; i++){
     	   overlayList[i].setMap(null);
        }
	}
	
	//마커 제거 
	function remove_marker(){
		for(var i=0; i<markers.length; i++){
			console.log(markers[i]);
			markers[i].setMap(null);
	    }
		markers = [];
		positions = [];
	}

	//맵 리스트 불러오기	
	function get_jObj(){
		var url = "${url}/mapInfo?pageNo="+pageNo+"&pageCount="+pageCount+"&searchWord="+searchWord;
		$.ajax({
			url : url,
			type: "POST",
			success : function(data){
				remove_marker();
				console.log(JSON.parse(data));
				jobj = JSON.parse(data);
				show_map();
				make_list();
				console.log(jobj);
			},
			error : function(error){
			}
		})
	}
	
	//리스트 만들기
	function make_list(){
	      tag = "";
	      jobj.forEach(item=>{//"""템플릿 리터럴""", jsp에서는 중괄호 한번 더, forEach/innerHTML 더 찾아보기
	         tag += `<div class="tourlistContents">
	                  <a><img class="listImg" src=${'${item.firstimage}'}></a>
	                  <h1>${'${item.title}'}</h1>
	                  <li class="item_f">${'${item.addr1}'}</li>
	                  <li class="item_s scroll">${'${item.overview}'}</li>
	                  <div class="listSubInfoWrap">
	                         <div class="listSubInfo">
	                             <img class="listSubInfoImg" src="../../img/map/map_07.png">
	                             <span>${'${item.likeCount}'}</span>
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
	      //Document.getElementById("").innerHTML = tag;
	      $("#listContent").html(tag);
	}
	
	//지도를 불러오는 함수
    function load_map(){
		console.log("load map");
        mapContainer = document.getElementById('map'), // 지도를 표시할 div 
        mapOption = {
        	center: new kakao.maps.LatLng(33.451475, 126.570528), // 지도의 중심좌표
        	level: 8 // 지도의 확대 레벨
        	};
        map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니
    }
        
        //지도에 표시 하는 함수
    function show_map(){
    	console.log("지도 시작");
        var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
            
        // 마커 이미지의 이미지 크기 입니다
        const imageSize = new kakao.maps.Size(24, 35); 
        // 마커 이미지를 생성합니다    
        const markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
            
             console.log("마커 생성");
            for(let index = 0; index < jobj.length; index++){
            	console.log("마커 생성1");
               positions.push({
                  title:jobj[index].title,
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
            console.log("마커 생성2");
            for(let index=0; index < positions.length; index++){
                let data = positions[index];
                displayMarker(data);
            }
            // Draw Overlay Over Marker
            function displayMarker(data) {
            	 console.log("마커 그리기");
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
                
                var content = document.createElement('div');
                content.innerHTML =  data.title;
                content.style.cssText = 'background: white; border: 1px solid black';
                
                var closeBtn = document.createElement('button');
                closeBtn.innerHTML = '닫기';
                closeBtn.onclick = function () {
                    overlay.setMap(null);
                };
                
                var addBtn = document.createElement('button');
                closeBtn.innerHTML = '닫기';
                closeBtn.onclick = function () {
                    overlay.setMap(null);
                };
                content.appendChild(closeBtn);
                overlay.setContent(content);
                //오버레이 저장
                overlayList.push(overlay);
                markers.push(marker);
                kakao.maps.event.addListener(marker, 'click', function() {
                   // 이전의 Overlay for문을 돌려서 setmap(null);
                   for(var i=0; i<overlayList.length; i++){
                	   console.log(overlayList[i]);
                	   overlayList[i].setMap(null);
                   }
                   overlay.setMap(map);
                    
                });
                
            }
        }
         
         
 </script>
</html>