const toggleBtn = document.querySelector('.site-home-nav-toggleBtn');
const menu = document.querySelector('.site-home-nav-menu');
const icon = document.querySelector('.site-home-nav-socialLinks');

toggleBtn.addEventListener('click', () => {
    menu.classList.toggle('active');
    icon.classList.toggle('active');
});

