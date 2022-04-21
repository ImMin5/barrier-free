<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="url" value="<%=request.getContextPath()%>" />

<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">	
<link rel="stylesheet" href="${url }/css/myreview.css" />
<script src='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js'></script>
<script>
	$(function(){
		
		var rating = $('.review .rating');
		
		rating.each(function(){
			var targetScore = $(this).attr('data-rate');
			$(this).find('svg:nth-child(-n+' + targetScore +')').css({color:'rgb(250, 166, 50)'});
			
			
		});

		$(document).on('click','#del',function(event){
			event.preventDefault();
			var userid = "${logId }";
			var no = $(this).attr("title");
			if(confirm("정말 삭제하시겠습니까?")){
			$.ajax({
		        url:'${url}/review/myreview',
		        type:'DELETE',
		        data: {
		        	no:no,
		        	userid:userid,
		        },
		        dataType : "json",

		        success:function(data){
		  			alert(data.msg)
		        	location.reload();
		        },	
		        error: function (error){
					
		        	alert(data.msg);
		        	
		        }
			});
		}else{
			return false;
		}
		});
	});		

</script>

<div id="contents">
			<section class="mypage-box">
			
				<h1>마이 페이지</h1>
				
<nav class="lnb-box">
					<a href="${url }/mypage/myplanner" >나의 플래너</a>
					<a href="${url }/mypage/myreview" >나의 리뷰</a>
					<a href="${url }/mypage/myqna" >나의 문의 사항</a>
					<a href="${url }/mypage" >나의 정보</a>

				</nav>
</section>
</div>			
<div class="myreview-box">
	<a class="title1">나의 리뷰👀</a>
	<div class="line2"></div>
	<table>
		<c:forEach var="vo" items="${reviewList }" >
		<thead class="review_thead" >
		<tr>
			<th>
				<div class="date">
					${vo.write_date }
					<input type="button" id="del" value="리뷰삭제" title="${vo.no}">
				</div>
			</th>
		</tr>
		</thead>
		<tbody>
			<tr class="review_tr">
					<th>
					
					<div class="review">
						<div class="title">
						<c:if test="${vo.contentTypeId == '32'}">
							<a href="${url }/accommodation/${vo.contentid}">${vo.title }</a>
						</c:if>
						<c:if test="${vo.contentTypeId =! '32'}">
							<a href="${url }/travel_information/${vo.contentid }">${vo.title }</a>
						</c:if>
						</div>
						<div class="rating" data-rate="${vo.score }">
							<i class="fas fa-star"></i>
							<i class="fas fa-star"></i>
							<i class="fas fa-star"></i>
							<i class="fas fa-star"></i>
							<i class="fas fa-star"></i>
						</div>
					</div>
					</th>
			</tr>
			<tr>
			
				<th>
				<div class="content">
				<c:if test="${vo.contentTypeId == '32'}">
					<a href="${url }/accommodation/${vo.contentid}">${vo.content }</a>
				</c:if>
				<c:if test="${vo.contentTypeId =! '32'}">
					<a href="${url }/travel_information/${vo.contentid }">${vo.content }</a>
				</c:if>
				</div>
				</th>
			</tr>
			<tr>
				<th>
					<div id="line"></div>
				</th>
			</tr>
			</c:forEach>
		</tbody>
	
	</table>
			<div class="bo__n__page">
		
	</div>
	
	<!-- 페이징 -->
	<ul class="paging">
		<!-- 이전페이지 -->
		<c:if test="${pvo.pageNo==1 }">
		<li>◀</li>
		</c:if>
		<c:if test="${pvo.pageNo>1 }">
		<li><a href="${url}/mypage/myreview?pageNo=${pvo.pageNo-1}<c:if test='${pvo.searchWord!=null}'>&searchWord=${pvo.searchWord}</c:if>">◀</a></li>
		</c:if>
		<!-- 페이지 번호  -->
		<c:forEach var="p" begin="${pvo.startPage}" end="${pvo.startPage+pvo.onePageCount-1}">
			<!-- 총 페이지수 보다 출력할 페이지 번호가 작을 때 -->
			<c:if test ="${p <= pvo.totalPage}">
				<c:if test="${p==pvo.pageNo }">
					<li style="font-size= 20px"><a href="${url}/mypage/myreview?pageNo=${p}">${p}</a></li>
				</c:if>
				<c:if test="${p!=pvo.pageNo }">
					<li><a href=${url}/mypage/myreview?pageNo=${p}<c:if test='${pvo.searchWord!=null}'>&searchWord=${pvo.searchWord}</c:if>>${p}</a></li>
				</c:if>
			</c:if>
		</c:forEach>
		<!-- 다음 페이지  -->
		<c:if test="${pvo.pageNo == pvo.totalPage }">
			<li>▶</li>
		</c:if>
		<c:if test="${pvo.pageNo < pvo.totalPage }">
			<li><a href="${url}/mypage/myreview?pageNo=${pvo.pageNo+1}<c:if test='${pvo.searchWord!=null}'>&searchWord=${pvo.searchWord}</c:if>">▶</a></li>
		</c:if>
	</ul>
</div>
