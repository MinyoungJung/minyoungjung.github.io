---
layout: post
title: 안드로이드에 Facebook 로그인 연동하기
category: [안드로이드]
tags: [Android, Java, Facebook SDK, REST API, Auth]
---

# Facebook SDK 연동하기
한동안 Facebook SDK를 쓸일이 없다가 다시 기회가 생겨 간단한 샘플을 제작해 보았다.  
잊어버리지 않게 정리해두려 한다.

## Dependency 추가
`compile 'com.facebook.android:facebook-android-sdk:[4,5)'`를 `build.gradle`에 추가한다.  

## Manifest 수정
인터넷 엑서스가 필요하므로 권한을 추가해야 한다.   
``` xml
<uses-permission android:name="android.permission.INTERNET"/>
```  

meta Data를 추가해 어플리케이션 ID를 넣고,  
``` xml
<meta-data android:name="com.facebook.sdk.ApplicationId"
    android:value="@string/facebook_app_id"/>
```

Facebook Activity도 추가해야 한다.  
``` xml
<activity android:name="com.facebook.FacebookActivity"
    android:configChanges=
        "keyboard|keyboardHidden|screenLayout|screenSize|orientation"
    android:label="@string/app_name" />
```
## Layout 수정
페이스북에서 제공하는 기본 로그인 버튼을 이용하려면, 레이아웃에 다음을 추가한다.  
``` xml
<com.facebook.login.widget.LoginButton
    android:id="@+id/login_button"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content"
    android:layout_gravity="center_horizontal"
    android:layout_marginTop="30dp"
    android:layout_marginBottom="30dp" />
```

## Activity 수정
1. LoginButton의 참조를 얻은 후  
`final LoginButton mLoginBtn = (LoginButton) findViewById(R.id.login_button);`
2. 읽기 퍼미션을 준다.  
`mLoginBtn.setReadPermissions("public_profile");`
3. 쓰기 퍼미션은 추후 다음과 같이 LoginManager를 통해 준다.  
``` java
LoginManager.getInstance().logInWithPublishPermissions(this,
    Arrays.asList("publish_actions")
);
```
4. LoginButton에 콜백을 등록하고, 필요한 메소드를 오버라이드 한다.  
``` java
mLoginBtn.registerCallback(mCallbackManager, new FacebookCallback<LoginResult>() {
    @Override
        public void onSuccess(LoginResult loginResult) {

    }

    @Override
        public void onCancel() {

    }

    @Override
        public void onError(FacebookException error) {

    }
});
```

5. onActivityResult를 통해 CallbackManager에 결과를 전달한다.  
`mCallbackManager.onActivityResult(requestCode, resultCode, data);`

