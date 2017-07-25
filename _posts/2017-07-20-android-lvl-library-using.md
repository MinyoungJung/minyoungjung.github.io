---
layout: post
title: 안드로이드 라이센스 라이브러리 사용하기
category: [안드로이드]
tags: [Android, License]
---

앱을 유료로 마켓에 업로드하려 할때, apk 파일을 통해 앱을 설치하는게 우려된다면,  
Google의 라이센싱 라이브러리를 사용하면 apk파일이 구매한 것인지 검증해 준다.

# 설치
Android SDK Tools에서 라이센싱 라이브러리를 설치한다.
![라이브러리 설치](/post_assets/2017-07-20/add_lib.png)

# 라이브러리 추가
안드로이드 스튜디오에서 File -> New -> Import Module을 선택한 후,  
설치한 라이센스 소스 디렉토리의 AndroidManifest.xml을 선택한다.
![라이브러리 추가](/post_assets/2017-07-20/import_module.png)

# 계정 설정
Google Play console에서 라이센스 테스트를 수행할 계정을 선택한다.  
이 계정으로 기기에 로그인 해야 한다.
![계정설정](/post_assets/2017-07-20/test_response.png)

# 라이센스 키 설정
Google Play console에서 개별 앱 페이지로 들어가서 라이센스 키를 복사한다.  
![라이센스 키 설정](/post_assets/2017-07-20/license_key.png)

# 라이브러리 포함하여 빌드하도록 설정
app의 build.gradle에 다음 구문을 추가한다
`compile project(path: ':library')`

# 라이브러리 사용
사용법은 딱히 까다롭지 않아 [Android docs](https://developer.android.com/google/play/licensing/adding-licensing.html#imports)의 링크로 대체하고, 일부 부분만 설명한다. 

## 고유 디바이스 아이디 처리
``` java
new AESObfuscator(SALT, getPackageName(), deviceId)
```
부분에서 고유한 deviceId를 처리해줘야 한다.
``` java
Settings.Secure.getString(this.getContentResolver(), Settings.Secure.ANDROID_ID))),
```
장치 고유값을 가져오는 것이 생각보다 쉽지않은데, 그냥 단순하게 처리하려면 위와같이 하면 된다.

## 에러처리
![에러 처리](/post_assets/2017-07-20/error.png)
라이브러리의 intent 사용 방법 떄문에 에러가 발생한다.  

``` java
if (mService == null) {
    Log.i(TAG, "Binding to licensing service.");
    try {
        boolean bindResult = mContext
            .bindService(
            new Intent(
            new String(
            Base64.decode("Y29tLmFuZHJvaWQudmVuZGluZy5saWNlbnNpbmcuSUxpY2Vuc2luZ1NlcnZpY2U="))),
            this, // ServiceConnection.
            Context.BIND_AUTO_CREATE);

        if (bindResult) {
            mPendingChecks.offer(validator);
        } else {
            Log.e(TAG, "Could not bind to service.");
            handleServiceConnectionError(validator);
        }
    } catch (SecurityException e) {
        callback.applicationError(LicenseCheckerCallback.ERROR_MISSING_PERMISSION);
    } catch (Base64DecoderException e) {
        e.printStackTrace();
    }
}
```
라이브러리의 위 코드를 아래와 같이 수정한다.  
``` java
if (mService == null) {
    Log.i(TAG, "Binding to licensing service.");
    try {
        Intent serviceIntent = new Intent(
        new String(Base64.decode("Y29tLmFuZHJvaWQudmVuZGluZy5saWNlbnNpbmcuSUxpY2Vuc2luZ1NlcnZpY2U=")));
        serviceIntent.setPackage("com.android.vending");
        boolean bindResult = mContext.bindService(serviceIntent,
            this, // ServiceConnection.
            Context.BIND_AUTO_CREATE);

        if (bindResult) {
            mPendingChecks.offer(validator);
        } else {
            Log.e(TAG, "Could not bind to service.");
            handleServiceConnectionError(validator);
        }
    } catch (SecurityException e) {
        callback.applicationError(LicenseCheckerCallback.ERROR_MISSING_PERMISSION);
    } catch (Base64DecoderException e) {
        e.printStackTrace();
    }
} 
```

## 또 다른 에러
LicenseCheckerCallback에서 applicationError가 호출되며 에러코드 3이 찍히는 경우가 있다.  
이는 ERROR_NOT_MARKET_MANAGED로 마켓에 앱을 올리지 않았을때 반환되는 코드인데, 처리할 필요 없다.  
정상적인 시나리오에서는 allow나 dontallow가 호출되기 때문인데, 자세한 이유를 알고 싶다면 [여기](https://stackoverflow.com/questions/10377325/how-do-you-deal-with-licensecheckercallback-error-not-market-managed-error-code)서 확인할 것

