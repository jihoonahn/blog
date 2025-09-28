import HomeIcon from "@components/Icons/HomeIcon.astro";
import PostIcon from "@components/Icons/PostIcon.astro";

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
        }
    ]
};