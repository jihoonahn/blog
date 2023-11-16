extension ElementDefinitions {
    enum Main: ElementDefinition { public static var wrapper = Node.main }
    enum Section: ElementDefinition { public static var wrapper = Node.section }
    enum ASide: ElementDefinition { public static var wrapper = Node.aside }
    enum Figure: ElementDefinition { public static var wrapper = Node.figure }
}

typealias Main = ElementComponent<ElementDefinitions.Main>
typealias Section = ElementComponent<ElementDefinitions.Section>
typealias ASide = ElementComponent<ElementDefinitions.ASide>
typealias Figure = ElementComponent<ElementDefinitions.Figure>
