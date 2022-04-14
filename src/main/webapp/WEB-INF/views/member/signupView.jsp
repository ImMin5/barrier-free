<!DOCTYPE html>
<html lang="en">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>회원가입</title>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <link rel="stylesheet" href="/barrier-free/src/main/webapp/css/signup.css" type="text/css" />
        <script src="/barrier-free/src/main/webapp/js/signup.js"></script>
        <script>
            $(function () {
                // 아이디 중복검사
                $("#button").click(function () {
                    var userid = $("#userid").val();

                    if (userid != '' && userid.length >= 6) {
                        var url = "/signup/memberIdCheck";
                        $.ajax({
                            url: url,
                            data: "userid=" + userid,
                            type: "POST",
                            success: function (result) {
                                if (result > 0) {
                                    $("#chk").html("&nbsp; &nbsp; 중복되거나 사용할 수 없는 아이디입니다.");
                                    $("#idchk").val("N");
                                    $("#chk").css("color", "#FF4848");
                                } else {
                                    $("#chk").html("&nbsp; &nbsp; 사용가능한 아이디 입니다.");
                                    $("#idchk").val("Y");
                                    $("#chk").css("color", "#5AAEFF");
                                }
                            }
                        });
                    } else {
                        $("#chk").html("&nbsp; &nbsp; 중복되거나 사용할 수 없는 아이디입니다.");
                        $("#idchk").val("N");
                        $("#chk").css("color", "red");
                    }
                });
            });
        </script>
    </head>

    <body>
        <h1>회원가입</h1>
        <hr />
        <div id="signup">

<<<<<<< HEAD
        <div id="signup" >
        	
        	<div id="signuph1">
        	
        	
        	</div>	
				
			
			<div class="wd">
			<a id="suplogo"><img src="${url }/img/bf_logo_signup4.png"></a>
			<div id="logoud"><hr/></div>
=======
>>>>>>> parent of 612d39c (Merge branch 'develop' of https://github.com/ImMin5/barrier-free into feature/signupView)
            <form method="post" action="/signup" id="sFrm" onsubmit="return memberCheck()">
                <ul>
                    <li>아이디 &nbsp; <img src="/barrier-free/src/main/webapp/img/bf_signup.png" /></li>
                    <li><input type="text" name="userid" id="userid" placeholder="아이디를 입력해주세요." />
                        <input id="button" type="button" value="중복확인" /><span id='chk'></span>
                        <input type="hidden" id="idchk" value='N' />
                    </li>
<<<<<<< HEAD
                    <li>비밀번호 *</li>
                    <li><input type="password" name="userpassword" id="userpwd" placeholder="비밀번호를 입력해주세요" />
                    </li>
                    <li>비밀번호 확인 *</li>
                    <li><input type="password" name="userpassword2" id="userpwd2" placeholder="비밀번호를 다시 입력해주세요." /></li>
                    <li>이름 *</li>
                    <li><input type="text" name="username" id="username" placeholder="성함을 입력해주세요." />
                    <li>생년월일 *</li>
                    <li><input type="text" name="date_birth" id="userbirth" placeholder="생년월일을 입력해주세요. (예: 980121)" />
=======
                    <li>비밀번호 &nbsp; <img src="/barrier-free/src/main/webapp/img/bf_signup.png" /></li>
                    <li><input type="password" name="userpwd" id="userpwd" placeholder="비밀번호를 입력해주세요" />
                    </li>
                    <li>비밀번호 확인 &nbsp; <img src="/barrier-free/src/main/webapp/img/bf_signup.png" /></li>
                    <li><input type="password" name="userpwd2" id="userpwd2" placeholder="비밀번호를 다시 입력해주세요." /></li>
                    <li>생년월일 &nbsp; <img src="/barrier-free/src/main/webapp/img/bf_signup.png" /></li>
                    <li><input type="text" name="userbirth" id="userbirth" placeholder="생년월일을 입력해주세요. (예: 980121)" />
>>>>>>> parent of 612d39c (Merge branch 'develop' of https://github.com/ImMin5/barrier-free into feature/signupView)
                    </li>
                    <li>비밀번호 찾기 질문 &nbsp; <img src="/barrier-free/src/main/webapp/img/bf_signup.png" /></li>
                    <div>&nbsp;</div>
                    <select name="question" id="question">
                        <optgroup label="비밀번호 찾기 질문을 선택해주세요">
                            <option value="q1">자신의 인생 좌우명은?</option>
                            <option value="q2">자신의 보물 제1호는?</option>
                            <option value="q3">가장 기억에 남는 선생님 성함은?</option>
                            <option value="q4">가장 생각나는 친구 이름은?</option>
                            <option value="q5">인상 깊게 읽은 책 이름은?</option>
                            <option value="q6">내가 좋아하는 캐릭터는?</option>
                            <option value="q7">어릴 적 별명은?</option>
                        </optgroup>
                    </select>
                    <div>&nbsp;</div>
                    <li>비밀번호 찾기 답변 &nbsp; <img src="/barrier-free/src/main/webapp/img/bf_signup.png" /></li>
                    <li><input type="text" name="answer" id="answer" placeholder="비밀번호 찾기 답변을 입력해주세요." /></li>
                    <li>장애정도 &nbsp; <img src="/barrier-free/src/main/webapp/img/bf_signup.png" /></li>
                    <div>&nbsp;</div>
                    <select name="grade" id="grade">
                        <optgroup label="맞춤 할인 정보 제공을 위해 선택해주세요">
                            <option value=5>다음에 입력하기</option>
                            <option value=1>1등급</option>
                            <option value=2>2등급</option>
                            <option value=3>3등급</option>
                            <option value=4>4등급</option>
                        </optgroup>
                        <div>&nbsp;</div>
                    </select>
                    <li>회원 가입 약관 &nbsp; <img src="/barrier-free/src/main/webapp/img/bf_signup.png" /></li>
                    <li id="term"><textarea id="terms" rows="10" cols="61" disabled>회원 가입 약관 내용
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       </textarea></li>
                    <li id="term2"><input type="checkbox" id="termcheck" value="동의" /> 약관에 동의합니다.</li>
                </ul>
                <div id="sbm"><input id="button2" type="submit" value="가입하기" /></div>
            </form>
        </div>
<<<<<<< HEAD
	</div>
	<hr/>
=======

    </body>

</html>
>>>>>>> parent of 612d39c (Merge branch 'develop' of https://github.com/ImMin5/barrier-free into feature/signupView)
