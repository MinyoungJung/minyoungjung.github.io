---
layout: post
title: 장고 서비스 테스트하기
category: [파이썬, Django, 웹서비스, 테스트]
tags: [Django, Python, Web service, Test]
---

# Coverage 설치
파이썬 코드의 테스트 커버리지를 나타내 주는 라이브러리인 coverage를 설치한다.
`pip3 install coverage`

# Coverage 설정
## .coveragerc 파일 생성
``` shell
vi .coveragerc
```
vim을 이용해서 간단하게 coveragerc 설정 파일을 생성.

## 실행환경 설정
[run] 헤더 이후에 설정을 적어주면 된다.  
include = 테스트를 포함할 경로  
omit = 테스트를 제외할 경로  

```
[run]
omit = ../virtualenvs/landlord_reputation_venv/*
```
기본적으로 project_root의 폴더들이 모두 포함되므로 위와 같이 가상환경만 제외했다.  

# Coverage 실행
`coverage run manage.py test`로 테스트를 수행
```
Creating test database for alias 'default'...
System check identified no issues (0 silenced).

----------------------------------------------------------------------
Ran 0 tests in 0.000s

OK
```
위와 같이 테스트를 수행한다.  
현재는 아무런 테스트도 넣지 않은 상태  


# 리포트 보기
`coverage report`로 각각의 파일에 대한 리포트를 볼수 있다.
```
Name                                    Stmts   Miss  Cover
-----------------------------------------------------------
landlord_reputation/__init__.py             0      0   100%
landlord_reputation/settings.py            20      0   100%
landlord_reputation/urls.py                 4      0   100%
landlord_reputation/views.py                8      0   100%
manage.py                                  13      6    54%
reputation/__init__.py                      0      0   100%
reputation/admin.py                         8      0   100%
reputation/apps.py                          3      0   100%
reputation/migrations/0001_initial.py       8      0   100%
reputation/migrations/__init__.py           0      0   100%
reputation/models.py                        9      0   100%
reputation/tests.py                         1      0   100%
reputation/urls.py                          3      0   100%
reputation/views.py                        90     65    28%
-----------------------------------------------------------
TOTAL                                     167     71    57%
```

view 파일에 대해 하나도 테스트가 작성되지 않은 상태라 coverage가 매우 낮게 출력된다.

# 리포트 html 형식으로 보기
좀더 자세한 결과를 보기위해서 리포트를 Html 형식으로 출력할수도 있다.  
`coverage html` 명령을 통해 `htmlcov/index.html`로 리포트가 생성된다.

## 리포트 형식
![커버리지 리스트](/post_assets/2017-06-20/coverage_list.png)

## 리포트를 선택했을때 나오는 상세 결과
![커버리지 디테일](/post_assets/2017-06-20/coverage_detail.png)

# 테스트 코드 작성하기
``` python
from django.core.urlresolvers import reverse
from django.test import TestCase

from reputation.models import Reputation

class ReputationView(TestCase):
    def setUp(self):
        Reputation.objects.get_or_create(address="sample address", latitude="23.456789",
        longitude="123.4567890", owner_id=1)

    def test_template_url(self):
        url = reverse("reputation:reputation_template",  args=["123.1234567", "23.456789"])
        response = self.client.get(url)
        self.assertEqual(response.status_code, 200)
```
generic view Http 응답에 대한 테스트 코드를 삽입하였다.

## 이후 다시 테스트를 수행한 결과
![커버리지 디테일](/post_assets/2017-06-20/coverage_detail2.png)
커버리지가 조금 올라가고 붉은색으로 표시된 테스트 되지 않은 범위도 조금 줄어들었다.  

테스트 플랜을 짜고 좀더 상세한 Suite/Case를 작성해야겠지만 위 방법을 확장하여 테스트 커버리지를 높일 수 있다.


