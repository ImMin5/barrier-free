<link rel="stylesheet" href="${url}/css/suggest.css">



<div id="#b__table" >
        <h1 class="bf__title">π κ±΄μ ν λμ π</h1>
       <form id="suggestionFrm" class="bf__container" method="post" action="/suggest/suggestionList/edit/${svo.no}" id="suggestionFrm" >
           <input type="hidden" value="suggestWrite" name="command">
        
            <table class="bf__table">
                <tr>
                    <th class="bd__tb__sub">μ λͺ©</th>
                    <td>${svo.title }</td>
                </tr>
                <tr>
                    <th>μμ΄λ</th>
                    <td>${svo.userid }</td>
                </tr>
                <tr>
                    <th>λ΄μ©</th>
                    <td>${svo.content }</td>
                </tr>
            </table>
            <input class="bo__btn__m" type="submit" id="btn_submit" value="μμ ">
            <input class="bo__btn__mb" type="button" value="λͺ©λ‘μΌλ‘" onclick="javascript:history.back()">
       </form>
    </div>