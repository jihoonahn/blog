---
title: Copy On Write
date: 2023-2-15 22:52
tags: Swift, Theory, Memory
description: How can I save memory?
---

오늘은 COW (Copy On Write) 에 대해서 배워 볼 것입니다.
개발할 때 꼭 알아야 하는 지식이기 때문에, 이번에 정리해보려고 합니다.

이제 시작하겠습니다!

---

Swift 문서상에서는

> 복사를 즉각적으로 하지 않고, collection들은 값들이 저장된 메모리를 원본 객체와 복사본들끼리 공유합니다.
만약, collection의 복사본들중 하나가 변경되었다면, 수정되기 전에 복사됩니다.
