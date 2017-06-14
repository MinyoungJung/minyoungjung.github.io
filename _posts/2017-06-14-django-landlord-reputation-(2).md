---
layout: post
title: Django를 이용한 건물주 평판 조회 서비스 제작 (2) - DB 구성, 외부 라이브러리
category: [파이썬, Django, 웹서비스, 안드로이드]
tags: [Django, Web service, Python, Map API, REST API, Android, 평판조회]
---

# DB 구성
## Reputation 테이블

ID|Longitude|Latitude|Description|Created_date
:-:|:-:|:-:|:-:|:-:|
Primary Key|경도|위도|평판|레코드 생성 날짜

<br>
# App 구성 및 외부 라이브러리
## App 구성
평판 조회/출력하는 단일 app으로 구성

## 주소검색 라이브러리  
[주소검색솔루션](http://www.juso.go.kr/addrlink/main.do)  
행정자치부에서 만든 솔루션이다.  
자체적으로 서버에 솔루션을 설치해야 하기에 간단히 제작한다는 취지에 너무 과하다는 생각이 들어 패스했다.

[네이버맵스](https://developers.naver.com/docs/map/javascriptv3/)  
간단하고 쓰기편한 네이버 지도 API 선택.

## 프론트엔드 라이브러리
[부트스트랩](http://http://getbootstrap.com/)  
프론트엔드는 그냥 고민없이 부트스트랩으로... 


# 추후 일정
Generic View, Admin 기능 등.. 최대한 장고 자체의 기능을 이용해서 빨리빨리 MVP 구현.  
이후 저번 프로젝트와는 다른쪽에 중점을 두고 개선/확장 예정

