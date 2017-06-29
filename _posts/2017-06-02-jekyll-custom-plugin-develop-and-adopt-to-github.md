---
layout: post
title: Jekyll 커스텀 플러그인 개발 및 적용, Github 페이지에 적용하기 
category: [환경설정, 블로그]
tags: [Github, Blog, Jekyll, Tag, Plugin]
---

# 발단
<p class="message"> Jekyll로 구성한 블로그 디자인을 수정하며 조금씩 구색을 맞추기 시작했다.<br> 
사이트맵을 추가해 구글에서 검색되지 않는 부분도 수정하고, &nbsp;<a href="http://tech.kakao.com/2016/07/07/tech-blog-story/" target="_blank">Kakao Tech 참고자료</a><br>
어날리틱스 & 서치콘솔 연동과 같은 소소한 부분도 처리했다. <br> 
"블로그 자체에 큰 노력을 들이지 않고 컨텐츠에 집중해 매일 무엇인가 정리해보자"는 취지도 이때까지는<br> 맞는듯 했다... </p>

>하지만 데일리 로그라는 명목하에,&nbsp;블로그 첫 게시일로부터 며칠이 지났고,&nbsp;며칠째 포스팅을 이어가고 있는지 표시하고 싶다는 생각이 들었다.

# 커스텀 플러그인 개발
Jekyll 환경변수, Liquid 템플릿 태그 등을 확인해 보았는데 마땅한 방법이 보이지 않았다.  
어딘가에 있을법한 기능인데도 찾기가 쉽지 않아 기존 플러그인 몇 개의 소스를 들여다 보고 자체 제작하기로 했다.
``` ruby
module Jekyll
  class RenderTotalBloggingDate < Liquid::Tag
    def render(context)
      site = context.registers[:site]
      (Date.today() - Date.strptime(site.posts.docs.first.date.strftime('%Y-%m-%d'), '%Y-%m-%d')).to_i+1
    end
  end
end
liquid::Template.register_tag('total_blogging_date', Jekyll:: RenderTotalBloggingDate)
```
루비는 예전에 간단히 레일스를 만져볼때 빼고는 다뤄본적이 없어, 라이브러리나 문법등이 기억이 나지 않았다.  
다행히 플러그인 구조가 간단하기에 큰 문제가 되지는 않았다.

## 플러그인 구조
1. Jekyll 모듈에서 `Liquid::Tag`를 상속받은 클래스를 생성한다.  
2. `render(context)`함수를 오버라이딩 한다.  
3. `liquid::Template.register_tag('태그이름', Jekyll:: 태그 클래스 이름)`과 같이 태그를 등록한다.  
4. 등록된 태그는 템플릿에서 {% raw %}`{% 태그이름 %}`{% endraw %}과 같이 사용가능하다.

## 플러그인 적용
1. 블로그 경로에 `_plugins` 폴더를 생성한다.
2. 원하는 곳에 태그를 넣는다.


# Github page로 적용?
<p class="message"> 로컬에서 잘 동작하는 것을 확인하고, Github로 페이지를 푸쉬했다.<br>그리고... </p>
![깃허브에서 온 메일](/post_assets/2017-06-02/mail_from_github.png)
<p style="color:red; font-weight:bold;">빌드가 실패했다!</p>


## 원인 분석
여전히 Tag가 인식되지 않는단다. 이유를 확인해보니, 보안상의 이유로 [github/pages-gem](https://github.com/github/pages-gem)을  
제외한 커스톰 plugin을 Github에서는 공식 사용할 수 없게 되어있다.  

## 해결방안
다행히 Workaround가 존재한다. 자세한 것은 다른 분의 링크로 대체.
<a href="http://gumpcha.github.io/blog/github-pages-with-jekyll-custom-plugin/" target="_blank">링크</a>
간단히 요약하면,  
1. Jekyll이 생성하는 정적 페이지인 `_site`폴더를 Github에 Master 브랜치로 등록한다.  
2. 소스코드를 담은 기존 Master 브랜치는 Source 브랜치로 따로 딴 후, Source에서 동일하게 포스팅을 작성한다.  
3. `Jekyll serve`를 실행하면 템플릿 태그는 전부 정적 리소스로 변경된다.  
4. 정적 리소스만 포함한 마스터 브랜치(`_site` 폴더)와 Source 브랜치를 모두 Github에 푸시한다.  
5. 마스터 브랜치를 삭제한다.  

## 문제점
매번 포스팅 할때마다 브랜치를 새로 생성하고 Source에서 작업하고 다시 Master를 삭제하는 방법을 사용해야 한다.  
다행히 쉘 스크립트를 이용해서 간편하게 해결 가능하다.  
`publish.sh`를 다음과 같이 블로그 폴더에 생성하고, 
``` shell
#!/bin/bash

git checkout source
git branch -D master
git checkout -b master 
git filter-branch --subdirectory-filter _site/ -f
git push --all
git checkout source
```
필요한 일련의 명령들을 하나로 모은다.  

그 이후 블로그를 작성하는 방법은 아래와 같다.

# 블로그 퍼블리싱
1. `_posts` 폴더에 마크다운 작성
2. `(source) $ jekyll serve` 로 정적 사이트 생성
3. `(source) $ git add .`
4. `(source) $ git commit -m 'Commit message'`
5. `(source) $ ./publish.sh`


# Plugin 링크
[깃허브](https://github.com/MinyoungJung/jekyll-plugin-blogStreak)  

## 사용법
1. 블로그 폴더 안에 `_plugins` 폴더를 생성한다.  
2. `blog_streak.rb` 파일을 `_plugins` 폴더에 넣는다.
3. 템플릿에 태그를 넣는다. {% raw %}`{% 태그이름 %}`{% endraw %} 

## 태그 종류
- ~~{% raw %}`{% total_blogging_date %}`{% endraw %}~~  
~~첫 포스팅부터 현재까지 지난 일 수~~
- {% raw %}`{% current_date_streak %}`{% endraw %}  
현재 연속 포스팅 일 수 (포스팅을 하지 않고 하루를 넘기면 초기화 됨)
- {% raw %}`{% longest_date_streak %}`{% endraw %}  
최장 연속 포스팅 일 수 (첫 포스팅부터 현재까지 최장 연속 포스팅 일 수)

[Jekyll 커스텀 플러그인 개발 및 적용, Github 페이지에 적용하기(2)](/환경설정/블로그/2017/06/03/jekyll-custom-plugin-develop-and-adopt-to-github-(2)/)



