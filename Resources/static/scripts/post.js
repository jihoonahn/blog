function attachEvent(selector, event, fn) {
  const matches = typeof selector === 'string' ? document.querySelectorAll(selector) : selector;
  if (matches && matches.length) {
    matches.forEach((elem) => {
      elem.addEventListener(event, (e) => fn(e, elem), false);
    });
  }
}

window.onload = function() {
  var host = window.location.host;
  var pathname = window.location.pathname;

  attachEvent('.copyPost', 'click', function() {
    var tempInput = document.createElement("input");
    tempInput.value = host + pathname;
    document.body.appendChild(tempInput);
    tempInput.select();
    tempInput.setSelectionRange(0, 99999);
    document.execCommand("copy");
    document.body.removeChild(tempInput);
  });
};
