---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Restore Deleted Nginx Config From Running Process"
subtitle: ""
summary: "從運行中的 Nginx 行程回復被刪除的設定檔"
authors: [Zane]
tags: [Nginx]
categories: [DevOps]
date: 2020-09-21T17:34:11+08:00
lastmod: 2020-09-21T17:34:11+08:00
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

人非聖賢，只要是人一定會犯錯，更何況是腦子裡裝了一大堆東西的工程師們，尤其是在緊湊的專案腳步上，就更容易犯錯。

這次是同事發生的事，但因為有參與其中的過程，而且也順利的解決了這個問題，而自己也是犯過同樣的錯，但之前沒有紀錄下來，
剛好趁這次做個紀錄。

從標題可以知道，這次的問題是誤刪了 Nginx 的設定檔。大部份的公司為了省錢，通常會把測試的服務統一放在同一個伺服器裡，
也就是 - 一站式。 Nginx 是很常拿來做代理的伺服器的軟體，筆者過去的經驗也幾乎是在這套軟體上。
通常我們會把不同服務的設定檔獨立出來放到如:`/etc/nginx/conf.d/`底下，再從`/etc/nginx/nginx.conf`裡面做匯入，
做模組化的管理。筆者的同事雖然誤刪了某個服務的設定檔，但目前服務仍正常運行中，因為需要的檔案已經被讀進記憶體了，可是，一旦 Nginx 的服重啟就會因為找不到該匯入的設定而發生錯誤。

## 解法

解法的順序是

- 找到 Nginx Root Process ID
- 找到系統運行中的程序的 Memory Map
- 找到`[heap]`的位址區段
- 利用`gdb`將`[heap]`的資料 Dump 出來
- 將 Dump 出來的資料轉成字串

## 總結

<https://stackoverflow.com/questions/45852224/restore-current-sites-available-file>
