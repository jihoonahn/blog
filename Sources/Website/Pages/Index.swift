import Web
import Generator

@HTMLBuilder
func index() -> HTML {
    let metadata = SiteMetaData()

    Layout(
        metadata: metadata
    ) {
        Main {
            // Coming Soon Section
            Div {
                Div {
                    H1("Coming Soon")
                        .class("text-4xl md:text-6xl font-bold text-center mb-6 text-white")
                    Paragraph("""
                        이 페이지는 현재 개발 중입니다. 
                        곧 멋진 콘텐츠로 찾아뵙겠습니다!
                    """)
                    .class("text-lg text-neutral-600 text-center max-w-2xl mx-auto leading-relaxed mb-8")
                }
                .class("max-w-2xl mx-auto px-6")
            }
            .class("min-h-screen flex items-center justify-center")
        }
        .class("min-h-screen")
    }
}
