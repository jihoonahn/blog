struct PostPage: Component {
    var item: Item<Blog>
    var context: PublishingContext<Blog>
    
    var body: Component {
        PostLayout(item: item, context: context)
    }
}
