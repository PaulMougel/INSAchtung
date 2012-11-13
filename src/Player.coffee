# represents a player in the game, considering his coulour, his keys, his name
class Player
	constructor: (@name, @color, @keys, @painter) ->
		@score = 0

# represents the snake associated with a player during a specific round
class PlayerInstance
	constructor: (@static) ->
		@radius = 1
		@course = Math.floor((Math.random()*2*Math.PI)+0);
		@size = 5
		@bonuses = []
		@positions = [new Position(Math.floor((Math.random()*700)+100), Math.floor((Math.random()*700)+100), ACTION.MOVE_TO)]

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
		@playBonuses()
		@paint()

	updatePos: () ->
		@positions.push(new Position(@lastPos().x + Math.cos(@course) * @radius, @lastPos().y + Math.sin(@course) * @radius, ACTION.LINE_TO))

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
	paint: () ->
		@static.painter.paintPositions(@)
		@static.painter.paintHead(@)

	playBonuses: () ->
		i = 0
		while (i < @bonuses.length)
			if @bonuses[i].duration is 0
				@bonuses.splice(i, 1)
			else
				@bonuses[i].play()
				i++

	lastPos: () ->
		@pos()

	pos: (index = 0) ->
		# pos() = pos(0) = current position
		# pos(-1) =  last position
		# etc.
		@positions[@positions.length - 1 - index]