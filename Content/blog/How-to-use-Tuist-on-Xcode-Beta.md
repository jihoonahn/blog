---
title: Xcode-Beta에서 Tuist 사용방법
date: 2023-6-10 00:03
tags: Swift, Tuist, Beta
description: Xcode Beta에서 Tuist를 사용방법에 대해서 알아봅시다.
postImage: https://github.com/Jihoonahn/Blog/assets/68891494/488897f3-ad98-472c-ac6b-10ebfc0a4a75.svg
---

오늘의 Xcode-Beta 버전에서 Tuist 사용방법에 대해서 막힌 부분과 해결방법에 대해서 이야기 해보려고 합니다.

일단 시작해보겠습니다!

---

## Beta를 사용했을때
최근에 WWDC23이 공개되었습니다. macOS에서 발표된 내용을 보고 macOS 14와 Xcode 15의 변화에 대해서 보기 위해서, 업데이트를 했습니다.

<img width="10%" src="https://github.com/Jihoonahn/Blog/assets/68891494/9042ff22-337c-459b-b01b-4ab7718c4bcd"></img>

그렇게 봉인된.. Xcode..

macOS 14에서는 기존 Xcode 14.3.1(글 작성 기준)를 사용하지 못하게 됩니다. <br/>
그래서 Xcode 15를 설치해야합니다. 

[Xcode 설치 링크](https://xcodereleases.com/)


## 어떤 문제가 있었나..
그렇게, Xcode 15를 설치하고 Tuist를 실행 했을 때, 이런 문제가 있더군요.
Tuist에서 ``tuist edit`` 명령어를 실행했을 때,

<img width="60%" src="https://github.com/Jihoonahn/Blog/assets/68891494/c22e5b50-273a-45ab-a96e-484d715b014a"></img>

이런 식으로 실행이 안되는 문제가 있었습니다. <br/>
이유는.. 위에서 빌드업 했지만, 문제는 [Tuist Command Service](https://github.com/tuist/tuist/blob/main/Sources/TuistKit/Services/EditService.swift) 부분에 있었습니다. <br/>


## 문제는 어디서?

<img width="80%"  src="https://github.com/Jihoonahn/Blog/assets/68891494/7455feac-8ad3-4877-968f-7675681f31d1"></img>

위 코드부분에서 에러가 발생합니다. <br/>
Xcode 앱을 실행시키는 코드이고, 현재 Xcode는 위 그림처럼 봉인(?)당했기 때문에 Xcode앱을 열 수 없는 것입니다. <br/>
나머지 명령어에서는 문제가 없었지만, ``tuist edit`` 명령어에서만 문제가 생기더라고요. <br/>
이 문제에 대한 해결 방법은 없을까요? <br/>


## 해결 방법

<img width="50%" src="https://github.com/Jihoonahn/Blog/assets/68891494/cd7a8e9c-59c0-435b-9ff2-bb124bb8d9f8"></img>

``tuist edit -h``를 실행시켜 명령어를 찾아봅시다.

Tuist 공식 깃허브 코드에서는 permanent가 true면, Xcode앱을 실행시키지 않습니다.

```swift
let workspacePath = try projectEditor.edit(
    at: path,
    in: path,
    onlyCurrentDirectory: onlyCurrentDirectory,
    plugins: plugins
)
logger.notice("Xcode project generated at \(workspacePath.pathString)", metadata: .success)
```

그렇기 떄문에, ``tuist edit --permanent`` 명령어를 실행하면?

<img width="80%" src="https://github.com/Jihoonahn/Blog/assets/68891494/f71302cb-91ad-4e0c-a665-52dde3574409"></img>

에러가 발생하여 동작이 실패하지 않고, 아래 처럼 프로젝트와 워크스페이스 파일이 생성됩니다.

<img width="80%" src="https://github.com/Jihoonahn/Blog/assets/68891494/21ac8d5b-9353-4d04-846f-edaa4103fc0d"></img>

이런식으로 진행이 됬다면, Manifests.xcworkspace 파일을 눌러서, tuist 프로젝트를 수정할 수 있습니다.
