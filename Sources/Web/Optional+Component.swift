import Foundation

extension Optional: Renderable, Component where Wrapped: Component {
    public var body: Component {
        self?.body ?? EmptyComponent()
    }
}
