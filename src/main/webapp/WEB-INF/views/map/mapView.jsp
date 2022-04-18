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
<script>
   $(function(){
      //console.log(${tourList }); //즉시 실행함수로 foreach문을 돌려서 확인먼저 하고 짜기. 
      let tag =""; //초기화
      
      ${tourList}.forEach(item=>{//"""템플릿 리터럴""", jsp에서는 중괄호 한번 더, forEach/innerHTML 더 찾아보기
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
   });
   
   $(function(){//검색하는 스크립트
      var searchWord = $("#searchWord").val();
      $("#searchFrm").submit(function(){
         if($("#searchWord").val()==""){
            alert("검색어를 입력하세요.");
            return false;
         }
         if($("#searchWord").val() != ''){
            window.location.href = "${url}/mapView?pageCount=10&pageNum=1&serachWord=" + searchWord;
         }
      });
   });
   
</script>
</head>
<body>
   <div id="listWrap">
        <!-- 리스트 -->
        <div id="list">
            <!-- 리스트 버튼 -->
            <div class="topBotton">
                <button onclick="location.href='/mapView'" class="listbutton">목록</button>
                <button onclick="location.href='/planView'" class="planbutton">플래너</button>
            </div>
            <!-- 검색 -->
         <div class="searchFrmWrap">
            <form method="get" action="#" id="searchFrm">
               <input type="text" name="searchWord" id="searchWord"/>
               <input type="submit" value="장소검색" id="searchWordSubmit"/>
            </form>
         </div>
            <!-- 리스트 내용 -->
            <div class="listContentWrap ">
                  <ul class="listContent" id="listContent"></ul>
            </div>
        </div>
        <!-- 지도 -->
        <div class="map_wrap">
            <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
            <!-- 지도타입 컨트롤 div 입니다 -->
            <div class="custom_typecontrol radius_border">
                <span id="btnRoadmap" class="selected_btn" onclick="setMapType('roadmap')">지도</span>
                <span id="btnSkyview" class="btn" onclick="setMapType('skyview')">스카이뷰</span>
            </div>
            <!-- 지도 확대, 축소 컨트롤 div 입니다 -->
            <div class="custom_zoomcontrol radius_border">
                <span onclick="zoomIn()"><img src="../../img/map/map_18.png" alt="확대"></span>
                <span onclick="zoomOut()"><img src="../../img/map/map_19.png" alt="축소"></span>
            </div>
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a4370da25b2b005f46ac559243f9b721"></script>
        <script>
        // https://devtalk.kakao.com/t/topic/60502?u=ad6979&source_topic_id=93671
        // https://devtalk.kakao.com/t/topic/96966
      // https://velog.io/@breeze202/%EB%88%88%EB%AC%BC%EC%9D%98-%EC%B9%B4%EC%B9%B4%EC%98%A4%EB%A7%B5-%EA%B5%AC%ED%98%84-%EC%9D%BC%EC%A7%80-1%ED%83%84.-%EB%8B%A4%EC%A4%91-%EC%BB%A4%EC%8A%A4%ED%85%80-%EC%98%A4%EB%B2%84%EB%A0%88%EC%9D%B4-%EC%9D%B4%EB%B2%A4%ED%8A%B8%EA%B0%80-%EC%9D%B4%EC%83%81%ED%95%98%EB%8B%A4
        // https://apis.map.kakao.com/web/sample/dragCustomOverlay/   
        // https://devtalk.kakao.com/t/topic/41602/4
        // https://apis.map.kakao.com/web/sample/categoryFromBounds/
        // https://devtalk.kakao.com/t/topic/72032
        // https://devtalk.kakao.com/t/topic/103147
        // https://devtalk.kakao.com/t/topic/96966/3
        // https://gist.github.com/DaumMaps/4840802f2ad080c91f79
          $(function(){
             let positions = [];
              var markers = []; // 지도에 표시된 마커 객체를 가지고 있을 배열입니다
            var contents = [];
            var overlays = [];
            
             var clickedOverlay = null;
             
             //오버레이를 저장할 리스트 생성
             var overlayList = [];
             
             var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
               mapOption = {
                   center: new kakao.maps.LatLng(33.451475, 126.570528), // 지도의 중심좌표
                   level: 8 // 지도의 확대 레벨
               };
   
              var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
              
              //console.log(${tourList});
              var jobj = ${tourList};
            // alert(jobj[0].mapx+"/"+jobj[0].mapy);
           
              // 마커 이미지의 이미지 주소입니다
              //var imageSrc = "/img/map/map_01.png"; 
              var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
              
              // 마커 이미지의 이미지 크기 입니다
              const imageSize = new kakao.maps.Size(24, 35); 
               
               // 마커 이미지를 생성합니다    
               const markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
               
              for(let index = 0; index < jobj.length; index++){
                 
                 positions.push({
                    title:jobj[index].title,
                    latlng: new kakao.maps.LatLng(jobj[index].mapy, jobj[index].mapx)
                 })
                 
                 const marker = new kakao.maps.Marker({
                      map: map, // 마커를 표시할 지도
                      position: new kakao.maps.LatLng(jobj[index].mapy, jobj[index].mapx),
                      title : jobj[index].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
                      clickable: true,
                      image : markerImage // 마커 이미지
                  });
              }
              
              for(let index=0; index < positions.length; index++){
                  let data = positions[index];
                  displayMarker(data);
              }
              // Draw Overlay Over Marker
              function displayMarker(data) {
                 
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
                  kakao.maps.event.addListener(marker, 'click', function() {
                     // 이전의 Overlay for문을 돌려서 setmap(null);
                     for(var i=0; i<overlayList.length; i++){
                    	console.log(overlayList[i]);
                    	 overlayList[i].setMap(null);
                     }
                      overlay.setMap(map);
                      
                  });
                  
              }
              function closeOverlay() {
                   overlay.setMap(null);
            }
              
              // 순서 찾아보기- 카카오 api document 확인해보기!!!
               // 지도 확대 ----------------------------------------------------------//
               // 지도타입 컨트롤의 지도 또는 스카이뷰 버튼을 클릭하면 호출되어 지도타입을 바꾸는 함수입니다
               function setMapType(maptype) {
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
         });///////
         
         
        </script>
        <!-- 플래너 생성 버튼 
        <div class="planCreate">
            <a href="#" class="button">플래너 생성 +</a>
        </div>-->
    </div>
</body>
</html>