---
layout: post
title: Django Admin 테마 변경하기
category: [파이썬, Django]
tags: [Django, Python, Admin, Theme, Material Design]
---

# 개요
Django의 기본 Admin은 강력한 기능이지만 Look이 그다지 아름답지 않다.  
직접 Admin을 커스터마이즈 하는 것은 상당히 손이 많이 가므로 [djangopackages.org](https://djangopackages.org/grids/g/admin-styling/)에 올라와 있는  
패키지를 이용해 간단히 수정해 보았다.  

# 패키지 선택
가장 널리 쓰이는 `DJANGO-GRAPPELLI`부터, `DJANGO-SUIT` 등등 여러 패키지가 있지만,  
Material Design의 팬(?)으로써 `DJANGO-MATERIAL`을 이용해 보았다.  
`DJANGO-MATERIAL`은 전에 [Django를 이용한 스케쥴러 제작](https://minyoungjung.github.io/%ED%8C%8C%EC%9D%B4%EC%8D%AC/django/%EC%9B%B9%EC%84%9C%EB%B9%84%EC%8A%A4/2017/06/08/django-scheduler-(1)/)에서도 이용했었던 [Materialize](http://materializecss.com/getting-started.html)를 기반으로 하므로  
사용도 간단하리라 생각했다.  

# 사용법
## django-material 설치
`pip install django-material`

## INSTALLED_APPS 추가
``` python
INSTALLED_APPS = (
    'material',
    'material.admin',
    ...
)
```
`django.contrib.admin` 앞에 두 줄이 추가되어야 한다.  

## 적용결과
![적용결과](/post_assets/2017-06-28/material-admin.png)

## 간단한 커스터마이즈 (사이드바 아이콘)
`apps.py`의 AppConfig class에 `icon = '<i class="material-icons">subject</i>'`속성 추가  
아이콘 주소는 [https://material.io/icons/](https://material.io/icons/)를 따른다.  

## 간단한 커스터마이즈 (카드 내 아이콘)
`admin.py`의 admin.ModelAdmin class에 `icon` 속성 추가 (위와 동일)  

## 커스터마이즈 후 결과
![커스터마이즈 결과](/post_assets/2017-06-28/material-admin-modify.png)

## 추가 커스터마이즈
[라이브러리 Doc 참조](http://docs.viewflow.io/admin_customization.html)





