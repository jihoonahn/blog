function attachEvent(selector, event, fn) {
    const matches = typeof selector === 'string' ? document.querySelectorAll(selector) : selector;
    if (matches && matches.length) {
      matches.forEach((elem) => {
        elem.addEventListener(event, (e) => fn(e, elem), false);
      });
    }
}

window.onload = function() {
  let lastKnownInnerWidth = window.innerWidth;
  let ticking = true;

  attachEvent('#mobileNavButton', 'click', function() {
    document.body.classList.toggle('overflow-hidden');
    document.getElementById('blogNavScreen')?.classList.toggle('hidden');
    document.getElementById('mobileNavButton')?.classList.toggle('expanded');
  });

  function applyHeaderStylesOnResize() {
    if (lastKnownInnerWidth<768) {
      document.body.classList.remove('overflow-hidden');
      document.getElementById('blogNavScreen')?.classList.add('hidden');
      document.getElementById('mobileNavButton')?.classList.remove('expanded');
    }
  }

  applyHeaderStylesOnResize();
  window.addEventListener('resize', applyHeaderStylesOnResize);
};

window.onpageshow = function() {
  document.body.classList.remove('overflow-hidden');
  document.getElementById('header nav')?.classList.add('hidden');
};
