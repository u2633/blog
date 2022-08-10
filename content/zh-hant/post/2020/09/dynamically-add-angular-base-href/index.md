---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Dynamically Add Angular Base Href"
subtitle: ""
summary: "動態設定 Angular Base Href"
authors: [Zane]
tags: [Angular]
categories: [Programming]
date: 2020-09-11T10:06:19+08:00
lastmod: 2020-09-11T10:06:19+08:00
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

這篇雖然跟 DevOps 沒有直接關係，但是這也關係到了系統的可用性。所以，也將此問題收錄在我的筆記中。

## 發生的問題

昨天，開發人員在本機開發完 Angular 的專案之後並且利用 Jenkins 完成佈署後，噹啷~~
進入頁面後只看見一片空白…。

在看了一下 `Chrome DevTools` 後發現，Client 端在讀頁面的時候並沒有正確網頁資源的位置。
因為過去有開發過 Angular 的經驗，當下便知道一定是 [Angular Base Href](https://angular.io/guide/deployment#the-base-tag) 造成的問題。

## 解決方式

我找了三種解法。三種方法的複雜度依序排列為下。

- 直接 Hard Code 在 `index.html`
- 利用 [Angular CLI](https://cli.angular.io/) 的指令來完成設
- 利用程式碼進行動態配置

### 直接 Hard Code 在 index.html

最簡單的方式，但同時也造成了開發人員的困擾。一開始我就是用這個方式先解決無法正常讀取網頁的問題。
我先在 Web Server 裡面直接對 `index.html` 下手，並且把修改的地方也上到了專案程式碼裡。但是，
開發人員馬上跟我反應他在本機端發生無法正常執行的問題。
原因是 Angular 在本機開發上不需要 `Base Href`，所以在換頁的時候是直接導路徑的。例如:
在正式環境上的位置是 `https:/your_domain/my_base_href/my_path`，而開發環境上會變成 `localhost:4200/my_path`。

如果直接在 `index.html` 上做 Hard Code，就會造成他們在開發上的問題。所以，這個方法只能對伺服器端進行。

### 利用 [Angular CLI](https://cli.angular.io/) 的指令來完成設

Angular 專案裡面都有個 `package.json`。通常工程師們都會把 Build Command 寫在 scripts 欄位裡面。

```json
"scripts": {
  "ng": "ng",
  "start": "ng serve --open --aot",
  "build": "ng build",
  "build:prod": "node node_modules/@angular/cli/bin/ng build --prod",
  "build:sit": "node node_modules/@angular/cli/bin/ng build -c sit --base-href=/your/base/href/",
  "test": "ng test",
  "lint": "ng lint",
  "e2e": "ng e2e"
},
```

上面 `build:sit` 最後面的 `--base-href` 就是第二個解法。直接在後面打上你的 Base Href，
在每次 Build 的時候會主動在生成的 `index.html` 裡寫入 Base Href。如下:

```html
<base href="/your/base/href/" />
```

### 利用程式碼進行動態配置

這個方式只能讓專案在 Routing 的時候不用再加上 Base Href，可參考[官方文](https://angular.io/api/common/PathLocationStrategy#description)，但其實是無法解決讀取網路資源找不到的問題。

這邊利用了 [Angular Provider](https://angular.io/guide/dependency-injection-providers) 來對 [APP_BASE_HREF](https://angular.io/api/common/APP_BASE_HREF#app_base_href)屬性進行設定。

```typescript
import { Component, NgModule } from "@angular/core";
import { APP_BASE_HREF } from "@angular/common";

@NgModule({
  providers: [{ provide: APP_BASE_HREF, useValue: "/my/app" }],
})
class AppModule {}
```

`useValue`中值的部份，我們可以將它寫入到 `environment` 裡面，讓程式看來更具可讀性。

```typescript
import { Component, NgModule } from "@angular/core";
import { APP_BASE_HREF } from "@angular/common";
import { environment } from "src/environments/environment";

@NgModule({
  providers: [
    {
      provide: APP_BASE_HREF,
      useValue: environment.baseRef,
    },
  ],
})
class AppModule {}
```

## 總結

想要解決網路資源無法正常讀取的問題，只能在`ng build`的時候利用 Build Tools 來幫我們把 Base Href 寫入`index.html`裡面。

## 參考資料

<https://angular.io/guide/deployment#the-base-tag>
<https://angular.io/guide/deployment#deploy-to-github-pages>
<https://stackoverflow.com/questions/51182322/whats-the-difference-between-base-href-and-deploy-url-parameters-of-angular>
