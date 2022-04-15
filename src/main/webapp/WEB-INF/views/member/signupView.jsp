<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="url" value="<%=request.getContextPath()%>" />
	    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">	
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <link rel="stylesheet" href="${url }css/signup.css">
        <script src="/js/signup.js"></script>
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
 

        <div id="signup" >
        	
        	<div id="signuph1">
        	
        	
        	</div>	
				
			
			<div class="wd">
			<a id="suplogo"><img src="${url }/img/member/bf_logo_signup4.png"></a>
			<div id="logoud"><hr/></div>
            <form method="post" action="/signup" id="sFrm" onsubmit="return memberCheck()">
                <ul>
                	
                    <li>* 아이디 <input id="button" type="button" value="중복확인" /><span id='chk'></span></li>
                    <li><input type="text" name="userid" id="userid" placeholder="아이디를 입력해주세요." />
                     <input type="hidden" id="idchk" value='N' /></li>
                    <li>* 비밀번호</li>
                    <li><input type="password" name="userpassword" id="userpwd" placeholder="비밀번호를 입력해주세요" />
                    </li>
                    <li>* 비밀번호 확인</li>
                    <li><input type="password" name="userpassword2" id="userpwd2" placeholder="비밀번호를 다시 입력해주세요." /></li>
                    <li>* 이름</li>
                    <li><input type="text" name="username" id="username" placeholder="성함을 입력해주세요." /></li>
                    <li>* 생년월일</li>
                    <li><input type="text" name="date_birth" id="userbirth" placeholder="생년월일을 입력해주세요. (예: 980121)" />
                    </li>
                    <li>* 비밀번호 찾기 질문</li>
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
                    <li>* 비밀번호 찾기 답변</li>
                    <li><input type="text" name="answer" id="answer" placeholder="비밀번호 찾기 답변을 입력해주세요." /></li>
                    
                    <li>장애정도 </li>
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
                    <li>회원 가입 약관 <input type="button" class="btn-open-popup"/ value="[보기]"><input class="term2" type="checkbox" id="termcheck" value="동의" /> 약관에 동의합니다.</li>
                    <li id="sbm"><input id="button2" type="submit" value="가입하기" /></li>
                    <div class="modal">
                    <div class="modal_body"><textarea id="terms" rows="27" cols="61" disabled>회원 가입 약관 내용
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       </textarea></div>
                       <script>
    					  const body = document.querySelector('body');
     					  const modal = document.querySelector('.modal');
    					  const btnOpenPopup = document.querySelector('.btn-open-popup');

  							    btnOpenPopup.addEventListener('click', () => {
      						    modal.classList.toggle('show');

     					   if (modal.classList.contains('show')) {
       							   body.style.overflow = 'hidden';
     						   }
  						    });

  						    modal.addEventListener('click', (event) => {
      						   if (event.target === modal) {
       					   modal.classList.toggle('show');

         				 if (!modal.classList.contains('show')) {
          				  body.style.overflow = 'auto';
          }
        }
      });
    </script>
						

                    </div>
                </ul>
                
            </form>
        </div>
	</div>
	<hr/>
