import Foundation
import Plot
import Publish

struct IndexProfile: Component {
    var context: PublishingContext<Blog>
    
    var body: Component {
        Div {
            H2("Profile").class("post-title")
            Div {
                
            }
        }
    }
}
