---
layout: post
title: Phaser를 이용한 간단 인터랙션 제작
category: [Javascript]
tags: [Javascript, Phaser, HTML5, Game]
---

# Phaser란
HTML5의 Canvas및 WebGL을 이용해 Web game을 제작할 수 있게 해주는 Javascript 라이브러리  
Phaser를 테스트 하기 위해서는 로컬 웹서버를 실행해야 한다.  
Python이 깔려있다면 Python의 기본 웹서버를 이용하면 간단하다.  

`python -m SimpleHTTPServer`

# 구조
``` javascript
var game = new Phaser.Game(Width, Height, Phaser.AUTO, '', 
        { preload: preload, create: create, update: update });
```
위의 전역 변수 정의를 통해 width * height 크기의 게임창을 생성한다.  
크게 preload, create, update의 세 메소드로 나뉘어져 있다.

## Preload
게임 실행전에 실행되는 메소드로 주로 이미지나 기타 자료의 로딩에 쓰인다.

## Create
게임이 실제적으로 생성될때 실행되는 메소드로 로딩된 이미지를 출력하거나 리스너를 할당하거나 등의 작업을 한다.

## Update
주기적으로 실행되는 메소드로 주로 키 이벤트를 할당하거나 게임의 개체들을 업데이트 하는 등의 작업을 한다.

# 간단한 결과물
사용자의 마우스 이벤트에 반응해서 이미지의 알파값을 변경시켜 출력 시켜주는 애니메이션 예제  
[Phaser로 제작한 간단한 결과물](http://minimi.surge.sh/)

# 추후 계획
주 1회 협업, 매번 간단한 인터렉션 제작 (장기적으로는 게임이 될 수도...)










