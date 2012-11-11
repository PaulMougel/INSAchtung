# represents a player in the game, considering his coulour, his keys, his name
class Player
	constructor: (@name, @color, @keys) ->
		@score = 0

# represents the snake associated with a player during a specific round
class PlayerInstance
	constructor: (@static) ->
		@pos = {x: Math.floor((Math.random()*700)+100), y:Math.floor((Math.random()*700)+100)}
		@lastPos = {x: undefined, y: undefined}
		@radius = 1
		@course = Math.floor((Math.random()*2*Math.PI)+0);
		@size = 5

		# Keys logic
		@keysPressed = [false, false]
		@lastKeyPressed = "none"
		document.addEventListener("keydown",
			(event) =>
				if event.keyCode is @static.keys[0]
					@lastKeyPressed = "left"
					@keysPressed[0] = true

				else if event.keyCode is @static.keys[1]
					@lastKeyPressed = "right"
					@keysPressed[1] = true
		, false
		)
		document.addEventListener("keyup",
			(event) =>
				if event.keyCode is @static.keys[0]
					@keysPressed[0] = false
					if @keysPressed[1]
						@lastKeyPressed = "right"
					else
						@lastKeyPressed = "none"
				if event.keyCode is @static.keys[1]
					@keysPressed[1] = false
					if @keysPressed[0]
						@lastKeyPressed = "left"
					else
						@lastKeyPressed = "none"
		, false)

	play: () ->
		@updateCourse()
		@updatePos()

	updatePos: () ->
		@lastPos.x = @pos.x
		@lastPos.y = @pos.y
		
		@pos.x = @pos.x + Math.cos(@course)*@radius
		@pos.y = @pos.y + Math.sin(@course)*@radius

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