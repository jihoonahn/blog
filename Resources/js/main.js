const menubutton = document.querySelector('.menu-bar');
const menu = document.querySelector('.nav');
const icon = document.querySelector('.social-links');

menubutton.addEventListener('click', () => {
    menu.classList.toggle('active');
    icon.classList.toggle('active');
});
