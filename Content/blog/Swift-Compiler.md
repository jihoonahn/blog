---
title: Swift Compiler
date: 2022-10-21 00:49
tags: Swift, Theory
description: Swift는 어떻게 컴파일 될까요?
---

오늘의 Post에서는 Swift Compiler 에 대해서 공부해 볼 것입니다.

일단 시작해보겠습니다!

---

Swift 툴체인의 중심에는 Swift Compiler가 존재합니다.

Swift Compiler의 책임은 소스 코드를 실행할 수 있는 Object 코드로 변경시킵니다.

### Data Flow 
Swift Compiler는 LLVM이라는 Compiler의 기본구조에서 동작하며, 다음과 같은 data flow를 구성합니다.

Swift와 같은 high-level 언어를 machine code로 변환하는 과정은 Lowering이라는 실제 하드웨어에서 효과적으로 동작합니다.

둥근 코너의 사각형과 일반 사각형은 데이터의 Input 과 output을 나타내며, high level에서 부터 각각의 단계를 이해하는데 많은 도움을 줄 것입니다.

<img width="50%"  alt="my-option" src="https://user-images.githubusercontent.com/68891494/196997871-4c97c0aa-c87a-475a-b79a-82b76d679bb7.png">
</img>

1. **Parse**: Swift 소스는 먼저 token들로 변환되고, AST(abstract syntax tree)에 들어가게 됩니다. <br/>
각각의 노드로 표현되는 트리라고 생각할 수 있습니다. <br/>
각 노드들은 소스들의 위치 정보를 함께 가지고 있기 떄문에 에러를 찾았을 때 각 노드는 정확하게 어디에서 문제가 발생했는지 말해줍니다. <br/><br/>

2. **Sematic Analysis(Sema)**: 해당 단계에서 컴파일러는 AST를 사용하여 프로그램의 의미를 분석합니다.
    해당 단계에서 type checking이 일어납니다. <br/>
    마찬가지로 AST를 사용하기 때문에 에러가 발생한 위치를 정확하게 짚어낼 수 있습니다. <br/>
    type check 완료 후 AST는 type-checked AST 상태가 되며, 이를 SILGen 단계로 전달하게 됩니다. <br/><br/>
    
3. **SILGen**: 이 단계는 해당 단계를 가지지 않는 Clang 처럼 이전 컴파일러 파이프라인에서 벗어납니다. <br/>
    AST는 ASL(Swift Intermediate Language)로 lowered 됩니다. SIL은 basic block을 가지고 있는데, 이는 Swift Type, RC, Dispatch rules들과 computation을 가지고 있습니다. <br/>
    SIL은 raw와 canonical 두가지 특색을 가지고 있습니다. Canonical SIL은 raw SIL의 최소한의 최적화를 통한(모든 최적화를 진행하지 않아도) 결과입니다. <br/>
    SIL은 또한 소스의 위치 정보를 가지고 있기 때문에 의미있는 에러를 제공합니다. <br/><br/>
    
4. **IRGen**: 이 도구는 SIL을 LLVM의 Intermediate Representation으로 lower 시킵니다. 이 시점의 instructions는 Swift만의 특성이 아닙니다. (모든 LLVM 기반은 이 representation을 사용합니다.) <br/>
    IR은 꽤 추상적입니다. SIL 처럼 IR은 Static Single Assignment(SSA) 형태입니다. <br/>
    IR은 무제한의 레지스터를 가진 machine처럼 모델링하고, 최적화를 찾기 쉽게 만듭니다. <br/>
    또한 Swift type과는 무관합니다. <br/><br/>
    
5. **LLVM(Low Level Virtual Machine)**: 최종 단계는 IR을 최적화 하고, 특정 플랫폼의 Machine의 명령어로 Lower를 진행합니다. <br/>
    백엔드(machine 명령어를 방출하는것)에는 ARM, x86, Wasm 등이 포함됩니다. <br/>
    위의 다이어그램은 Swift 컴파일러가 어떻게 object code를 생성하는지 보여줍니다. <br/>
    source code formatters, refactoring tools, documentation generators and syntax highlighters과 같은 도구들도 AST와 같은 중간 결과를 활용하여 최종 결과를 보다 견고하고 일관되게 만들 수 있습니다. <br/><br/>
