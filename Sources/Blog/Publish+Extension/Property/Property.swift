import Plot
 
extension Attribute where Context == HTML.MetaContext {
    static func property(_ openGraphTag : String) -> Attribute {
        Attribute(name: "property", value: openGraphTag)
    }
}
