---
title: Publish 사용하기 part 2
date: 2023-10-26 14:48
tags: Swift, Publish, Web, Theory
description: Swift publish 커스텀하기
postImage: https://github.com/jihoonahn/blog/assets/68891494/0c4b40f7-bde3-4f90-ab09-60a3eca33476
---

## Publish 구조 작성하기

```swift
struct PublishHTMLFactory: HTMLFactory {
    typealias Site = Example

    func makeIndexHTML(for index: Publish.Index, context: Publish.PublishingContext<Example>) throws -> Plot.HTML {
        <#code#>
    }
    
    func makeSectionHTML(for section: Publish.Section<Example>, context: Publish.PublishingContext<Example>) throws -> Plot.HTML {
        <#code#>
    }
    
    func makeItemHTML(for item: Publish.Item<Example>, context: Publish.PublishingContext<Example>) throws -> Plot.HTML {
        <#code#>
    }
    
    func makePageHTML(for page: Publish.Page, context: Publish.PublishingContext<Example>) throws -> Plot.HTML {
        <#code#>
    }
    
    func makeTagListHTML(for page: Publish.TagListPage, context: Publish.PublishingContext<Example>) throws -> Plot.HTML? {
        <#code#>
    }
    
    func makeTagDetailsHTML(for page: Publish.TagDetailsPage, context: Publish.PublishingContext<Example>) throws -> Plot.HTML? {
        <#code#>
    }
}
```

이전 포스트에서 만든 `PublishHTMLFactory` 부분 부터 보도록 하겠습니다.

Publish에서 HTML 로 구조를 작성하기 위해서, [`Plot`](https://github.com/JohnSundell/Plot)이라는 JohnSundell이 만든 라이브러리를 사용합니다.

기존에는 
```swift
let html = HTML(
    .head(
        .title("My website"),
        .stylesheet("styles.css")
    ),
    .body(
        .div(
            .h1("My website"),
            .p("Writing HTML in Swift is pretty great!")
        )
    )
)
```

이런 방식으로 작성했지만, Plot이 업데이트 되면서, Component 프로토콜을 사용해서 Component 요소들을 SwiftUI와 유사한 방식으로 작성할 수 있습니다.

```swift
struct NewsArticle: Component {
    var imagePath: String
    var title: String
    var description: String

    var body: Component {
        Article {
            Image(url: imagePath, description: "Header image")
            H1(title)
            Span(description).class("description")
        }
        .class("news")
    }
}
```
이런 방식으로 말이죠

간단하게 알아 봤으니 한번 Publish에서 사용해보겠습니다.
먼저 가장 먼저 보일 부분인 Index 부분을 커스텀해보겠습니다.

```swift
func makeIndexHTML(for index: Index, context: PublishingContext<Example>) throws -> HTML {
    <#code#>
}
```

먼저 `HTML`이라는 구조체를 `makeIndexHTML` 메서드에 추가해줍니다.

```swift
func makeIndexHTML(for index: Index, context: PublishingContext<Example>) throws -> HTML {
    /// HTML 구조체 내에 node를 추가할 수 있는 형태
    HTML()

    /// HTML 구조체에 들어갈 head 부분이랑 body 부분을 init에서 분리해주는 형태
    HTML(head: [], body: {})
}
```
위 두가지 HTML 에서 하나를 선택해주시면 됩니다.
저는 위 방식으로 진행하도록 하겠습니다.

먼저 사용할 언어를 선택해줍니다.

```swift
func makeIndexHTML(for index: Index, context: PublishingContext<Example>) throws -> HTML {
    HTML(
        .lang(context.site.language) /// <html lang="$(main에서 설정한 언어)">
    )
}
```

Head에 필요한 정보들을 넣어줍니다. 저는 publish에서 제공해주는 head static 메서드를 통해서 구성해주도록 하겠습니다.
```swift
func makeIndexHTML(for index: Index, context: PublishingContext<Example>) throws -> HTML {
    HTML(
        .lang(context.site.language),
        .head(for: index, on: context.site)
    )
}
```
빌드를 돌리게 되면

<img width=80% src="https://github.com/jihoonahn/blog/assets/68891494/af1b26e6-2045-4775-bcae-877912ca7b84"></img>

이런식으로 Head 부분이 쉽게 구축이 된것을 확인 할 수 있습니다.
publish에서 제공하는 head 메서드는 저희가 따로 node로 넣어줄 필요없이 가장 자주 사용되는것들로 구성해 줍니다. 

하지만 웹에서는 /style.css에러가 발생합니다. 이 부분은 

```swift
static func head<T: Website>(
    for location: Location,
    on site: T,
    titleSeparator: String = " | ",
    stylesheetPaths: [Path] = ["/styles.css"],
    rssFeedPath: Path? = .defaultForRSSFeed,
    rssFeedTitle: String? = nil
) -> Node {}
```
head static 메서드가 선언된 부분을 보면 알 수 있습니다. <br/>
`stylesheetPath`에 내용이 들어가지 않기 때문에, 자동으로 style.css 부분을 넣어줘서, 현재는 style.css 파일이 없기 때문에 에러가 발생하는 것입니다.

```swift
.head(for: index, on: context.site, stylesheetPaths: [])
```

그래서 아직 stylesheet 넣지 않을것이라면 이런식으로 빈 배열로 값을 넣어주면 에러가 발생하지 않습니다.

그 다음은 Body 입니다. <br/>
Body 같은 경우도 node로 추가하는 방법도 있지만, 앞에서 말했던 Component를 사용해봅시다.

```swift
func makeIndexHTML(for index: Index, context: PublishingContext<Example>) throws -> HTML {
    HTML(
        .lang(context.site.language),
        .head(for: index, on: context.site),
        .body {}
    )
}
```

이번 Post에서는 JekyllTheme에 있는 [Bay](http://jekyllthemes.org/themes/bay/) 라는 테마를 클론해보면서 Publish 감을 잡아보도록 합시다.

<img width=100% src = "https://raw.githubusercontent.com/eliottvincent/bay/master/screenshot.png"></img>
