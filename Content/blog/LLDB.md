---
title: LLDB
date: 2023-2-25 1:39
tags: Swift, Debugging, Theory, Actual Use
description: Debugging with LLDB
---

오늘의 Post에서는 LLDB 에 대해서 공부해 볼 것입니다.

더 LLDB를 잘 사용하기 위해서 이 글을 정리합니다.

일단 시작해보겠습니다!

---

## What is LLDB?

LLDB는 Low-Level Debbuger의 약자로 LLVM Debbuger 컴포넌트를 개발하는 애플의 서브 프로젝트이며, 우리가 사용하는 Xcode의 기본으로 내장되어 있는 디버거 입니다. <br/>
Xcode IDE의 Terminal에 곧바로 접근해서 실행중인 프로세스 값을 변경하거나, 흐름을 제어하는 등 다양한 디버깅 작업을 할 수 있습니다!


## And What is LLVM?
LLVM은 Low-level Virtual Machine의 약어로 LLVM은 intermediate / binary 기계 코드를 구성, 최적화 및 생성하는데 사용하는 라이브러리라고 생각하면 될것 같습니다. <br/>
추후 LLVM에 대한 자세한 포스트는 나중에 정리하겠습니다.


<br/>

## Commands
LLDB에서는 유용한 명령어가 많기 때문에 오늘은 무슨 명령어가 있는지 알아보겠습니다.

<img width = 100% src = "https://user-images.githubusercontent.com/68891494/221356567-0fcb2381-dfd9-459e-a2b4-bc11dfceb7e7.png"></img>

[Download full size version with this link](https://www.dropbox.com/s/9sv67e7f2repbpb/lldb-commands-map.png?dl=0)

<br/>


##### LLDB의 기초 문법
```
(lldb) command [subcommand] -option "this is argument"
```

- Command와 subCommand는 LLDB의 Object의 이름을 표기한다.
- LLDB동작은 Xcode에서 브레이크 포인트를 걸고 실행 시 콘솔 창에 (lldb)라는 단어가 보이게 되는데, 이곳에 command를 입력하면됩니다.



## Reference
- [lldb.llvm.org](https://lldb.llvm.org/)
- [Apple - LLDB Quick Start Guide](https://developer.apple.com/library/archive/documentation/IDEs/Conceptual/gdb_to_lldb_transition_guide/document/Introduction.html#//apple_ref/doc/uid/TP40012917-CH1-SW1)
