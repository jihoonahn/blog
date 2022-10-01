import Foundation
import Publish
import Plot

struct Blog: Website {
    typealias SectionID = <#type#>
    
    typealias ItemMetadata = <#type#>
    
    var name: String
    
    var description: String
    
    var language: Plot.Language
    
    var imagePath: Publish.Path?
    
     
}
