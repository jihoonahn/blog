---
title: Hello Swift 6.0!
date: 2025-09-28
tags: swift, swift6, concurrency
image: https://picsum.photos/800/400?random=2
description: Swift 6.0의 새로운 기능과 strict concurrency를 살펴봅니다.
---

# Hello Swift 6.0!

Swift 6.0의 새로운 기능을 살펴보겠습니다.

## Strict Concurrency

Swift 6.0에서는 strict concurrency가 기본으로 활성화됩니다. 이를 통해 더 안전한 동시성 프로그래밍이 가능합니다.

```swift
actor Counter {
    private var value = 0

    func increment() {
        value += 1
    }

    func getValue() -> Int {
        return value
    }
}
```

## Sendable Protocol

`Sendable` 프로토콜을 사용하여 타입이 동시성 경계를 안전하게 넘어갈 수 있음을 표시할 수 있습니다.

```swift
struct Message: Sendable {
    let id: UUID
    let content: String
    let timestamp: Date
}
```

## 결론

Swift 6.0은 더 안전하고 현대적인 Swift 프로그래밍을 위한 훌륭한 업데이트입니다!
