# Player
class Player
	constructor: (@name, @color, @keys) ->
		@pos = [Math.floor((Math.random()*700)+100), Math.floor((Math.random()*700)+100)]
		@lastPos = [undefined, undefined]
		@radius = 1
		@course = Math.floor((Math.random()*2*Math.PI)+0);
		@size = 5
		@state = []

		# Keys logic
		@keysPressed = [false, false]
		@lastKeyPressed = "none"
		document.onkeydown = (event) =>
			if event.keyCode is keys[0]
				@lastKeyPressed = "left"
				@keysPressed[0] = true

			else if event.keyCode is keys[1]
				@lastKeyPressed = "right"
				@keysPressed[1] = true
		document.onkeyup = (event) =>
			if event.keyCode is keys[0]
				@keysPressed[0] = false
				if @keysPressed[1]
					@lastKeyPressed = "right"
				else
					@lastKeyPressed = "none"
			if event.keyCode is keys[1]
				@keysPressed[1] = false
				if @keysPressed[0]
					@lastKeyPressed = "left"
				else
					@lastKeyPressed = "none"

	play: () ->
		@updateCourse()
		@updatePos()

	updatePos: () ->
		@lastPos[0] = @pos[0]
		@lastPos[1] = @pos[1]
		
		@pos[0] = @pos[0] + Math.cos(@course)*@radius
		@pos[1] = @pos[1] + Math.sin(@course)*@radius

	updateCourse: () ->
		if @lastKeyPressed is "left"
			val = - 2*Math.PI / 320
		else if @lastKeyPressed is "right"
			val = 2*Math.PI / 320
		else
			val = 0

		@course = @course + val
		if @course > 2*Math.PI
			@course -= 2*Math.PI