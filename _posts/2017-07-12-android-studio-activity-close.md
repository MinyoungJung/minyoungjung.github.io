---
layout: post
title: 안드로이드 startActivity 시에 기존 activity 제거하기
category: [안드로이드]
tags: [Android, Android Studio, Java]
---

요즘 바빠서 블로깅하기가 힘들다.  
그냥 간단한 것이라도 남기기로 한다.  

# 인텐트 전달하며 기존 액티비티 제거하기
액티비티에서 액티비티로 갈때에는 `finish();` 를 호출하면 간단하다.  

비동기 태스크와 같이 액티비티가 아닌 곳에서 기존 액티비티를 없애려면 다음과 같이 한다.  

``` java
Intent i = new Intent(context, MainActivity.class);
i.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
context.startActivity(i);
```

# 사용법
Splash 화면 만들어놓고 비동기로 작업 해놓고 그 작업이 다 완료되면 다음 액티비티로 넘어가며,  
Back Stack에 Splash Activity가 남지 않게 하려면 사용하면 된다.  
