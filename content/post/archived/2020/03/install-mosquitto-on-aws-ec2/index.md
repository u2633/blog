---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "在 AWS EC2 上安裝 Mosquitto(MQTT) Client 套件"
subtitle: ""
summary: "紀錄 MQTT 在 EC2 上的安裝步驟"
authors: [Zane]
tags: [AWS, MQTT]
categories: [Cloud]
date: 2020-03-12T21:45:17+08:00
lastmod: 2020-03-12T21:45:17+08:00
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

```bash
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -P /tmp
sudo yum install -y /tmp/epel-release-latest-7.noarch.rpm
sudo yum install libwebsockets
sudo yum install mosquitto mosquitto-clients
```

[參考文章](https://stackoverflow.com/questions/49746357/installing-linking-libwebsockets-library-in-aws-linux-for-mosquitto-mqtt?answertab=votes#tab-top)
