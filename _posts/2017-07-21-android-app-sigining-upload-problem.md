---
layout: post
title: Google Play App Signing으로 업로드 시 apk 업로드 안될 때
category: [안드로이드]
tags: [Android, Release]
---


![App Signing](/post_assets/2017-07-21/app_signing.png)
위와 같이 Google Play App Signing을 한번 누르니 다시 돌이킬 수도 없고,  
APK를 업로드를 하려니 다음의 화면이 출력되며 apk 업로드도 안된다.
![apk 업로드 불가](/post_assets/2017-07-21/upload_error.png)

# 문제 원인
Signed apk를 만들 때 Signature Vesion의 V1을 체크하지 않으면 .jar 파일이 생성되지 않아,  
Jar_sig_no라며 jar signature가 없다는 메시지를 뱉는 것이다.

![apk 빌드 설정](/post_assets/2017-07-21/bulid_jar.png)

Signature Vesion을 둘다 체크하고 다시 Signed APK를 생성하면 잘 업로드 된다.
![업로드 완료](/post_assets/2017-07-21/uploaded.png)
