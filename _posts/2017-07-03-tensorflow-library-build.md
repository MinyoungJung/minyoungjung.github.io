---
layout: post
title: 텐서플로 소스로부터 안드로이드 라이브러리 빌드하기
category: [안드로이드, 환경설정, 머신러닝]
tags: [Machine Learning, AI, Tensorflow, Android]
---

# 텐서플로 repository clone
`git clone --recurse-submodules https://github.com/tensorflow/tensorflow.git`

# Android NDK 설치
텐서플로의 core 모듈이 c++로 이루어져 있고, 이를 이용하기 위해서는 JNI가 필요.  
~~Android Studio의 Preference -> Appearance & Behavior -> System Settings -> Android SDK -> SDK Tools 탭에서 NDK를 찾아 설치~~  
위와 같이 하면 NDK 최신 버전이 설치되는데 `WORKSPACE` 파일을 보면 r12b를 쓰라 되어있다.  
그러므로 [여기](https://developer.android.com/ndk/downloads/older_releases.html#ndk-12b-downloads)서 다운 받은 r12b를 설치

# Bazel 설치
텐서플로의 빌드 툴인 [Bazel](https://docs.bazel.build/versions/master/bazel-overview.html) 설치

# WORKSPACE 파일 수정
Clone된 텐서플로 프로젝트의 Root의 `WORKSPACE` 파일을 열어
```
#android_sdk_repository(
#    name = "androidsdk",
#    api_level = 23,
#    # Ensure that you have the build_tools_version below installed in the
#    # SDK manager as it updates periodically.
#    build_tools_version = "25.0.2",
#    # Replace with path to Android SDK on your system
#    path = "<PATH_TO_SDK>",
#)
#
# Android NDK r12b is recommended (higher may cause issues with Bazel)
#android_ndk_repository(
#    name="androidndk",
#    path="<PATH_TO_NDK>",
#    # This needs to be 14 or higher to compile TensorFlow.
#    # Note that the NDK version is not the API level.
#    api_level=14)
```
이 부분의 주석을 제거하고 SDK 및 NDK 경로를 넣어줌  
```
android_sdk_repository(
    name = "androidsdk",
    api_level = 23,
    build_tools_version = "25.0.2",
    path = "/Users/mymacpro/Library/Android/sdk/",
)
android_ndk_repository(
    name="androidndk",
    path="/Users/mymacpro/AndroidStudio_workspace/android-ndk-r12b/",
    api_level=14)
```

# .so 파일 빌드
```
bazel build -c opt //tensorflow/contrib/android:libtensorflow_inference.so \
--crosstool_top=//external:android/crosstool \
--host_crosstool_top=@bazel_tools//tools/cpp:toolchain \
--cpu=x86_64
```

빌드가 끝나면 프로젝트 폴더에 `bazel-bin/tensorflow/contrib/android/libtensorflow_inference.so`가 생성

# .jar 파일 빌드
```
bazel build //tensorflow/contrib/android:android_tensorflow_inference_java
```

마찬가지로 `bazel-bin/tensorflow/contrib/android/libandroid_tensorflow_inference_java.jar` 생성됨


# 안드로이드 프로젝트 생성
## 라이브러리 추가
라이브러리에 `libandroid_tensorflow_inference_java.jar` 및 `libtensorflow_inference.so` 추가

이제 텐서플로의 Java API를 `TensorFlowInferenceInterface`를 통해 호출 가능하다.  


> 소스 빌드하지 않을 경우 라이브러리 추가하는 제일 간단한 방법  
[Project nightly-android](http://ci.tensorflow.org/view/Nightly/job/nightly-android/)에서 빌드된 파일을 받는다.  
굳이 빌드할 필요도 없음...







