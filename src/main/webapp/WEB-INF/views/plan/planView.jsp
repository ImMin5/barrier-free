<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>map</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<c:set var="url" value="<%=request.getContextPath()%>" />
<link rel="stylesheet" href="${url}/css/planstyle.css">
<script>
	function updateDate()
	{
		getAirPrice();
	//	showLoading(thedate);
		getHighlights(lastHighlight);
		saveCookie();
	//	drawDayList();
		updateDateInOut();
		updateDateSilent(0);
	
	}
	
	function update_arr_nextday()
	{
		saveCookie();
		updateTerm();
		updateDateInOut();
	}
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
            <div class="searchFrmWrap">
            <form method="get" action="#" id="searchFrm">
               <input type="text" name="searchWord" id="searchWord"/>
               <input type="submit" value="장소검색" id="searchWordSubmit"/>
            </form>
         	</div>
            <div class="planList">
            	<div class="planCalendar">
            		<span>
            			<img alt="" src="../../img/map/map_18.png">
            			출발날짜
            		</span>
            		<form method="post" action="" id="">
            			<input type="date" id="input_date" value="2022-01-31"/>
            			<input type="submit" id="input_submit" onclick="input()" value="확인"/>
            			<input type="checkbox" id="arr_nextday" onclick="update_arr_nextday()"/>
            		</form>
            		<!-- <input type="text" id="thedate" class="hasDatepicker" onchange="updateDate()" /> -->
            	</div>
            	<button class="companion"></button>
            </div>

            <!-- 리스트 내용 -->
            <div class="listContent">
                <div class="listContentWrap">
                	<div class="listMonth"></div>
                	<div class="listTitle"></div>
                	<div class="listAddr"></div>
                </div>
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
        <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a4370da25b2b005f46ac559243f9b721"></script>
        <script>
            var overlayArr = [];
            var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                mapOption = {
                    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                    level: 3 // 지도의 확대 레벨
                };

            var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

            // 마커 생성 ----------------------------------------------------------//
            // 마커를 표시할 위치와 내용을 가지고 있는 객체 배열입니다 
            //var jobj = ${tourList};
            /* var positions = [
                {
                    //content: jobj.get("title");
                    content: '<div>카카오</div>',   //jboj.get("mapX"), jboj.get("mapY");
                    latlng: new kakao.maps.LatLng(33.450705, 126.570677)
                },
                {
                    content: '<div>생태연못</div>', 
                    latlng: new kakao.maps.LatLng(33.450936, 126.569477)
                },
                {
                    content: '<div>텃밭</div>', 
                    latlng: new kakao.maps.LatLng(33.450879, 126.569940)
                },
                {
                    content: '<div>근린공원</div>',
                    latlng: new kakao.maps.LatLng(33.451393, 126.570738)
                }
            ];
        
            
            for (var i = 0; i < positions.length; i ++) {
                // 마커를 생성합니다
                var marker = new kakao.maps.Marker({
                    map: map, // 마커를 표시할 지도
                    position: positions[i].latlng // 마커의 위치
                });
            
                // 마커에 표시할 인포윈도우를 생성합니다 
                var infowindow = new kakao.maps.InfoWindow({
                    content: positions[i].content // 인포윈도우에 표시할 내용
                });
                
                    // 커스텀 오버레이에 표시할 컨텐츠 입니다
                // 커스텀 오버레이는 아래와 같이 사용자가 자유롭게 컨텐츠를 구성하고 이벤트를 제어할 수 있기 때문에
                // 별도의 이벤트 메소드를 제공하지 않습니다 
                var content2 = '<div class="wrap">' + 
                            '    <div class="info">' + 
                            '        <div class="title">' + 
                                        positions[i].content + 
                            '            <div class="close" onclick="closeOverlay('+i+')" title="닫기"></div>' + 
                            '        </div>' + 
                            '        <div class="body">' + 
                            '            <div class="img">' +
                            '                <img src="https://cfile181.uf.daum.net/image/250649365602043421936D" width="73" height="70">' +
                            '           </div>' + 
                            '            <div class="desc">' + 
                            '                <div class="ellipsis">제주특별자치도 제주시 첨단로 242</div>' + 
                            '                <div class="jibun ellipsis">(우) 63309 (지번) 영평동 2181</div>' + 
                            '                <div><a href="https://www.kakaocorp.com/main" target="_blank" class="link">홈페이지</a></div>' + 
                            '            </div>' + 
                            '        </div>' + 
                            '    </div>' +    
                            '</div>';
                
                var overlay = new kakao.maps.CustomOverlay({
                                content: content2,
                                map: map,
                                position: marker.getPosition()       
                            });	
                overlayArr.push(overlay);
                    
                // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
                // 이벤트 리스너로는 클로저를 만들어 등록합니다 
                // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
                //kakao.maps.event.addListener(marker, 'click', makeOverListener(map, marker, infowindow));
                kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
                
                // 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
                kakao.maps.event.addListener(marker, 'click', function() {
                    $(".wrap").show();
                    overlay.setMap(map);
                });
                // 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
                
            } */

            /* function closeOverlay(i) {
                //alert(i)
                overlayArr[i].setMap(null);     
            } */
            // 마커 위에 커스텀오버레이를 표시합니다
            // 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
            /* var overlay = new kakao.maps.CustomOverlay({
                        content: content2,
                        map: map,
                        position: marker.getPosition()       
                    });	 */

            // 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
            /* function makeOverListener(map, marker, infowindow) {
                return function() {
                    infowindow.open(map, marker);
                };
            } */

            // 인포윈도우를 닫는 클로저를 만드는 함수입니다 
            /* function makeOutListener(infowindow) {
                return function() {
                    infowindow.close();
                };
            } */


            // 마커 생성 ----------------------------------------------------------//

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
        </script>
        <!-- 플래너 생성 버튼 -->
        <div class="planCreate">
            <a href="#" class="button">플래너 생성 +</a>
        </div>
    </div>
</body>
</html>