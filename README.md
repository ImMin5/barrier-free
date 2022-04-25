# Barrier-free Jeju

# 목차
[1. 개요](#개요)

[2. 개발환경](#개발환경)

[3. 실행방법](#실행방법)

[4. 구현화면-사용자](#구현화면-사용자)

[5. 구현화면-관리자](#구현화면-관리자)

## 개요
- Open API와 AI를 활용하여 모두가 편하고 행복한 여행을 즐길 수 있게 도움을 주는 무장애 여행 웹페이지 제작 

### 주제 선정 이유
![image](https://user-images.githubusercontent.com/38625842/165121769-5f15e9c9-3bea-4be2-84f8-a4fa02d9c88d.png)
![image](https://user-images.githubusercontent.com/38625842/165121795-7cefa509-387d-4a91-b096-29273c4f7b50.png)


### 목표
1. 장애인, 고령자, 임산부와 같은 관광 약자가 이동 수단, 시설 이용 등 관광 활동을 제약 없이 여행을 하는 것을 목표
2. 기존 관련 홈페이지는 기본 정보 제공 위주였던 단점을 보강하여 사용자 본인이 관광지를 계획할 수 있도록 함
3. 접근성 향상을 위한 음성 안내 서비스 및 픽토그램 활용 등 사용자 사용성을 고려한 UI 개발과 디자인 구축
4. 원활한 웹페이지 관리 서비스 제공을 위한 관리자 페이지 운영
5. 관광 이용 중 이동에 불편한 장소가 있을 시, 건의할 수 있는 소통창구(게시판) 마련


### 개발 인원 및 기간
- 기간 : 2022-04-01 ~ 2022-04-21
- 인원 : 6명 

### 주요 기능
- 무장애 여행 API를 활용하여 관광 약자에게 편안한 여행 정보 제공
- 여행 플래너 작성을 통해 관광코스를 작성하는데 도움을 줌
- 시각장애인의 접근성을 높이기 위한 TTS 기능 활용
- 제주도에서의 관광약자들을 위한 OPEN API기반 여행 정보 소개 웹 어플리케이션 

### 접속주소
- http://barrier-free.tk/

## 개발환경
### 의존성
- jdk 11
- springboot 2.6.6
- mysql 8.0
- apache tomcat 9.0

### 기술 스택
- FrontEnd
    - Html
    - CSS
    - JavaScript, jQuery , Ajax
- BackEnd
    - Java
    - SpringBoot
    - Mybatis
- DB
    - MySQL

- IDE
    - STS

- API TEST
   - POSTMAN
- Server 
  -  GCP(배포시)
 
### 시스템 구성도
![image](https://user-images.githubusercontent.com/38625842/165111460-c7b5307d-31a9-4172-b327-f737110c2396.png)

### 데이터 베이스
![image](https://user-images.githubusercontent.com/38625842/165112208-a3beb72a-3613-45f3-894f-8452f9a9d7c4.png)

## 실행방법
```
  $ ./gradlew build
  $ cd build/libs
  or
  $ java -Dfile-encoding=UTF-8 -jar barrier-free.war
  $ java -jar barrier-free.war 
```

## 구현화면-사용자

### 1.메인페이지
![image](https://user-images.githubusercontent.com/38625842/165116272-daace870-c805-4922-bb79-b2f413c23bc9.png)
![image](https://user-images.githubusercontent.com/38625842/165116288-61a24f04-42b8-4832-b6b4-71c49abb8515.png)


### 2.숙박정보, 여행지정보
![image](https://user-images.githubusercontent.com/38625842/165116337-ae2832c4-932d-40f0-bb95-ed6e6b834f9d.png)

```
지역 및 키워드 별 검색 기능
장소별 상세 정보 확인 가능
장소에 대한 리뷰 평점, 리뷰 수 확인 가능
```

### 2-1.상세 페이지
![image](https://user-images.githubusercontent.com/38625842/165116386-408ed40b-641c-4040-aa63-3606d01b8f0a.png)
```
로그인 후, 리뷰 달기 및 삭제 가능
장소 별 상세 정보 확인 가능
카카오 맵을 통한 장소 좌표 확인가능
장소에 대한 평균 리뷰평점, 리뷰 수 확인 가능
```
### 3. 이동수단
![image](https://user-images.githubusercontent.com/38625842/165116570-7e44f575-f9ae-4fb4-b706-41011ec3153a.png)
```
비행기, 버스 , 택시등 여행에 필요한 이동 수단에 대한 정보를 확인 할 수 있는 페이지 
```
### 4. 지도
![image](https://user-images.githubusercontent.com/38625842/165117137-1ee4cf0c-c460-4efc-8aa2-61ada41988d0.png)
![image](https://user-images.githubusercontent.com/38625842/165117170-f5fa153d-79a6-4d11-8595-91df7b580ad3.png)

```
검색을 하면 목록에 보이고 지도에 마커가 찍힘
장소 별 상세 정보 확인 가능
장소에 대한 좋아요, 찜하기, 리뷰평점, 리뷰 수 확인 가능
TTS기능으로 제목과 상세주소를 읽어 줌
로그인 사용자만 이용 가능
```

### 5. 지도를 활용한 여행 플래너
![image](https://user-images.githubusercontent.com/38625842/165117285-f284e6e6-73d0-42c4-9542-12c3275eab80.png)
```
마커의 플래너 추가버튼으로 리스트에 추가가능
```
![image](https://user-images.githubusercontent.com/38625842/165117321-15f60456-34b4-4914-982a-d50f6745f36e.png)
```
플랜 제목과 날짜, 리스트 목록 저장가능
```
![image](https://user-images.githubusercontent.com/38625842/165117348-c83b1baf-fe4e-4ffe-943b-7fd5ffdd4d49.png)
```
플랜 목록에서 이전에 저장된 정보 불러오기, 삭제 가능
```
![image](https://user-images.githubusercontent.com/38625842/165117368-b3e3436d-73f6-45ec-9694-463d44d57fa7.png)
```
플랜 리스트의 목록들 순서이동, 개별 삭제가능
```
![image](https://user-images.githubusercontent.com/38625842/165117769-eb9ef80a-0267-4a69-9ed5-d9b37017ee21.png)

![image](https://user-images.githubusercontent.com/38625842/165117780-1218f111-2a11-418a-8290-88820702ac82.png)
![image](https://user-images.githubusercontent.com/38625842/165117800-16b33a0d-d546-4d4d-8b33-6712d379d140.png)

```
동행자 추가, 삭제기능
```

![image](https://user-images.githubusercontent.com/38625842/165117857-cb177413-b5a1-4f67-ba7f-c0296f1e0071.png)

```
TTS 기능
```
### 6.회원가입
![image](https://user-images.githubusercontent.com/38625842/165118347-a248f61b-9851-47d3-b692-b46548365377.png)
```
회원가입 입력 폼 제공
회원정보 입력 여부 확인
아이디 중복검사
회원가입 약관  동의 확인
```
### 7.로그인
![image](https://user-images.githubusercontent.com/38625842/165118509-bb4f0308-8362-4c32-8db2-e9f7a6db7c3a.png)

### 8.아이디/비밀번호 찾기 및 회원탈퇴
![image](https://user-images.githubusercontent.com/38625842/165118566-4f38e0f4-b72f-451f-ab95-a8ab0e1d4397.png)
```
이름 생년월일 확인 아이디 비밀번호 찾기 질문/답변 확인
회원탈퇴 -> 비밀번호 확인
```
### 9. 마이페이지
![image](https://user-images.githubusercontent.com/38625842/165118726-cf2c4562-d670-46a5-ab1e-979bb8feb7b9.png)
```
마이페이지-나의 플래너
지도-플래너에서 저장한 나의 플랜을 확인/삭제할 수 있음
클릭 시 지도-플래너로 이동
```

![image](https://user-images.githubusercontent.com/38625842/165118837-200a6aee-73f8-4d8c-be43-3aff8a43d475.png)
```
마이페이지-나의 리뷰
여행지 정보, 숙박 업소 정보에서 등록한 나의 리뷰들을 한눈에 확인/삭제할 수 있는 페이지
클릭 시 리뷰가 달린 페이지로 이동 
```

![image](https://user-images.githubusercontent.com/38625842/165118903-e51fc201-a87c-4195-a767-097a8f472fcd.png)
```
마이페이지-나의 문의사항
커뮤니티 문의사항 게시판에 등록한 나의 문의사항과 문의사항의 답변을 확인할 수 있는 페이지 
클릭 시, 등록한 문의 사항 글과 답변 글 페이지로 이동 
```

### 10. 건의할래요
![image](https://user-images.githubusercontent.com/38625842/165119025-bfd4efaf-d306-4a2f-99ab-8f42f269783f.png)
![image](https://user-images.githubusercontent.com/38625842/165119058-aa9a67a2-ea7a-4d96-9743-57f225a321a3.png)
![image](https://user-images.githubusercontent.com/38625842/165119237-9f9e773d-0c8a-4b94-9679-9770b2761e8b.png)

```
글목록 리스트
글 생성, 수성, 삭제 가능
```
### 11. 공지/문의사항
![barrier-free tk_board_boardList_form](https://user-images.githubusercontent.com/38625842/165120704-2d043947-b6c1-4b03-8fec-800b9f1739f4.png)
```
문의사항
문의사항 생성, 수정, 삭제 가능
```

### 12. 코디네이터 연결
![image](https://user-images.githubusercontent.com/38625842/165119340-7d1ce1eb-e38e-4403-ab0b-f477f107b76f.png)


## 구현화면-관리자
### 1. 관리자 로그인
![image](https://user-images.githubusercontent.com/38625842/165120877-5076999a-6159-43be-854b-c18eb52de62a.png)

### 2. 공지사항 관리
![image](https://user-images.githubusercontent.com/38625842/165121056-ea5d5f3f-971e-4efe-9920-ce289de4e16f.png)
![image](https://user-images.githubusercontent.com/38625842/165121098-054c2243-c206-467b-b138-37edc6c94aa7.png)
```
공지사항을 등록할 수 있고, 이용자의 문의사항에 답변할 수 있는 기능
```

### 3. 코디네이터 관리
![image](https://user-images.githubusercontent.com/38625842/165121184-9f872e54-f041-46a7-bc57-b262ea9e4202.png)
```
코디네이터를 등록 할 수 있는 기능
```

### 4. 회원관리
![image](https://user-images.githubusercontent.com/38625842/165121274-1dbff87e-b3e3-40c9-bcb5-f7936458d4d5.png)

```
관리자 – 회원관리
회원정보 수정 / 삭제 할 수 있는 기능
``

