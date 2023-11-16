function attachEvent(selector, event, fn) {
    const matches = typeof selector === 'string' ? document.querySelectorAll(selector) : selector;
    if (matches && matches.length) {
      matches.forEach((elem) => {
        elem.addEventListener(event, (e) => fn(e, elem), false);
      });
    }
}

window.onload = function() {
  let lastKnownInnerWidth = window.innerWidth
  let ticking = true;

  attachEvent('#mobileNavButton', 'click', function(_, elem) {
    document.body.classList.toggle('overflow-hidden');
    document.querySelector('#blogNavScreen')?.classList.toggle('hidden');
    document.querySelector('#mobileNavButton')?.classList.toggle('expanded');
  });

  function applyHeaderStylesOnResize() {
    if (lastKnownInnerWidth<768) {
      document.body.classList.remove('overflow-hidden');
      document.querySelector('#blogNavScreen')?.classList.add('hidden');
    }
  }

  applyHeaderStylesOnResize();
  window.addEventListener('resize', applyHeaderStylesOnResize);
};

window.onpageshow = function() {
    const navButton = document.getElementById('mobileNavButton');
    document.body.classList.remove('overflow-hidden');
    document.querySelector('#header nav')?.classList.add('hidden');
};
