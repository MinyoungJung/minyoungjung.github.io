---
layout: post
title: Django 프로젝트 Heroku에 릴리즈하기
category: [파이썬, Django, 웹서비스]
tags: [Django, Web service, Python, Heroku]
---

# 기존 Django 프로젝트 Heroku에 릴리즈

## Heroku CLI 설치
`brew install heroku`

## gunicorn을 추가
`pip3 install gunicorn`

gunicorn 설정시 폴더구조는  
메인 -  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|- 프로젝트  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|- 다른 앱  
폴더 구조가 다르면 gunicorn module 임포트를 적절히 수정해 줘야 한다.

## Procfile 추가
프로젝트 루트에 `Procfile`을 추가하고 다음 내용을 저장한다.  
`web: gunicorn myproject.wsgi --log-file -`

## runtime.txt 추가
프로젝트 루트에 `runtime.txt`을 추가하고 다음 내용을 저장한다. (파이썬 3.# 일 경우)  
`python-3.6.1`

## dj-database-url 추가
`pip3 install dj-database-url`

이후 프로젝트의 `settings.py`파일에
``` python
import dj_database_url
db_from_env = dj_database_url.config(conn_max_age=500)
DATABASES['default'].update(db_from_env)
```
를 추가한다.

## whitenoise 추가
장고는 기본적으로 프로덕션에서 스태틱 파일을 제공하지 않는다.  
whitenoise는 개발 환경 그대로 스태틱 파일을 제공하게 해준다.  
`pip install whitenoise`

`settings.py`에 다음 내용을 추가한다.
``` python
# Simplified static file serving.
# https://warehouse.python.org/project/whitenoise/

STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')
STATICFILES_STORAGE = 'whitenoise.django.GzipManifestStaticFilesStorage'
```

`wsgi.py`에 다음 내용을 추가한다.
```
from django.core.wsgi import get_wsgi_application
from whitenoise.django import DjangoWhiteNoise

application = get_wsgi_application()
application = DjangoWhiteNoise(application)
```

## Heroku에 로그인
`heroku login`

## Heroku 앱 생성
`heroku create`

```
heroku create
Creating app... done, ⬢ calm-basin-17299
https://calm-basin-17299.herokuapp.com/ | https://git.heroku.com/calm-basin-17299.git

Git remote heroku added
```

## Heroku를 git remote로 추가
`git remote add heroku https://git.heroku.com/calm-basin-17299.git`


## db가 생성되어 있지 않다면 생성 
`heroku run python manage.py migrate`  
간혹 dev와 production 환경의 db가 다를 경우 db 생성이 되지 않은 상태라 push가 제대로 되지 않는다.

# 슈퍼유저 생성
`heroku run python manage.py createsuperuser`


## commit하고 Heroku에 push
`git push heroku master`


## 만약 matpolib을 쓴다면... 헤로쿠와 충돌이 일어난다

```
import matplotlib
matplotlib.use('Agg')
```
를 `import matplotlib.pyplot as plt, mpld3` 전에 추가한다.






