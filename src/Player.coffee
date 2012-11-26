# represents a player in the game, considering his colour, his keys, his name
class Player
	constructor: (@name, @color, @keys, @constants, @painter) ->
		@score = 0

# represents the snake associated with a player during a specific round
class PlayerInstance
	constructor: (@static) ->
		@speed = @static.constants.playerSpeed
		@course = Math.floor((Math.random()*2*Math.PI)+0);
		@courseOffset = @static.constants.playerCourseOffset
		@size = @static.constants.playerSize
		@bonuses = []
		@positions = []
		@getFirstPosition()
		
		@noWallTime = new Date()
		@updateNoWallTime()

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

	getFirstPosition: () ->
		x = Math.round((Math.random() * (@static.constants.canvasSize - (@static.constants.boundariesWidth + @static.constants.canvasSize/8))) + @static.constants.boundariesWidth + @static.constants.canvasSize/8)
		y = Math.round((Math.random() * (@static.constants.canvasSize - (@static.constants.boundariesWidth + @static.constants.canvasSize/8))) + @static.constants.boundariesWidth + @static.constants.canvasSize/8)
		@positions.push(new Position(x, y, @size / 2, ACTION.MOVE_TO))

	updateNoWallTime: () ->
		@noWallTime = new Date()
		@noWallTime.setSeconds(@noWallTime.getSeconds() + Math.round((Math.random() * 4) + 1))

	play: () ->
		if (new Date() - @noWallTime) > 0
			@updateNoWallTime()
			console.log(Math.round(2 * @size / @speed))
			@bonuses.push(new NoWall(@, Math.ceil(2 * @size / @speed)))
		@updateCourse()
		@updatePos()
		@playBonuses()
		@paint()

	updatePos: () ->
		@positions.push(new Position(@lastPos().x + Math.cos(@course) * @speed, @lastPos().y + Math.sin(@course) * @speed, @size / 2, ACTION.LINE_TO))

	updateCourse: () ->
		if @lastKeyPressed is "left"
			val = - @courseOffset
		else if @lastKeyPressed is "right"
			val = @courseOffset
		else
			val = 0

		@course = @course + val

	paint: () ->
		@static.painter.paintLastPosition(@)
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
		@positions[@positions.length - 1 + index]