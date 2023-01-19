import Plot

public extension ElementDefinitions {
    enum Main: ElementDefinition { public static var wrapper = Node.main }
    enum Section: ElementDefinition { public static var wrapper = Node.section }
    enum ASide: ElementDefinition { public static var wrapper = Node.aside }
}

public typealias Main = ElementComponent<ElementDefinitions.Main>
public typealias Section = ElementComponent<ElementDefinitions.Section>
public typealias ASide = ElementComponent<ElementDefinitions.ASide>
