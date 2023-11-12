struct PostLayout: Component {
    var item: Item<Blog>
    var context: PublishingContext<Blog>

    var body: Component {
        Section {
            Article {
                
            }
            .class("block")
        }
    }
}
