---
layout: post
title: Django 설정 개발/운영환경 나누기, PostgreSQL 사용하기
category: [파이썬, Django, 웹서비스]
tags: [Django, Web service, Python, PostgreSQL, Pycharm, pgAdmin4]
---

# 개발/운영환경 설정파일 분리
1. Settings 폴더를 생성하여 `__init__.py` 파일을 넣어 모듈로 만든다.
2. 기존 `settings.py`를 `base.py`로 변경하여 setting에 공통으로 필요한 부분만 남긴다.
3. `base.py`를 import한 `prod.py`를 추가하여 운영 환경에 관련된 세팅을 추가한다.  
4. `base.py`를 import한 `dev.py`를 추가하여 개발환경에 관련된 세팅을 추가한다.

``` python
from .base import *


# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = []

EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'
```

# 키값 분리
base.py에서 SECRET_KEY나 여러 API키 등 노출되면 안되는 부분을 분리해야 한다.  
가상환경의 `bin/activate` 파일을 수정하여 마지막 부분에 다음 줄을 넣는다.
``` shell
{% raw %}
export SECRET_KEY=`secret key`
{% endraw %}
```
이후 `SECRET_KEY = os.environ["SECRET_KEY"]`를 세팅에 추가한다.  
Runserver를 동작시켜보면 잘 돌아간다.

# Pycharm에서의 문제점
위와 같이 설정할 경우 Pycharm에서 서버를 실행하면 환경변수를 받아오지 못한다.  
이는 Pycharm과 같은 GUI 프로그램이 가상환경을 실행한 Shell을 상속받지 않기 때문인데,  
``` python
def get_env_variable(var_name, default=False):
    try:
        return os.environ[var_name]
    except KeyError:
        import io
        import configparser
        env_file = os.environ.get('PROJECT_ENV_FILE', os.getcwd() + "/.env")
    try:
        config = io.StringIO()
        config.write("[DATA]\n")
        config.write(open(env_file).read())
        config.seek(0, os.SEEK_SET)
        cp = configparser.ConfigParser()
        cp.read_file(config)
        value = dict(cp.items('DATA'))[var_name.lower()]
        if value.startswith('"') and value.endswith('"'):
            value = value[1:-1]
        elif value.startswith("'") and value.endswith("'"):
            value = value[1:-1]
        os.environ.setdefault(var_name, value)
        return value
    except (KeyError, IOError):
        if default is not False:
            return default
        from django.core.exceptions import ImproperlyConfigured
        error_msg = "Either set the env variable '{var}' or place it in your " \
                    "{env_file} file as '{var} = VALUE'"
        raise ImproperlyConfigured(error_msg.format(var=var_name, env_file=env_file))


# Make this unique, and don't share it with anybody.
SECRET_KEY = get_env_variable('SECRET_KEY')
```
위와 같이 환경변수를 받아오는 메소드를 설정파일에 집어넣고,  
프로젝트 루트에 `.env`파일을 생성해서
``` shell
SECRET_KEY=`secret key`
```
과 같이 작성하면 해결된다.

**위와 같은 경우에는 .gitignore에 .env 파일을 추가해서 키값이 노출되는 것을 막아줘야 한다.**

# 설정파일 적용
`python manage.py runserver --settings=앱이름.settings.dev`  
위와 같이 설정파일을 각각 적용 가능하다.

# PostgreSQL 사용하기
Django는 기본 DB로 SQLite를 사용한다.  
운영 환경에서는 PostgreSQL을 이용할 것이므로, 개발환경에서도 PostgreSQL을 적용하기로 했다.  
ORM이 많은 부분을 해결해 주더라도 개발/운영환경이 일치되는 편이 문제 발생률을 크게 줄여준다.  
또한 실환경의 Data를 덤프해서 개발환경에 집어넣고 테스트가 가능하기도 하다.

1. psycopg2 설치  
`pip3 install psycopg2`

2. postgresql 설치 및 db 생성  
`createdb db이름`

3. `dev.py`에 설정
``` python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'db이름',
        'USER': '',
        'PASSWORD': '',
        'HOST': '',
        'PORT': '',
    }
}
```
4. migrate 하기  
`python manage.py migrate --settings=앱이름.settings.dev`

5. superuser 생성  
`python manage.py createsuperuser --settings=앱이름.settings.dev`

6. 서버 실행  
`python manage.py runserver --settings=앱이름.settings.dev`  

# pgAdmin4
## Data 보기
db이름 → Schemas → public → Tables → 테이블에서 우클릭 → View Data

## 기타
SQlite GUI 관리툴로는 DB Browser for SQLite를 쓰며 만족스러웠는데,  
이놈의 pgAdmin4는 왜이렇게 마음에 안드는지 모르겠다.




