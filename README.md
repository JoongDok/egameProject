# egameProject

## 목차

- [프로젝트소개](#프로젝트소개)
- [개발내용](#개발내용)
- [주요기능](#주요기능)
- [시연영상](#시연영상)

## 프로젝트 소개

### 1. 기획의도
코로나 사태로 인하여 패키지게임의 수요가 증가함에 따라 게임 중개 사이트의 수요도 올라갔습니다. </br>
여러 패키지게임을 하나의 사이트에서 찾고 구매할 수 있는 사이트의 필요성을 느끼게 되어 이번 기회에 만들게 되었습니다. 

### 2. 개발일정
2023.02.27에 시작하여 2023.04.05에 마무리하고 2023.04.06에 프로젝트발표 후 마무리하였습니다.</br>
![개발일정](https://i.esdrop.com/d/f/D6JOYU5GMF/MjEKbGaMrz.png)</br>
1주차에는 주제선정 및 메뉴구성, DB설계를 하였으며</br>
2주차에는 DB설계 마무리와 메인페이지 디자인, 본격적인 백, 프론트작업을 실시하여 4주차메 마무리 하였습니다.</br>
5주차에는 디버깅 및 발표준비를 하고 프로젝트 마무리를 하였습니다.</br>

## 개발내용

### 1. 적용기술
![적용기술](https://i.esdrop.com/d/f/D6JOYU5GMF/QblFFIjkAa.png)</br>

### 2. DB설계
![DB](https://i.esdrop.com/d/f/D6JOYU5GMF/eehhJtK66T.png)</br>
총 13개의 테이블로 구성하였습니다.

### 3. 유저설명 및 메뉴구성도
유저구분은 크게 3가지로 나뉘어집니다.</br>
1. 일반사용자, 2. 판매자, 3. 관리자

![메뉴구성도](https://i.esdrop.com/d/f/D6JOYU5GMF/fzLQlWFhCj.png)</br>
메뉴구성도 입니다.
구성도의 하얀색부분은 비회원이 접근할 수 있는 영역이며,</br>
하양 + 노랑 은 일반회원유저, 하양+노랑+보라는 판매자유저가 접근 가능합니다.</br>
관리자는 모든부분 접근가능합니다.

## 주요기능

### 1. 이메일인증
![이메일인증](https://i.esdrop.com/d/f/D6JOYU5GMF/AbI9QzYDg7.png)</br>
JavaMailSender를 활용하여 이메일인증기능을 구현했습니다.</br>
이메일로 중복가입을 제한하며 인증번호 미입력 시 회원가입이 불가합니다.

### 2. 상품검색기능
![상품검색](https://i.esdrop.com/d/f/D6JOYU5GMF/R5VB0lTVTw.gif)</br>
상품검색 조건으로는 정렬방법, 상품이름검색,할인여부, 가격검색, 장르 가 있으며 모든 검색조건은 교차검색이 가능합니다.</br>
상품페이지를 AJAX로 구현하여 검색조건이 바뀔때마다 보이는 상품도 바뀌게됩니다.

### 3. 리뷰기능

### 4. 할인기능


더 많은기능들이 있지만 자세한 설명은 시연영상 시청을 부탁드립니다.
## 시연영상
https://youtu.be/J-3O4g2vs1s

