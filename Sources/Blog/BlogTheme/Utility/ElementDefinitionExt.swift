import Plot

public extension ElementDefinitions {
    enum Main: ElementDefinition { public static var wrapper = Node.main }
    enum Section: ElementDefinition { public static var wrapper = Node.section }
}

public typealias Main = ElementComponent<ElementDefinitions.Main>
public typealias Section = ElementComponent<ElementDefinitions.Section>
