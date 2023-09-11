---
title: Mach-O
date: 2022-10-23 11:00
tags: Swift, Theory
description: Mach-O에 대해서 배워봅시다.
postImage: https://user-images.githubusercontent.com/68891494/235434662-d39d802a-60c0-4965-8605-ff56e38b89d7.svg
---
오늘은 Mach-O에 대해서 배워볼 것입니다.
공부를 진행하는 도중 Mach-O에 대한 이야기가 많이 나오더라고요!

그래서 이번 기회에 깔끔하게 정리해보겠습니다!

일단 시작하겠습니다!

---

## Mach-O

Mach-O는 Apple OS에서 동작하는 컴파일된 프로그램에 대한 파일 포맷

- 오브젝트 파일(.o)
- 동적 라이브러리(.dylib)
- 정적 라이브러리(.a)
- 번들 (.bundle)
- 커널 익스텐션(.kext)
- 그외 (Core Dump, Framework...등등)

이런 파일 포맷들이 바로 Mach-O입니다..

그러면 Mach-O의 영역에 관해서 공부해봅시다.

## Mach-O 구조

<img width = 70%  src = "https://user-images.githubusercontent.com/68891494/202772719-547f0d38-83d5-4de0-aea8-1a6bb1133852.png"></img>

애플 플랫폼에서 컴파일된 모든 것들은 다음과 같은 Mach-O 구조를 가집니다.
(Header + Load Commands + Data)

---

Header, Load Command, Segment Data 영역으로 나뉘어 있습니다.

하나씩 봐봅시다.

## Mach-O Header

> 해당 Program이 실행될 수 있는 CPU 아키텍처, Excutable의 타입, 헤더 다음에 오는 Load Command의 갯수.. 등의 정보가 담겨 있습니다.


<img width = 80% src = "https://user-images.githubusercontent.com/68891494/229299955-01c6f433-4849-4b5b-9e2e-cf733715128e.png"></img>

예제를 봐봅시다.

DerivedData 폴더에 프로젝트에 대한 Executable 파일이 생성되어 있습니다. 

Mach-O 파일을 읽을 수 있게 otool이라는 Command Tool을 애플에서 제공합니다.

otool 만 작성하면 어떤 옵션이 있는지 알 수 있습니다.
