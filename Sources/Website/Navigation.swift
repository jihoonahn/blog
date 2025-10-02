import Web

struct NavigationItem {
    let name: String
    let href: String
    let icon: Component
}

let navigation = [
    NavigationItem(
        name: "Index",
        href: "/",
        icon: HomeIcon()
    ),
    NavigationItem(
        name: "Posts",
        href: "/posts",
        icon: PostIcon()
    ),
    NavigationItem(
        name: "About",
        href: "/about",
        icon: PersonIcon()
    )
]
