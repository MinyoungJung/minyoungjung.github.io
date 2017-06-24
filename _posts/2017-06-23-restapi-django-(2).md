---
layout: post
title: Django에 Rest API 추가하기 (2) - API에 인증 추가
category: [파이썬, Django, 웹서비스]
tags: [Django, Python, Web service, REST API, Auth]
---

# 지난번에 추가한 API
지난번에는 Django REST Framework의 `generics.RetrieveUpdateDestroyAPIView`를 이용하여,  
GET/PUT/PATHCH/DELETE에 반응하는 API를 제작했다.  
[Django에 Rest API 추가하기 - 링크](https://minyoungjung.github.io/%ED%8C%8C%EC%9D%B4%EC%8D%AC/django/%EC%9B%B9%EC%84%9C%EB%B9%84%EC%8A%A4/2017/06/21/restapi-django/)  

하지만 지금 상태로는 누구나 정보를 수정/삭제가 가능하므로 인증 기능을 추가해야 한다.

# API에 인증 추가
로그인 하지 않으면 Read 권한만 주고 로그인한 사용자에게는 Write/Update 권한을 주려면 간단한 방법이 있다.

``` python
from rest_framework import permissions

class ReputationDetail(MultipleFieldLookupMixin, generics.RetrieveUpdateDestroyAPIView):
    queryset = Reputation.objects.all()
    serializer_class = ReputationSerializer
    lookup_fields = ('longitude', 'latitude')
    permission_classes = (permissions.IsAuthenticatedOrReadOnly,)  # 추가
``` 

하지만 현재 서비스는 다중 사용자 환경이므로, 이와 같이 작성하면 계정을 가진 모두가 정보를 삭제할 수 있게 된다.  
따라서 정보 작성자의 계정과 api 접속 인증 계정이 일치할 때만 정보를 삭제할 수 있도록 해야 한다.  
이를 위해서 먼저 Custom permisson을 추가한다.  

``` python
from rest_framework import permissions


class IsOwnerOrReadOnly(permissions.BasePermission):

    def has_object_permission(self, request, view, obj):
        if request.method in permissions.SAFE_METHODS:  # GET, HEAD, OPTIONS 
            return True

    return obj.owner_id == request.user.id

```
위와 같이 새로운 권한을 추가하고, SAFE_METHOD(객체의 상태를 변화시키지 않는 메소드)일 경우는 True를 반환,  
그렇지 않은 경우에는 정보의 모델 필드의 owner_id가 요청하는 유저의 id와 일치할때만 True를 반환하게 했다.


``` python
from reputation.permissions import IsOwnerOrReadOnly

class ReputationDetail(MultipleFieldLookupMixin, generics.RetrieveUpdateDestroyAPIView):
    queryset = Reputation.objects.all()
    serializer_class = ReputationSerializer
    lookup_fields = ('longitude', 'latitude')
    permission_classes = (IsOwnerOrReadOnly,)  # 변경
``` 
그 후 API를 반환하는 View의 퍼미션 클래스에 해당 클래스를 추가했다.  
마지막으로 object를 반환하는 mixin 클래스에서,  

```
class MultipleFieldLookupMixin(object):
    def get_object(self):
        queryset = self.get_queryset()             # Get the base queryset
        queryset = self.filter_queryset(queryset)  # Apply any filter backends
        filter = {}
        for field in self.lookup_fields:
            if self.kwargs[field]:  # Ignore empty fields.
                filter[field] = self.kwargs[field]
        obj = get_object_or_404(queryset, **filter)  # Lookup the object
        self.check_object_permissions(self.request, obj)  # Check permissions
        return obj
```
위와 같이 obj를 반환하기 전에 퍼미션을 확인하도록 변경하였다.  

# API 테스트 결과
## Postman을 이용해서 api를 테스트 한 결과 (GET)
![실행결과](/post_assets/2017-06-23/without_auth.png)
GET 명령은 인증 없이도 잘 동작한다.

## Postman을 이용해서 api를 테스트 한 결과 (DELETE)
![실행결과](/post_assets/2017-06-23/without_auth_delete.png)
Delete 명령은 인증이 없으니 동작하지 않는다.

## Postman을 이용해서 api를 테스트 한 결과 (DELETE & wrong Auth)
![실행결과](/post_assets/2017-06-23/invalid_id_pw.png)
Auth를 포함할 때 잘못된 아이디/패스워드를 사용했을때는 다음과 같은 결과가 돌아온다.  

## Postman을 이용해서 api를 테스트 한 결과 (DELETE & Auth (not owner))
![실행결과](/post_assets/2017-06-23/valid_auth_not_owner.png)
제대로된 Auth로 인증했으나 Owner가 아닌 경우에도 역시 동작하지 않는다.

## Postman을 이용해서 api를 테스트 한 결과 (DELETE & Auth (Owner))
![실행결과](/post_assets/2017-06-23/valid_auth_owner.png)
Owner인 경우에는 정상적으로 동작하여 해당 정보가 삭제되었다.










