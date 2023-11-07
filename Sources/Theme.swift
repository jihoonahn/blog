extension Theme where Site == Blog {
    static var blog: Self {
        Theme(htmlFactory: BlogHTMLFactory())
    }
}
