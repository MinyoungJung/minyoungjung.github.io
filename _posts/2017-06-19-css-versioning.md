---
layout: post
title: 브라우저 CSS 캐쉬 무력화하기 및 Mac에서 Localhost 지정하기
category: [파이썬, Django, CSS, 웹서비스, Mac 사용팁]
tags: [CSS, Django, Python, Web service, Chrome, Cache, Localhost, Mac]
---

# 브라우저 CSS 캐쉬 무력화하기
웹서비스를 제작하며 CSS 를 수정하다보면 분명 수정했는데도 불구하고 브라우저에 적용되지 않을때가 있다.  
이는 브라우저가 기존의 CSS 파일을 캐쉬로 저장하고 있기 때문인데 간단하게 해결할 수 있다.  

## 해결방법
HTML에서 css 파일을 로딩하는 부분에 아래와 같이 버전번호를 인자로 추가하면 된다.
```
<link href="/css/custom.css?v=1.0" rel="stylesheet">
```

### Django의 경우
```
{% raw %}
<link href="{% static '/css/custom.css' %}?v=1.0" rel="stylesheet">
{% endraw %}
```
  


# Mac에서 Localhost 지정하기
IP 주소(127.0.0.1) 대신 localhost로 접근할때 localhost의 접속 IP를 설정하는 파일 위치는  
`/private/etc/hosts` 이다.  
`sudo vi /private/etc/hosts`와 같이 해당 파일을 편집기로 진입해 host이름과 ip 짝을 수정해주면 된다.

