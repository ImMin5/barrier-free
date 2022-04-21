<link rel="stylesheet" href="${url}/css/suggest.css">



<div id="#b__table" >
        <h1 class="bf__title">👇 건의 할래요 👇</h1>
       <form id="suggestionFrm" class="bf__container" method="post" action="/suggest/suggestionList/edit/${svo.no}" id="suggestionFrm" >
           <input type="hidden" value="suggestWrite" name="command">
        
            <table class="bf__table">
                <tr>
                    <th class="bd__tb__sub">제목</th>
                    <td>${svo.title }</td>
                </tr>
                <tr>
                    <th>아이디</th>
                    <td>${svo.userid }</td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td>${svo.content }</td>
                </tr>
            </table>
            <input class="bo__btn__m" type="submit" id="btn_submit" value="수정">
            <input class="bo__btn__mb" type="button" value="목록으로" onclick="javascript:history.back()">
       </form>
    </div>