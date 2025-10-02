struct ModifiedComponent: Component, Sendable {
    var base: Component
    var deferredAttributes = [AnyAttribute]()
    var environmentOverrides = [Environment.Override]()
    var body: Component { Node.modifiedComponent(self) }
}
