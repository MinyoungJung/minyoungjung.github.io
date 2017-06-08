---
layout: post
title: Django를 이용한 스케쥴러 제작 (1) - 정의 및 구성
category: [파이썬, Django, 웹서비스]
tags: [Django, Web service, Python, Scheduler, Material Design]
---

# 발단
1일 1커밋을 생활화하기 위해 Django를 이용한 간단한 서비스를 만들기로 했다.  
운동을 좋아하는 만큼 운동 스케쥴러를 작성하기로 했고, 프로젝트 목표와 개발 방향을 설정했다.

# 목표
1. 스스로 사용할 만한 서비스 구축
2. 깔끔한 디자인
3. 확장성(?)

# 요구사항
1. 일정을 추가할 수 있고, 일별/월별 보기가 가능할 것
2. 당일 해야할 운동 종류를 표시하며, 해당 Todo 리스트에서 수행 여부를 표시할 수 있을 것
3. 수행한 항목의 수행 시간에 비율을 그래프로 출력할 것

# DB 구성
크게 운동 종류를 나타낸 Category 테이블을 만들고, 카테고리 테이블을 Foreign key로 이용한 List 테이블,  
마지막으로 각각의 개별 운동을 나타내는 Workout 테이블을 생성했다.  
테이블 상세 구성은 아래와 같다.  


## Workout List 테이블  

id|workout_title|category_id 
:-:|:-:|:-:
PK|개별 운동 이름|FK(Category)

## Workout Category 테이블  

id|category_name
:-:|:-:
PK|운동 카테고리 이름
 
## Workout 테이블  

id|create_date|workout_done|owner_id|workout_id|duration|workout_date
:-:|:-:|:-:|:-:|:-:|:-:|:-:
PK|생성일|운동 수행여부|소유자|FK(List)|수행시간(분)|수행 날짜

<br>

# App 구성 및 외부 라이브러리
App은 할일을 출력하는 todolist, 월별 목록을 출력하는 calendar,  
그래프를 출력하는 stats의 세 부분으로 구성되어 있다.  

전체적인 Look&Feel은 심플한 Material Design 형태로 가기로 하고, [Materialize](http://materializecss.com/getting-started.html)를 이용했다.  
그래프를 출력하기 위해서는 [Plotly](https://github.com/plotly/plotly.py)와 [Matplotlib](https://matplotlib.org/gallery.html)을 고민하다 최종적으로 matplotlib으로 결정하였다.


[Django를 이용한 스케쥴러 제작 (2) - 구현](https://minyoungjung.github.io/파이썬/django/웹서비스/2017/06/09/django-scheduler-(2)/)


