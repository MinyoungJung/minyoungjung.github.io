---
layout: post
title: 파이썬 오브젝트 소스코드 간단히 보기 및 스탠다드 라이브러리 메소드 오버라이딩
category: [파이썬]
tags: [Python, Python Calendar]
---

# 파이썬 오브젝트 소스 코드 보기
1. `inspect` 모듈 임포트
`import inspect`  

2. 살펴볼 오브젝트 임포트
`from calendar import HTMLCalendar`  

3. 소스코드를 보기좋은 형태로 출력
`print(inspect.getsource(HTMLCalendar))`  


# 스탠다드 라이브러리 메소드 오버라이딩
HTMLCalendar는 베이스 클래스인 Calendar를 상속받아 HTML 달력을 만들어주는 역할을 하는 클래스이다.  
0(월요일:디폴트)에서 6(일요일)까지 달력의 시작을 정의하는 하나의 firstweekday인자를 전달받는다.    

`print(calendar.HTMLCalendar(6).formatmonth(2017,6))`과 같이 입력하면 아래의 달력이 출력된다.

<table border="0" cellpadding="0" cellspacing="0" class="month">
<tr><th colspan="7" class="month">June 2017</th></tr>
<tr><th class="sun">Sun</th><th class="mon">Mon</th><th class="tue">Tue</th><th class="wed">Wed</th><th class="thu">Thu</th><th class="fri">Fri</th><th class="sat">Sat</th></tr>
<tr><td class="noday">&nbsp;</td><td class="noday">&nbsp;</td><td class="noday">&nbsp;</td><td class="noday">&nbsp;</td><td class="thu">1</td><td class="fri">2</td><td class="sat">3</td></tr>
<tr><td class="sun">4</td><td class="mon">5</td><td class="tue">6</td><td class="wed">7</td><td class="thu">8</td><td class="fri">9</td><td class="sat">10</td></tr>
<tr><td class="sun">11</td><td class="mon">12</td><td class="tue">13</td><td class="wed">14</td><td class="thu">15</td><td class="fri">16</td><td class="sat">17</td></tr>
<tr><td class="sun">18</td><td class="mon">19</td><td class="tue">20</td><td class="wed">21</td><td class="thu">22</td><td class="fri">23</td><td class="sat">24</td></tr>
<tr><td class="sun">25</td><td class="mon">26</td><td class="tue">27</td><td class="wed">28</td><td class="thu">29</td><td class="fri">30</td><td class="noday">&nbsp;</td></tr>
</table>

오브젝트 소스코드를 살펴보고 HTML Calendar의 첫번째 row에 좌/우 이동 화살표(<,>)를 출력해보자.  

**파이썬 라이브러리 코드**  
    


``` python
def formatmonthname(self, theyear, themonth, withyear=True):
    """
    Return a month name as a table row.
    """
    if withyear:
        s = '%s %s' % (month_name[themonth], theyear)
    else:
        s = '%s' % month_name[themonth]
    return '<tr><th colspan="7" class="month">%s</th></tr>' % s
```

주석을 보면 달 이름을 테이블 행 형태로 돌려주는 메소드이고, 리턴값은 HTML의 형태인 것을 알 수 있다.  
해당 메소드를 바로 오버라이딩 하면 `month_name[themonth]` 구문에서 오류가 뜨는데,  
month_name은 calendar 모듈의 Data 속성이므로 `from calendar import month_name`를 해야한다. 

**오버라이딩한 메소드**
``` python
from calendar import HTMLCalendar, month_name

class ArrowCalendar(HTMLCalendar):
    def __init__(self, firstweekday):
        HTMLCalendar.__init__(self, firstweekday)

    def formatmonthname(self, year, month, withyear=True):
        if withyear:
            s = '%s %s' % (month_name[month], year)
        else:
            s = '%s' % month_name[month]
        return '<tr><th colspan="1" class="month_arrow"> < </th>' \
            '<th colspan="5" class="month">%s</th>' \
            '<th colspan="1" class="month_arrow"> > </th></tr>' % s
```
7칸짜리 테이블로 달 이름을 넘겨주는 것을 5칸으로 줄이고 양쪽에 한칸씩 좌/우 화살표를 넣었다.  
이후 css 클래스를 적용해서 화살표를 정렬하면 완성

``` css
.month_arrow {
    text-align: center;
}
```

## 완성된 달력 
<table border="0" cellpadding="0" cellspacing="0" class="month">
<tr><th colspan="1" class="month_arrow"> < </th><th colspan="5" class="month">June 2017</th><th colspan="1" class="month_arrow"> > </th></tr>
<tr><th class="sun">Sun</th><th class="mon">Mon</th><th class="tue">Tue</th><th class="wed">Wed</th><th class="thu">Thu</th><th class="fri">Fri</th><th class="sat">Sat</th></tr>
<tr><td class="noday">&nbsp;</td><td class="noday">&nbsp;</td><td class="noday">&nbsp;</td><td class="noday">&nbsp;</td><td class="thu">1</td><td class="fri">2</td><td class="sat">3</td></tr>
<tr><td class="sun">4</td><td class="mon">5</td><td class="tue">6</td><td class="wed">7</td><td class="thu">8</td><td class="fri">9</td><td class="sat">10</td></tr>
<tr><td class="sun">11</td><td class="mon">12</td><td class="tue">13</td><td class="wed">14</td><td class="thu">15</td><td class="fri">16</td><td class="sat">17</td></tr>
<tr><td class="sun">18</td><td class="mon">19</td><td class="tue">20</td><td class="wed">21</td><td class="thu">22</td><td class="fri">23</td><td class="sat">24</td></tr>
<tr><td class="sun">25</td><td class="mon">26</td><td class="tue">27</td><td class="wed">28</td><td class="thu">29</td><td class="fri">30</td><td class="noday">&nbsp;</td></tr>
</table>



