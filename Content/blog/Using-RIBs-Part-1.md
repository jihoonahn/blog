---
title: RIBs 사용해보기 Part 1
date: 2022-10-27 14:05
tags: Swift, Architecture, RIBs, Actual Use
description: RIBs의 간단한 사용 방법에 대해서 알아봅시다.
---

저번 포스트에서는 RIBs에 대해서 이론을 공부했는데요!
이번 포스트에서는 RIBs의 실전으로 사용해보는 글입니다.

이전 포스트를 안읽으신 분은 [이전 글](https://blog.jihoon.me/posts/RIBs-Introduce)을 읽어주세요!

---

RIBs를 시작하기전에 [RIBs Template](https://github.com/uber/RIBs/tree/main/ios/tooling)를 설치해주세요!


Project를 생성해주고, RIBs를 SwiftPackageManager 로 추가해주도록 하겠습니다!

<img width="100%"  alt="my-option" src = "https://user-images.githubusercontent.com/68891494/198204193-93a77152-76e3-40ee-97ac-a2a0b0e57998.png"></img>

RIBs를 추가하면 RxSwift도 같이 온다는 것을 볼 수 있습니다. 

RIBs의 Package 파일을 보면
[RIBs Package](https://github.com/uber/RIBs/blob/main/Package.swift)

<img width="70%"  alt="my-option" src = "https://user-images.githubusercontent.com/68891494/198204978-6334786b-34c6-4e45-a346-8b5b4b1f87db.png"></img>

dependencies에서 RxSwift를 가져오는 것을 알 수 있습니다.
그리고 Target을 보면 RIBs가 RxSwift를 사용한다는 것을 확인할 수 있습니다.


RxSwift에 대한 글은 나중에 자세히 적도록 하겠습니다.

---

이제 본론으로 와서 시작하도록 하겠습니다.

Root 파일부터 만들고 시작하겠습니다. 설치한 Template으로 Root를 생성해줍니다.
<img width="50%" alt="my-option" src = "https://user-images.githubusercontent.com/68891494/198207168-2af3819a-d4aa-439f-a451-fa9752812598.png"></img>

* 저는 제가 직접 커스텀한 Template을 사용해서 조금 다를 수 있습니다.

생성을 하셨다면 이렇게 파일 4개가 만들어 질겁니다.
<img width=30% alt="my-option" src = "https://user-images.githubusercontent.com/68891494/198207667-88667f37-ee87-4aa0-a3d4-6e18b6b265d5.png"></img>

Root 생성후에 화면을 띄우는 작업을 하겠습니다.

일단 AppComponentFile을 생성해주세요.
그후에 일단 처음에는 빈 component를 생성해주겠습니다.

```swift
import RIBs

class AppComponent : Component<EmptyDependency>, RootDependency{
    init(){
        super.init(dependency: EmptyComponent())
    }
}
```

이후 설정을 위해서 SceneDelegate 파일로 이동해주세요! 
그리고 willConnectTo 메서드를 
```swift
private var launchRouter: LaunchRouting?

func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    if let windowScene = scene as? UIWindowScene {
          let window = UIWindow(windowScene: windowScene)
          self.window = window

          let launchRouter = RootBuilder(dependency: AppComponent()).build()
          self.launchRouter = launchRouter
          launchRouter.launch(from: window)
      }
}
```

이렇게 바꾸시면 됩니다. 하지만 현재는 build()부분에서 에러가 발생할 것입니다. 
build() 에러를 해결하시려면 RootBuilder 파일로 가시면 됩니다.

처음 Builder에서는 
```swift
func build(withListener listener: RootListener) -> RootRouting {
    let component = RootComponent(dependency: dependency)
    let viewController = RootViewController()
    let interactor = RootInteractor(presenter: viewController)
    interactor.listener = listener
    return RootRouter(interactor: interactor, viewController: viewController)
}
```
이렇게 생성되어 있습니다. 하지만 저희는 파라미터를 주지 않을 것입니다.

해결하는 방법으로  Buildable을 
```swift
protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}
```
이렇게 바꿔주고, Build 메서드도 
```swift
func build() -> LaunchRouting {
    let component = RootComponent(dependency: dependency)
    let viewController = RootViewController()
    let interactor = RootInteractor(presenter: viewController)
    return RootRouter(interactor: interactor, viewController: viewController)
}
```
이렇게 바꿔주면 됩니다. 다시 빌드를 돌려보면 RootRouter 부분에 에러가 발생할 것입니다.

RootRouter파일로 이동후 RootRouter도 기존 ViewableRouter로 되어 있는 부분을
```swift
final class RootRouter: ViewableRouter<RootInteractable, RootViewControllable>, RootRouting {
```
이렇게 바꿔주면 됩니다.
```swift
final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
```

이렇게 되면 RIBs 초기 Root 세팅은 완료가 되었습니다!

RootViewController로 이동해서
```swift
override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.white
}    
```
간단하게 잘 마무리가됬는지 확인하기 위해서 색상을 바꿔보겠습니다.
<img width="40%" src = "https://user-images.githubusercontent.com/68891494/198225700-53d5af41-9528-418e-b9c8-44c449fed831.png"></img>

Root 세팅하는것부터 시간이 어마어마하게 드네요 
이어서 작성하면 글이 계속 길어질 것 같아서 다음 글에서 이어서 적도록 하겠습니다!

### RIBs Part1 프로젝트 코드
이곳에서 지금까지 작성된 코드를 확인할 수 있어요!

[전체 코드](https://github.com/Jihoonahn/Blog-Documment/tree/main/Architecture/RIBs/RIBs-1)
