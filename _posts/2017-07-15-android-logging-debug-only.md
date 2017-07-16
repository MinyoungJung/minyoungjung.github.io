---
layout: post
title: 안드로이드 개발시에만 로그 출력하기
category: [안드로이드]
tags: [Android, Java, Log]
---

# 사용씬
디버그로 빌드할때만 로그가 출력되고, release로 빌드했을때는 로그가 출력되지 않도록 하려고 한다.

# 사용 방법
Log 클래스의 Wrapper class를 생성한 후, `BuildConfig.BUILD_TYPE` 값을 체크하여 로그를 출력한다.

``` java
public class LogUtils {
    public static boolean LOGGING_ENABLED = !BuildConfig.BUILD_TYPE.equalsIgnoreCase("release");

    public static void LOGD(final String tag, String message) {
        if (LOGGING_ENABLED){
            if (Log.isLoggable(tag, Log.DEBUG)) {
                Log.d(tag, message);
            }
        }
    }

    public static void LOGD(final String tag, String message, Throwable cause) {
        if (LOGGING_ENABLED){
            if (Log.isLoggable(tag, Log.DEBUG)) {
                Log.d(tag, message, cause);
            }
        }
    }

    public static void LOGV(final String tag, String message) {
        if (LOGGING_ENABLED) {
            if (Log.isLoggable(tag, Log.VERBOSE)) {
                Log.v(tag, message);
            }
        }
    }

    public static void LOGV(final String tag, String message, Throwable cause) {
        if (LOGGING_ENABLED) {
            if (Log.isLoggable(tag, Log.VERBOSE)) {
        Log.v(tag, message, cause);
            }
        }
    }

    public static void LOGI(final String tag, String message) {
        if (LOGGING_ENABLED) {
            Log.i(tag, message);
        }
    }

    public static void LOGI(final String tag, String message, Throwable cause) {
        if (LOGGING_ENABLED) {
            Log.i(tag, message, cause);
        }
    }

    public static void LOGW(final String tag, String message) {
        Log.w(tag, message);
    }

    public static void LOGW(final String tag, String message, Throwable cause) {
        Log.w(tag, message, cause);
    }

    public static void LOGE(final String tag, String message) {
        Log.e(tag, message);
    }

    public static void LOGE(final String tag, String message, Throwable cause) {
        Log.e(tag, message, cause);
    }

    private LogUtils() {
    }

}

```
참고로 INFO 레벨 미만은 Log.isLoggable을 이용해 로그가 출력 가능한지 확인해줘야 한다.  
디폴트 로그 레벨 출력값은 Info 이상이다.  

# 이스터에그? Log.wtf
API 문서를 참조하다. 로그레벨 wtf이 있다는 것을 알게되었다.  
"What a Terrible Failure: Report a condition that should never happen."라고 설명하고 있지만...  
우리는 모두 진실을 알고있다.  



