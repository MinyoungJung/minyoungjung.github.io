---
layout: post
title: Jekyll 커스텀 플러그인 개발 및 적용, Github 페이지에 적용하기 (2)
category: [환경설정, 블로그]
tags: [Github, Blog, Jekyll, Tag]
---

# 지난 포스팅 

[Jekyll 커스텀 플러그인 개발 및 적용, Github 페이지에 적용하기](/환경설정/블로그/2017/06/02/jekyll-custom-plugin-develop-and-adopt-to-github/)

# 발단
다시 하루가 지나고 Github page에 접속하자, 어제 만든 플러그인이 동작하지 않았다.  
`total_blogging_date` 태그가 동작하지 않아 하루가 지났음에도 총 일수가 더해지지 않은 것.  
한참 루비코드만 들여다보다 생각해보니, Jekyll 자체가 정적인 페이지를 생성하는데 페이지를 빌드하지 않았는데도 갱신되는게 말이 안되는 상황.  
계속해서 소스를 수정하면서 빌드하다보니, 제대로 동작하는 것으로 오해하게 된 것이었다.


# 해결 방안
총 블로깅 일수를 태그로 받았을때, 현재 날짜와 총 날짜를 계산할 때 사용된 마지막 날짜의 비교가 불가능하다.  
태그에서 받은 총 블로깅 날짜만을 가지고 빌드하지 않은채로 며칠이 지났는지 알 방법이 없고,  
혹여 있다해도 그냥 템플릿에서 가장 오래된 포스팅 날짜와 현재 날짜의 차이를 비교하는 것이 편하다.

``` javascript
// Calculate total_blogging_date_dynamically
$(document).ready(function() {
  var date_str = "{% raw %}{{ site.posts.last.date }}{% endraw %}"; // 2017-05-31 00:00:00 +0900
  var total_date = Math.floor((Date.now() - Date.parse(date_str.split(' ')[0])) / 86400000)+1; // calc datediff
  $("#dynamic_day").text(total_date);
});
```
결국 위와 같이 템플릿에서 받아온 날짜를 가지고, 매크로 형태로 JQuery에 적용시킴으로 해결.  
<br>
마찬가지로 며칠째 포스팅을 이어가고 있는지도 마지막 빌드 이후 며칠이 지났는지 알수 없기에,
``` javascript
$(document).ready(function(){
  var latest_post_date_str = "{% raw %}{{ site.posts.first.date }}{% endraw %}";
  var day_passed = Math.floor((Date.now() - Date.parse(latest_post_date_str.split(' ')[0])) / 86400000);
  // if latest posting date passed a day then reset to 0
  if (day_passed > 1) {
    $("#current_date_streak").text("0");
  }
});
```
위와 같이 템플릿에서 받아온 값을 마지막 포스팅의 날짜와 현재 날짜가 하루이상 지났을때,  
`current_date_streak` 태그 값을 0으로 덮어씌우도록 수정했다.


# 마무리
Github Plugin 코드 및 README를 업데이트 했다. [링크](https://github.com/MinyoungJung/jekyll-plugin-blogStreak)  

