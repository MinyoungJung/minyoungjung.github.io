---
layout: post
title: Pycharm Community 에디션에 Django 가상환경으로 세팅하기
category: [파이썬, Django, 환경설정]
tags: [Django, Web service, Python, Pycharm, Virtualenv, Git]
---

# Pycharm Community 에디션에 Django 가상환경으로 세팅
Pycharm Professional Edition과 다르게 Community Edition은 Django와 같은 프로젝트를 직접 생성할 수 없다.  
결국 설정을 위해서 약간의 번거로운 작업이 필요하다.

## 가상환경 설정
`python -m venv my-virtualenv`
my-virtualenv라는 이름의 가상환경 생성

## 가상환경 실행
`source my-virtualenv/bin/activate`  
가상환경이 실행되면 `(my-virtualenv) 프롬프트 이름$`와 같이 프롬프트가 변경된다.  
이 상태에서는 어떤 폴더로 이동하든 가상환경이 실행된 상태이다.  

## Django 설치
`pip3 install django`

## Django project 생성
`django-admin startproject 프로젝트이름`

## Git 설정
`git init`   
`git add .`  
`git commit -m "first commit"`  
`git remote add origin https://github.com/프로젝트github.git`  
`git push origin master`

## Pycharm 설정
1. Pycharm 커뮤니티 에디션 실행, 프로젝트 폴더 위치 선택하여 프로젝트 열기  
2. `⌘`+`,` 입력하여 Preference 창 출력
3. Project -> Project Interpreter 선택
4. 맨 위의 Prject Interpreter 선택 창 옆의 설정 아이콘 선택 -> Add local
5. 생성한 가상환경 폴더의 /bin/python3 선택 -> Apply
6. Run -> Edit configurations 선택
7. `+` 선택 후 Python 선택하여 새로운 환경 설정 생성 후 이름 지정
8. Script: 프로젝트 폴더의 manage.py 선택, Script parameters: runserver

## Pycharm에서 가상환경으로 작업
이제 커맨드라인에서 `deactivate`를 입력해 가상환경을 종료해도 Pycharm안에서 모두 해결 가능하다.  
패키지를 인스톨하고 싶다면 `⌘`+`,` 입력 후 Project Interpreter 항목의 리스트에서 선택하면 되고,  
테스트 서버를 실행하고 싶다면 간단히 `⌃`+`r`이나 재생버튼(?)을 선택하여 실행할 수 있다.

