struct DetailLayout {
    let items: [Item<Blog>]
    let context: PublishingContext<Blog>
    
    public init(
        items: [Item<Blog>],
        context: PublishingContext<Blog>) {
        self.items = items
        self.context = context
    }
}
