---
layout: post
title: Volley를 이용해 간단한 Android Rest API Client 만들기
category: [파이썬, Django, 웹서비스, Android]
tags: [Django, Python, Web service, REST API, Android, Volley, Java]
---

# 서론
지난번에 마무리했던 Project인 [Django를 이용한 건물주 평판 조회 서비스 제작 (1) - 기획](https://minyoungjung.github.io/%ED%8C%8C%EC%9D%B4%EC%8D%AC/django/%EC%9B%B9%EC%84%9C%EB%B9%84%EC%8A%A4/%EC%95%88%EB%93%9C%EB%A1%9C%EC%9D%B4%EB%93%9C/2017/06/12/django-landlord-reputation-(1)/)에서  
추가 목표로 안드로이드 App을 연동하기로 했으므로 간단하게나마 API Client를 작성한다.  

# API overview
클라이언트에 사용되는 API는  
[Django에 Rest API 추가하기](https://minyoungjung.github.io/%ED%8C%8C%EC%9D%B4%EC%8D%AC/django/%EC%9B%B9%EC%84%9C%EB%B9%84%EC%8A%A4/2017/06/21/restapi-django/)  
[Django에 Rest API 추가하기 (2) - API에 인증 추가](https://minyoungjung.github.io/%ED%8C%8C%EC%9D%B4%EC%8D%AC/django/%EC%9B%B9%EC%84%9C%EB%B9%84%EC%8A%A4/2017/06/23/restapi-django-(2)/)  
위의 포스팅들을 통해 제작한 간단한 API이다.  

`http://landlord-reputation.herokuapp.com/reputation/api/경도+위도` 형태로 질의 시,  
[우리동네집주인](http://landlord-reputation.herokuapp.com/)에 추가된 평판 정보를 전송하는 API이다.  

# Android Application Layout
EditText 2개를 통해 각각 위/경도를 전달받고 TextView를 통해 Response를 출력한다.  
간단하므로 설명은 생략.  

# Volley 추가
`build.gradle (Module:app)` 파일에 dependency를 추가한다.  
`compile 'com.android.volley:volley:1.0.0'`

# AndroidManifest.xml 권한 설정
인터넷 엑서스가 필요하므로 인터넷 권한도 설정한다.
``` XML
<uses-permission android:name="android.permission.INTERNET"/>
```

# Volley 사용
JSONObject Request를 이용해서 간단히 구현했다.  
Volley의 자세한 사용법은 [예전 블로그](https://ringsterz.wordpress.com/2014/12/03/volley%EB%A5%BC-%EC%9D%B4%EC%9A%A9%ED%95%B4-network-data-%EC%A0%84%EC%86%A1%ED%95%98%EA%B8%B0-1-simple-request-%EC%A0%84%EC%86%A1/)에 써놓은 글을 참조.

# API Client 실행 결과
![실행결과](/post_assets/2017-06-27/API_client.png)

# Github 링크
[SimpleAndroidRestAPIClient 바로가기](https://github.com/MinyoungJung/SimpleAndroidRestAPIClient)
