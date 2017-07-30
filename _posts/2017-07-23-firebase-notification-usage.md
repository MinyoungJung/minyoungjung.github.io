---
layout: post
title: Firebase 사용하여 Notification 보내기
category: [안드로이드]
tags: [Android, Java, Firebase]
---

## firebase 프로젝트 추가
[https://console.firebase.google.com](https://console.firebase.google.com)에서 프로젝트 추가
![프로젝트 추가](/post_assets/2017-07-23/add_done.png)

## firebase 안드로이드 추가
![안드로이드 추가](/post_assets/2017-07-23/firebase_add.png)

## google-services.json 추가
`google-services.json` 파일을 app 영역의 root에 집어넣음. (project 보기)

## build.gradle 변경

build.gradle(project)에 다음 추가
``` java
dependencies {
    classpath 'com.google.gms:google-services:3.1.0'
}
```

build.gradle(app) 마지막줄에 다음 줄 추가
``` java
apply plugin: 'com.google.gms.google-services'
```

build.gradle(app)의 dependency에 다음 추가 (Notification 사용 라이브러리)
``` java
compile 'com.google.firebase:firebase-core:11.0.2'
compile 'com.google.firebase:firebase-messaging:11.0.2'
```

이후 프로젝트 sync

## FirebaseMessagingService 추가
``` java
public class MyFirebaseMessagingService extends FirebaseMessagingService {
    private static final String TAG = "FCM Service";
    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        Log.e(TAG, "From: " + remoteMessage.getFrom());
        Log.e(TAG, "Notification Message Body: " + remoteMessage.getNotification().getBody());
    }
}
```

## FirebaseInstanceIdService 추가
``` java
public class FirebaseIDService extends FirebaseInstanceIdService {
    private static final String TAG = "FirebaseIDService";

    @Override
    public void onTokenRefresh() {
        // Get updated InstanceID token.
        String refreshedToken = FirebaseInstanceId.getInstance().getToken();
        Log.e(TAG, "Refreshed token: " + refreshedToken);

        // TODO: Implement this method to send any registration to your app's servers.
        sendRegistrationToServer(refreshedToken);
    }

    private void sendRegistrationToServer(String token) {
        // Add custom implementation, as needed.
    }
}
```

## 매니페스트에 서비스 추가
``` xml

<service android:name=".service.MyFirebaseMessagingService">
    <intent-filter>
        <action android:name="com.google.firebase.MESSAGING_EVENT"/>
    </intent-filter>
</service>

<service android:name=".service.FirebaseIDService">
    <intent-filter>
        <action android:name="com.google.firebase.INSTANCE_ID_EVENT"/>
    </intent-filter>
</service>
```
서비스 태그는 애플리케이션 태그 속에 넣으면 된다.

## Notification 보내기
![알림 보내기](/post_assets/2017-07-23/noti_send.png)
콘솔에서 앱 전체를 대상으로 Notification를 보낸 모습

## Notification 전송 모습
상태창을 보면 notification이 전송된 것을 볼 수 있다.
![백그라운드 알림](/post_assets/2017-07-23/noti_bg.png)

앱이 떠있을때는 로그로 정상 출력되는 것을 볼 수 있다.
![포그라운드 알림](/post_assets/2017-07-23/noti_sent.png)


