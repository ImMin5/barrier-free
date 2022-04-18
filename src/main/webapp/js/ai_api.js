function tts2(textData, url){
	var url = url+"/api/tts";
	console.log(textData);
	$.ajax({
		url : url,
		type : "POST",
		data : textData,
		success : function(){
		}
	});
}

function tts(textData){
//비동기식처리를 할 수 있는 객체
	console.log("textData" + textData);
	var url = "/api/tts";
	let xhr = new XMLHttpRequest();
         
         //응답받은 데이터의 데이터 타입설정
         xhr.responseType='blob'; //바이너리 타입으로 받아라
         
         //서버에서 응답받으면
         xhr.onload = function(){
            var audioURL = URL.createObjectURL(this.response);
            var audio = new Audio();
            audio.src = audioURL;
            audio.play();
         }
         
         //서버에 접속하기
         //      전송방식, 매핑주소
         xhr.open('post','/api/tts');
         xhr.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
         xhr.send("textData="+textData); //서버로 보낼 정보  text=보낼문자열	
}