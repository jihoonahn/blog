import Plot

struct BasicScripts: Component {
    var body: Component {
        Script(
            .raw("""
            (function(){
                function attachEvent(selector, event, fn) {
                  const matches = typeof selector === 'string' ? document.querySelectorAll(selector)    : selector;
                  if (matches && matches.length) {
                    matches.forEach((elem) => {
                      elem.addEventListener(event, (e) => fn(e, elem), false);
                    });
                  }
                }
            
                window.onload = function() {
                  var host = window.location.host;
                  var pathname = window.location.pathname;
                  let lastKnownInnerWidth = window.innerWidth;
                  let ticking = true;
                
                  attachEvent('#mobileNavButton', 'click', function() {
                    document.body.classList.toggle('overflow-hidden');
                    document.getElementById('blogNavScreen')?.classList.toggle('hidden');
                    document.getElementById('mobileNavButton')?.classList.toggle('expanded');
                  });
                
                  attachEvent('.copyPost', 'click', function() {
                    var tempInput = document.createElement("input");
                    tempInput.value = host + pathname;
                    document.body.appendChild(tempInput);
                    tempInput.select();
                    tempInput.setSelectionRange(0, 99999);
                    document.execCommand("copy");
                    document.body.removeChild(tempInput);
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
            })();
            """)
        )
    }
}
