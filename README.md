# 🚌 함께 타요 ( We TaYo )

KPU 캡스톤 프로젝트로 시각 장애인을 위한 gps와 비콘을 이용
승하차 보조 시스템입니다.

<br>

## 파일 구조

```
project
    └ wetayo_app ( flutter )
    └ wetayo_api ( spring api )
    └ raspberry ( 팀원간 상의 )
    └ wetayo_web ( web front server )
    └ README.md
```

<br>

## 브랜치 규칙

기본적으로 Git-flow를 따르며, release branch는 팀원들과 더 많은 협의 후 사용 예정.

```
◼ main
    - 실제 배포가될 브랜치
    - repo 총 관리자가 팀원들과 협의 후 최종 병합, 배포

◼ develop
    - 개인 로컬 저장소와 중앙 저장소의 코드 동기화를 위해 사용
    - default 브랜치로 다음 기능을 개발하는 브랜치

◼ feature
    - 실제 개발이 이루어지는 브랜치
    - 개발이나 버그 픽스때마다 develop브랜치로부터 분기
    - 본인의 로컬 저장소에서 관리하는 브랜치 개발이 완료되면 develop브랜치에 병합하여 다른 사람들과 공유

    🔹 이름 규칙 : feature/기능 요약

◼ release
    - 이번 출시 버전을 준비하는 브랜치
    - 배포할 수준의 기능이 모이거나 일정이 되면, master에 병합, 배포

    🔹 이름 규칙 : release-*(버전 명)

◼ hotfix
    - 출시 버전에서 발생한 버그를 긴급 수정하는 브랜치
    - master에서 배포한 브랜치에서 분기하여 필요한 부분만 수정후 병합, 배포

    🔹 이름 규칙 : hotfix-*(배포 버전)
```

<br>

## git 초기화

```
//터미널에서 자신이 원하는 디렉토리 이동 후 명령어 실행
git clone [repo url]

git init
git remote add origin [repo url]
git pull origin master

git checkout -b develop origin/develop
```

<br>

## 작업 수행시

```
// 브랜치 명은 브랜치 이름 규칙을 보자!
git checkout -b [브랜치 명] develop

/* 작업 수행 */

git add .                   //작업한 모든 파일 추가
git commit -m "메세지"       //메세지는 간단하게!!
git push origin develop

GUI툴이나 웹사이트에 가서 pull request

git branch -d [브랜치 명]    //feature 브랜치 삭제
```

<br>

## 다른 사람의 작업 동기화

```
git checkout develop
git pull origin develop
```

<br>

## hotfix

```
$ git checkout -b hotfix-[버전] master

/*  문제가 되는 부분만을 빠르게 수정  */

$ git checkout master
$ git merge --no-ff hotfix-[버전]
$ git tag -a [버전]

$ git checkout develop
$ git merge --no-ff hotfix-[버전]
```

<br>

## Collaborator

- 강석원
- 박형근
- 이지수
- 홍의성

<br><br>

<br><br>

<br><br>
