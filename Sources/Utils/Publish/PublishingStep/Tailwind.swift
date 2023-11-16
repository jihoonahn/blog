extension PublishingStep where Site == Blog {
    static func tailwindcss() -> Self {
        .step(named: "Tailwind", body: { step in
            try shellOut(
                to: "./tailwindcss",
                arguments: [
                    "-i",
                    "./Sources/Styles/global.css",
                    "-o",
                    "./Output/styles.css"
                ]
            )
        })
    }
}
