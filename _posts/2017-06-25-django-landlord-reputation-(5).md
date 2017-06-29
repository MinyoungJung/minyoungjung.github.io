---
layout: post
title: Django를 이용한 건물주 평판 조회 서비스 제작 (5) - Heroku 업로드
category: [파이썬, Django, 웹서비스, 안드로이드]
tags: [Django, Web service, Python, 평판조회, Heroku, whitenoise]
---

# 진행률
모든 기능구현을 끝내고 개발/운영환경을 설정 후 여러 보안 키들을 분리했다.  
[Django 설정 개발/운영환경 나누기, PostgreSQL 사용하기](https://minyoungjung.github.io/%ED%8C%8C%EC%9D%B4%EC%8D%AC/django/%EC%9B%B9%EC%84%9C%EB%B9%84%EC%8A%A4/2017/06/24/django-multiple-settings/)  

그리고 Heroku에 릴리즈하기 위한 설정을 했다.  
[Django 프로젝트 Heroku에 릴리즈하기](https://minyoungjung.github.io/%ED%8C%8C%EC%9D%B4%EC%8D%AC/django/%EC%9B%B9%EC%84%9C%EB%B9%84%EC%8A%A4/2017/06/10/django-project-heroku/)  


# Heroku 설정 (환경변수)
Django의 SECRET_KEY나 여러 API키들을 숨기기 위해 환경변수를 이용한 설정을 하는 경우,  
Heroku에도 동일하게 환경변수를 이용해 설정을 해줘야 한다.  

## SECRET_KEY 설정
`heroku config:set SECRET_KEY=asdasdsad` **= 양쪽에 공백이 없어야 한다.**  

## DJANGO_SETTINGS_MODULE 설정
`heroku config:set DJANGO_SETTINGS_MODULE=앱이름.settings.prod`  
이 항목을 설정해야 Heroku에 push 할때 여러개의 설정 파일 중, 운영환경의 설정 파일을 적용한다.  
**이 항목을 적용하지 않으면 `ModuleNotFoundError: No module named 'settings'` 에러가 발생한다.**  


아니면 Heroku 사이트의 [대시보드](https://dashboard.heroku.com/apps)에서 Settings 탭의 Config Variables를 통해 직접 설정할 수도 있다.  

# Heroku 설정 (Local Test)
`heroku conifg`를 통해 환경변수 설정값을 확인하고,  
`heroku local web`을 통해 heroku 설정을 이용해 로컬 웹서버를 띄워본다.  
이때 여전히 `ModuleNotFoundError: No module named 'settings'` 에러가 발생하는 경우가 있다.    
이는 로컬 웹서버를 띄울 시 DJANGO_SETTINGS_MODULE 환경변수 값을 Heroku에 설정한 값이 아닌  
로컬에 설정되어 있는 값을 가져오기 때문이다.  

`env | grep DJANGO_SETTINGS_MODULE`을 통해 값을 확인하고 값이 Heroku에 설정한 값과 다를 경우  
`export DJANGO_SETTINGS_MODULE=앱이름.settings.prod`를 입력하면 해결할 수 있다.

# Heroku 설정 (Debug=False 및 whitenoise)
이 설정 때문에 무난히도 삽질을 했다.  
전에 [Django를 이용한 스케쥴러 제작 (2) - 구현](https://minyoungjung.github.io/%ED%8C%8C%EC%9D%B4%EC%8D%AC/django/%EC%9B%B9%EC%84%9C%EB%B9%84%EC%8A%A4/2017/06/09/django-scheduler-(2)/) 시에는 사실 나 혼자 쓸 것이기도 하고,  
귀찮기도 해서 Debug도 켜놓고 키값조차 감추지 않은 개발환경 그대로 Heroku에 업로드를 했다.  
그때만 해도 [Django 프로젝트 Heroku에 릴리즈하기](https://minyoungjung.github.io/%ED%8C%8C%EC%9D%B4%EC%8D%AC/django/%EC%9B%B9%EC%84%9C%EB%B9%84%EC%8A%A4/2017/06/10/django-project-heroku/) 대로만 하면 아무런 문제없이 Heroku에서 동작했다.  
  
문제는 Debug를 False로 놓았을 때인데... [Heroku 문서](https://devcenter.heroku.com/articles/django-app-configuration#migrating-an-existing-django-project)부터가 삽질을 조장한다.  
[whitenoise 문서](http://whitenoise.evans.io/en/stable/django.html#make-sure-staticfiles-is-configured-correctly)를 보면 `settings.py`의 MIDDLEWARE 설정에 `whitenoise.middleware.WhiteNoiseMiddleware',`를 추가하라 되어있지만,  
이런 내용이 Heroku에는 쏙 빠져있다.  
덕분에 500 Internal server error를 일으키며 site가 동작하지 않는다.  
  
나의 경우는 미들웨어 설정을 추가했는데도 whitenoise가 계속 문제를 일으키며 staticfile을 제대로 제공하지 않아,  
결국 whitenoise 대신 기본 Django staticfiles로 해결했다.  

## whitenoise 대신 default Django staticfiles 이용
`STATICFILES_STORAGE = 'django.contrib.staticfiles.storage.StaticFilesStorage'`로 교체  
이후 `python manage.py collectstatic --settings=앱이름.settings.prod`를 실행하고  
`heroku local web`을 실행하면 사이트가 정상 동작한다.  
heroku에서는 Profile을 통해 collectstatic이 자동으로 실행된다.  

# 마무리
이걸로 또 하나의 프로젝트가 마무리 되었다.  
[우리동네집주인 바로가기](http://landlord-reputation.herokuapp.com/)


