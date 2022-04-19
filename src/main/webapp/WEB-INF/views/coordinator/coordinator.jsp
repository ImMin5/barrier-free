    <script>
        $(function(){
            $("#searchFrm").submit(function(){
                if($("#searchWord").val()== ""){
                    alert("검색어를 입력하세요");
                    return false;
                }
            });
        });
    
    </script>
</head>
<body>
    <div class="bo__title" style="margin:150px;">
        <h1> 🙆‍♀️ 등록 된 코디네이터 🙆‍♂️ </h1>
    </div>
    
    
    <!-- 검색 -->
    <div class="bo__tatble__top">
        <form method="get" action="" id="searchFrm">
            <select name="searchKey" class="bo__search">
                <option value="content">성명</option>
                <option value="userid">아이디</option>
            </select>
            <input type="text" name="searchWord" id="searchWord"/>
            <input type="submit" value="Search" class="bo__btn"/>
        </form>
    </div>
    
    <table class="bo__table">
        <thead>
           <tr>
                <th>No</th>
                <th>성명</th>
                <th>이메일</th>
                <th>연결문의</th>
           </tr>
        </thead>
        <tbody class="bd_t" id="bd_t">
        	<c:forEach var="vo" items="${coordiList}">
        		<tr>
        			<td>${vo.coo_userid}</td>
        			<td>${vo.email}</td>
        			<td>${vo.tel}</td>
        			<td>카카오톡 링크</td>
        		</tr>
        	</c:forEach>
        </tbody>
    </table>
    
    
    <div class="bo__container">
       
    </div>