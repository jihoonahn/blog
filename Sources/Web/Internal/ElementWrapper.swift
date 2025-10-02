import Foundation

struct ElementWrapper: Sendable {
    var wrappingElementName: String
    var deferredAttributes = [AnyAttribute]()
    var body: @Sendable (Component) -> Component
}

extension ElementWrapper {
    init(wrappingElementName: String) {
        self.wrappingElementName = wrappingElementName
        self.body = {
            Element(name: wrappingElementName, nodes: [
                Node<Any>.component($0)
            ])
        }
    }
}
