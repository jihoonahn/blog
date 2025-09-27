import Foundation
import Domain

public struct Route {
    public let path: String
    public let handler: (String, [String: String]) async -> Void // path, params
    
    public init(path: String, name: String, handler: @escaping (String, [String: String]) async -> Void) {
        self.path = path
        self.handler = handler
    }
}

public class Router {
    private let domManager: DOMManager
    private let htmlRenderer: HTMLRenderer
    private let blogManager: BlogManager
    private var routes: [Route] = []
    
    public init(domManager: DOMManager, htmlRenderer: HTMLRenderer, blogManager: BlogManager) {
        self.domManager = domManager
        self.htmlRenderer = htmlRenderer
        self.blogManager = blogManager
    }
    
    public func addRoute(_ route: Route) {
        routes.append(route)
    }
    
    public func navigate(to path: String) async {
        print("Router: Navigating to \(path)")
        
        // Find matching route
        if let route = findRoute(for: path) {
            await route.handler(path, domManager.getQueryParams())
        } else {
            await handleNotFound(path)
        }
    }
    
    private func updateHistory(_ path: String) {
        print("Router: updateHistory called for SSG: \(path)")
    }
    
    // MARK: - Route Finding
    
    private func findRoute(for path: String) -> Route? {
        // Exact match first
        if let exactMatch = routes.first(where: { $0.path == path }) {
            return exactMatch
        }
        
        // Parameterized match
        for route in routes {
            let routeComponents = route.path.split(separator: "/")
            let pathComponents = path.split(separator: "/")
            
            guard routeComponents.count == pathComponents.count else { continue }
            
            var params: [String: String] = [:]
            var isMatch = true
            
            for (index, routeComponent) in routeComponents.enumerated() {
                let pathComponent = pathComponents[index]
                
                if routeComponent.hasPrefix(":") {
                    // This is a parameter
                    let paramName = String(routeComponent.dropFirst())
                    params[paramName] = String(pathComponent)
                } else if routeComponent != pathComponent {
                    // Mismatch
                    isMatch = false
                    break
                }
            }
            
            if isMatch {
                // For SSG, we don't actually use the params in the handler, but we can pass them.
                // The handler signature needs to be updated to accept params.
                return Route(path: route.path, name: route.path, handler: { _, _ in
                    await route.handler(path, params)
                })
            }
        }
        
        // Wildcard match
        return routes.first(where: { $0.path == "*" })
    }
    
    private func setupNavigationListener() {
        print("Router: setupNavigationListener called for SSG. No actual listener setup.")
    }
    
    // MARK: - Error Handling
    
    private func handleNotFound(_ path: String) async {
        print("Router: Route not found for path: \(path)")
        let content = htmlRenderer.renderErrorPage(
            title: "페이지를 찾을 수 없음",
            content: "<div class='error-page'><h1>404 - 페이지를 찾을 수 없습니다</h1><p>요청하신 페이지 '\(path)'를 찾을 수 없습니다.</p></div>"
        )
        let fullContent = htmlRenderer.renderLayout(title: "404 Not Found", content: content)
        // In SSG, this would typically mean generating a 404.html
        print("Generated 404 content for \(path): \(fullContent.prefix(100))...")
    }
}
