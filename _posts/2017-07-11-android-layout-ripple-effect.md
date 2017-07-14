---
layout: post
title: 안드로이드 레이아웃 XML에서 위젯에 물결 이펙트 넣기
category: [안드로이드]
tags: [Android, Java, UI]
---

요즘 바빠서 블로깅하기가 힘들다.  
그냥 간단한 것이라도 남기기로 한다.  

# XML에 물결 이펙트 넣기
위젯이 터치 이벤트에 반응하여 움직이는 것처럼 보이게 하려면 위젯의 XML attribute에  
`android:background="?attr/selectableItemBackgroundBorderless" `
를 추가하면 된다.  

이펙트 크기는 padding값을 적절히 조절하면 된다.


