<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="url" value="<%=request.getContextPath()%>" />

<link rel="stylesheet" href="${url }/css/myplanner.css">

<script>
	$(function(){
		$(document).on('click','#del',function(event){
			event.preventDefault();
			var userid = "${logId }";
			var no = $(this).attr("title");
			if(confirm("정말 삭제하시겠습니까?")){
			$.ajax({
		        url:'${url}/planView',
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
<div class="info-box">
		<div class="hh1"><h1>🛫나의 플래너🛫</h1></div>
			<div class="line2"></div>
	<table class="planner1">
		<c:forEach var="vo" items="${planList }" >
		<thead class="plan_thead" >
		<tr>
			<th>

			</th>
		</tr>
		</thead>
		<tbody class="tbd">

			<tr>
				
				<th>
				
				<div class="planner">
				<div class="line2">&nbsp;</div>
				<div class="date">${vo.create_date } 
					<input type="button" id="del" value="삭제하기" title="${vo.no}">
				</div>
				<div class="title">
						${vo.title }
					
				</div>
				<div class="start">
					${vo.start_date } ~ ${vo.end_date }
				</div>
				</div>
				</th>
			</tr>
			<tr>
				<th>
					<div id="line"></div>
				</th>
			</tr>
			
		</tbody>
		</c:forEach>
	</table>
			<div class="bo__n__page">
		
	</div>
</div>	