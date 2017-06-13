---
layout: post
title: Python 가상환경 옮기기
category: [파이썬, 환경설정]
tags: [Virtualenv, Python, Matplotlib]
---

# 발단
가상환경을 이용한 로컬 프로젝트에서 matplotlib을 임포트 하려니 임포트 에러가 발생했다.

```
(tensorflow_venv) My-MacBook-Pro:tensorflow_demo mymacpro$ python3 linearregression.py 
Traceback (most recent call last):
File "linearregression.py", line 14, in <module>
import matplotlib.pyplot as plt
File "/Users/mymacpro/Documents/Python_workspace/tensorflow_demo/tensorflow_venv/lib/python3.6/site-packages/matplotlib/pyplot.py", line 115, in <module>
_backend_mod, new_figure_manager, draw_if_interactive, _show = pylab_setup()
File "/Users/mymacpro/Documents/Python_workspace/tensorflow_demo/tensorflow_venv/lib/python3.6/site-packages/matplotlib/backends/__init__.py", line 32, in pylab_setup
globals(),locals(),[backend_name],0)
File "/Users/mymacpro/Documents/Python_workspace/tensorflow_demo/tensorflow_venv/lib/python3.6/site-packages/matplotlib/backends/backend_macosx.py", line 19, in <module>
from matplotlib.backends import _macosx
RuntimeError: Python is not installed as a framework. The Mac OS X backend will not be able to function correctly if Python is not installed as a framework. See the Python documentation for more information on installing Python as a framework on Mac OS X. Please either reinstall Python as a framework, or try one of the other backends. If you are using (Ana)Conda please install python.app and replace the use of 'python' with 'pythonw'. See 'Working with Matplotlib on OSX' in the Matplotlib FAQ for more information.
```

라이브러리의 FAQ를 보니 virtualenv 대신에 venv를 이용하여 가상환경을 이용하란다.

# 해결 방법
1. `pip3 freeze > requirements.txt`로 기존 가상환경의 패키지 리스트를 추출한다.  
2. `python3 -m venv myvenv`로 myenv라는 새로운 가상환경을 만든다.  
3. `source myvenv/bin/activate`로 myenv 가상환경을 실행한다.  
4. `pip3 install -r requirements.txt`를 통해 전에 있던 가상환경에서 추출한 패키지 리스트를 다시 설치한다.  
5. 필요하다면 (기존 가상환경을 삭제한다.)  


## 결과

![그래프](/post_assets/2017-06-07/matplotlib_plot.png)


