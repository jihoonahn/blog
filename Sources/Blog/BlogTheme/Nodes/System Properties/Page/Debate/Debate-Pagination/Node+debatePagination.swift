import Foundation
import Publish
import Plot


extension Node where Context == HTML.BodyContext {
    static func debatePagination(numberOfPages: Int, activePage: Int, pageURL: (_ pageNumber: Int) -> String) -> Node {
        return List(1...numberOfPages) {
            
        }
    }
}
