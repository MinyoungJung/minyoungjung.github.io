---
layout: post
title: Django 프로젝트 Heroku 릴리즈 - (최종 수정)
category: [파이썬, Django, 웹서비스]
tags: [Django, Web service, Python, Heroku, whitenoise]
---

할때마다 고생이라 한번 더 정리한다.  
보안키 같은것 숨기지 않고, 그냥 가장 빠르게 설정하는 방법이다.  
CLI 등 툴 인스톨은 기존 포스팅을 참고하자.  

## gunicorn 추가 (장고 기본 폴더 구성 시)
`pip3 install gunicorn`

## Procfile 추가
프로젝트 루트에 `Procfile`을 추가하고 다음 내용을 추가  
`web: gunicorn myproject.wsgi --log-file -`

## runtime.txt 추가
프로젝트 루트에 `runtime.txt`을 추가하고 다음 내용 추가 
`python-3.6.1`

## dj-database-url 추가
`pip3 install dj-database-url`

`settings.py`파일에 다음 내용 추가
``` python
import dj_database_url
db_from_env = dj_database_url.config(conn_max_age=500)
DATABASES['default'].update(db_from_env)
```

## whitenoise 추가 
`pip install whitenoise`

`settings.py`에 다음 내용을 추가한다.
``` python
STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')
STATICFILES_STORAGE = 'whitenoise.django.GzipManifestStaticFilesStorage'
```

`wsgi.py`에 다음 내용을 추가
```
from django.core.wsgi import get_wsgi_application
from whitenoise.django import DjangoWhiteNoise

application = get_wsgi_application()
application = DjangoWhiteNoise(application)
```

## psycopg2 추가
`pip install psycopg2`

## requirements.txt 생성
`pip freeze > requirements.txt` 입력

## ALLOWED Host 추가
`settings.py`에 `ALLOWED_HOSTS = ['*']`를 추가

## DEBUG 끄기
`settings.py`에서 `DEBUG = False` 설정

## Heroku 앱 생성
`heroku create`

## Git commit 하고 heroku로 push
`git add .`  
`git commit -m "heroku settings update"`  
`git push heroku master`  

## db가 생성 
`heroku run python manage.py migrate`

## 슈퍼유저 생성
`heroku run python manage.py createsuperuser`


# 중요
SECRET_KEY를 숨기려면 기존에 작성한 포스팅을 참고할 것.  
위의 방법은 가장 빠르게 릴리즈만을 위한 방법임  


