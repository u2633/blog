---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "狀態管理工具 - MobX"
subtitle: ""
summary: "學習 MobX 並且在 Flutter 專案中實作"
authors: [Zane]
tags: [Flutter, MobX]
categories: [Programming]
date: 2020-04-14T13:56:46+08:00
lastmod: 2020-04-14T13:56:46+08:00
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

之前有介紹什麼是 [BLoC](https://blog.zcychen.com/post/2020/03/bloc-design-pattern/)。
今天來學習另一個狀態管理工具 - [MobX](https://mobx.netlify.com/)。

類似 BLoC，但可以讓開發者更專注在資料面上且不用寫太多的程式碼。同樣是狀態管理工具，
MobX 似乎看起來更有優勢，因為我們只需要專注在哪些畫面需要哪些資料，
而不用像 BLoC 一樣，需要實作`事件(Event)`與`狀態(State)`。

MobX 的主要三大核心元件: `Observables`, `Actions` 與 `Reactions`，
圖是人的朋友，我們可利用下圖來了解彼此的關係。

![Mobx Core Concepts](mobx-core-concepts.png)

首先，我們會先定義哪此資料是必需被`觀察(Observable)`的，並且能在任何`行為(Action)`造成的`改變(Mutate)`時`通知(Notify)`頁面並做出`反應(Reaction)`。
而且，在頁面做完`反應(Reaction)`後又可能會`觸發(Fire)`另一個`行為(Action)`。如此就型成了上述的三角狀態。

## Observables

`Observables`代表`嚮應的狀態(Reactive-State)`。它可以是一個簡單的值，可以是個復雜的物件(`reactive-state-tree`)。
我們可以在 Widget Tree 中的任何一個地方利用`觀察者(Observer)`取得這些`Observables`。

基於這些概念，我們可以定義出如下的程式碼

```dart
class Counter {
  Counter() {
    increment = Action(_increment);
  }

  final _value = Observable(0);
  int get value => _value.value;

  set value(int newValue) => _value.value = newValue;
  Action increment;

  void _increment() {
    _value.value++;
  }
}
```

程式碼有點不易越讀性，如果在大型一點專案中會更容易有這種問題。
但是，在透過 MobX 的幫助下，我們只需要使用`Annotation`的方式就能簡化其程式碼。
實作中，我們會建立一個`Store(Entity的概念)`來存放`Observable`、`Action`、`Computed Observable`的資料，
並利用第三方插件 - [mobx_codegen](https://pub.dev/packages/mobx_codegen) 來幫我們產出`Annotation`裡的樣版程式碼

```dart
import 'package:mobx/mobx.dart';

part 'counter.g.dart';

class Counter = CounterBase with _$Counter;

abstract class CounterBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
```

### Computed Observables

MobX 中的狀態組成為`核心狀態(Core-State)` + `衍生狀態(Derived-State)`。
假設我們有個叫`Contact`的 Store，如下:

```dart
import 'package:mobx/mobx.dart';

part 'contact.g.dart';

class Contact = ContactBase with _$Contact;

abstract class ContactBase with Store {
  @observable
  String firstName;

  @observable
  String lastName;

  @computed
  String get fullName => '$firstName, $lastName';
}
```

`Computed Observables`也就是所謂的`衍生狀態(Derived-State)`，
是個以`核心狀態(Core-State)`或是其他`衍生狀態(Derived-State)`為基礎的`Observable`。

範例中`firstName`與`lastName`就是`核心狀態(Core-State)`，而`fullName`就是`衍生狀態(Derived-State)`。
`fullName`的值也會與`firstName`及`lastName`保持同步的狀態。

## Actions

`Action`就是在 Store 中對`Observable`操作的`函數`。不同於直接對`Observable`操作，
藉由`Annotation`可以讓程式碼更具可讀性。此外，`Action`還會保證所有的改變都會在完成後被確實通知。

## Reactions

在 MobX 中，它代表`Observer`，監聽追蹤的`Observable`並在有改變的時候通知`Observer Widget`。
`Reaction`有四個不一樣的形態:

- `ReactionDisposer autorun(Function(Reaction) fn)`

  `autorun`會在被建立後立刻做出反應並且在任何改變的時候做出反應

  ```dart
  import 'package:mobx/mobx.dart';

  String greeting = Observable('Hello World');

  final dispose = autorun((_){
    print(greeting.value);
  });

  greeting.value = 'Hello MobX';

  // Done with the autorun()
  dispose();

  // Prints:
  // Hello World
  // Hello MobX
  ```

- `ReactionDisposer reaction<T>(T Function(Reaction) fn, void Function(T) effect)`

  `reaction`僅會在有改變的時候才會做出反應

  ```dart
  import 'package:mobx/mobx.dart';

  String greeting = Observable('Hello World');

  final dispose = reaction((_) => greeting.value, (msg) => print(msg));

  greeting.value = 'Hello MobX'; // Cause a change

  // Done with the reaction()
  dispose();

  // Prints:
  // Hello MobX
  ```

- `ReactionDisposer when(bool Function(Reaction) predicate, void Function() effect)`

  `when`僅會在條件成立的時候做出反應，而且`僅會觸發一次`。

  ```dart
  import 'package:mobx/mobx.dart';

  String greeting = Observable('Hello World');

  final dispose = when((_) => greeting.value == 'Hello MobX', () => print('Someone greeted MobX'));

  greeting.value = 'Hello MobX'; // Causes a change, runs effect and disposes

  // Prints:
  // Someone greeted MobX
  ```

- `Future<void> asyncWhen(bool Function(Reaction) predicate)`

  `asyncWhen`與`when`雷同，只是它回傳的是一個`Future`。

  ```dart
  final completed = Observable(false);

  void waitForCompletion() async {
    await asyncWhen(() => completed.value == true);

    print('Completed');
  }
  ```

除了`asyncWhen`是傳回一個`Future`之外，其他三個都會傳回一個`ReactionDisposer`。
`ReactionDisposer`一個可以被調用以處理`Reaction`的函數。

## Observer Widget

`Observer Widget`的功用是監聽其 Widget 內`Observable`的改變，
並且在接收`Reaction`發出的通知後進行畫面更新。

```dart
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

part 'counter.g.dart';

class Counter = CounterBase with _$Counter;

abstract class CounterBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}

class CounterExample extends StatefulWidget {
  const CounterExample({Key key}) : super(key: key);

  @override
  _CounterExampleState createState() => _CounterExampleState();
}

class _CounterExampleState extends State<CounterExample> {
  final _counter = Counter();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Counter'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Observer(
                builder: (_) => Text(
                    '${_counter.value}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _counter.increment,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
}
```

## 總結

雖然 MobX 還是得借助額外的函式庫來幫我們產生底層的程式碼，但與 BLoC 比起來,確實可以少寫點 Code。
文件說明也蠻詳儘的，也有把使用者可能會有的疑問也在文件中加以說明。另外，也有不少範例可以參考。
但在學習的曲線上，BLoC 還是讓我覺得比較易懂跟直覺。該學哪種呢?當然是兩種都學!!!
