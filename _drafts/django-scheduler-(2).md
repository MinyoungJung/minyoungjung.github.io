---
layout: post
title: Django를 이용한 스케쥴러 제작 (2) - 구현
category: [파이썬, Django, 웹서비스]
tags: [Django, Web service, Python, Scheduler, Material Design]
---

# 구현
## Todolist
Django의 Generic view를 이용해 구현했다.  
TodayArchiveView/DayArchiveView를 이용해 해당 날짜의 할일들을 보여주었다.

## Calendar
Python standard library의 HTMLCalendar를 이용해 구현했다.  
지난달/다음달로 이동할 수 있는 화살표를 추가하고, Workout 테이블을 조회하여 리스트를 해당 날짜에 뿌려주었다.

## Stats

id|create_date|workout_done|owner_id|workout_id|duration|workout_date
:-:|:-:|:-:|:-:|:-:|:-:|:-:
PK|생성일|운동 수행여부|소유자|FK(List)|수행시간(분)|수행 날짜

Workout 테이블에서 owner를 필터로 쿼리셋울 뽑아낸 후, duration의 평균을 구해 matplotlib으로 출력하였다.  
별도의 DB 테이블에 각각의 평균값을 운동 수행 결과 표시 시마다 계산하여 저장하고,  
해당 테이블을 조회하는 것이 훨씬 빠르겠지만, 일단은 나 혼자 쓰는 서비스니까 그냥 전체 DB를 검색하기로 결정.  
Django 철학에도 있지않은가.. `Simple is better than complex` ~~이럴때 쓰란말은 아니지만...~~
<br>
여러 종류의 그래프를 통해 다양한 그래프를 출력하고 싶었지만, 막상 데이터가 여러 방법으로 보여줄 것이 없었다.  
워낙 DB 구성이 단순하니까... 나중에 더 생각나면 추가하기로 했다.  

## 로그인/관리자 기능
Django의 기본 Auth와 Admin을 이용했다.  
혼자 쓰는 서비스이지만 결국 웹에 올려놓을 테니.. 로그인 기능이 필요하긴 했다.  

# 스크린샷
## Todolist
![할일목록](/post_assets/2017-06-09/todolist.png)

## Calendar
![캘린더](/post_assets/2017-06-09/calendar.png)

## Stats
![그래프](/post_assets/2017-06-09/stats.png)

## 모바일 대응 메뉴
![모바일 대응](/post_assets/2017-06-09/mobile-react.png)


# 마무리
간단히 시작한 프로젝트였지만, 막상 너무 간단한게 아닌가하는 생각이 들어 무엇인가를 추가하려 했다.  
하지만 기능은 추가하고 싶고 마땅히 추가할 기능은 없고... 점점 본질에서 멀어져가며 흥미가 떨어지는 것을 느끼고,  
이러다가는 프로젝트를 완성하지도 못할 것 같아 다시 초심으로 돌아가 간단히 마무리했다.  
일단은 이것으로 프로젝트 구현을 마치고, 스스로 사용해보고 마음에 들면 개선하고 추가해 볼 생각이다.

# 추후 계획 
1. 각종 버그 수정... (귀찮지 않다면...)
2. 데이터 분석 및 그래프 기능 확장
3. 데이터 입력 기능 편하게 만들기 (현재는 혼자 쓰니 그냥 어드민으로 넣음..)
4. 간단한 소셜 기능 (옵션)

# 서비스 링크
간단히 무료 Dyno를 통해 Heroku에 올려두었다.  
DB row도 10000줄까지 밖에 지원하지 않지만 혼자쓰니 문제없겠지..  

[https://workoutcal.herokuapp.com](https://workoutcal.herokuapp.com)



