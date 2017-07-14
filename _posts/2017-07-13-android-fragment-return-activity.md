---
layout: post
title: 안드로이드 Activity에서 Fragment로부터 데이터 전달 받기
category: [안드로이드]
tags: [Android, Java]
---  

# 사용씬
액티비티에서 Fragment Transaction을 이용하여 DialogFragment 등을 호출했다.  
이 Dialog가 종료시에 Activity가 결과값을 돌려받고자 한다.  

# 문제점
Fragment - Fragment 면 `setTargetFragment`와 `onActivityResult`를 통해 인텐트로 전달가능하다.  
하지만 Activity가 Fragment를 호출했을때는 Dialog가 종료 시 `onActivityResult`가 호출되지 않는다.  

# 해결책
액티비티에서 인터페이스를 생성하여 구현하거나 기타등등 해결법이 있지만 제일 간단한 방법은...
1. 액티비티에 public 메소드를 구현한다.
2. DialogFragment에서 다음과 같이 액티비티의 메소드를 인자와 같이 호출한다.
``` java
((MainActivity)getContext()).someMethod(args);
```

엄밀히 따지면 데이터 전달은 아니다.


