---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Extensible Messaging and Presence Protocol (XMPP)"
subtitle: ""
summary: "XMPP 的學習筆記"
authors: [Zane]
tags: [XMPP]
categories: [Programming]
date: 2020-04-09T14:34:42+08:00
lastmod: 2020-04-09T14:34:42+08:00
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

最近在串 Firebase Cloud Messaging 的時候在官方文件看到了 XMPP 這個通訊協定，
雖然這並不是新的技術，但過去也沒看過，就來學點新知識吧。

## What

[XMPP, eXtensible Messaging and Presence Protocol](https://xmpp.org/)
是一種基於[XML](https://zh.wikipedia.org/wiki/XML)，用於傳遞`訊息及狀態`的`開放式標準`通訊協定。可應用於如: WebRTC, IoT, Gaming
, Instant Message(IM)等許多領域中。

目前一些科技大廠如: Google, Apple 的`Push Notification`也是使用此通訊協定。
IM 中較國內知名的就屬[WhatsApp](http://whatsapp.com/)。
Gaming 中[Nintendo Switch](https://www.nintendo.com/switch/) 也利用它當作`Push Notification Server`，
另一個 Gaming Use Case 就是[League of Legends](https://leagueoflegends.com/) - 將其利用作為`聊天室`與`遊戲邀請`的通訊協定。
有興趣多了解可參考[官方 Uses](https://xmpp.org/uses/)

## Why

優點:

- 開放
  
  XMPP協議是自由、開放、公開的，並且易於瞭解。而且在客戶端、伺服器、元件、原始碼庫等方面，都已經各自有多種實作。
  
- 標準
  
  網際網路工程工作小組（IETF）已經將Jabber的核心XML串流協定以XMPP之名，正式列為認可的即時通訊及Presence技術。而XMPP的技術規格已被定義在RFC 3920及RFC 3921。任何IM供應商在遵循XMPP協定下，都可與Google Talk實現連接。

- 證實可用
  
  第一個Jabber（現在XMPP）技術是Jeremie Miller在1998年開發的，現在已經相當穩定；數以百計的開發者為XMPP技術而努力。今日的網際網路上有數以萬計的XMPP伺服器運作著，並有數以百萬計的人們使用XMPP即時傳訊軟體。

- 分散式
  
  XMPP網路的架構和電子郵件十分相像；XMPP核心協定通信方式是先建立一個stream，XMPP以TCP傳遞XML資料流，沒有中央主伺服器。任何人都可以運行自己的XMPP伺服器，使個人及組織能夠掌控他們的即時傳訊體驗。

- 安全
  
  任何XMPP協定的伺服器可以獨立於公眾XMPP網路（例如在企業內部網路中），而使用SASL及TLS等技術的可靠安全性，已內建於核心XMPP技術規格中。

- 可擴展
  
  XML命名空間的威力可使任何人在核心協定的基礎上建造客製化的功能；為了維持通透性，常見的擴充套件由XMPP標準基金會。

- 彈性佳
  
  XMPP除了可用在即時通訊的應用程式，還能用在網路管理、內容供稿、協同工具、檔案共享、遊戲、遠端系統監控等。

- 多樣性
  
  用XMPP協定來建造及布署即時應用程式及服務的公司及開放原始碼計劃分布在各種領域；用XMPP技術開發軟體，資源及支援的來源是多樣的，使得使你不會陷於被「綁架」的困境。

缺點

- 資料負載太重
  
  隨著通常超過70％的XMPP協定的伺服器的資料流量的存在和近60％的被重複轉發，XMPP協定目前擁有一個大型架空中存在的資料提供給多個收件人。新的議定書正在研究，以減輕這一問題。

- 二進制資料傳輸受限
  
  XMPP傳輸單一的XML檔案，因此要透過XMPP傳輸二進制資料，需先將二進制資料以Base64編碼。但是大量的二進制資料傳輸，較佳的作法是用外部的其他協定傳輸，而以XMPP進行溝通。至於其他二進制資料加密會話（encrypted conversations）或圖形圖標（graphic icons）以嵌入式使用相同的方法。

## How

`XMPP Client` 的傳輸都**必需**經過 `XMPP Server`，但這 Server 不是官方控制的(**Jabber.org的公眾伺服器上有大量的用戶，但它並不是官方的**)。
任何人都可以在自己或是公司的網域架設 XMPP Server，例如:

朱麗葉（juliet@capulet.com）想和羅密歐（romeo@montague.net）通話，他們兩人的帳號分別在Capulet.com及Montague.net的伺服器上。
其流程為

1. 朱麗葉的 XMPP客戶端 將她的訊息傳送到 Capulet.com XMPP 伺服器。
2. Capulet.com XMPP 伺服器開啟與 Montague.net XMPP 伺服器的連接。
3. Montague.net XMPP 伺服器將訊息寄送給羅密歐。如果他目前不在線上，那麼儲存訊息以待稍後寄送。

在上述的過程中，訊息會在傳送時被 [OMEMO](https://en.wikipedia.org/wiki/OMEMO) 的加密方式處理過後再送出。

XMPP 亦支援跨協定傳輸，稱為 `Transport 或是 Gateway`。

[官方這裡](https://xmpp.org/software/) 也整理不少實作 XMPP 協定的 Client 與 Server 軟體。

## 總結

在網路上也不少 XMPP 與 [MQTT](http://mqtt.org/) 比較的文章，尤其是在 IoT 的領域中，這兩種𠦢定都是可以被利用的。
但是，MQTT 由於其`低功耗`且`低頻寬消耗`的特性，所以更適合在 IoT 領域，開發者認為它就是個`機器對機器的通訊協定`。
相對的，XMPP 也因`高安全性`及`易擴展`等特性讓它能夠在不同的領域中被廣泛使用。
