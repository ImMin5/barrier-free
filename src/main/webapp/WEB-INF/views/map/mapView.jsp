<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>map</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <c:set var="url" value="<%=request.getContextPath()%>" />
    <link rel="stylesheet" href="${url}/css/mapstyle.css">
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a4370da25b2b005f46ac559243f9b721"></script>
    <script type="text/javascript" src="${url}/js/ai_api.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script type="text/javascript" src="${url}/js/ai_api.js"></script>
    
</head>

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
            <!-- 플래너 불러오기 창 -->
            <div class="planListReader" style="display:none;">
                <!-- 로그인 상태일 때 // 창 하나 더뜨는거 수정하기 -->
                <c:if test="${logId != null}">
                    <span id="logList" style="color:#474747;">
                        <img id="logImg" alt="플랜 목록" src="../../img/map/map_18.png">
                        플랜 목록
                    </span>
                    <select name="planReadSelect" id="planReadSelect" class="planReadSelect">
                    		  <option value=-1>여행을 선택해 주세요</option>
                        <c:forEach var="vo" items="${planList}">
                            <option value="${vo.no}">${vo.title}</option>
                        </c:forEach>
                    </select>
                    <input type="button" id="planListLoad_btn" value="불러오기" />
                    <input type="button" id="planListDelete_btn" name="planListDelete" value="삭제" onclick="del_plan()" />
                <div class="listPlanContentWrap" id="listPlanContentWrap"></div>
                </c:if>
                <!-- 로그아웃 상태일 때 -->
                <c:if test="${logId == null}">
                    <span id="logNullList" style="color:#474747;">
                        <img id="logNullImg" alt="플랜 목록" src="../../img/map/map_18.png">
                        플랜 목록
                    </span>
                    <div id="logMsg">로그인 후 이용하세요.</div>
                </c:if>
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
                <span id="btnSkyview" class="skybtn" onclick="setMapType('skyview')">스카이뷰</span>
            </div>
            <!-- 지도 확대, 축소 컨트롤 div 입니다 -->
            <div class="custom_zoomcontrol radius_border">
                <span onclick="zoomIn()"><img src="../../img/map/map_18.png" alt="확대"></span> <span
                    onclick="zoomOut()"><img src="../../img/map/map_19.png" alt="축소"></span>
            </div>
        </div>
    </div>
   
    <div style="width: 100px; height:1250px"></div>
    
    
   <!-- Modal -->
   <div class="modal fade" id="modal_invite" tabindex="-1" aria-hidden="true">
     <div class="modal-dialog">
       <div class="modal-content">
         <div class="modal-header">
           <h5 class="modal-title">멤버 초대 </h5>
           <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>
         <div class="modal-body">
            <div class="input-group mb-3">
               <input type="text" class="form-control" id="modal_invite_userid" placeholder="아이디 입력" maxlength="20">
            </div>
         </div>
         <div class="modal-footer">
           <button type="button" class="btn" data-bs-dismiss="modal">닫기</button>
           <button type="button" id="modal_btn_invite" class="btn">초대하기</button>
         </div>
       </div>
     </div>
   </div>
   
   <!-- Modal -->
   <div class="modal fade" id="modal_del" tabindex="-1" aria-hidden="true">
     <div class="modal-dialog">
       <div class="modal-content">
         <div class="modal-header">
           <h5 class="modal-title">여행 동행인 목록</h5>
           <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>
         <div class="modal-body">
            <div class="table-responsive">
			 <table class="table">
			   <thead>
			   	<tr>
			   		<th>이름</th>
			   		<th>비교</th>
			   </tr>
			   </thead>
			   <tbody id="modal_table">
			   
			   </tbody>
			 </table>
			</div>
         </div>
         <div class="modal-footer">
           <button type="button" class="btn" id="modal_close_btn" data-bs-dismiss="modal">닫기</button>
         </div>
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
    let pageCount = "10";
    let searchWord = "";

    let seqList = [];
    let contentidList = [];

    let planlistContent = ""; // 여행 목록html 전체 저장
    let planSubject_text;
    let plan_dateFrom;
    let plan_dateTo;
    let jobj_planner = ""; // 여행 목록에 있는 마커 생성을 위한 데이터

    let planner_no = -1 // -1 : 불러온 여행 계획이 없음

    let idx = [];

    // 오버레이를 저장할 리스트 생성
    let overlayList = [];

    // 플래너 정보 저장
    let tag = ""; //초기화

    // 지금 창이 리스트인지 아닌지 구분하는 변수
    let flag_plan = false; // false이면 리스트, true면 플래너

    //지도 타입
    let currentTypeId;
    
    let modal;

    $(function () {
        // 웹페이지 로딩시 시작.
        
        load_map();
        
        
        
        if(${planner_no} != null)
          planner_no = ${planner_no};
       console.log("start planner_no -->"+planner_no);
       //trigger 보다 위에 있어야함
       
       $("#planner_btn").bind("click",function(){
          console.log("강제 클릭");
          add_planList();
            remove_tourList(); 
            add_planListReader();
            hide_searchFrm();
            //목록에 저장한게 있으면 불러온다.
            if(planlistContent != ""){
               load_planlistContent();
               make_ordering();
            }
              
            flag_plan = true;
            $(this).css("background", "#FAA631")
            $(this).css("color", "#FFFFFF")
            $("#list_btn").css("background", "#F2F2F2")
            $("#list_btn").css("color", "#000000")         
              
            console.log("플래너 클릭");
             console.log(planSubject_text);
            console.log(plan_dateFrom)
            console.log(plan_dateTo)
             $("#planSubject_text").val(planSubject_text);
             $("#dateFrom").val(plan_dateFrom);
             $("#dateTo").val(plan_dateTo);
             
             load_myplanner();
             
        });
       
  
        if(planner_no < 0){
            get_jObj();   
        }
        else{
           $("#planner_btn").trigger("click");
        }
        

        // 검색하는 스크립트 ===========================================================
        $("#searchWordSubmit").on("click", function (event) {
            // 여행 플래너에서 검색을 할때 
            if (flag_plan) {
                alert("목록으로 이동해 주세요.");
                return;
            }

            event.preventDefault();
            if (flag_plan) save_planlistContent(); // 플래너의 html 목록 저장
            if ($("#searchWord").val() == "") {
                alert("검색어를 입력하세요.");
                return false;
            }
            if ($("#searchWord").val() != '') {
                searchWord = $("#searchWord").val();
                get_jObj(pageNo, pageCount, searchWord);
            }
        });
        
        // 검색하는 스크립트 ===========================================================
        $("#searchWordSubmit").on("click", function (event) {
            // 여행 플래너에서 검색을 할때 
            if (flag_plan) {
                alert("목록으로 이동해 주세요.");
                return;
            }
            event.preventDefault();
            if (flag_plan) save_planlistContent(); // 플래너의 html 목록 저장
            if ($("#searchWord").val() == "") {
                alert("검색어를 입력하세요.");
                return false;
            }
            if ($("#searchWord").val() != '') {
                searchWord = $("#searchWord").val();
                get_jObj(pageNo, pageCount, searchWord);
            }
        });

        // 이벤트 대기중인 함수 등 
        // 목록으로 이동 ===========================================================
        $("#list_btn").on("click", function () {
            if (flag_plan) {
                planSubject_text = $("#planSubject_text").val();
                plan_dateFrom = $("#dateFrom").val();
                plan_dateTo = $("#dateTo").val();

                console.log(planSubject_text);
                console.log(plan_dateFrom)
                console.log(plan_dateTo)

                save_planlistContent(); //목록을 저장 
                remove_planList();
                add_searchFrm();
                hide_planListReader();

                flag_plan = false;
                $(this).css("background", "#FAA631")
                $(this).css("color", "#FFFFFF")
                $("#planner_btn").css("background", "#F2F2F2")
                $("#planner_btn").css("color", "#000000")

                //make_ordering();
            }
        });

        // 플래너로 이동 ===========================================================
        $("#planner_btn").on("click", function () {
            if (!flag_plan) {
                add_planList();
                remove_tourList();
                add_planListReader();
                hide_searchFrm();
               
                
                
                //목록에 저장한게 있으면 불러온다.
                if (planlistContent != "") {
                    load_planlistContent();
                    make_ordering(); 
                }
                modal = document.getElementById("modal");
                
                window.onload = function(){
                   var btnModal = document.getElementById("btn-modal");
                   btnModal.addEventListener('click', function(){
                      console.log("클릭클릭");
                      modal.style.display = "flex";
                   })
               }

                flag_plan = true;
                $(this).css("background", "#FAA631")
                $(this).css("color", "#FFFFFF")
                $("#list_btn").css("background", "#F2F2F2")
                $("#list_btn").css("color", "#000000")
                 
                console.log("플래너 클릭");
                console.log(planSubject_text);
                console.log(plan_dateFrom);
                console.log(plan_dateTo);
                $("#planSubject_text").val(planSubject_text);
                $("#dateFrom").val(plan_dateFrom);
                $("#dateTo").val(plan_dateTo);
                make_ordering();
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


        //좋아요 찜하기 ===========================================================
        $(document).on("click", "img[name=like_btn]", function () {
            //console.log("dd");
            var contentid = $(this).attr("data-contentid");
            $.ajax({
                url: "${url}/like",
                type: "POST",
                dateType: "JSON",
                data: {
                    contentid: contentid
                },
                success: function (result) {
                    console.log(result);
                    $("#like_count_" + contentid).text(result.likeCount);
                }
            });
        });

        $(document).on("click", "img[name=heart_btn]", function () {
            //console.log("dd");
            var contentid = $(this).attr("data-contentid");
            $.ajax({
                url: "${url}/heart",
                type: "POST",
                dateType: "JSON",
                data: {
                    contentid: contentid
                },
                success: function (result) {
                    console.log(result);
                    $("#heart_count_" + contentid).text(result.heartCount);
                }
            });
        });
        
        $(document).on("click","#modal_btn_invite",function(){
            var url = "${url}/planView/member";
             //console.log(url);d
             console.log("add meme");
            
            var planner_no = $("#planReadSelect").val();
            var useridInvite = $("#modal_invite_userid").val();
            if(planner_no <0 ) return;
             $.ajax({
                 url: url,
                 type: "POST",
                 dataType: "JSON",
                 data: {
                    planner_no: planner_no,
                     useridInvite:useridInvite,
                 },
                 success: function (result) {
                     alert(result.msg);
                 },
                 error: function (error) {
                     console.log(error.responseJSON);
                     alert(error.responseJSON.msg);
                 }
             });
           
        });
        
        
        //멤버삭제 클릭 시 
        $(document).on("click","#modal_del_btn",function(){
        	if( $("#planSubject_text").val() == "") {
        		return;
        	}
        	var url ="${url}/planView/memberList";
        	var planner_no = parseInt($("#planReadSelect").val());
        	
        	console.log("planner_no :" + planner_no);
        	$.ajax({
        		url : url,
        		type : "POST",
        		data :{
        			planner_no : planner_no,
        		},
        		success : function(data){
        			console.log(data);
        			for(var i =0; i<data.length; i++){
        				$("#modal_table").append("`<tr id='tr_"+data[i]+"' name='tr'><th>"+data[i]+"</th><th><button class='btn' name='modal_member_delete' data-planner_no="+planner_no+" data-userid='"+data[i]+"'>삭제</button></th><tr>`");
        			}
        			
        		},error : function(error){
        			console.log(error);
        		}
        	})
        });
        // 모달 닫기 누를 경우 테이블 초기화
        $(document).on("click","#modal_close_btn",function(){
        	$("tr[name=tr]").remove();
        });
        
        //모달에서 삭제 버튼 클릭시 
        $(document).on("click","button[name=modal_member_delete]",function(){
        	var planner_no = $(this).attr("data-planner_no");
        	var userid = $(this).attr("data-userid");
        	var url ="${url}/planView/member";
        	$.ajax({
        		url : url,
        		type : "DELETE",
        		data :{
        			planner_no : planner_no ,
        			useridDelete : userid,
        		},success : function(data){
        			alert(data.msg);
        			console.log(data);
        			$("#tr_"+userid).remove();
        		}
        	})
        })
        
    });// $(function) END
   
    //1. 맵의 리스트를 가져와 jobj에 데이터 넣어줌   
    function get_jObj() {
        var url = "${url}/mapInfo"
        $.ajax({
            url: url,
            type: "POST",
            data: {
                pageNo: pageNo,
                pageCount: pageCount,
                searchWord: searchWord,
            },
            success: function (data) {
                //데이터 갱신
                jobj = JSON.parse(data);
                remove_marker();
                show_map(jobj);

               if(jobj != ""){
                    //플래너 목록 생성을 위한 데이터가 있을 경우
                    console.log("jobj planner--> ", jobj_planner);
                    show_map(jobj_planner);
                }
                make_list();
            },
            error: function (error) {
            }
        })
    }
    
    // 리스트 만들기 ===========================================================
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
                        <img class="listSubInfoImg" name="like_btn" data-contentid="${'${item.contentid}'}" src="../../img/map/map_08.png">
                        <span id="like_count_${'${item.contentid}'}">${'${item.likeCount}'}</span>
                    </div>
                    <div class="listSubInfo">
                        <img class="listSubInfoImg" name="heart_btn" data-contentid="${'${item.contentid}'}" src="../../img/map/map_07.png">
                        <span id="heart_count_${'${item.contentid}'}" >${'${item.heartCount}'}</span>
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
        tag += "</ul>";
        //좋아요 카운트 추가하기
        $("#listContentWrap").html(tag);
    }// make_list() END

    // 플래너 리스트에 숫자 부여
    function make_ordering() {
        //console.log(idx);
        $("input[name=seq]").each(function (i, value) {
            //var contentid = value.attr("data-contentid");
            //$("#seq_"+contentid).attr("data-seq",(i+1));
            value.setAttribute("data-seq", i + 1);
            value.setAttribute("value",i+ 1);
        });
    }
    
    // 플래너 생성 ===========================================================
    function add_planList() {
        var plantag = `       
            <div class="myplan">
                <form name="planFrm" id="planFrm" onsubmit="return false">
                    <div class="planSubject">
                        <span style="color:#474747;">
                            <img alt="" src="../../img/map/map_18.png" >
                            플랜 제목
                        </span>
                        <input type="text" name="planSubject_text" id="planSubject_text" placeholder="제목을 입력해주세요."/>
                           <a class="btn btn-info" id="invite" data-bs-toggle="modal" data-bs-target="#modal_invite" >멤버 초대</a>
                           <a class="btn btn-danger" id="invite_del" data-bs-toggle="modal" data-bs-target="#modal_del" id="modal_del_btn">멤버 삭제</a>
                        <input type="hidden" id="planner_no" />
                    </div>
                    <div class="planList">
                        <span style="color:#474747;">
                            <img alt="" src="../../img/map/map_18.png" >
                            출발 날짜
                        </span>
                        <input type="date" id="start_date" name="start_date" > ~ 
                        <input type="date" id="end_date" name="end_date"> 
                        <input type="button" name="btnSearch" id="btnSearch" onclick="dataCheck()"value="검색"> 
                    </div>
                    <div id="planListCancel" name="planListCancel">
                        <input type="button" id="planListCancel_btn" onclick="ListCancel()" value="취소"/>
                        <input type="button" id="planListSave_btn" onclick="save_plan()" value="저장"/>
                    </div>
                    <div class="planListContentWrap"></div>
                        <div class="planlistContentBG" id="planlistContentBG"></div>
                    </div>
                </form>
            </div>
        `;//);
        //console.log("플래너 선택");
        $('#listPlanContentWrap').html(plantag);
        
    }// add_planList()() END
    
    
    
    //동행자 추가 버튼 클릭시 planView로 가지 않고 mapView로 가게 하기
    /*function mapViewGo(frm) { 
        frm.action='/mapView'; 
        frm.submit(); 
        return true; 
      } */

    // 플래너 추가하기 버튼으로 생성되는 플래너 ===========================================================
    function addPlanner(data) {
                var addplantag = `
            <div id="planlistContent" name="planlistContent">
                <input type="text" name="seq" id="seq"  readonly>
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
                <div class="planArrow">
                    <img src="../../img/map/map_33.png" alt="위로 올리기" id="planUp" />
                    <img src="../../img/map/map_34.png" alt="아래로 내리기" id="planDown" />
                </div>
                <img src="../../img/map/map_32.png" alt="플래너 삭제" id="planDel" onclick="readPlanDel()"; />
            </div>
        `;
        //console.log("data====>>>" , data);
        $('#planlistContentBG').append(addplantag);
    }// addPlanner(data) END

    // 저장된 플래너 불러오기 ===========================================================
    function readPlanner(data) {
        var addplantag = `
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
                   <div class="saveplanArrow">
                       <img src="${url}/img/map/map_33.png" alt="위로 올리기" id="savePlanUp" />
                       <img src="${url}/img/map/map_34.png" alt="아래로 내리기" id="savePlanDown" />
                   </div>
                      <img src="../../img/map/map_32.png" alt="플래너 삭제" id="savePlanDel" onclick="readPlanDel()"; />
                   </div>
            </div>
        `;
        $('#planlistContentBG').append(addplantag);
    }// readPlanner(data) END   

    //불러온 플래너 삭제하기
    function readPlanDel(){
       $("#planlistContent").remove();
       make_ordering();
    }

    // 플래너 날짜 ===========================================================
    // 날짜 유효성 검사 
    function dataCheck(start_date, end_date) {
        var start_date = document.getElementById('start_date'); //시작일 
        var end_date = document.getElementById('end_date'); //종료일 
        //var today = new Date(); //오늘 날짜 

        start_date = new Date(start_date.value);
        var fromYear = start_date.getFullYear();
        var fromMonth = start_date.getMonth() + 1;
        var fromDay = start_date.getDate();

        //날짜 지정을 하지 않았을 때 NaN이 발생하여 0으로 처리 
        if (isNaN(fromYear) || isNaN(fromMonth) || isNaN(fromDay)) {
            fromYear = 0;
            fromMonth = 0;
            fromDay = 0;
        }
        start_date = fromYear + '/' + fromMonth + '/' + fromDay;

        end_date = new Date(end_date.value);
        var toYear = end_date.getFullYear();
        var toMonth = end_date.getMonth() + 1;
        var toDay = end_date.getDate();

        //날짜 지정을 하지 않았을 때 NaN이 발생하여 0으로 처리 
        if (isNaN(toYear) || isNaN(toMonth) || isNaN(toDay)) {
            toYear = 0; toMonth = 0; toDay = 0;
        }
        end_date = toYear + '/' + toMonth + '/' + toDay;

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
        if (start_date <= end_date) {
            alert("해당 기간은 가능합니다.");
        } else {
            alert("해당 기간의 조회가 불가능합니다.\n다시 선택해주세요");
            return false;
        }
    }// dataCheck(dateFrom, dateTo) END

    // 플래너 제거 ===========================================================
    function remove_planList() {
        $(".planList").remove();
        get_jObj(1, 2, "");
    }

    // 리스트 제거 =========================================================== 
    function remove_tourList() {
        $(".tourlistContents").remove();
    }

    // 오버레이 제거 ===========================================================
    function remove_overlay() {
        for (var i = 0; i < overlayList.length; i++) {
            overlayList[i].setMap(null);
        }
    }

    // 마커 제거 =========================================================== 
    function remove_marker() {
        for (var i = 0; i < markers.length; i++) {
            //console.log(markers[i]);
            markers[i].setMap(null);
        }
        markers = [];
        positions = [];
    }

    // 플래너 목록창 보이기
    function add_planListReader() {
        $(".planListReader").show();
        $(".planSubject").show();
    }

    // 플래너 목록창 숨기기
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

    // 플래너 리스트 취소버튼
    function ListCancel() {
        alert('담은 리스트를 취소합니다.');
        console.log("취소");
        $("div").remove("#planlistContent");
    }


    // 플래너 값보내기  
    // seqList ===========================================================
    function get_seqList() {
        var idx = 0;
        $("input[name=seq]").each(function (i, tag) {
            console.log(tag);
            seqList[idx++] = tag.getAttribute('data-seq');
        });
    }

    // contentidList ===========================================================
    function get_contentidList() {
        var idx = 0;
        $("input[name=contentid]").each(function (i, tag) {
            console.log(tag);
            contentidList[idx++] = tag.value;
        });
    }

    // save_planlistContent ===========================================================
    function save_planlistContent() {
        var idx = 0;
        planlistContent = $("#planlistContentBG").html();
        console.log(planlistContent);
    }

    // load_planlistContent ===========================================================
    function load_planlistContent() {
        $("#planlistContentBG").append(planlistContent);
        console.log("불러오기 ->",planlistContent);

    }
    



    //여행 계획 저장 및 수정
    //save_plan ===========================================================
    function save_plan() {
        var type = "";
        //전역변수 planner_no가 있을 경우 수정 , 없을 경우 저장
        var planner_no = $("#planReadSelect").val();
        console.log("planReadSelect의 planner_no : " + planner_no);
        if(planner_no == null ) planner_no = -1;
        if (planner_no >= 0) {
            console.log("여행 계획 수정")
            type = "PUT";
        } else {
            console.log("여행 계획 저장")
            type = "POST";
        }

        var url = "${url}/planView"
        var title = $("#planSubject_text").val();
        var start_date = $("#start_date").val();
        var end_date = $("#end_date").val();

        if (title == null || title == "") {
            alert("제목을 입력해 주세요.");
            return;
        }

        //seq와 contentid
        get_seqList();
        get_contentidList();
        $.ajax({
            url: url,
            type: type,
            data: {
                no: planner_no,
                title: title,
                start_date: start_date,
                end_date: end_date,
                seqList: seqList,
                contentidList: contentidList,
            },
            success: function (data) {
                alert(data.msg);
                if (data.status == "201") return;
                //저장 혹은 수정을 하면 여행 계획의 no값을 저장
                planner_no = data.planner_no;
                $("#planner_no").val(data.planner_no);
                $("#dataFrom").val(data.start_date);
                $("#dateTo").val(data.end_date);
                get_plannertitle();
             
            },
            error: function (error) {
                alert("로그인 후 이용해 주세요.");
                console.log(error);
            }
        })
    }
    
    //수정 삭제후 타이틀을 업데이트 해줌
    function get_plannertitle(){
    	var url ="${url}/planView/plannerList";
    	$.ajax({
    		url : url ,
    		type : "POST",
    		success : function(data){
    			console.log(data.length);
    			$("#planReadSelect > option").remove();
    			data.forEach(function(obj, i){
    				console.log("obj =>"+obj.title);
    				if(i==0){
    					 $("#planReadSelect").append(`<option value=-1>여행을 선택해 주세요.</option>`);
    				} 
    				if($("#planSubject_text").val() == obj.title){
    					$("#planReadSelect").append("<option value='"+obj.no+"'selected>"+obj.title+"</option>");
    				}else{
    					$("#planReadSelect").append("<option value='"+obj.no+"'>"+obj.title+"</option>");	
    				}
    				 
    			});
    			
    			
    		}
    	});
    }
    //

    //여행 계획 삭제
    //del_plan ===========================================================
    //planListDelete_btn
    function del_plan() {
        var url = "${url}/planView";
        //console.log(url);
        $.ajax({
            url: url,
            type: "DELETE",
            dataType: "JSON",
            data: {
                no: planner_no,
            },
            success: function (result) {
                alert(result.msg);
                window.location.href = result.redirect;
            },
            error: function (error) {
                console.log(error.responseJSON);
                alert(error.responseJSON.msg);
                window.location.href = error.responseJSON.redirect;
            }
        });
    }
    
     //동행자 추가
    function add_mem() {
        var url = "${url}/planView/member";
        //console.log(url);d
        console.log("add meme");
        return;
       //var planner_no = 1;  
        $.ajax({
            url: url,
            type: "POST",
            dataType: "JSON",
            data: {
                no: planner_no,
                userid:useridInvite,
            },
            success: function (result) {
                alert(result.msg);
                window.location.href = result.redirect;
            },
            error: function (error) {
                console.log(error.responseJSON);
                alert(error.responseJSON.msg);
                window.location.href = error.responseJSON.redirect;
            }
        });
    }


    //여행 계획 삭제
    //del_plan ===========================================================
    	//planListDelete_btn
    function del_plan() {
        
        var url = "${url}/planView";
        console.log(url);
        $.ajax({
            url: url,
            type: "DELETE",
            dataType: "JSON",
            data: {
                no: planner_no,
            },
            success: function (result) {
                alert(result.msg);
                window.location.href = result.redirect;
            },
            error: function (error) {
                console.log(error.responseJSON);
                alert(error.responseJSON.msg);
                window.location.href = error.responseJSON.redirect;
            }
        });
    }


    //4-1.여행 계획 불러오기 ===========================================================
    function load_myplanner() {
        if (planner_no < 0) return;
        console.log(planner_no);
        var obj;
        $.ajax({
            url: "${url}/planView/detail/" + planner_no,
            type: "POST",
            datType: "JSON",
            success: function (data) {
                console.log(data);
                console.log(data.msg);
                obj = JSON.parse(data.data);
                pvo = obj.pvo;
                console.log(pvo);
                $("#planSubject_text").val(pvo.title); //제목 넣기 
                $("#start_date").val(pvo.start_date);//시작 날짜
                $("#end_date").val(pvo.end_date);//종료 날짜

                for (var i = 0; i < pvo.contendList.length; i++) {
                    contentidList[i] = pvo.contendList[i];
                    seqList[i] = pvo.seqList[i];
                }
                for (var i = 0; i < pvo.contendList.length; i++) {
                    console.log(contentidList[i]);
                    console.log(seqList[i]);
                }
                $("#planner_no").val(pvo.no);
                load_plan(contentidList);

            },
            error: function (error) {
                console.log(error)
            },
        })
    }

    //4-2 load_myplanner에서 실행 후 작동 ===========================================================
    function load_plan(contentidList) {
        var url = "${url}/mapInfo/load";
        $.ajax({
            url: url,
            type: "POST",
            data: {
                contentidList: contentidList,
            },
            success: function (data) {
                $("div[name=planlistContent]").each(function (i, element) {
                    console.log(element);
                    element.remove();
                    // div 요소를 순서대로 선택한다.  i: 순서 시작은 0 ,  element : 선택된 요소 
                });

                $("div").remove("#planlistContent");
                console.log("prev jobj", jobj);
                console.log("prev jobj_planner", jobj_planner);
                //jobj에 저장하여 마커에 표시하기 위함
                jobj = JSON.parse(data);
                jobj_planner = JSON.parse(data);

                console.log("after jobj", jobj);
                console.log("after jobj_planner", jobj_planner);
                //이전 여행기록 지워야됨

                show_map(jobj);//마커 표시
                make_ordering();

                for (var i = 0; i < jobj.length; i++) {
                    //플래너 목록에 추가 
                    readPlanner(jobj[i]);
                }
            }, error: function (error) {
                console.log(error);
            }
        })
    }
    

    $(document).on("click", "#planListLoad_btn", function () {
        planner_no = $("#planReadSelect").val();
        console.log("click", planner_no);
        if (planner_no < 0) return;
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
    function show_map(items) {
        console.log("지도 시작");
        console.log("jobj --> ", jobj);
        console.log("jobj planner --> ", jobj_planner);
        var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";

        // 마커 이미지의 이미지 크기
        const imageSize = new kakao.maps.Size(24, 35);
        // 마커 이미지 생성   
        const markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

        //console.log("마커 생성");
        for (let index = 0; index < items.length; index++) {
            //console.log("마커 생성1");
            positions.push({
                index: index,
                contentid: items[index].contentid,
                title: items[index].title,
                // 수정 자리
                img: items[index].firstimage,
                addr1: items[index].addr1,
                overview: items[index].overview,
                homepage: items[index].homepage,
                latlng: new kakao.maps.LatLng(items[index].mapy, items[index].mapx)
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
            closeBtn.setAttribute("title", "닫기");
            closeBtn.onclick = function () { overlay.setMap(null); };
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
            LinkContent.target = "_blank";

            var home = data.homepage;
            //홈페이지가 없는 경우도 있음
            if (data.homepage != null)
                home = home.substring(9, home.indexOf('target') - 2);

            LinkContent.href = home;

            LinkDiv.appendChild(LinkContent);

            //플래너 추가 버튼
            var addBtn = document.createElement("input");
            addBtn.setAttribute("type", "button");
            addBtn.className = "add";
            addBtn.setAttribute("value", "플래너 추가 +");

            addBtn.onclick = function () {
                if (!flag_plan) { //목록일 때
                    alert("플래너 목록에서 추가해주세요");
                }
                if (flag_plan) {//플래너일 때
                    addPlanner(data);
                    make_ordering();
                    get_seqList();
                    for (var i = 0; i < seqList.length; i++) {
                        console.log("seq : " + seqList[i]);
                    }
                }
            };

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

