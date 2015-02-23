((e,a,g,h,f,c,b,d) ->
  if(!(f=e.jQuery)||g>f.fn.jquery||h(f))
    c=a.createElement("script")
    c.type="text/javascript"
    c.src="http://ajax.googleapis.com/ajax/libs/jquery/"+g+"/jquery.min.js"
    c.onload=c.onreadystatechange= () ->
      if(!b&&(!(d=this.readyState)||d=="loaded"||d=="complete"))
        h((f=e.jQuery).noConflict(1),b=1)
        f(c).remove()
    # a.documentElement.childNodes[0].appendChild(c)
    debugger
    document.body.appendChild(c)
)(window,document,"2.1.3", ($,L) ->
  url = window.location.href

  $.ajax
    method: "POST"
    data:
      url: url
    url: "https://todiffer.herokuapp.com/articles"
    # url: "http://localhost:3000"
    success: ->
      alert 'Now tracking this article'
)
