    <div id="wrap">
        <h2>게시글 상세보기</h2>
        
            <table>
                <tr>
                    <th>제목</th>
                    <td>${bvo.subject}</td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>${bvo.userid}</td>
                </tr>
                <tr>
                    <th>작성시간</th>
                    <td>${bvo.write_date}</td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td><pre>${bvo.content}</pre></td>
                </tr>
            </table>
            <input class="btn" type="submit" value="새글 작성" onclick="location.href='/board/boardList/form'">
            <input class="btn" type="reset" value="글 수정">
            <input class="btn" type="button" value="글 삭제">
            <input class="btn" type="button" value="목록으로" onclick="location.href='/board/boardList/'">
        
    </div>