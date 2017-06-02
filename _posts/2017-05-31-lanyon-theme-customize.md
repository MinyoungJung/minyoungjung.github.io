---
layout: post
title: Jekyll과 Lanyon을 이용한 블로깅 및 테마 편집 방법
category: [환경설정, 블로그]
tags: [Github, Blog, Jekyll]
---


## Jekyll이란?
정적 사이트 생성기.  
간단히 말하면 마크다운 언어**(.md 등)**로 작성된 글을 알아서 HTML로 변경해준다.  
이러한 방식을 이용하여 포스팅 뿐만 아니라, 페이지 전체를 빌드할 수 있다.  

<br>
## 테마 설정
Jekyll 및 테마를 설치하고 `Jekyll serve` 명령을 실행하니
`Build Warning: Layout 'home' requested in index.md does not exist.`
라는 warning과 함께 빈 화면이 출력되었다.  
이는 Lanyon 테마 설치 이후 `index.html`을 생성하는 마크다운인 `index.md`에
`layout: home`이 설정되어 있으나, home이라는 레이아웃이 존재하지 않기 때문에 일어난다.

- 해결방법 1 : `index.md`를 삭제해서 `index.html`이 알아서 처리하게 한다.
- 해결방법 2 : `index.md`의 내용을 아래와 같이 바꾼다.  
            
`_layouts` 폴더에 존재하는 default 레이아웃을 이용하여 포스트의 리스트를 출력하는 예제

``` 
{% raw %}
---
layout: default
title: Home
---
<ul>
    {% for post in site.posts %}
<li>
    <a href="{{ post.url }}">{{ post.title }}</a>
</li>
    {% endfor %}
</ul>
{% endraw %}
```

<br>
## 테마 사이드바 설정

### 사이드바 추가
마크다운 작성 시 파일 상단 머릿말을 다음과 같이 작성한다.
```
---
layout: page
title: About
---
페이지 내용
```
HTML 빌드 시 사이드바에 자동으로 추가되며 주소는 `base_url/title`가 된다.

### 기존 사이드바 수정
`_includes` 폴더 하위의 `sidebar.html`을 수정한다.



<br>
## 포스트 작성
`_posts` 폴더 안에 `년-월-일-제목.md`와 같은 이름으로 마크다운 파일을 생성한다.  

머릿말의 layout을 post로 선택하면 `_layouts` 폴더 하위의 `post.html`을 이용해 페이지가 생성된다. 

```
---
layout: post
title: Jekyll과 Lanyon을 이용한 블로깅 및 테마 편집 방법
---
이곳에 포스트 내용 작성
```
`2017-05-31-lanyon-theme-customize.md`로 생성한 포스트의 주소는  
`base_url/2017/05/31/lanyon-theme-customize/`가 된다.


<br>
## 느낀점
- 글 자체를 집중해서 쓰기 좋다.  
  보기 좋게 꾸미는대 들어가는 노력이 줄어든다.  
  ~~하지만 페이지 자체를 꾸미는데 노력이 들어갈 것 같다는 느낌이 든다...~~

- Github와 연동 시 시너지가 발생한다.  
  - Git repository를 이용해 블로그의 버전 관리를 할 수 있다.  
  - 블로그의 호스팅을 Github에서 제공한다.  
  - 한번 설정해 놓으면 사이트에 방문할 필요 없이 로컬에서 마크다운을 작성하고 git으로 push하면 된다.  

- 마크다운을 작성하여 페이지를 구성하는 동작 방식이 포스팅뿐만 아니라 페이지 전체에 이용된다는 것이 인상적이다. 

- 레이아웃 및 페이지 수정에 대한 자유도가 높다. (진입장벽이 높다)

- 일반인들이 쓰기에는 어려움이 따를 듯하다.
  - 깃허브 설정까지는 그렇다고 쳐도, 커맨드라인 인터페이스에 익숙한 일반인은 많지 않겠지..
  - 페이지 테마와 레이아웃을 수정하는대 템플릿 태그와 html/css에 대한 이해가 어느 정도 필요하다.


<br>
## 전체 소스코드
[Github repository (Link)](https://github.com/MinyoungJung/minyoungjung.github.io)


