---
title: Scade introduce
date: 2023-03-17 21:24
tags: Swift, Cross Platform
description: There's a way to cross-platform with Swift?
---

오늘의 Post는 Swift로 CrossPlatform 개발이 가능하게 하는 Scade에 대한 소개글입니다.

### What is Scade?
Swift로 iOS 와 Android 개발을 동시에 할 수 있는 크로스 플랫폼입니다.

<img width = 100% src = "https://user-images.githubusercontent.com/68891494/225908911-ad6d8638-99a4-496e-ad4e-ccc62238fe81.png"></img>

[scade.io](https://www.scade.io)

전용 툴을 제공하며, 위 [링크](https://www.scade.io/download/)에서 다운 받을 수 있다. <br/>
Scade의 [공식문서](https://docs.scade.io/docs) 입니다.

---

### 어떻게 동작되는 걸까?
Swift코드를 네이티브 iOS와 Android를 바이너리로 컴파일하여, 앱을 빌드합니다. <br/>
현재 기준 Scade는 Swift 5.4를 지원합니다.
<img width = 100% src = "https://files.readme.io/448093c-scadecompiler.png"></img>

위 링크를 통해 전용 툴을 다운로드 받았다면
<img width=20% src = "https://user-images.githubusercontent.com/68891494/225911086-829ed397-231c-42f8-9286-30a14cea8887.png"></img>

이러한 어플리케이션을 확인할 수 있을겁니다.

그리고 Xcode와 AndroidStudio 설치까지 마치셨다면, [공식문서](https://docs.scade.io/docs/getting-started)를 보고 세팅해주시면 됩니다. 시작해 보겠습니다.

IDE 내부에서 FILE| Name | New Project 로 프로젝트를 생성해줍니다.

<img width=50% alt="스크린샷 2023-03-18 오후 3 38 06" src="https://user-images.githubusercontent.com/68891494/226089798-20eb3b08-1c00-4aef-9c32-88c18c04909e.png"></img>
<img width=50% alt="스크린샷 2023-03-18 오후 3 38 20" src="https://user-images.githubusercontent.com/68891494/226089897-4f4940d2-fc90-4e21-9da5-11f00456b2a4.png"></img>

Scade IDE에서 프로젝트를 생성해주면 됩니다.

