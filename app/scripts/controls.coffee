supportsRange = do ->
	i = document.createElement 'input'
	i.setAttribute 'type', 'range'
	return i.type == 'range'


if supportsRange
	onInputChange = (e) ->
		if this.name == 'width'
			window.oscillator.setSinWidth this.value
		if this.name == 'speed'
			window.oscillator.setSpeed this.value


	controls = document.querySelector '.controls'
	controls.className += ' visible'

	for input in controls.querySelectorAll 'input'
		input.addEventListener 'change', onInputChange
		# input.addEventListener 'input', onInputChange