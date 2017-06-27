---
layout: post
title: Google Tag analysis 사용하기
category: [Analytics, 블로그]
tags: [Github, Blog, Tag analysis, Google Analytics]
---

# Tag analysis
Tag Anaylytics는 Google Analytics등 추적코드가 정상적으로 동작하는지 알게 해주는 툴이다.  
Github blog의 사용자 추적을 위해 걸어넣은 Google Analytics 대쉬보드에 들어갈때마다  
Tag analysis를 사용해 보라는 팝업이 계속해서 출력되어 사용해 보기로 했다. 

# 사용법
## 크롬 애드온 설치
![애드온설치](/post_assets/2017-06-26/chrome_addon.png)
크롬에 Tag Assistant 애드온을 설치한다.  

![설치화면](/post_assets/2017-06-26/addon_installed.png)
설치되면 애드온에 위와 같이 Assistant 아이콘이 출력된다.

## 현재 페이지에서 Tag analysis 사용
Enalble을 선택한 후 페이지를 리로드 한다.

## 여러 페이지에 걸쳐 Tag analysis 사용
Record를 선택한 후 여러 페이지를 걸쳐 이동한다.  
이후 Recording을 중지하면 이동한 페이지들에 대한 레포트를 출력해준다.  

![결과](/post_assets/2017-06-26/analysis_result.png)
![리포트](/post_assets/2017-06-26/analysis_report.png)

## Full analysis_report
View Full report를 선택하면 전체 레포트를 출력한다.
![리포트 상세1](/post_assets/2017-06-26/report_detail_1.png)
![리포트 상세2](/post_assets/2017-06-26/report_detail_2.png)

## 문제점 해결하기
문제가 있는 태그가 있다면 태그가 붉은색으로 표시되는데 해당 태그를 선택하면 관련 오류 메시지가 출력된다.  
