---
layout: post
title: Django 프로젝트 Heroku에 릴리즈하기
category: [파이썬, Django, 웹서비스]
tags: [Django, Web service, Python, Heroku]
---

# 기존 프로젝트 Heroku에 릴리즈

## Heroku CLI 설치
https://devcenter.heroku.com/articles/heroku-cli

## Procfile 추가
루트에 `Procfile`을 추가한다
`web: gunicorn myproject.wsgi --log-file -`

## runtime.txt 추가
루트에 `runtime.txt`를 추가한다.
`python-3.6.1`

## gunicorn을 추가한다
`pip3 install gunicorn`

## dj-database-url을 추가한다.
`pip3 install dj-database-url`

프로젝트의 `settings.py`파일에
``` python
import dj_database_url
db_from_env = dj_database_url.config(conn_max_age=500)
DATABASES['default'].update(db_from_env)
```
추가한다.

## whitenoise를 추가한다.
장고는 기본적으로 프로덕션에서 스태틱 파일을 serving하지 않는다. 
pip install whitenoise

`settings.py`
``` python
# Simplified static file serving.
# https://warehouse.python.org/project/whitenoise/

STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')
STATICFILES_STORAGE = 'whitenoise.django.GzipManifestStaticFilesStorage'
```

`wsgi.py`
from django.core.wsgi import get_wsgi_application
from whitenoise.django import DjangoWhiteNoise

application = get_wsgi_application()
application = DjangoWhiteNoise(application)

##

## Heroku Login
`heroku login`


## Heroku create
`heroku create`

```
heroku create
Creating app... done, ⬢ calm-basin-17299
https://calm-basin-17299.herokuapp.com/ | https://git.heroku.com/calm-basin-17299.git

Git remote heroku added
```

## Heroku를 git remote로 추가
`git remote add heroku https://git.heroku.com/calm-basin-17299.git`


## Heroku에 push
`git push heroku master`

## 아아 정말 오래 개고생했는데...

matplotlib때문에 일어난 문제였음..

import matplotlib
matplotlib.use('Agg')를 해주고,

heroku에 올리기 전에 db 생성해줘야함.. (production에서 db 생성이 안되어 있을경우...)

`heroku run python manage.py migrate`


슈퍼유저 생성
heroku run python manage.py createsuperuser



gunicorn 설정시 폴더구조는
메인 -
    |- 프로젝트
    |- 다른 앱
    





