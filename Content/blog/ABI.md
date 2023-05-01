---
title: ABI
date: 2023-4-2 17:55
tags: Swift, Binary
description: Application Binary Interface에 대한 공부
postImage: https://user-images.githubusercontent.com/68891494/235434656-0cb8b84f-3934-44e4-a832-79d112215374.svg
---

오늘 **ABI** (Application Binary Interface)에서 어떤 역할을 하는지 알아보겠습니다.

일단 시작해보겠습니다!

---
## ABI란?

위에서도 말했던 Application Binary Interface 의 약자로 바이너리간의 인터페이스를 나타냅니다.
Runtime 내에서 Swift 프로그램 바이너리는 ABI를 통해 다른 라이브러리 및 구성요소와 상호작용한다는 특징이 있습니다.

## ABI stability
Swift 5.0 부터 지원하게 된 ABI stability는 바이너리 내부는 바뀔 수 있지만 인터페이스는 유지되기 때문에 ABI stability가 지원이 되면 ABI가 지원하는 버전의 Swift Compiler를 통해 컴파일한 앱과 이후 업데이트 된 바이너리 간의 호환이 가능합니다.
<img width="100%" src ="https://www.swift.org/assets/images/abi-stability-blog/abi-stability.png"></img>

위 이미지 예시에서는 Swift 5로 빌드된 앱은 Swift 5 표준 라이브러리와 가상의 Swift 5.1, 6에도 실행이 된다는 것을 보여줍니다. <br/>

> ABI에 대해서 이해가 되셨나요?<br/>그러면 ABI를 사용하면 어떤 이점을 얻을 수 있을까요?

## 이점
**Source compatibility(소스 호환성)**

- 새로운 Swift 버전이 나왔을 때 마이그레이션 을 해야하는 비용을 줄일 수 있습니다.

**Binary framework & runtime compatibility**

- Binary framework & runtime compatibility를 통해 여러가지 버전에서 작동하는 Framework를 배포할 수 있습니다.
<br/><br/>

## Reference
- [ABI stability in swift.org](https://www.swift.org/blog/abi-stability-and-more/)
- [swift github](https://github.com/apple/swift/blob/main/docs/ABIStabilityManifesto.md)
- [medium](https://medium.com/@rahulnakeel9898/abi-stability-3ed7f3f84177)
