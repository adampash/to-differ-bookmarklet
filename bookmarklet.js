// Generated by CoffeeScript 1.8.0
(function() {
  (function(e, a, g, h, f, c, b, d) {
    if (!(f = e.jQuery) || g > f.fn.jquery || h(f)) {
      c = a.createElement("script");
      c.type = "text/javascript";
      c.src = "http://ajax.googleapis.com/ajax/libs/jquery/" + g + "/jquery.min.js";
      c.onload = c.onreadystatechange = function() {
        if (!b && (!(d = this.readyState) || d === "loaded" || d === "complete")) {
          h((f = e.jQuery).noConflict(1), b = 1);
          return f(c).remove();
        }
      };
      return document.body.appendChild(c);
    }
  })(window, document, "2.1.3", function($, L) {
    var getSelectors, injectStyles, prevElement, submitStory;
    injectStyles = function(rule) {
      var div;
      return div = $("<div />", {
        html: '&shy;<style>' + rule + '</style>'
      }).appendTo("body");
    };
    injectStyles('.mouseOn { background: #bcd5eb !important; outline: 2px solid #5166bb !important; }');
    injectStyles(".content_check {\n  z-index: 9999999999999999999;\n  border: 5px solid #ddd;\n  width: 600px;\n  position: absolute;\n  top: 50px;\n  right: 0;\n  left: 0;\n  background: white;\n  margin: 0 auto;\n}\n.content_check_container {\n  width: 100%;\n}");
    prevElement = null;
    $(document).on('mousemove', function(e) {
      var $el, elem;
      elem = e.target || e.srcElement;
      $el = $(elem);
      if (prevElement !== null) {
        prevElement.classList.remove("mouseOn");
      }
      elem.classList.add("mouseOn");
      return prevElement = elem;
    });
    document.addEventListener('click', function(e) {
      var elem, selectors;
      $(document).off('mousemove');
      $('.mouseOn').removeClass('.mouseOn');
      elem = e.target || e.srcElement;
      selectors = getSelectors(elem);
      return submitStory(selectors);
    }, true);
    getSelectors = function(el) {
      var $el, classNames, id, selector;
      $el = $(el);
      selector = "";
      if (selector) {
        selector += " " + $el[0].nodeName.toLowerCase();
      }
      id = $el.attr("id");
      if (id) {
        selector += "#" + id;
      }
      classNames = $el.attr("class");
      if (classNames) {
        selector += "." + $.trim(classNames).replace(/\s/gi, ".");
      }
      selector = selector.replace('.mouseOn', '');
      return selector;
    };
    return submitStory = function(selector) {
      var url;
      url = window.location.href;
      return $.ajax({
        method: "POST",
        data: {
          url: url,
          selector: selector,
          format: 'html'
        },
        url: "https://text-fetch.herokuapp.com/",
        success: function(result) {
          var content_div;
          result = JSON.parse(result);
          console.log(result);
          content_div = $('<div class="content_check_container"><div class="content_check"></div></div>');
          debugger;
          content_div.find('.content_check').html(result.text.replace(/\n/g, "<br>"));
          return $('body').append(content_div);
        }
      });
    };
  });

}).call(this);
