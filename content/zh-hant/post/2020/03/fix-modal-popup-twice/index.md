---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "解決Flutter Bottom Modal彈跳兩次的問題"
subtitle: ""
summary: "紀錄我是如何解決 Flutter Bottom Modal的問題"
authors: [Zane]
tags: [Flutter]
categories: [程式語言]
date: 2020-03-12T19:58:18+08:00
lastmod: 2020-03-12T19:58:18+08:00
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

在開發 Flutter 的時候，不知為何觸發 Bottom Modal 的選單時，總是會觸發兩次，問題如下影片

{{< youtube RqUUDLlzAkE >}}

## 預期的行為

預期只會出現一次

{{< youtube ntuETYdeMjc >}}

## 解決方法

增加 listener 檢查目前的 Widget 是否已經被 Focus，避免觸發兩次

```dart
_institutionOnFocus.addListener(() {
  if (_institutionOnFocus.hasFocus) {
    BottomModalBuilder.items(
      context,
      _institutionController,
      _institutionList.map((i) => i.name).toList(),
    );
  }
});

/// Institution text field
Widget _showInstitutionField(CheckupDownloadState state) {
  return TextFormFieldBuilder(
    labelText: '健檢機構',
    hintText: '請選擇',
    controller: _institutionController,
    focusNode: _institutionOnFocus,
    isReadOnly: true,
    validateFailureMessage: !state.isInsitutionValid ? '請選擇機構' : null,
  );
}
```
