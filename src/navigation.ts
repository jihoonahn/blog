import HomeIcon from "@components/Icons/HomeIcon.astro";
import PostIcon from "@components/Icons/PostIcon.astro";
import PersonIcon from "@components/Icons/PersonIcon.astro";

export const navigation = {
    navigation: [
        {
            name: "Index",
            href: "/",
            icon: HomeIcon,
        },
        {
            name: "Posts",
            href: "/posts",
            icon: PostIcon,
        },
        {
            name: "About",
            href: "/about",
            icon: PersonIcon,
        }
    ]
};