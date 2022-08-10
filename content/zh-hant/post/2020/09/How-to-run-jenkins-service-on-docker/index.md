---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "How to Run Jenkins Service on Docker"
subtitle: ""
summary: "在 Docker 上運行 Jenkins"
authors: [Zane]
tags: [Jenkins, Docker]
categories: [DevOps]
date: 2020-09-08T13:56:55+08:00
lastmod: 2020-09-08T13:56:55+08:00
featured: false
draft: false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: ""
  focal_point: ""
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: []
---

## 前言

目前筆者又因緣際會的跳回去當 [DevOps](https://en.wikipedia.org/wiki/DevOps) 的角色了。做為一個專業的~~汽車維修工~~DevOps 工程師，身上有個 1-2 套熟悉的 [CI/CD](https://en.wikipedia.org/wiki/CI/CD) 工具，也是應該的，如: [Jenkins](https://www.jenkins.io/), [Drone](https://www.jetbrains.com/teamcity/promo/free-ci/?&source=g&campaign=APAC_en_TW_TeamCity_Search&gclid=CjwKCAjwtNf6BRAwEiwAkt6UQjqdsyDtP78TzdhFlNPVeZipm20q8eO-Lr8fSqS2PO5cv-Vx0rjX4hoClsgQAvD_BwE&gclsrc=aw.ds)...等。

距離上次 DevOps 的時間也有 2-3 年了，這段時間較熟悉的工具(Jenkins)也一直在持續的更新，而新的工具又是一直在推出(如: Drone)。先不感慨時間飛逝了…，這次要紀錄的是 - 如何在 Docker 上運行 Jenkins。

[Docker](<https://en.wikipedia.org/wiki/Docker_(software)>) - 容器化服務的核心工具，工程師們不僅要認識它，還要了解它的功用及基本操作，[官方](https://www.docker.com/)永遠是個~~囉嗦~~好用的資源。

## 安裝 Docker

`brew install docker`

安裝完後可以直接運行`open /Applications/Docker.app`

## 運行 Jenkins

`docker run -d -v jenkins_home:/var/jenkins_home -p 8080:8080 -p 50000:50000 jenkins/jenkins:lts`

這邊建立一個 Volume 讓 Jenkins 存放 Configs 及一些 Plugins。使用者其實也可以利用 [bind mount](https://docs.docker.com/storage/bind-mounts/) 的方式，但[官方](https://github.com/jenkinsci/docker/blob/master/README.md)比較不建議，原因是為了避免權限造成的其他問題。但如果使用者對權限的操作很熟悉又需要跟 Host 共享資源，亦可使用此方法。如果只是與 Container 的話，還是建議用 Volume 掛載的方式。

當 Container 運行後，可以使用`docker container ps`查詢 Container ID，然後使用`docker logs $CONTAINER_ID`便可以得到初始化的管理者密碼。

## 總結

由於容器化的便利性，造就了我們只需要一行 Docker 的指令，便可啟動 Jenkins 這項服務。
連我最近蠻有興趣的 Drone CI 也是以容器為基礎來完成所有的 CI/CD 流程，由此可見容器的重要性了，
下次就以 Docker 為主題來做紀錄吧!
