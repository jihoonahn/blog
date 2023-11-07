extension ElementDefinitions {
    enum Main: ElementDefinition { public static var wrapper = Node.main }
    enum Section: ElementDefinition { public static var wrapper = Node.section }
    enum ASide: ElementDefinition { public static var wrapper = Node.aside }
}

typealias Main = ElementComponent<ElementDefinitions.Main>
typealias Section = ElementComponent<ElementDefinitions.Section>
typealias ASide = ElementComponent<ElementDefinitions.ASide>
