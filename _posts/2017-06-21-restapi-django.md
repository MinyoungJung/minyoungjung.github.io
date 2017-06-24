---
layout: post
title: Django에 Rest API 추가하기
category: [파이썬, Django, 웹서비스]
tags: [Django, Python, Web service, REST API]
---

# API 구성
기존에 만든 [Django를 이용한 건물주 평판 조회 서비스](https://minyoungjung.github.io/%ED%8C%8C%EC%9D%B4%EC%8D%AC/django/%EC%9B%B9%EC%84%9C%EB%B9%84%EC%8A%A4/%EC%95%88%EB%93%9C%EB%A1%9C%EC%9D%B4%EB%93%9C/2017/06/16/django-landlord-reputation-(4)/)에 Rest API를 추가하려 한다.  
API endpoint로 `/api/위도+경도`의 URL을 날리면 해당 좌표에 맞는 정보가 날아오는 형태이다.



# Django REST Framework 설치
`pip3 install djangorestframework`  
Rest API를 생성할때 가장 보편적으로 쓰는 라이브러리인 Django REST Framework를 설치한다.

# Serializer 클래스 정의
별도의 `serializer.py` 파일을 정의하였다.  
모델 전체를 Serialize 할 수도 있지만, ModelSerializer를 상속받으면 더욱 간단하다.  


``` python
from reputation.models import Reputation
from rest_framework import serializers


class ReputationSerializer(serializers.ModelSerializer):
class Meta:
model = Reputation
fields = ('address', 'latitude', 'longitude', 'description')
```

Django Shell에서 작성한 Serializer를 확인해 보았다.  
``` shell
>>> from reputation.serializer import ReputationSerializer
>>> ser = ReputationSerializer()
>>> print(repr(ser))
ReputationSerializer():
address = CharField(max_length=50)
latitude = DecimalField(decimal_places=7, max_digits=9)
longitude = DecimalField(decimal_places=7, max_digits=10)
description = CharField(style={'base_template': 'textarea.html'})
```

# API URL 생성
``` python
# Endpoint URL: /api/126.575834+33.427337/
url(r'^api/(?P<longitude>\d{1,3}\.\d{1,7})\+(?P<latitude>\d{1,2}\.\d{1,7})/$',
ReputationDetail.as_view(), name='reputation_rest_api'),
```
위도, 경도를 매개변수로 넘겨주도록 URL을 설정했다.

# API를 제공하는 View 생성
하나의 모델에 대해 read-write-delete 엔드포인트를 제공하는 RetrieveUpdateDestroyAPIView를 상속받았다. 

``` python
from reputation.serializer import ReputationSerializer
from rest_framework import generics

class ReputationDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Reputation.objects.all()
    serializer_class = ReputationSerializer
```
DB의 리스트를 전부 출력하기 위해서는 위와 같이 generics를 적절히 상속받는 것으로 충분하나  
넘겨받은 위/경도를 이용해서 DB를 검색하기 위해 조금 추가 작업이 필요하다.  

여러개의 필드를 검색할 수 있는 Mixin class를 생성하여 ReputationDetail이 상속받도록 한다.  

``` python
class MultipleFieldLookupMixin(object):
    def get_object(self):
        queryset = self.get_queryset()             # Get the base queryset
        queryset = self.filter_queryset(queryset)  # Apply any filter backends
        filter = {}
        for field in self.lookup_fields:
            if self.kwargs[field]: # Ignore empty fields.
                filter[field] = self.kwargs[field]

        return get_object_or_404(queryset, **filter)  # Lookup the object
```

이후 ReputationDetail이 MultipleFieldLookupMixin을 상속하게 하고,  
lookup_fields 항목에 필터로 지정할 항목을 정해주면 된다.  


``` python
class ReputationDetail(MultipleFieldLookupMixin, generics.RetrieveUpdateDestroyAPIView):
    queryset = Reputation.objects.all()
    serializer_class = ReputationSerializer
    lookup_fields = ('longitude', 'latitude')
```

# API 테스트 결과
Postman을 이용해서 api를 테스트 한 결과
![실행결과](/post_assets/2017-06-21/test_api.png)


# 다음편 링크
[Django에 Rest API 추가하기 (2) - API에 인증 추가](https://minyoungjung.github.io/%ED%8C%8C%EC%9D%B4%EC%8D%AC/django/%EC%9B%B9%EC%84%9C%EB%B9%84%EC%8A%A4/2017/06/23/restapi-django-(2)/)  













