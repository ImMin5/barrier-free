function load_map(mapy, mapx) {
	    // 웹페이지 로딩시 시작.
		 

	    mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	       center : new kakao.maps.LatLng(mapy, mapx), // 지도의 중심좌표
	       level : 4
	    // 지도의 확대 레벨
	    };
	    map = new kakao.maps.Map(mapContainer, mapOption);

	    // 마커가 표시될 위치입니다 
	    var markerPosition = new kakao.maps.LatLng(mapy, mapx);

	    // 마커를 생성합니다
	    var marker = new kakao.maps.Marker({
	       position : markerPosition
	    });
	 
	    // 마커가 지도 위에 표시되도록 설정합니다
	    marker.setMap(map);
	}