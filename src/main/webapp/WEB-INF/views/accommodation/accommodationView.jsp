<link rel="stylesheet" href="${url}/css/accommoView.css" type="text/css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a4370da25b2b005f46ac559243f9b721"></script>
<script type="text/javascript" src="/js/accommodation/a_map.js"></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js'></script>
<script>
	$(document).on("click", "#btn_enter",function(event){
		event.preventDefault();
		var url = "${url}/review/myreview";
		var content = $("#comment").val();
		var contentid = "${acvo.get('contentid')}";
		var contentTypeId = "${acvo.get('contenttypeid')}" ;
		var title = "${acvo.get('title')}";
		var score = $("[name=rating]:checked").length;
		
		if($("#comment").val()==""){//댓글을 입력하지 않은 경우
			alert("댓글을 입력해주세요!");
			return;
		}else{//댓글을 입력한 경우
		//form에 있는 데이터를 params에 담기
			var params = $(document).serialize();
		
		$.ajax({
			url : url,
			type : "POST",
			data : {
				contentid : contentid,
				content : content,
				contentTypeId : contentTypeId,
				title : title,
				score : score,
			},success : function(result){
				$("#comment").val("");
				alert(result.msg);
				window.location.href="${url}/accommodation/"+contentid;
			},error: function(error){
				alert(error.responseText);
			}
		});
		}
	});

	

$(function(){ 
	
	$("a[name=delete_btn]").on("click",function(){
	
	//사용자가 Y(true),N(false) 선택 가능
	if(confirm("삭제하시겠습니까?")){
		var no = $(this).attr("data-no");
		var contentid = $(this).attr("data-contentid");
		no = parseInt(no);
		console.log(contentid);		
		
				
		//확인 버튼 클릭시
		$.ajax({
			dataType : "JSON",
			type: "delete",
			url:'${url}/review/myreview',
			data:{
				no:no,
			},
			success:function(result){
				console.log(result);
				window.location.href="${url}/accommodation/"+contentid;
			},error:function(){
				console.log("댓글 삭제 에러");
			}
			});
		}
	});
});

//별점 마킹 모듈 프로토타입으로 생성
function Rating(){};
Rating.prototype.rate = 0;
Rating.prototype.setRate = function(newrate){
    //별점 마킹 - 클릭한 별 이하 모든 별 체크 처리
    this.rate = newrate;
    let items = document.querySelectorAll('.rate_radio');
    items.forEach(function(item, idx){
        if(idx < newrate){
            item.checked = true;
        }else{
            item.checked = false;
        }
    });
}
let rating = new Rating();//별점 인스턴스 생성

document.addEventListener('DOMContentLoaded', function(){
    //별점선택 이벤트 리스너
    document.querySelector('.rating').addEventListener('click',function(e){
        let elem = e.target;
        if(elem.classList.contains('rate_radio')){
            rating.setRate(parseInt(elem.value));
        }
    })
});

$(function(){
	
	var rating = $('.list_reply .review_rating');
	
	rating.each(function(){
		var targetScore = $(this).attr('data-rate');
		$(this).find('svg:nth-child(-n+' + targetScore +')').css({color:'rgb(250, 166, 50)'});
		
		});
	});
</script>
</head>
<body onload='load_map(${acvo.get("mapy")},${acvo.get("mapx")})'>
	<div class="aView_container">
		<h1>Welcome to "${acvo.get('title')}"</h1>
		<div class="aView_img">
			<img src="${acvo.get('firstimage')}">
		</div>
		<!-- 지도 -->
		<div class="map_wrap">
		
			<div id="map"></div>
		</div>
	</div>	
	<div class="aView_content">
		<h2>${acvo.get('title')}</h2>
		<p>${acvo.get('homepage')}</p>
		<p>${acvo.get('tel')}<p>
		<strong><img src="/img/information/star.png" width="15" height="15"> : ${acvo.get('avgScore')}</strong>
		<hr/>
		<p>${acvo.get('overview')}</p>
	</div>
	
	<!-- 댓글 기능 -->
	<div class="area_reply">
		<strong class="tit_reply" onclick="">
		<span id="#">${acvo.get("reviewCount")}</span> Comments</strong>		
		<div id="aComment">
			<ul class="list_reply">
			<c:forEach var="vo" items="${reviewList}"> 
			<li id="#" class="rp_general" style="">                           
				<span class="reply_content">
                <span class="tit_nickname">${vo.userid}</span>
                <span class="txt_date">${vo.write_date}</span>
                <span class="txt_reply">${vo.content}</span>
                <span class="tit_score">${vo.score}</span>
            	<div class="review_rating" data-rate="${vo.score }">
							<i class="fas fa-star"></i>
							<i class="fas fa-star"></i>
							<i class="fas fa-star"></i>
							<i class="fas fa-star"></i>
							<i class="fas fa-star"></i>
				</div>
				<div class="area_more" data-userid="${vo.userid}">	
					<div class="reply_layer">
						<div class="link_reply">
								<!-- 로그인 아이디와 글쓴이가 같은 경우 -->
								<c:if test="${logId==vo.userid}">
									<a href="${url}/accommodation/replyEdit?no=${vo.no}">수정</a>
									<a href="#" name="delete_btn" data-contentid="${vo.contentid}" data-no="${vo.no}">삭제</a>
								</c:if>
							</div>
						</div>
				</div>
			</li>
			</c:forEach>
			</ul>
			<form style="margin: 0">
				<fieldset class="fld_reply">
					<legend class="screen_out">댓글쓰기 폼</legend>
					<div class="review_rating">
            			<div class="warning_msg">별점을 선택해 주세요.</div>
           					<div class="rating" id=score>
              				<!-- 해당 별점을 클릭하면 해당 별과 그 왼쪽의 모든 별의 체크박스에 checked 적용 -->
                			<input type="checkbox" name="rating" id="rating1" value="1" class="rate_radio" title="1점">
                			<label for="rating1"></label>
               		 		<input type="checkbox" name="rating" id="rating2" value="2" class="rate_radio" title="2점">
                			<label for="rating2"></label>
               				<input type="checkbox" name="rating" id="rating3" value="3" class="rate_radio" title="3점" >
                			<label for="rating3"></label>
                			<input type="checkbox" name="rating" id="rating4" value="4" class="rate_radio" title="4점">
                			<label for="rating4"></label>
                			<input type="checkbox" name="rating" id="rating5" value="5" class="rate_radio" title="5점">
                			<label for="rating5"></label>
            				</div>
       					</div>
					<div class="reply_write ">
						<label for="comment" class="lab_write screen_out">내용</label>
						<textarea name="comment" id="comment" class="tf_reply" placeholder="댓글을 입력해주세요"></textarea>
					</div>

					<div class="writer_btn">
						<button class="btn_enter" id="btn_enter">등록</button>
					</div>
				</fieldset>
			</form>
		</div>
	</div>
</body>
</html>