---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Linux Commands Cheat Sheet"
subtitle: ""
summary: "Linux 指令備忘錄"
authors: [Zane]
tags: [Linux]
categories: [CheatSheet]
date: 2020-11-09T14:00:18+08:00
lastmod: 2020-11-09T14:00:18+08:00
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

## 查詢使用者是否具有 SUDO 的權限

指令:

`sudo -l -U $USER_NAME`

範例:

```shell
# 無權限
-bash-4.2# sudo -l -U jenkins
User jenkins is not allowed to run sudo on localhost.

# 有權限
-bash-4.2# sudo -l -U root
Matching Defaults entries for root on localhost:
    !visiblepw, always_set_home, match_group_by_gid, env_reset,
    env_keep="COLORS DISPLAY HOSTNAME HISTSIZE KDEDIR LS_COLORS",
    env_keep+="MAIL PS1 PS2 QTDIR USERNAME LANG LC_ADDRESS LC_CTYPE",
    env_keep+="LC_COLLATE LC_IDENTIFICATION LC_MEASUREMENT LC_MESSAGES",
    env_keep+="LC_MONETARY LC_NAME LC_NUMERIC LC_PAPER LC_TELEPHONE",
    env_keep+="LC_TIME LC_ALL LANGUAGE LINGUAS _XKB_CHARSET XAUTHORITY",
    secure_path=/sbin\:/bin\:/usr/sbin\:/usr/bin

User root may run the following commands on localhost:
    (ALL) ALL
-bash-4.2#
```

## 將 Screen Log 也導流一份至檔案

指令:

`$COMMAND | tee build.log 2>&1`
