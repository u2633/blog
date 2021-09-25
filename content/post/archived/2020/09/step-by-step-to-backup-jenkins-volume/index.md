---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Step by Step to Backup Jenkins Volume"
subtitle: ""
summary: "建立 Jenkins 的備份並且利用此備份建立新的 Container"
authors: [Zane]
tags: [Docker]
categories: [DevOps]
date: 2020-09-15T18:02:17+08:00
lastmod: 2020-09-15T18:02:17+08:00
featured: false
draft: true

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

最近筆者想要將工作環境裡的 Jenkins 容器化，令 Jenkins 的可攜性可以更高一點，這裡我們就需要使用到 Docker 的備份技巧了。

在參考了網路上一些資料並且實作之後，也成功的將自己的 Jenkins 環境做了備份並且還原在新的 Container 上，過程不複雜，
觀念才是重點，就來看看我怎麼做的吧!

## 建立備份檔

Docker 根據不一樣的安全性，分`bind mount`、`volume`及`tmpfs mount`這三種掛載方式。
這次的備份教學是使用`volume`這種方式。

![Types Of Mounts Volume](types-of-mounts-volume.png)

`docker run --rm --volumes-from jenkins -v $(pwd):/backup alpine tar cvf /backup/backup.tar /var/jenkins_home`

上述指令執行後，跑完打包的流程後，便可以在當前目錄下看到`backup.tar`這個備份檔。
接下來我們來了解一下這個指令本身的含義吧。

- `--rm` - 當行程結束後，自動移除容器。可避免多餘的容器被建立。
- `--volumes-from jenkins` - 使用`jenkins`這個容器的`volume`。
- `-v $(pwd):/backup` - 將當前目錄掛載到容器的`/backup`位置。
- `tar cvf /backup/backup.tar /var/jenkins_home` - 將`/var/jenkins_home`的資料打包到`/backup`(也就是目前的工作錄目)並且命名為`backup.tar`。

*注意:*因為打包的時候我們是直接指定`/var/jenkins_home`，所以，備份檔的檔名會是`/var/jenkins_home/*.*`。
因為這會影響到還原時候的指令，若不想有前面的的目錄名稱指令要下`tar cvf /backup/backup.tar -C /var/jenkins_home`。
`-C`會在打包的時候切換至`/var/jenkins_home`再進行打包。

## 透過備份檔還原系統

還原的重點在於要執行的指令。必需指到正確的位置。

`docker run --rm --volumes-from jenkins -v $(pwd):/backup ubuntu bash -c "cd /var/jenkins_home && tar xvf /backup/backup.tar --strip 2"`

一樣來看這串指令做了什麼吧!介紹過的就直接跳過。

- `-v $(pwd):/backup` - 因為剛剛的備份檔存放在當前目錄下，所以，一樣掛載當前目錄到容器的`/backup`。
- `bash -c "cd /var/jenkins_home && tar xvf /backup/backup.tar --strip 2` -
  這裡執行了兩段指令，執行`cd /var/jenkins_home`切換到 Jenkins 的資料夾中，再執行`tar xvf /backup/backup.tar --strip 2`將備份的檔案解壓縮到`/var/jenkins_home`，`--strip 2`是為了將檔案的前導路徑移除。

## 總結

因為這不是單純的 Docker 操作指令，也有使用到 Linux 的打包指令，如果在打包或是還原的時候沒下好指令，
就很有可能會造成檔案還原時位置的錯誤。可以在還原前看一下備份檔的內容，指令為`tar -tvf backup.tar`。

## 參考資料

<https://docs.docker.com/storage/volumes/>
<https://dotblogs.com.tw/artBlog/2018/10/02/how-to-backup-restore-docker-volume>
<https://medium.com/@loomchild/backup-restore-docker-named-volumes-350397b8e362>
<https://blog.ssdnodes.com/blog/docker-backup-volumes/>
