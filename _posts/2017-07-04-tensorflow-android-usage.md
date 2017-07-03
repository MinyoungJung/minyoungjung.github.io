---
layout: post
title: 텐서플로 라이브러리 안드로이드에 사용하기
category: [안드로이드, 머신러닝]
tags: [Machine Learning, AI, Tensorflow, Android]
---

# 빌드된 라이브러리 다운로드
상세 설정은 [지난 포스팅](https://minyoungjung.github.io/%EC%95%88%EB%93%9C%EB%A1%9C%EC%9D%B4%EB%93%9C/%ED%99%98%EA%B2%BD%EC%84%A4%EC%A0%95/%EB%A8%B8%EC%8B%A0%EB%9F%AC%EB%8B%9D/2017/07/03/tensorflow-library-build/) 참조.  

[Project nightly-android](http://ci.tensorflow.org/view/Nightly/job/nightly-android/)에서 최신 빌드된 버전 이미지의 `libandroid_tensorflow_inference_java.jar`  
파일 다운로드,  `native` 폴더의 `libtensorflow_inference.so`도 zip 파일로 압축해서 다운로드

# 안드로이드 프로젝트 생성
텐서플로를 사용할 안드로이드 프로젝트 생성

# 라이브러리 추가
`app/libs/` 폴더에 zip 파일로 압축한 폴더를 풀어서 복사  
동일 폴더안에 `libandroid_tensorflow_inference_java.jar` 또한 복사  
트리 구조는 아래와 같음
![폴더구조](/post_assets/2017-07-04/tree.png)

# build.gradle 수정
`build.gradle (Module: app)` 파일의 android 항목 안에 native 라이브러리 경로 추가
``` 
sourceSets {
    main {
        jniLibs.srcDirs = ['libs']
    }
}
```

# 메인 액티비티 수정
## 라이브러리 로드
``` java
static {
    System.loadLibrary("tensorflow_inference");
}
```

## onCreate 수정
``` java
Tensor c = Tensor.create(3.0f);

TextView tv = (TextView) findViewById(R.id.textView);
tv.setText(String.valueOf(c.floatValue()));
```

간단히 Tensor를 하나 생성한 후 값을 빼내서 출력함.





