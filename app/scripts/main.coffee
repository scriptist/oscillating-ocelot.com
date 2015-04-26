requestAnimationFrame = do ->
	window.requestAnimationFrame       ||
	window.webkitRequestAnimationFrame ||
	window.mozRequestAnimationFrame    ||
	(callback) ->
		window.setTimeout(callback, 1000 / 60)


class Oscillator
	constructor: (@parent) ->
		@itemWidth = 140
		@sinWidth  = 3
		@speed     = 2

		@start     = @time()
		@sideCount = (@parent.offsetWidth - @itemWidth) / 2 // @itemWidth
		@build()
		@render()

	time: ->
		return (new Date()).getTime()

	setSinWidth: (val) ->
		val = parseFloat val || 3
		ratio = @sinWidth / val

		time = @time()
		@start = time - (time - @start) / ratio

		@sinWidth = val


	setSpeed: (val) ->
		val = parseFloat val || 2
		ratio = @speed / val
		@start = @start * ratio - @time() * (ratio - 1)
		@speed = val

	build: ->
		@items = []
		for i in [-@sideCount..@sideCount]
			elm = @buildItem i

			@items.push {i: i, elm: elm}

	buildItem: (position) ->
		item = document.createElement 'div'
		item.className = 'oscillator-item'
		item.style.marginLeft = position * @itemWidth + 'px'
		@parent.appendChild item
		return item

	render: =>
		offset = (@time() - @start) * @speed / 1000;
		for item in @items
			pos = 30 * Math.sin ((item.i - offset) * Math.PI / @sinWidth)
			item.elm.style.transform = "translateY(#{pos}vh)";
		requestAnimationFrame @render

parent = document.getElementById 'put-the-ocelots-here'
window.oscillator = new Oscillator parent