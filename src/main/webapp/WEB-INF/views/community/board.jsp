
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<link rel="stylesheet" href="${url}/css/board.css">

<script>
	$(function(){
		$("#searchFrm").submit(function(){
			if($("#searchWord").val()== ""){
				alert("검색어를 입력하세요");
				return false;
			}
		})
		
		//전체 선택 or 해제
		$("#delAll").on("click",function(){
			console.log("ddd");
			var checked =  $("#delAll").is(':checked');
			$("input:checkbox").prop('checked',checked);
			
		});
		
		$("#allCheck").on("click",function(){
			var checked =  $("#allCheck").is(':checked');
			$("input:checkbox").prop('checked',checked);
		});
		
		//선택 삭제
		$("#boradDelBtn").on("click",function(){
			var url = '/myapp/board/boarDelSelect';
			var delAll = $("#delAll").is(':checked');
	
			console.log(delAll);
			let no = new Array();
			var idx =0;
			
			$("input:checkbox[name=noList]").each(function(i,value){
				console.log("idx :" +idx + " "+value.getAttribute("data-no")+ value.checked);
				if(value.checked)
					no[idx++] = value.getAttribute("data-no")
			});
			if(no.length == 0) return;
			
			$.ajax({
				url:url,
				datatype: "JSON",
				data : {
					no:no,
				},success:function(data,headers, res){
					location.reload();
					console.log(res.statusText);
					
				},error:function(e){
					alert("삭제 실패");
					console.log(e);
				}
			});
			
		});
		
		//선택 삭제 2
		$("#multiDel").click(function(){
			var cnt = 0;
			$(".chk").each(function(i,obj){
				if(obj.checked){
					cnt++;
				}
				console.log("cnt :" + cnt);
			});
			
			if(cnt<=0){
				alert("목록을 선택 후 삭제하세요...");
				return false;
			}
			else{
				$("#listFrm").submit();
			}
		})
		
	});

</script>

<div class="bo__title">
	<h1> 공지/문의 사항</h1>
</div>


<!-- 검색 -->
<div class="bo__tatble__top">
	<form method="get" action="" id="searchFrm">
		<select name="searchKey" class="bo__search">
			<option value="subject">제목</option>
			<option value="content">글 내용</option>
			<option value="userid">작성자</option>
		</select>
		<input type="text" name="searchWord" id="searchWord"/>
		<input type="submit" value="Search" class="bo__btn"/>
	</form>
</div>

<table class="bo__table">
    <thead>
       <tr>
            <th>No</th>
            <th>제목</th>
            <th>작성자</th>
         </tr>
    </thead>
    <tbody class="bd_t" id="bd_t">
 		<c:forEach var="vo" items="${boardList}">
         <tr>
            <td>${vo.board.no}</td>
            <td><a> ${vo.board.subject} </a></td>
            <td>${vo.board.userid}</td>
        </tr>
        <tr>
        	<c:if test="${vo.reply != null}">
        		<td>${vo.reply.no}</td>
        		<td>${vo.reply.subject}</td>
        		<td> ${vo.reply.subject}</td>
        	</c:if>
        </tr>
        </c:forEach> 
    </tbody>
</table>


<div class="bo__container">
	<button class="bo__btn__w" type="submit" onclick="location.href='${url}/board/boardList/form'">글 작성</button>
	<div class="bo__n__page">
		현재 페이지 ${pvo.pageNo}/ ${pvo.totalPage }
	</div>
	
	<form method="post" id="listFrm">
	<!-- 페이징 -->
	<ul class="paging">
		<!-- 이전페이지 -->
		<c:if test="${pvo.pageNo==1 }">
		<li>prev</li>
		</c:if>
		<c:if test="${pvo.pageNo>1 }">
		<li><a href="${url}/board/boardList?pageNo=${pvo.pageNo-1}<c:if test='${pvo.searchWord!=null}'>&searchWord=${pvo.searchWord}</c:if>">prev</a></li>
		</c:if>
		<!-- 페이지 번호  -->
		<c:forEach var="p" begin="${pvo.startPage}" end="${pvo.startPage+pvo.onePageCount-1}">
			<!-- 총 페이지수 보다 출력할 페이지 번호가 작을 때 -->
			<c:if test ="${p <= pvo.totalPage}">
				<c:if test="${p==pvo.pageNo }">
					<li style="font-size= 20px"><a href="${url}/board/boardList?pageNo=${p}">${p}</a></li>
				</c:if>
				<c:if test="${p!=pvo.pageNo }">
					<li><a href=${url}/board/boardList?pageNo=${p}<c:if test='${pvo.searchWord!=null}'>&searchWord=${pvo.searchWord}</c:if>>${p}</a></li>
				</c:if>
			</c:if>
		</c:forEach>
		<!-- 다음 페이지  -->
		<c:if test="${pvo.pageNo == pvo.totalPage }">
			<li>next</li>
		</c:if>
		<c:if test="${pvo.pageNo < pvo.totalPage }">
			<li><a href="${url}/board/boardList?pageNo=${pvo.pageNo+1}<c:if test='${pvo.searchWord!=null}'>&searchWord=${pvo.searchWord}</c:if>">next</a></li>
		</c:if>
	</ul>
</div>

