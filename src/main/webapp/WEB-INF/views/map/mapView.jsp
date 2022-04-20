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
	<script type="text/javascript" src="${url}/js/ai_api.js"></script>
	
	
</head>
<body>
    <div id="listWrap">
        <!-- 리스트 -->
        <div id="list">
            <!-- 리스트 버튼 -->
            <div class="topBotton">
                <button id="list_btn" class="listbutton">목록</button>
                <button id="planner_btn" class="planbutton" onclick="">플래너</button>
            </div>
            <!-- 검색 -->
            <div class="searchFrmWrap" >
                <div id="searchFrm">
                    <input type="text" name="searchWord" id="searchWord" />
                    <input type="button" value="장소검색" id="searchWordSubmit" />
                </div>
            </div>
            <div class="planListReader" style="display:none;">
          		<span>
	       			<img alt="" src="../../img/map/map_18.png" >
	       			플랜 목록
     			</span>
				<input type="select" name="listReader" id="listReader" placeholder="불러올 플래너를 선택해주세요"/>
				<input type="button" id="planListLoad_btn" value="불러오기"/>
			</div>
            <!-- 리스트 내용 -->
            <div class="listContentWrap" id="listContentWrap"></div>
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
	let pageNo = "1";
	let pageCount = "3";
	let searchWord = "";
	
	let seqList = [];
	let contentidList = [];
	
	let planlistContent =""; //여행 목록html 전체 저장
	let jobj_planner; //여행 목록에 있는 마커 생성을 위한 데이터 
	
	let planner_no =-1
	
	let idx=[];
	
	//오버레이를 저장할 리스트 생성
	let overlayList = [];
	
	//플래너 정보 저장
	let tag = ""; //초기화
	
	//지금 창이 리스트인지 아닌지 구분하는 변수
	let flag_plan = false; //false이면 리스트  true면 플래너
	
	//지도 타입
	let currentTypeId;


    $(function () {
        // 웹페이지 로딩시 시작.
        load_map();
        get_jObj();
        
        /*$(document).on("change","#planner_no",function(){
        	$("#planListSave_btn").text("수정");
        	console.log("change");
        });*/
        /*
        $(document).ready(function(){
           $("#planner_btn").trigger("click");
           $("#planner_btn").bind("click",function(){
               flag_plan = false;
                
                $(this).css("background", "#FAA631")
                $(this).css("color", "#FFFFFF")
                $("#planner_btn").css("background", "#F2F2F2")
                $("#planner_btn").css("color", "#000000")  
           })
        });*/
		
        // 검색하는 스크립트 ===========================================================
        searchWord = $("#searchWord").val();
        
        $("#searchWordSubmit").on("click", function (event) {
            //여행 플랜에서 검색을 할때 
            if(flag_plan){
               alert("목록으로 이동해 주세요.");
               return;
            }
              event.preventDefault();
              if(flag_plan)save_planlistContent(); //플래너의 html 목록 저장
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
        //목록으로 이동 ===========================================================
        $("#list_btn").on("click", function () {
            if (flag_plan) {
                //console.log("목록 이동");
                remove_planList();
                
                add_searchFrm();
                hide_planListReader();
                
                flag_plan = false;
                $(this).css("background", "#FAA631")
                $(this).css("color", "#FFFFFF")
                $("#planner_btn").css("background", "#F2F2F2")
                $("#planner_btn").css("color", "#000000")  
            }
        });
        
      //플래너로 이동 ===========================================================
        $("#planner_btn").on("click", function () {
            if (!flag_plan) {
                //console.log("플래너");
                add_planList();
                remove_tourList();
                
                add_planListReader();
                hide_searchFrm();
                
                flag_plan = true;
                $(this).css("background", "#FAA631")
                $(this).css("color", "#FFFFFF")
                $("#list_btn").css("background", "#F2F2F2")
                $("#list_btn").css("color", "#000000")                
            }
        });
    
     	//검색창 값 유무 판별 ===========================================================
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

        // 순서 찾아보기- 카카오 api document 확인해보기!!!
        // 지도 확대 ===========================================================
        // 지도타입 컨트롤의 지도 또는 스카이뷰 버튼을 클릭하면 호출되어 지도타입을 바꾸는 함수입니다
        /* function setMapType(maptype) {
            var changeMaptype;

            //console.log("맵타입" + maptype);
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
        }*/
    });// $(function) END
    
  	//맵 리스트 불러오기 ===========================================================    
    function get_jObj() {
        var url = "${url}/mapInfo"
        $.ajax({
            url: url,
            type: "POST",
            data :{
               pageNo : pageNo,
               pageCount : pageCount, 
               searchWord : searchWord,
            },
            success: function (data) {
               
                //데이터 갱신
                //console.log(JSON.parse(data));
                jobj = JSON.parse(data);
                remove_marker();
                show_map(jobj);
                if(jobj_planner === undefined){
                   
                }
                else{
                   console.log("jobj planner--> ",jobj_planner);
                    show_map(jobj_planner);
                }
                   
                make_list();
                //console.log(jobj);
            },
            error: function (error) {
            }
        })
    }
  
  	//리스트 만들기 ===========================================================
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
                        <img class="listSubInfoImg" src="../../img/map/map_08.png">
                        <span>${'${item.likeCount}'}</span>
                    </div>
                    <div class="listSubInfo">
                        <img class="listSubInfoImg" src="../../img/map/map_07.png">
                        <span>${'${item.heartCount}'}</span>
                    </div>
                    <div class="listSubInfo">
                        <img class="listSubInfoImg" src="../../img/map/map_09.png">
                        <span>${'${item.avgScore}'}(${'${item.reviewCount}'})</span>
                    </div>
                    <div class="listSubInfo">
	                    <button class="itemTitle_btn"onclick="tts('${'${item.title}'}')"><img src="../../img/map/map_30.png" width="25" height="25"></button>
	                    <button class="itemAddr_btn"onclick="tts('${'${item.addr1}'}')"><img src="../../img/map/map_30.png" width="25" height="25"></button>
                    </div>
				</div>
			</div>`
        });
        tag+= "</ul>";
        //좋아요 카운트 추가하기
        $("#listContentWrap").html(tag);
    }// make_list() END
    
  	//플래너 생성 ===========================================================
    function add_planList() {
    	var plantag=`    	
			<div class="myplan">
           		<form method="post" action="/planView" name="planFrm" id="planFrm" onsubmit="return ()">
	           		<div class="planSubject">
		           		<span>
			       			<img alt="" src="../../img/map/map_18.png" >
			       			플랜 제목
			       		</span>
						<input type="text" name="planSubject_text" id="planSubject_text" placeholder="제목을 입력해주세요."/>
						<button class="companion" id="companion" onclick="">동행자 추가 +</button>
						<input type="hidden" id="planner_no" />
					</div>
					<div class="planList">
						<span>
		           			<img alt="" src="../../img/map/map_18.png" >
		           			출발 날짜
		           		</span>
          				<input type="date" id="dateFrom" name="from" > ~ 
          				<input type="date" id="dateTo" name="to"> 
	           			<input type="button" name="btnSearch" id="btnSearch" onclick="dataCheck()"value="검색"> 
	           		</div>
	           		<div id="planListCancel" name="planListCancel">
	            		<input type="button" id="planListCancel_btn" onclick="" value="취소"/>
	        			<input type="button" id="planListSave_btn" onclick="save_plan()" value="저장"/>
	        			
	   				</div>
	           		<div class="planListContentWrap"></div>
	               		<div class="planlistContentBG" id="planlistContentBG"></div>
	           		</div>
				</form>
			</div>
        `;//);
        //console.log("플래너 선택");
        $('#listContentWrap').html(plantag);
  	}// add_planList()() END
  	
  	//플래너 추가하기로 생성되는 플래너 ===========================================================
  	function addPlanner(data){
    	var addplantag=`
	    	<div id="planlistContent" name="planlistContent">
		    	<input type="text" name="seq" id="seq">
				<input type="hidden" name="contentid" id="contentid" value=${'${data.contentid}'}>
				<div class="planTitle" id="planTitle">${'${data.title}'}</div>
		        <ul>
		        	<li class="planAddr plan_scroll" >${'${data.addr1}'}</li>
		            <li class="planOverview plan_scroll" >${'${data.overview}'}</li>
		        </ul>
		        <div class="planListImg">
		        	<img src=${'${data.img}'} >
		        </div>
		     </div>
        `;
        //console.log("data====>>>" , data);
    	$('#planlistContentBG').append(addplantag);
    }// addPlanner(data) END
    
	//플래너 불러오기 ===========================================================
    function readPlanner(data){
       var addplantag=`
       <div id="planlistContent" name="planlistContent">
          <input type="text" name="seq" id="seq" value=${'${data.seq}'} data-seq=${'${data.seq}'} readonly>
         <input type="hidden" name="contentid" id="contentid" value=${'${data.contentid}'}>
         <div class="planTitle" id="planTitle" value=${'${data.title}'}>${'${data.title}'}</div>
           <ul>
              <li class="planAddr plan_scroll" >${'${data.addr1}'}</li>
               <li class="planOverview plan_scroll" >${'${data.overview}'}</li>
           </ul>
           <div class="planListImg">
              <img src=${'${data.firstimage}'} >
           </div>
        </div>
        `;
       $('#planlistContentBG').append(addplantag);
    }  // readPlanner(data) END	
  	
  	
  	//동행자 추가 모달창으로
  	
  	//플래너 날짜 ===========================================================
	//날짜 유효성 검사 
	function dataCheck(dateFrom, dateTo){
		var dateFrom = document.getElementById('dateFrom'); //시작일 
		var dateTo = document.getElementById('dateTo'); //종료일 
		//var today = new Date(); //오늘 날짜 
		
		dateFrom = new Date(dateFrom.value); 
		var fromYear = dateFrom.getFullYear(); 
		var fromMonth = dateFrom.getMonth() + 1; 
		var fromDay = dateFrom.getDate(); 
		
		//날짜 지정을 하지 않았을 때 NaN이 발생하여 0으로 처리 
		if (isNaN(fromYear) || isNaN(fromMonth) || isNaN(fromDay)){
			fromYear = 0; 
			fromMonth = 0; 
			fromDay = 0; 
		} 
		dateFrom = fromYear +'/'+ fromMonth +'/'+fromDay; 
		
		dateTo = new Date(dateTo.value); 
		var toYear = dateTo.getFullYear(); 
		var toMonth = dateTo.getMonth() + 1; 
		var toDay = dateTo.getDate(); 
		
		//날짜 지정을 하지 않았을 때 NaN이 발생하여 0으로 처리 
		if (isNaN(toYear) || isNaN(toMonth) || isNaN(toDay)){
			toYear = 0; toMonth = 0; toDay = 0; 
		} 
		dateTo = toYear +'/'+ toMonth +'/'+toDay; 
		
		//오늘날짜 날짜 형식으로 지정 
		//var todayYear = today.getFullYear(); //2020 
		//var todayMonth = today.getMonth() + 1; //06 
		//var todayDay = today.getDate(); //11 
		//today = todayYear +'/'+ todayMonth +'/'+todayDay; // 2020/06/11 (형식 지정은 본인 자유) 
		
		//날짜 조회 시, 시작일이 오늘 날짜보다는 크고, 종료일이 시작일보다는 커야하기 때문에 조건을 걸어줌 
		/*if(dateFrom >= today && dateTo >= dateFrom){
			alert("해당 기간은 가능합니다."); 
		} else {
			alert("해당 기간의 조회가 불가능합니다."); 
			return false; 
		}*/ 
		if(dateTo >= dateFrom){
			alert("해당 기간은 가능합니다."); 
		} else {
			alert("해당 기간의 조회가 불가능합니다.\n다시 선택해주세요"); 
			return false; 
		} 
		console.log("dateFrom :" + dateFrom);
	  	console.log("dateTo :" + dateTo);
	}// dataCheck(dateFrom, dateTo) END
	
    //플래너 제거 ===========================================================
    function remove_planList() {
        $(".planList").remove();
        get_jObj(1, 2, "");
    }
    
    //리스트 제거 =========================================================== 
    function remove_tourList() {
        $(".tourlistContents").remove();
    }
    
    //오버레이 제거 ===========================================================
    function remove_overlay() {
        for (var i = 0; i < overlayList.length; i++) {
            overlayList[i].setMap(null);
        }
    }
    
    //마커 제거 =========================================================== 
    function remove_marker() {
        for (var i = 0; i < markers.length; i++) {
            //console.log(markers[i]);
            markers[i].setMap(null);
        }
        markers = [];
        positions = [];
    }
  	
    //플래너 목록창 보이기
  	function add_planListReader() {
        $(".planListReader").show();
        $(".planSubject").show();
    }
  	
  	//플래너 목록창 숨기기
    function hide_planListReader() {
        $(".planListReader").hide();
        $(".planSubject").hide();
    }
  	
  	//검색창 보이기
  	function add_searchFrm() {
        $(".searchFrmWrap").show();
    }
  
    //검색창 숨기기
    function hide_searchFrm() {
        $(".searchFrmWrap").hide();
    }
    
    //////////////////////////////////////////
    
    
    //플래너 값보내기 ===========================================================    
    //seqList ===========================================================
    function get_seqList(){ 
       var idx = 0;
       $("input[name=seq]").each(function(i,tag){
           console.log(tag);
           seqList[idx++] = tag.getAttribute('data-seq');
        });
    } 
    
  	//contentidList ===========================================================
    function get_contentidList(){
       var idx = 0;
       $("input[name=contentid]").each(function(i,tag){
           console.log(tag);
           contentidList[idx++] = tag.value;
        });
	}
  	
    function save_planlistContent(){
        var idx = 0;
        planlistContent = $("#planlistContentBG").html();
        console.log(planlistContent);
     }
    
     function load_planlistContent(){
        $("#planlistContentBG").append(planlistContent);   

     }
   	//여행 계획 저장 및 수정
  	//save_plan ===========================================================
	function save_plan() {
       var type = "";
       
       //전역변수 planner_no가 있을 경우 수정 , 없을 경우 저장
       if(planner_no >= 0){
          console.log("여행 계획 수정")
          type ="PUT";
       }else{
          console.log("여행 계획 저장")
          type ="POST";
          
       }
      var url = "${url}/planView"
      var title = $("#planSubject_text").val();
      var start_date = $("#dateFrom").val();
      var end_date = $("#dateTo").val();
      
      if(title == null || title == ""){
         alert("제목을 입력해 주세요.");
         return;
      }
      
      //seq와 contentid
      get_seqList();
      get_contentidList();
      $.ajax({
         url: url,
         type: type,
         data :{
            no : planner_no,
            title : title,
            start_date : start_date,
            end_date : end_date,
            seqList : seqList,
            contentidList : contentidList,
           },
           success: function (data) {
              alert(data.msg);
              if(data.status=="201") return;
              console.log(data);
               console.log(data.msg);
               console.log(data.planner_no);
               //저장 혹은 수정을 하면 여행 계획의 no값을 저장
               planner_no = data.planner_no;
               $("#planner_no").val(data.planner_no);
           },
           error: function (error) {
              alert("로그인 후 이용해 주세요.");
              console.log(error);
           }
       })
      }
	//4.여행 계획 불러오기
    function load_plan(contentidList){
       var url = "${url}/mapInfo/load";
       $.ajax({
          url : url,
          type : "POST",
          data : {
             contentidList : contentidList,
          },
          success : function(data){
             //jobj에 저장하여 마커에 표시하기 위함
             jobj = JSON.parse(data);
             jobj_planner = JSON.parse(data);
             $("div[name=planlistContentBG]").remove();
               show_map(jobj);//마커 표시
               for(var i=0; i<jobj.length; i++){
                  //플래너 목록에 추가 
                  readPlanner(jobj[i]);
               }
               
          },error : function(error){
             console.log(error);
          }
       })
       
    }
    
    function load_myplanner(){
       if(planner_no < 0) return;
       console.log(planner_no);
       var obj;
       $.ajax({
          url : "${url}/planView/detail/"+planner_no,
          type : "POST",
          datType : "JSON",
          success : function(data){
             console.log(data);
             console.log(data.msg);
             obj = JSON.parse(data.data);
                pvo = obj.pvo;
                console.log(pvo);
                $("#planSubject_text").val(pvo.title); //제목 넣기 
                $("#plan_startDate").val(pvo.start_date);//시작 날짜
                $("#plan_endDate").val(pvo.end_date);//시작 날짜

                
                console.log("load_myplanner -> ",pvo.contendList);
                console.log("load_myplanner ->", pvo.seqList);
                for(var i=0; i<pvo.contendList.length; i++){
                   contentidList[i] = pvo.contendList[i];
                   seqList[i] = pvo.seqList[i];
                }
             for(var i=0; i<pvo.contendList.length; i++){
                console.log(contentidList[i]);
                console.log(seqList[i]);
               }
                $("#planner_no").val(pvo.no);
                load_plan(contentidList);
            
          },
          error : function(error){
             console.log(error)
          },
       })
    }
    $(document).on("click","#planListLoad_btn",function(){
       planner_no = 17;
       console.log("click", planner_no);
       load_myplanner();
    })
    //지도를 불러오는 함수 ===========================================================
    function load_map() {
        console.log("load map");
        mapContainer = document.getElementById('map'), // 지도를 표시할 div 
            mapOption = {
                center: new kakao.maps.LatLng(33.21411, 126.31459), // 지도의 중심좌표
                level: 8 // 지도의 확대 레벨
            };
        map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니
    }
    
    //지도에 표시 하는 함수 ===========================================================
    function show_map() {
        console.log("지도 시작");
        var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";

        // 마커 이미지의 이미지 크기
        const imageSize = new kakao.maps.Size(24, 35);
        // 마커 이미지 생성   
        const markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

        //console.log("마커 생성");
        for (let index = 0; index < jobj.length; index++) {
            //console.log("마커 생성1");
            positions.push({
            	index:index,
            	contentid:jobj[index].contentid,
                title: jobj[index].title,
             	// 수정 자리
                img:jobj[index].firstimage,
                addr1:jobj[index].addr1,
                overview:jobj[index].overview,
                homepage:jobj[index].homepage,
                latlng: new kakao.maps.LatLng(jobj[index].mapy, jobj[index].mapx)
            })
            /*
            //마커 저장
            const marker = new kakao.maps.Marker({
                    map: map, // 마커를 표시할 지도
                    position: new kakao.maps.LatLng(jobj[index].mapy, jobj[index].mapx),
                    title : jobj[index].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
                    clickable: true,
                    image : markerImage // 마커 이미지
                });
            */
            console.log(index);
        }// show_map() END
        
        // 마커 생성 for 문 ===========================================================
        for (let index = 0; index < positions.length; index++) {
            let data = positions[index];
            displayMarker(data);
        }
        
        // Draw Overlay Over Marker ===========================================================
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
			
			//커스텀오버레이 이미지
			var imgDiv = document.createElement("div");
			imgDiv.className = "img";
			bodyContent.appendChild(imgDiv);

			var imgContent = document.createElement("img");
			imgContent.setAttribute("src", data.img);
			imgDiv.appendChild(imgContent);

			var descContent = document.createElement("div");
			descContent.className = "desc"
			bodyContent.appendChild(descContent);

			//커스텀오버레이 주소			
			var addressContent = document.createElement("div");
			addressContent.className = "addr1";
			addressContent.innerHTML = data.addr1;
			descContent.appendChild(addressContent);

			//커스텀오버레이 상세정보
			var overviewContent = document.createElement("div");
			overviewContent.className = "overview";
			overviewContent.innerHTML = data.overview;
			descContent.appendChild(overviewContent);
			
			//커스텀오버레이 링크
			var LinkDiv = document.createElement("div");
			descContent.appendChild(LinkDiv);

			var LinkContent = document.createElement("a");
			LinkContent.className = "link";
			
			var LinkText = document.createTextNode("홈페이지");
			LinkContent.appendChild(LinkText);
			LinkContent.target="_blank";
			
			var home = data.homepage;
			var home = home.substring(9, home.indexOf('target')-2);
			
			LinkContent.href= home;
			
			LinkDiv.appendChild(LinkContent);
			
			//플래너 추가 버튼
			var addBtn = document.createElement("input");
			addBtn.setAttribute("type", "button");
			addBtn.className = "add";
			addBtn.setAttribute("value", "플래너 추가 +");
			
			
			addBtn.onclick = function() {
				if(!flag_plan){ //목록일 때
					alert("플래너 목록에서 추가해주세요");
		            }
	            if(flag_plan){//플래너일 때
	            	addPlanner(data);
	            	make_ordering();
	            	get_seqList();
	            	for(var i=0;i<seqList.length; i++){
	            		console.log("seq : " + seqList[i]);
	            	}
	            }
			};
			//
			function make_ordering(){
                //console.log(idx);
                $("input[name=seq]").each(function(i, value){
                	//var contentid = value.attr("data-contentid");
                	//$("#seq_"+contentid).attr("data-seq",(i+1));
                	value.setAttribute("data-seq",i+1);
                	value.value=(i+1);
                });
            }
			descContent.appendChild(addBtn);
			//마커 위에 커스텀오버레이 콘텐츠 Dom으로 구현 끝
            
            overlay.setContent(Customcontent);

            //오버레이 저장
            overlayList.push(overlay);
            markers.push(marker);
            kakao.maps.event.addListener(marker, 'click', function () {
                // 이전의 Overlay for문을 돌려서 setmap(null);
                for (var i = 0; i < overlayList.length; i++) {
                    //console.log(overlayList[i]);
                    overlayList[i].setMap(null);
                }
                overlay.setMap(map);
            });
        }// displayMarker(data) END
    }
</script>
</html>