---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Build Up Angular Ssr With Nginx"
subtitle: ""
summary: "在 Nginx 上實作 Angular Serve Side Render"
authors: [Zane]
tags: [Angular, Nginx]
categories: [DevOps]
date: 2020-09-07T21:29:59+08:00
lastmod: 2020-09-07T21:29:59+08:00
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

[SPA(Single Page Application 亦稱 Client Side Rendering) 與 MPA(Multiple Page Application 亦稱 Server Side Rendering)](https://en.wikipedia.org/wiki/Single-page_application)，兩種開發模式都是現代的 Web Application 開發方式。但是，最近筆者的公司想做電商，這時候 [SEO(Search Engine Optimization)](https://en.wikipedia.org/wiki/Search_engine_optimization)就很重要了，而 SPA 因為是動態的關係，所以較不適用。
但是，[Angular](https://angular.io/) 也有提供 [SSR](https://angular.io/guide/universal) 的開發方式。就讓我紀錄一下，我如何將專案以 SSR 運行在 [Nginx](https://www.nginx.com/) 上吧。

## 建置專案

在 Angular SSR 裡，已經有完整的教學與說明，我們唯一要做的就是執行 Build 指令而已。
這個專案其實除了 SSR 的方式可以建置之外，其實也是可以建置 CSR 的，官方 Demo 的腳本裡面已經提供了。
若要建置 SSR 就執行`npm run build:ssr`，CSR 則執行`npm run build`即可。

執行完 SSR 的建置指令後，`dist`裡面會出現兩個資料夾 - `browser`及`server`。

- `browser`則是要被傳回前端的各個頁面。

- `server`裡面只有一隻名為`main.js`的檔案，這是將要被執行在伺服器裡的服務。

## 在 Nginx 運行專案

進入到伺服器後，我們要做兩件事。

1. 修改 Nginx 設定檔。

2. 運行 Angular SSR 服務。

### 修改 Nginx 設定檔

在`/etc/nginx/nginx.conf`加入下列設定

```conf
upstream ssr_nodejs {
    server 127.0.0.1:4000;
}

server {
    listen 443 ssl http2;

    server_name $YOUR_DOMAIN; # <--- Change this part

    include /etc/nginx/ssl/ssl-params.conf;# <--- Ignore this part if not using SSL
    include /etc/nginx/ssl/$YOUR_SSL.ssl;# <--- Ignore this part if not using SSL

    root /home/$YOUR_ROOT/ssr/dist/browser; # <-- Notice where we're point to

   location / {
        try_files $uri $uri @backend; # <--- This looks for requests (statics i.e js/css/fonts)
                                      # in /ssr/dist/browser folder. If nothing found, calls @backend
    }

    location @backend {
        # NOTE THERE IS NO TRAILING SLASH AT THE END. NO TRAILING SLASH. NO SLASH. NO!
        proxy_pass http://ssr_nodejs; # <--- THIS DOES NOT HAVE A TRAILING '/'
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_http_version 1.1;
        proxy_set_header X-NginX-Proxy true;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_cache_bypass $http_upgrade;
        proxy_redirect off;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

server {
    listen 80;
    server_name $YOUR_DOMAIN;
    return 301 https://$server_name$request_uri?;
}
```

重啟 Nginx Service

`sudo systemctl restart nginx`

### 運行 Angular SSR 服務

這邊要注意的是運行`main.js`的位置必需要是在`dist`的父資料夾，以上述的設定檔中`root /home/$YOUR_ROOT/ssr/dist/browser`來看，就需要在`/home/$YOUR_ROOT/ssr`底下執行此服務，不然就會造成錯誤。

主要原因是官方的原始碼中是以目前工作目錄下的位置為基礎去尋找內容。

```javascript
export function app() {
  const server = express();
  const distFolder = join(process.cwd(), 'dist/browser'); // This line
  ...
}
```

執行指令`node /home/$YOUR_ROOT/ssr/dist/server/main.js`後就可以看到頁面了。

如果運行的時候發生如:`ReferenceError: document is not defined`之類的錯誤，不用緊張喔。這是因為 Angular SSR 不像 CSR 一樣具有 browser 的物件如: **window, document, navigator, or location**`。可參考[官方說明](https://angular.io/guide/universal#working-around-the-browser-apis)。解法可參考[這裡](https://github.com/angular/universal/issues/860#issuecomment-349619247)

## 總結

看起目前流行的 SPA 開發方式在 SEO 的支援還是有瓶頸在，而且根據不同的用途 SSR 還是有它存在的價值在。
過去我一直以為 SSR 是很舊式的開發方式且效能不佳。但是，在還沒出現完全支援 SPA 的 SEO 方法之前，SSR 還是最適合做電商的開發模式。

## 參考資料

<https://angular.io/guide/universal>
<https://blog.daudr.me/painless-angular-ssr/>
<https://blog.khophi.co/serve-angular-universal-server-side-dynamic-rendering-nginx-proxy/>
