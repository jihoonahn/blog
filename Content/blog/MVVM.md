---
title: MVVM 패턴
date: 2023-2-16 1:15
tags: Swift, Architecture, MVVM, Theory
description: MVVM 패턴에 대한 이론
---

오늘은 iOS에서 가장 많이 사용하는 MVVM 패턴에 대해서 이론부분을 공부할 겁니다.

일단 시작해보겠습니다!
---

MVVM은 (Model - View - ViewModel)로 구성되어 있습니다.
각각의 역할을 알아보면

### Model
- 데이터 구조를 정의하고 ViewModel에 결과를 알려주는 역할을 합니다.

### View 
- View는 사용자와의 상호작용을 통해 이벤트가 일어나면 ViewModel에게 알려줍니다.

### ViewModel
- ViewModel은 사용자의 상호작용을 view가 보내주면 이벤트에 맞는 처리를 하고 Model의 상태를 관리합니다.

<img width = 100% src = "https://miro.medium.com/max/1400/1*J7_36YMEO8pNAYGyR53hkA.png"></img>
[Medium 블로그 중 MVVM ex ](https://www.google.com/url?sa=i&url=https%3A%2F%2Fmedium.com%2F%40json.ios.0802%2Fios-%25EB%2594%2594%25EC%259E%2590%25EC%259D%25B8%25ED%258C%25A8%25ED%2584%25B4-mvvm-ac676124c662&psig=AOvVaw2RgeE45Gij-UGJ4laxrAqU&ust=1676810923210000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCOjnrM6Nn_0CFQAAAAAdAAAAABAI)

MVVM의 구조를 잘 보여주는 이미지 입니다.

기존의 View는 User Interface를 표시하기 위한 로직만 담당하고, 그 외에 메서드 호출 정도만 하는것이 이상적입니다.

ViewModel은 기존 UIKit을 import할 필요도 없이 데이터 update 및 View(UI) 요소를 업데이트 합니다.

Model은 데이터 구조를 갖습니다.

이런식으로 양방향 데이터 플로우 구조를 갖게 됩니다.

### 장점
- 독립적인 테스트가 가능합니다.
- 단위 테스트에서 이점을 갖는다.
- View와 Model의 독립성을 갖는다.

### 단점
- 설계가 어렵다.
- 데이터 바인딩이 필수적이다.
