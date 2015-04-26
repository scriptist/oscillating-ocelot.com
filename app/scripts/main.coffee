requestAnimationFrame = do ->
	window.requestAnimationFrame       ||
	window.webkitRequestAnimationFrame ||
	window.mozRequestAnimationFrame    ||
	(callback) ->
		window.setTimeout(callback, 1000 / 60)


class Oscillator
	itemWidth: 140
	sinWidth: 4
	speed: 2
	constructor: (@parent) ->
		@start = @time()
		@sideCount = (@parent.offsetWidth - @itemWidth) / 2 // @itemWidth
		@build()
		@render()

	time: ->
		return (new Date()).getTime()

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
		offset = (@time() - @start) / 1000 * @speed;
		for item in @items
			pos = 30 * Math.sin ((item.i - offset) * Math.PI / @sinWidth)
			item.elm.style.transform = "translateY(#{pos}vh)";
		requestAnimationFrame @render

parent = document.getElementById 'put-the-ocelots-here'
parent && new Oscillator parent