---
layout: post
title: Google의 머신러닝 라이브러리, 텐서플로 알아보기 - 환경설정 및 설치
category: [환경설정, 머신러닝]
tags: [Machine Learning, AI, Tensorflow]
---

# 설치

1. 파이썬3 가상환경 생성  
`$ virtualenv --system-site-packages -p python3 타겟폴더 이름 # Python3 기준`
2. 가상환경 실행  
`$ source ~/tensorflow/bin/activate`
3. 텐서플로 설치  
`$ pip3 install --upgrade tensorflow` # CPU 버전, GPU 버전은 tensorflow-gpu로 설치  
4. 데모파일 작성 (`demo.py`)

```python
import tensorflow as tf

node1 = tf.constant(3.0, tf.float32)
node2 = tf.constant(4.0) # also tf.float32 implicitly
print(node1, node2)
```
**실행 결과**  
`Tensor("Const:0", shape=(), dtype=float32) Tensor("Const_1:0", shape=(), dtype=float32)`  
위와 같이 출력되면 환경설정은 완료

[공식 설치문서](https://www.tensorflow.org/install/install_mac)  


# 주요개념

## Tensor
```
3 # a rank 0 tensor; this is a scalar with shape []
[1. ,2., 3.] # a rank 1 tensor; this is a vector with shape [3]
[[1., 2., 3.], [4., 5., 6.]] # a rank 2 tensor; a matrix with shape [2, 3]
[[[1., 2., 3.]], [[7., 8., 9.]]] # a rank 3 tensor with shape [2, 1, 3]
```
Tensorflow의 기본 자료구조.    
동적인 크기를 갖는 원시값의 다차원 데이터 배열이며 Tensor의 rank는 차원을 의미한다.

## Computational Graph
노드 그래프로 배열된 일련의 텐서플로우 오퍼레이션 모음.  
Tensorflow의 코어는 Computational Graph를 생성하고, 실행하는 각각의 부분으로 나뉜다.  
그리하여 데모파일의 실행 결과가 각각의 노드값이 아닌 두개의 텐서가 출력된 것.  

### Computational Graph 실행
1. Session을 생성하고
2. Session.run()을 실행
```
sess = tf.Session()
print(sess.run([node1, node2]))
```

**실행결과**
```
2017-06-04 22:24:47.634630: W tensorflow/core/platform/cpu_feature_guard.cc:45] The TensorFlow library wasn't compiled to use FMA instructions, but these are available on your machine and could speed up CPU computations.
[3.0, 4.0]
```
워닝이 뜨기는 했지만 결과값은 제대로 출력되었다.  
구글링해보니 로컬에서 소스코드를 빌드하지 않았을 경우 뜨는 오류라 한다.  
해결방법 : [링크](http://www.kwangsiklee.com/ko/2017/04/%ED%85%90%EC%84%9C%ED%94%8C%EB%A1%9C%EC%9A%B0-%EA%B2%BD%EA%B3%A0%EB%A9%94%EC%84%B8%EC%A7%80-%ED%95%B4%EA%B2%B0%ED%95%98%EA%B8%B0-the-tensorflow-library-wasnt-compiled-to-use-sse3-instructions/)  


## 기타 더 읽어볼거리
[텐서플로우 문서 한글 번역본](https://tensorflowkorea.gitbooks.io/tensorflow-kr/content/g3doc/get_started/basic_usage.html)  
[텐서플로우 시작하기](http://www.popit.kr/%ED%85%90%EC%84%9C%ED%94%8C%EB%A1%9C%EC%9A%B0tensorflow-%EC%8B%9C%EC%9E%91%ED%95%98%EA%B8%B0/)  
[텐서보드 사용법](http://pythonkim.tistory.com/39)  


# 최종목표
텐서플로우를 이용한 Android app 작성

