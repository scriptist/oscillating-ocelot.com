requestAnimationFrame = do ->
	window.requestAnimationFrame       ||
	window.webkitRequestAnimationFrame ||
	window.mozRequestAnimationFrame    ||
	(callback) ->
		window.setTimeout(callback, 1000 / 60)


class Oscillator
	itemWidth: 140
	constructor: (@parent) ->
		@sideCount = (@parent.offsetWidth - @itemWidth) / 2 // @itemWidth
		@build()

	build: ->
		@items = []
		for i in [-@sideCount..@sideCount]
			item = @buildItem i

			@items.push item

	buildItem: (position) ->
		item = document.createElement 'div'
		item.className = 'oscillator-item'
		item.style.marginLeft = position * @itemWidth + 'px';
		@parent.appendChild item
		return item

parent = document.getElementById 'put-the-ocelots-here'
parent && new Oscillator parent