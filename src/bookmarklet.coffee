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

  prevElement = null
  document.addEventListener('mousemove', (e) ->
    elem = e.target || e.srcElement
    $el = $(elem)
    if (prevElement!= null)
      prevElement.classList.remove("mouseOn")
    elem.classList.add("mouseOn")
    $(elem).on 'click', -> submitStory
    $(prevElement).off 'click', -> submitStory
    prevElement = elem
  ,true)
  # url = window.location.href

  submitStory = ->
    debugger
    $.ajax
      method: "POST"
      data:
        url: url
      url: "https://todiffer.herokuapp.com/articles"
      # url: "http://localhost:3000"
      success: ->
        alert 'Now tracking this article'

)
