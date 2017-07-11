---
layout: post
title: 안드로이드 액티비티 전체화면 만들기
category: [안드로이드]
tags: [Android, Android Studio, Java]
---

요즘 바빠서 블로깅하기가 힘들다.  
그냥 간단한 것이라도 남기기로 한다.  

# 툴바 및 상태바 숨기기

아래 코드를 onCreate의 `setContentView` 전에 해주면 된다.  
사실 Android Studio에서 자동으로 생성해주는 FullScreenActivity에서도 볼 수 있는 내용이다.  

``` java
getWindow().getDecorView().setSystemUiVisibility(
    View.SYSTEM_UI_FLAG_LAYOUT_STABLE
        | View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
        | View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
        | View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
        | View.SYSTEM_UI_FLAG_FULLSCREEN
        | View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY);
```


