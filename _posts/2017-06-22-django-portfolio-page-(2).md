---
layout: post
title: Django를 이용한 포트폴리오 사이트 제작 (2) - 사이트 형태 잡기, User Model 확장
category: [파이썬, Django, 웹서비스]
tags: [Django, Web service, Python, Portfolio, Bootstrap]
---
# 공동 프로젝트 진행상황  
**1주차** : JQuery를 이용한 간단한 애니메이션  
**2주차** : Phaser Library를 이용한 마우스 이벤트에 반응하는 인터랙션  
**3주차** : 개인 포트폴리오 사이트 공동 기획

# 4주차 진행상황
이번주는 토요일에 작업을 진행하기 힘들것 같아 일정을 미리 앞당겨 진행했다.  
먼저 지난주 목표였던 요구사항에 대해 작업을 진행했다.

## 지난주 요구사항
### 최신 작업중인 작품을 보여주는 페이지  
TemplateView를 상속한 HomeView를 추가해서 최신 작품의 커버 이미지를 보여주는 페이지를 제작했다.  

### 간단한 프로필 페이지 (Contact, Profile description, SNS 링크 등)  
TemplateView를 상속해 마찬가지로 정적 페이지로 제작해 집어넣었다가 마지막에 약간 수정했다.  
Django의 기본 User Model을 확장하여 SNS ID나 Biography 등을 넣을 수 있게끔 하고,  
이 내용이 프로필 페이지에 반영되도록 했다.  
``` python
class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    bio = models.TextField(max_length=500)
    twitter_id = models.CharField(max_length=30, blank=True)
    instagram_id = models.CharField(max_length=30, blank=True)
    tumblr_id = models.CharField(max_length=30, blank=True)
    facebook_id = models.CharField(max_length=30, blank=True)
```
별도의 User model 자체에 대한 변경은 필요없고 몇개 추가적인 필드가 필요한 뿐이라,  
위와 같이 OneToOneField를 이용해 유저 모델을 확장했다.  

### 기존 작품 목록
- 목록을 선택하면 [ISSUU](https://issuu.com/)와 같은 책 형식으로 작품을 보여줄 수 있어야 함.
- 아날로그적인 느낌으로 책장을 넘기는 애니메이션이 있으면 좋겠음

목록은 단순히 그리드 형태로 배치하고, 선택했을때 Modal popup을 이용해 상세정보를 띄워주도록 했다.  
책장을 넘기는 애니메이션이 있는 Viewer는 JQuery Library 중 page transition 관련 하나를 골라 제작했다.  

### 사이드 프로젝트 목록
- 주 작업 외에 기타 작품들을 전시할 공간

아직 어떠한 작품들을 어떠한 형식으로 보여주고 싶은지 확정되지 않아 Navbar와 링크만 제작해 놓았다. 

# 다음주 목표

1. 작품 업로드 구현하기
- 여러장의 이미지로 이루어진 파일을 손쉽게 올릴수 있는 방법 생각
- 여러장의 이미지에는 Cover와 table contents가 포함되어 있음
2. 관리자 기능 추가 및 디자인 업데이트



