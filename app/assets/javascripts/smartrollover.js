function smartRollover(selector, method) {
  var images = $(selector);
  for (var i = 0, jj = images.length; i < jj; i++) {
    if (images[i].getAttribute("src").match("_off.")) {
      images[i].onmouseover = function() {
        this.setAttribute("src", this.getAttribute("src").replace("_off.", "_on."));
        if (typeof method === 'function'){
          method();
        }
      }
      images[i].onmouseout = function() {
        this.setAttribute("src", this.getAttribute("src").replace("_on.", "_off."));
//                if (typeof method === 'function'){
//                    method();
//                }
      }
    }
  }
}