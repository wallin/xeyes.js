#= require jquery/jquery

Eyes = []

class Eye
  constructor: (@iris, @container)->
    @iRad = @iris.width() / 2
    @refresh()

  refresh: ->
    @w = @container.width()
    @h = @container.height()
    @pos = @container.offset()

  setFocusPoint: (x, y) ->
    dx = x - @pos.left - (@w/2)
    dy = y - @pos.top - (@h/2)

    R = Math.sqrt(dx*dx + dy*dy)
    x = if (R < @iRad) then dx else dx*@iRad/R;
    y = if (R < @iRad) then dy else dy*@iRad/R;

    @iris.css
      left: x + @w/2
      top: y + @h/2

$('.eye').each (i, el) ->
  $iris = $(el).find('.iris')
  Eyes.push new Eye($iris, $(el))

$(document).bind 'mousemove', (e) ->
  eye.setFocusPoint(e.pageX, e.pageY) for eye in Eyes

$(window).bind 'resize', ->
  eye.refresh() for eye in Eyes