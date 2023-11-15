function attachEvent(selector, event, fn) {
    const matches = typeof selector === 'string' ? document.querySelectorAll(selector) : selector;
    if (matches && matches.length) {
      matches.forEach((elem) => {
        elem.addEventListener(event, (e) => fn(e, elem), false);
      });
    }
}

window.onload = function() {
    attachEvent('#mobileNavButton', 'click', function(_, elem) {
        document.body.classList.toggle('overflow-hidden');
        document.getElementById("header")?.classList.toggle("blogMobileNav");
        document.querySelector("#header nav")?.classList.toggle("hidden");
    });
};

window.onpageshow = function() {
    const navButton = document.getElementById('mobileNavButton');
    document.body.classList.remove("overflow-hidden");
    document.getElementById("header")?.classList.remove("h-screen");
    document.querySelector("#header nav")?.classList.add("hidden");
};
