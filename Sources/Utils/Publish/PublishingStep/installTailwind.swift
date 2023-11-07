extension PublishingStep {
    static func installTailwind() -> Self {
        .installPlugin(
            .init(name: "Tailwind", installer: { context in
                let rootDirectory = try! AbsolutePath(validating: try context.folder(at: "/").path)
                try await tailwind.run(input: rootDirectory.appending(components: ["Style", "input.css"]),
                                       output: rootDirectory.appending(components: ["Output", "output.css"]))
                try await tailwind.initialize()
            })
        )
    }
}
