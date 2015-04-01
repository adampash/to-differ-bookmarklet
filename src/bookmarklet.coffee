((e,a,g,h,f,c,b,d) ->
  if(!(f=e.jQuery)||g>f.fn.jquery||h(f))
    c=a.createElement("script")
    c.type="text/javascript"
    c.src="http://ajax.googleapis.com/ajax/libs/jquery/"+g+"/jquery.min.js"
    c.onload=c.onreadystatechange= () ->
      if(!b&&(!(d=this.readyState)||d=="loaded"||d=="complete"))
        h((f=e.jQuery).noConflict(1),b=1)
        f(c).remove()
    document.body.appendChild(c)
)(window,document,"2.1.3", ($,L) ->
  injectStyles = (rule) ->
    div = $("<div />",
      html: '&shy;<style>' + rule + '</style>'
  ).appendTo("body")
  injectStyles('.mouseOn { background: #bcd5eb !important; outline: 2px solid #5166bb !important; }')

  injectStyles("""
    .content_check {
      z-index: 9999999999999999999;
      border: 5px solid #ddd;
      width: 600px;
      position: absolute;
      top: 50px;
      right: 0;
      left: 0;
      background: white;
      margin: 0 auto;
    }
    .content_check_container {
      width: 100%;
    }
  """)
  prevElement = null
  $(document).on 'mousemove', (e) ->
    elem = e.target || e.srcElement
    $el = $(elem)
    if (prevElement!= null)
      prevElement.classList.remove("mouseOn")
    elem.classList.add("mouseOn")
    # $(elem).on 'click', ->
    #   debugger
    #   selectors = getSelectors(@)
    # $(prevElement).off() if prevElement?
    # elem.addEventListener 'click', submitStory
    # prevElement.removeEventListener 'click', submitStory if prevElement
    prevElement = elem

  document.addEventListener('click', (e) ->
    $(document).off 'mousemove'
    $('.mouseOn').removeClass('.mouseOn')
    elem = e.target || e.srcElement
    # $(elem).on 'click', ->
    selectors = getSelectors(elem)
    submitStory selectors
  , true)

  getSelectors = (el) ->
    $el = $(el)
    selector = ""
    # selector += $el.parents()
    #             .map () -> @tagName.toLowerCase()
    #             .get().reverse().join(" ")

    if selector
      selector += " "+ $el[0].nodeName.toLowerCase()

    id = $el.attr("id")
    if id
      selector += "#"+ id

    classNames = $el.attr("class")
    if (classNames)
      selector += "." + $.trim(classNames).replace(/\s/gi, ".")

    selector = selector.replace('.mouseOn', '')
    selector

  submitStory = (selector) ->
    url = window.location.href
    $.ajax
      method: "POST"
      data:
        url: url
        selector: selector
        format: 'html'
      url: "https://text-fetch.herokuapp.com/"
      success: (result)->
        result = JSON.parse result
        console.log result
        content_div = $('<div class="content_check_container"><div class="content_check"></div></div>')
        $('.mouseOn').removeClass('mouseOn')
        content_div.find('.content_check').html(result.text.replace(/\n/g, "<br>"))
        $('body').append(content_div)

)
