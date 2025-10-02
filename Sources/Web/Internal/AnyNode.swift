protocol AnyNode: Sendable {
    func render(into renderer: inout Renderer)
}
