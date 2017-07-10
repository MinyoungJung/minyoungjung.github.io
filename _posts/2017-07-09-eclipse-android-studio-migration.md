---
layout: post
title: 이클립스 프로젝트 안드로이드 스튜디오로 마이그레이션 할 때 주의점
category: [안드로이드]
tags: [Android, Android Studio, Java, Eclipse]
---

# 주의점 1
그냥 Open existing project 하면 에로사항이 꽃핀다.  
import project (Eclipse ADT, Gradle, etc.) 메뉴를 이용할 것

# 주의점 2
때로는 이클립스 프로젝트 자체에서 수정해야 될 필요성이 있다.  
이클립스를 지워버렸으면 좀더 귀찮아진다...

# 주의점 3
임포트 후에 라이브러리 설정을 잘 해줘야 한다.  
support-library 관련 충돌이 많이 일어난다.  
빌드버전/컴파일 버전/서포트 라이브러리 버전 등을 잘 맞춰야 한다.  

# 주의점 4
임포트가 끝난후에 Android Studio 프로젝트 루트 폴더에 res 폴더 및 src 폴더가 남아있다.  
한마디로 `app/src/main` 과 이중으로 폴더가 남아있는 것...  
이때문에 xml 레이아웃 수정시에 `URI is not registered ( Setting | Project Settings | Schemas and DTDs` 가 출력되며,
`xmlns:android="http://schemas.android.com/apk/res/android"` 구문에 계속 빨간줄이 가있고, 레이아웃 프리뷰가 제대로 출력이 안된다.  
해당 폴더들을 삭제하면 해결된다.


