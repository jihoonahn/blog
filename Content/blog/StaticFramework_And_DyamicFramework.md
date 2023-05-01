---
title: StaticFramework & DynamicFramework
date: 2022-10-24 16:17
tags: Swift, Framework, Theory
description: StaticFramework와 DynamicFramework의 차이점에 대해서 공부해봅시다.
postImage: https://user-images.githubusercontent.com/68891494/235434672-ac117359-08f8-4d32-bc53-ea5c124a0c8b.svg
---

오늘의 Post에서는 StaticFramework와 DynamicFramework 에 대해서 공부해 볼 것입니다.

Framework에 대해서 공부하던 중에, Static Framework와 Dynamic Framework는 완벽하게 숙지해야겠다 라는 생각이 들어서 바로 정리하게 되었습니다!

일단 시작해보겠습니다!

---

## Framework?
Framework는 Dynamic shared Library, nib File, Image File, localized strings, header files 및 reference 문서와 같이 공유 리소스를 패키지로 캡슐화 하는 계층 구조 파일 디렉토리를 이야기합니다. 그리고 Framework도 Bundle이며 NSBundle로 접근이 가능합니다. 또한 리소스 사본은 프로세스 수에 상관 없이 항상 물리적으로 메모리에 상주하며 리소스 공유로 풋 프린트를 줄이고 성능을 향상 시킵니다. 

## Dynamic Framework
<img width = 100% src = "https://user-images.githubusercontent.com/68891494/202763635-ff77e71c-10d7-4225-b23a-09c0385a52de.png"></img>

Xcode에서 Framework를 생성하면 Default로 DyamicFramework 로 생성이 됩니다. Dynamic Framework는 동시에 여러 프레임워크 또는 프로그램에서 동일한 코드사본을 공유하고 사용을 하므로, 메모리를 효율적으로 관리합니다. 동적으로 연결되어 있어, 전체 빌드를 하지 않아도 새로운 프레임워크가 사용이 가능합니다.
Static Linker를 통해 ``Dynamic Library Reference``가 어플리케이션에 들어가고 모듈 호출시 Stack에 있는 Library에 접근하여 사용합니다.
또한 여러 버전의 라이브러리가 존재할 수 있기 때문에 다음과 같은 symbolic links를 구성하기도 합니다.

<img width = 60% src = "https://minsone.github.io/image/2019/10/3.png"></img>

## Stactic Framework
<img width = 100% src = "https://user-images.githubusercontent.com/68891494/202765011-411d8cf4-3dce-45b7-adb4-82103c03337c.png">
</img>

Static Framework는 Static Linker를 통해 Static Library 코드가 어플리케이션 코드내로 들어가 Heap 메모리를 상주합니다. 따라서 Static Library가 복사가 되므로, Static Framework를 여러 Framework에서 사용하면 코드 중복이 발생합니다.

Library는 Framework가 아니라 Static Library가 복사된 곳에 위치하므로, Bundle 위치는 Static Framework가 아닌 Static Library가 위치하는 곳에 있게 됩니다. 그렇기 때문에 번들에 접근할 때에는 스스로 접근하는 것보다 외부의 Bundle의 위치를 주입받는 것이 좋습니다.

## 어떤 Mach-O Type을 선택해야 하나
- Dynamic Framework: 리소스를 가지고 있거나 전체 소스를 제공하는 경우 
- Static Framework: SDK 형태로 배포하는 경우
