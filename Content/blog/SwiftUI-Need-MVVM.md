---
title: SwiftUI에 MVVM이 필요할까요?
date: 2022-9-21 12:00
tags: Swift, Architecture, SwiftUI, Debate
description: 요즘 이슈가 되고 있는 내용으로, 과연 SwiftUI에는 MVVM이 필요한지에 대한 저의 주관적인 생각을 담은 글입니다.
postImage: https://user-images.githubusercontent.com/68891494/235434674-872c1cf2-3ed0-4669-be1b-0d9901de98c2.svg
---


[Stop using MVVM for SwiftUI](https://developer.apple.com/forums/thread/699003)

[「SwiftUIでMVVMを採用するのは止めよう」と思い至った理由 - Qiita](https://qiita.com/karamage/items/8a9c76caff187d3eb838)

요즘에 주의 깊게 보고 있는 issue 입니다.

위 글을 보면 SwiftUI에서 MVVM 사용을 멈추자는 의견을 제시하고 있습니다. 

[Stop using MVVM with SwiftUI](https://medium.com/@karamage/stop-using-mvvm-with-swiftui-2c46eb2cc8dc)

→ 제가 처음으로 본 사이트입니다.

“SwiftUI에서 MVVM 사용 중지”라는 강력한 주제로 저의 관심을 끌었습니다.

그 글은 꽤나 논리적인 글이라고 생각이 되었다. (진짜 많이 생각을 하게 만드는 글이라고 생각이 됩니다.)

[Is MVVM an anti-pattern in SwiftUI?](https://www.reddit.com/r/swift/comments/m60pv7/is_mvvm_an_antipattern_in_swiftui/)

Reddit에서도 issue가 된 내용입니다.

### 여기서부터는 저의 생각이 들어갔습니다.

SwiftUI는? 선언형 뷰 프로그래밍 방식입니다.

**선언형 UI에서는 ViewModel은 필요할까** 라는 주제의 여러 글들을 보고 따로 공부와 여러가지 생각을 했습니다.

옛날에는 “MVVM이 무조건 좋다” 라는 인식이 존재했습니다. 그런데 SwiftUI로 개발을 하면서 억지로 ViewModel을 만드는 상황이 발생하고 있습니다.

 ViewModel은 비즈니스 로직을 분리하는 목적으로 사용할 수 있기 때문에 ViewModel이 완전히 나쁘다 라고 하기는 어려울것 같습니다. 하지만 SwiftUI에서 **View가 자체적으로 Data Binding이 가능한 PropertyWrapper를 지원**하기 때문에 아래와 같이 생각합니다.


### SwiftUI에서의 View는 이미 View+ViewModel 입니다.

> ViewModel은 원래 상태를 View에 Binding하여 Reactive에 반영하기 위한 목적으로 도입되었지만, 선언적 UI에는 해당 기능이 포함되어 있으므로 ViewModel은 필요하지 않다고 생각합니다.

### 우리가 왜 MVVM이 무조건 좋다고 생각했을까요?

이것은 기존 사용했던 UIKit을 보고 알 수 있었습니다.

위에서 대답한 내용이지만 더 설명을 붙이자면, UIKit에서는 View와 ViewModel의 데이터 바인딩을 Observable을 생성하거나 React 구현체인 **RxSwift, Combine을 통해서 Reative하게 뷰에 값을 반영**시켜주고 있었습니다.

기존 코드에서는 rx를 통해 데이터 바인딩을 해주는 코드를 사용했다. 흔하게 알고 있는 ViewModel을 통해서 뷰와 데이터 바인딩을 해주는 MVVM 구조입니다. ViewModel의 가장 중요한 역할은 데이터 바인딩입니다. 모델과 뷰 사이에 양방향 통신을 해주면서 바인딩을 시켜줍니다.

**하지만 SwiftUI에서는 View에서 다 해줄 수 있기 때문에 필요가 없다는 생각이 됩니다.**

### SwiftUI의 View에서 다 처리하라고?

선언형 UI에서 ViewModel의 주요 기능인 데이터 바인딩이 필요없어진것입니다. 그래서 ViewModel이라고 표현하는 것이 어색하다고 생각이 됩니다. SwiftUI에서 MVVM 구조를 도입하는 것이 중간 계층의 레이어를 하나 더 두게 되는 복잡성이 생깁니다. View와 Model 사이에 없어도 되는 ViewModel이 들어가면서 굳이 양방향 데이터 플로우 구조가 되게 해야할까요?

요즘 핫하고 장점이 많은 단방향 아키텍처의 구조와는 거리가 멉니다.

**애플이 SwiftUI의 섹션에서 State와 Data Flow를 설명하면서도 보여준 예시가 있는데 이 또한 단방향 데이터 플로우를 권장하고 소개**합니다.

<img width="100%" alt="my-option" src="https://user-images.githubusercontent.com/73165292/196845240-6b0ed156-f79f-4d70-9b13-fcabe343725b.png">
</img>

상태 즉 State를 관리해줌으로 View를 나타내주면서 모든 흐름이 단방향 구조가 됩니다.

즉 상태 관리 기반의 단방향 구조라고 볼 수 있다.

**선언형 UI를 사용하는 환경에서는 단방향 데이터 플로우 구조를 지향합니다.**

현재 많은 개발자들이 아키텍처 패턴으로 MVVM을 사용합니다. 많은 자료들이 SwiftUI + MVVM을 사용하는 방법에 대해서 설명을 하고 있습니다. 하지만 저는 이러한 행위는 불필요하다고 생각합니다. 

**SwiftUI에서 MVVM을 사용하는 것은 MVVM + MVVM 즉 이중 구현이 된다고 생각이 됩니다.**

저는 이러한 동작이 정말 불필요하다고 생각을 합니다.

요즘 React나 Vue 또는 Flutter에서도 MVVM이 사용되고 있지 않습니다.

공통점으로 선언형 UI를 사용한다는 것을 알수 있습니다.

### 그럼 뭘 사용하라는 건가

ViewModel을 안사용하면 로직과 UI 분리는 어디서 담당해야할까?

[Realm](https://www.youtube.com/watch?v=mTv96vqTDhc&t=756s)에서는 MVI 접근 방식을 지향한다고 합니다.

원본에서 작성자는 두가지 방법을 제시합니다.

1. Model에서 이를 구현한다.
2. Flux 개념의 Store로 분리한다.

1번도 가능은 하나 모델에 비즈니스 로직을 넣으면 단방향 데이터 플로우를 해치게 된다고 생각합니다.

그래서 2번째 방법인 Flux적인 Store의 개념으로 분리해 거기서 View를 나타낼 상태 즉 State를 관리해주는 것이 적절하다고 생각합니다.

### 글 정리

이 글을 적으면서도 참으로 많은 생각을 하게 됩니다. 

**선언형 UI를 사용하는 환경에서는 MVI, Flux 정도가 잘 어울린다고 생각이 됩니다.**

MVI는 단방향 아키텍처이며, Flux는 Composit한 조합을 통해 상태 관리를 하는 마찬가지로 단방향 아키텍처입니다.

우리가 필요한 것들은

- View와 비즈니스 로직 분리
- 단방향의 데이터 플로우
- 각 View를 통해 나타낼 Component의 설계 및 조합
- Component들의 상태 관리 및 연결

MVVM 아키텍처는 이런 문제를 해결할 수 없다고 생각합니다.

저는 이 논쟁에 대해 저의 생각을 답글에 달았습니다.

<img width="100%" alt="my-option" src="https://user-images.githubusercontent.com/73165292/196845524-2621e870-0fc8-4caf-b636-34aa2a452be9.png">
</img>
