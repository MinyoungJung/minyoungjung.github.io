---
layout: post
title: Git Merge 충돌 해결 원인 파악하기
category: [Git]
tags: [Github, Git]
---

# 발단

로컬의 프로젝트를 Github로 푸쉬하려는데 문제가 발생했다.
```
(workoutscheduler) My-MacBook-Pro:workoutscheduler mymacpro$ git push origin master
To https://github.com/MinyoungJung/workoutscheduler_project.git
! [rejected]        master -> master (non-fast-forward)
error: failed to push some refs to 'https://github.com/MinyoungJung/workoutscheduler_project.git'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Integrate the remote changes (e.g.
hint: 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```
메시지를 보니 Github 브랜치 내용이 로컬의 브랜치 내용보다 최신이란다.  

# 해결 방안
1. `git push -f`를 통해 강제로 푸쉬한다.  
사실 혼자 로컬에서 작업하는 프로젝트다보니 Github 내용이 더 최신이 된 것 자체가 이상한 상황이고,  
로컬의 코드를 그냥 푸쉬해서 덮어씌워도 아무 문제 없으나 아무래도 찜찜한 것이 사실.

2. `gitk HEAD @{u}` 명령어로 upstream branch와 현재 헤드의 차이를 확인한다.
![머지 충돌](/post_assets/2017-06-06/conflict.png)
master와 origin 사이의 충돌이 생긴 이유가 명확해졌다.  
project setting에서 github page를 생성했더니, 그에 대한 파일이 변경된 것이 로컬에서는 반영되지 않은 것.  
원인을 파악했으니 편안한 맘으로 강제로 푸쉬할 수 있게 되었다.


