---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Linux Commands Cheat Sheet"
subtitle: "haha"
summary: "Kubernetes commands that I think it's important or commonly used"
authors: [Zane]
tags: [Linux]
categories: [Cheat Sheet]
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

## Check User SUDO Permission

Command:

`sudo -l -U $USER_NAME`

Example:

```shell
# Without permission
-bash-4.2# sudo -l -U jenkins
User jenkins is not allowed to run sudo on localhost.

# With permission
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

## Generate Log File and Show on Screen Simultaneously

Command:

`$COMMAND | tee build.log 2>&1`

Example:

``
