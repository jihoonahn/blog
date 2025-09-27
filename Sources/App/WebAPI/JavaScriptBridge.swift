import Foundation
import Domain

public class JavaScriptBridge {
    private let domManager: DOMManager
    
    public init(domManager: DOMManager) {
        self.domManager = domManager
    }
    
    public func setupBridge() {
        print("🌉 JavaScriptBridge: setupBridge called for SSG. No actual bridge setup.")
    }
}
