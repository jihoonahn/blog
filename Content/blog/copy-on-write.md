---
title: Copy On Write
date: 2023-2-15 22:52
tags: Swift, Theory, Memory
description: Copy On Write가 뭔지 알아봅시다.
postImage: https://user-images.githubusercontent.com/68891494/235434658-8439a3ff-288a-4c1b-bac2-eb7160144313.svg
---

오늘은 COW (Copy On Write) 에 대해서 배워 볼 것입니다.
개발할 때 꼭 알아야 하는 지식이기 때문에, 이번에 정리해보려고 합니다.

이제 시작하겠습니다!

---

Swift 문서상에서는

> 복사를 즉각적으로 하지 않고, collection들은 값들이 저장된 메모리를 원본 객체와 복사본들끼리 공유합니다.
만약, collection의 복사본들중 하나가 변경되었다면, 수정되기 전에 복사됩니다.

Swift에서 큰 값 타입의 데이터를 변수에 대입하거나 매개변수로 넘기게 되면 매우 비싼 복사 연산이 이루어집니다. 
이러한 이슈를 최소화 하기 위해서 Swift 표준 라이브러리는 배열과 같은 몇몇 값 타입에 대해 (두 개 이상의 참조가 있고 변형에 의해서만 복사가 일어납니다.)
하나의 참조만 있으면 복사가 아니라 해당 참조 내에서 값 변경이 일어나는 매커니즘을 설계했습니다. 

### Example

```swift
import Foundation

func address(o: UnsafeRawPointer) -> Int {
    return Int(bitPattern: o)
}

var value = [1,2,3]
var copyValue = value

print("value: \(address(o: &value))")
print("copyValue: \(address(o: &copyValue))")
```

Value Type은 값 복사가 기본적으로 이루어집니다.
예시 코드의 결과 값을 봐봅시다.

```plain
value: 105553140417888
copyValue: 105553140417888
Program ended with exit code: 0
```

결국에 Swift 문서에서 처럼 Collection들은 실제로 값이 바로 복사되지 않고 같은 공간을 share합니다.

```swift
copyValue.append(4)

print(" --> value: \(address(o: &value))")
print(" --> copyValue: \(address(o: &copyValue))")
```

변경이 일어났을때 바뀌게 되는지 확인해봅시다.

```plain
value: 105553140417888
copyValue: 105553150887520
```

Collection Type은 값이 바로 복사가 되지 않고 공유하다가 값의 변경 직전에 Copy되어서 두개로 분리 되는 것을 확인 할 수 있었습니다.

---

## OS에서 Copy On Write

OS에서는 Copy On Write가 보통 fock()를 수행할 때 적용됩니다.

<img width = 100% src = "https://www.cs.uic.edu/~jbell/CourseNotes/OperatingSystems/images/Chapter9/9_07_Page_C_Unmodified.jpg"></img>

process1 과 proccess2로 나누어져 있지만 fork() 개념을 사용하게 되면 process2는 process1의 child process가 될 것 입니다.
이 두개는 같은 영역의 resource를 공유하고 있습니다.

<img width = 100% src = "https://www.cs.uic.edu/~jbell/CourseNotes/OperatingSystems/images/Chapter9/9_08_Page_C_Modified.jpg"></img>

parent나 child쪽이 resource를 수정하게 되면 사진처럼 바뀌게 됩니다.
즉 수정된 page C(Copy of page C)를 proccess1이 점유하고 이에 대한 포인터도 기존의 page C를 가리키던 포인터를 Copy of page C를 가리키게끔 변경하면 이로써 Copy On Write가 적용이 됩니다.
