---
title: RIBs 사용해보기 Part 2
date: 2022-11-04 01:02
tags: Swift, Architecture, RIBs, Actual Use
description: RIBs의 간단한 사용 방법에 대해서 알아봅시다.
postImage: https://user-images.githubusercontent.com/68891494/235434680-57ac3fd0-05b5-405a-8478-3d4b9eac5715.svg
---

저번 포스트에서는 RIBs를 사용하기 위해서 세팅하는 법에 대해서 배웠습니다.
이번 포스트는 저번 글의 연장선입니다.

혹시 저번 글을 읽지 않으셨다면, [Using RIBs Part 1](https://blog.jihoon.me/posts/Using-RIBs-Part-1/) 을 먼저 보고 오시는 것이 도움될 것입니다.

그럼 다시 시작해보겠습니다

---

저희가 간단하게 구현할 앱입니다.
물론 오늘은 Onboarding이랑 Main만 연결할 것입니다.

<img width = 80% src = "https://user-images.githubusercontent.com/68891494/201262846-f5854953-aa3f-454f-b885-0fbc05ec7cc7.png"></img>


일단 Onboarding, Main RIB을 생성해줍니다.

<img width = 50% src = "https://user-images.githubusercontent.com/68891494/201261727-94182b2a-e39b-4937-9955-10a6950dee41.png"></img>

Root와 Main & Onboarding을 연결해주기 위해서 RootBuilder에서 작업을 해줍니다.

```swift
func build() -> LaunchRouting {
    let component = RootComponent(dependency: dependency)
    let viewController = RootViewController()
    let interactor = RootInteractor(presenter: viewController)
    let onboardingBuilder = OnboardingBuilder(dependency: component)
    let mainBuilder = MainBuilder(dependency: component)
    return RootRouter(interactor: interactor, viewController: viewController)
}
```

이렇게 하시면 
<img width="100%" src="https://user-images.githubusercontent.com/68891494/201265977-313c2925-3f3b-423f-bfae-d977929bb027.png"></img>
이러한 에러가 발생합니다.
에러가 발생하는 이유는 Component에서 MainDependency와 OnboardingDependency를 상속하지 않았기 때문에 발생합니다.

RootBuilder 파일 안에 있는 RootComponent에 MainDependency와 OnboardingDependency를 상속해줍니다.

```swift
extension RootComponent: MainDependency, OnboardingDependency {}
```

이러면 에러가 사라질 것입니다!

이후 RootRouter에서 각각 RIB의 Buildable과 Routing을 생성합니다.

```swift
final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    // MARK: - Onboarding
    private let onboardingBuilder: OnboardingBuildable
    private var onboardingRouter: OnboardingRouting?
    // MARK: - Main
    private let mainBuilder: MainBuildable
    private var mainRouter: MainRouting?
    
    init(
        onboardingBuilder: OnboardingBuildable,
        mainBuilder: MainBuildable,
        interactor: RootInteractable,
        viewController: RootViewControllable
    ) {
        self.mainBuilder = mainBuilder
        self.onboardingBuilder = onboardingBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
```

다시 Builder로 돌아와서 

```swift
func build() -> LaunchRouting {
    let component = RootComponent(dependency: dependency)
    let viewController = RootViewController()
    let interactor = RootInteractor(presenter: viewController)
    let onboardingBuilder = OnboardingBuilder(dependency: component)
    let mainBuilder = MainBuilder(dependency: component)
    return RootRouter(
        onboardingBuilder: onboardingBuilder,
        mainBuilder: mainBuilder,
        interactor: interactor,
        viewController: viewController
    )
}
```

RootRouter에 미리 만들어 놓은 Builder를 넘겨주시면 됩니다.

그다음.. (역시 RIBs는 세팅할게 많네요)

Root에서 Main, Onboarding 화면을 이동시켜보도록 하겠습니다.

Onboarding부터 attach 해보겠습니다.

```swift
protocol RootInteractable: Interactable, OnboardingListener, MainListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}
```
일단 시작하기 앞서, interactable 부분에 Listener를 상속 시킵니다.

그리고 Interactor에서 Routing에 무엇을 attach 할지, detach할지 적어줍니다.

```swift
protocol RootRouting: ViewableRouting {
    func attachOnboarding()
    func attachMain()
    func detachOnboarding()
    func detachMain()
}
```

그후 Attach 코드를 작성해주시면 됩니다.

```swift
func attachOnboarding() {
    guard onboardingRouting == nil else { return }
    let router = onboardingBuilder.build(withListener: interactor)
    let vc = router.viewControllable.uiviewController
    vc.modalTransitionStyle = .crossDissolve
    vc.modalPresentationStyle = .overFullScreen
    viewControllable.uiviewController.present(vc, animated: true)
    attachChild(router)
    self.onboardingRouting = router
}
```
그리고 Attach가 되었으면 detach도 시켜줘야겠죠?

```swift
func detachOnboarding() {
    guard let router = onboardingRouting else { return }
    viewController.uiviewController.dismiss(animated: true)
    self.onboardingRouting = nil
    detachChild(router)
}
```

자 이제 Router 부분은 끝난것 같네요!
이제 정말 실행되는지 확인해보겠습니다!

Interactor로 가셔서 

```swift
override func didBecomeActive() {
      super.didBecomeActive()
      router?.attachOnboarding()
}
```
이런식으로 테스트하겠습니다.

그냥 연결만 됬는지 확인하기 위해서 
Onboarding에서 background 색상을 바꿔보겠습니다.


[실행화면]

<img width = 30% src = "https://user-images.githubusercontent.com/68891494/201284305-3e750a12-3e62-4f19-8163-6fe4d3b3cedc.png">
</img>

일단 연결이 됬습니다!
글이 길어지는 관계로 다음 파트에서 작성하도록 하겠습니다!

[전체코드](https://github.com/Jihoonahn/Blog-Documment/tree/main/Architecture/RIBs/RIBs-2/ExRIBs)


[공지] RIBs example과 글 작성이 너무 오래 걸리는 관계로 RIBs 관련 글을 좀 미루려고 합니다 ㅎㅎ..
