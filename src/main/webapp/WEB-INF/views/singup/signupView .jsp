<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <link rel="stylesheet" href="${url}/css/signup.css" type="text/css" />
    <script src="/bf/js/signup.js"></script>
    <script>
        $(function(){
            // 아이디 중복검사
            $("#userid").keyup(function(){
                var userid = $("#userid").val();
                    
                if(userid !=''&&userid.length>=6){
                    var url = "/bf/member/memberIdCheck";
                    $.ajax({
                        url : url,
                        data : "userid="+userid,
                        type:"POST",
                        success:function(result){
                            if(result>0){// 사용불가
                                $("#chk").html("&nbsp; &nbsp; 사용불가능합니다.");
                                $("#idchk").val("N");
                                $("#chk").css("color","#FF4848");
                            }else{// 사용가능하다.
                                $("#chk").html("&nbsp; &nbsp; 사용가능합니다.");
                                $("#idchk").val("Y");
                                $("#chk").css("color","#5AAEFF");
                            }	
                        }
                    });
                }else{// 사용불가하다.
                    $("#chk").html("&nbsp; &nbsp; 사용불가능합니다.");
                    $("#idchk").val("N");
                    $("#chk").css("color","red");
                }	
            });
        });
    </script>
    <hr />
    <div id="signup">

        <form method="post" action="/bf/signup/signupOk" id="sFrm" onsubmit="return memberCheck()">
            <ul>
                <li>아이디 *</li>
                <li><input type="text" name="userid" id="userid" placeholder="아이디를 입력해주세요." />
                    <input id="button" type="button" value="중복확인" /><span id='chk'></span>
                    <input type="hidden" id="idchk" value='N' />
                </li>
                <li>비밀번호 *</li>
                <li><input type="password" name="userpwd" id="userpwd" placeholder="비밀번호를 입력해주세요" />
                </li>
                <li>비밀번호 확인 *</li>
                <li><input type="password" name="userpwd2" id="userpwd2" placeholder="비밀번호를 다시 입력해주세요." /></li>
                <li>생년월일 *</li>
                <li><input type="text" name="userbirth" id="userbirth" placeholder="생년월일을 입력해주세요. (예: 9801021)" /></li>
                <li>비밀번호 찾기 질문 *</li>
                <select name="question" id="question">
                    <optgroup>
                    	<option>자신의 인생 좌우명은?</option>
                        <option>자신의 보물 제1호는?</option>
                        <option>가장 기억에 남는 선생님 성함은?</option>
                        <option>가장 생각나는 친구 이름은?</option>
                        <option>인상 깊게 읽은 책 이름은?</option>
                        <option>내가 좋아하는 캐릭터는?</option>
                        <option>어릴 적 별명은?</option>
                    </optgroup>
                </select>
                <li>비밀번호 찾기 답 *</li>
                <li><input type="text" name="answer" id="answer" /></li>
<<<<<<< HEAD
                <li>장애정도</li>
=======
                <li>장애</li>
>>>>>>> f3641a6264363d797e7785ffebecb95bd0c3e29c
                <select name="grade" id="grade">
                    <optgroup>
                    	<option>다음에 입력하기</option>
                        <option>1등급</option>
                        <option>2등급</option>
                        <option>3등급</option>
                        <option>4등급</option>
                    </optgroup>
                </select>
                <li><input id="button" type="submit" value="회원가입" /></li>
            </ul>
        </form>
    </div>
    <hr />
    </body>

    </html>