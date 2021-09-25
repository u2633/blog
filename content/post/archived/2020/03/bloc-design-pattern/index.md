---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "什麼是BLoC Design Pattern"
subtitle: ""
summary: "在 Flutter 導入 Business Logic Component Pattern 的學習筆記"
authors: [Zane]
tags: [Flutter, BLoC]
categories: [Programming]
date: 2020-03-10T14:50:24+08:00
lastmod: 2020-03-10T14:50:24+08:00
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

Business Logic Component Pattern 簡稱 [BLoC](https://bloclibrary.dev/#/)。這是一種設計模式，特色在於把商業邏輯(Business Login)與畫面(Presentation)拆分開，類似 MVVM 中 ViewModel(BloC)與 View(Presentation)之間的關係，並且透過事件(Event)來改變狀態(State)，再由狀態(State)來改變畫面(Presentation), 又或者與其他的 BLoC 進行溝通。好處有 1)讓測試變的更簡單 2)更容讓程式碼 Reusable。所以元件主要會有三個部份: BloC 主件、事件(Event)及狀態(State)。

[BLoC 主件](https://bloclibrary.dev/#/coreconcepts?id=blocs)，主要是將 Event 與 State 做 Mapping，透過 Event 去改變狀態。所以，如果 Event 很多的話，就會看到冗長的 if...else 或是 switch...case，如下:

```dart
import 'package:bloc/bloc.dart';

enum CounterEvent { increment, decrement }

class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.decrement:
        yield currentState - 1;
        break;
      case CounterEvent.increment:
        yield currentState + 1;
        break;
    }
  }
}
```
