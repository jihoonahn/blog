const menuButton = document.querySelectorAll('.getElementsByClassName');

function createBlogNavScreen() {
    document.body.style.overflow = 'hidden';
}

menuButton.forEach((element) => {
    element.addEventListener('click', createBlogNavScreen);
})

