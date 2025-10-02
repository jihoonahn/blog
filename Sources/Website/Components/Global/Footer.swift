import Web

struct Footer: Component {
    
    var body: Component {
        Web.Footer {
            Div {
                Paragraph("© 2025 jihoon.me. All rights reserved.")
                    .class("text-neutral-400 text-sm")
            }
            .class("flex flex-row justify-center items-center px-4 py-2 rounded-full border border-neutral-800 bg-neutral-900/90 backdrop-blur-sm")
        }
        .class("left-0 right-0 flex justify-center items-center px-6 my-10 max-w-4xl mx-auto")
    }
}
