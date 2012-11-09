# Tests canvas
canvas = document.getElementById("canvas")
context = canvas.getContext('2d')

# Player
class Player
	constructor: () ->
		@lastPos = [200, 200]
		@pos = [200, 200]
		@radius = 1
		@course = Math.PI/4

		@keysPressed = [false, false]
		@lastKeyPressed = "none"

		document.onkeydown = (event) =>
			if event.keyCode in [79, 111]
				@lastKeyPressed = "left"
				@keysPressed[0] = true
			else if event.keyCode in [80, 112]
				@lastKeyPressed = "right"
				@keysPressed[1] = true

		document.onkeyup = (event) =>
			if event.keyCode in [79, 111]
				@keysPressed[0] = false
				if @keysPressed[1]
					@lastKeyPressed = "right"
				else
					@lastKeyPressed = "none"
			if event.keyCode in [80, 112]
				@keysPressed[1] = false
				if @keysPressed[2]
					@lastKeyPressed = "left"
				else
					@lastKeyPressed = "none"
	paint: () ->
		@updateCourse()
		@updatePos()

		context.beginPath()
		context.strokeStyle = "#FF0000"
		context.lineWidth = 5

		addedCourse = (@course > Math.PI and @course < 2*Math.PI) ? -Math.PI/2 : Math.PI/2
		circleCenterX = @pos[0] + Math.cos(@course + addedCourse)*@radius
		circleCenterY = @pos[1] + Math.sin(@course + addedCourse)*@radius
		startAngle = Math.acos((@lastPos[0] - circleCenterX) / @radius)
		endAngle = Math.acos((@pos[0] - circleCenterX) / @radius)
		
		#context.arc(circleCenterX, circleCenterY, @radius, startAngle, endAngle, false)

		context.moveTo(@lastPos[0], @lastPos[1])
		context.lineTo(@pos[0], @pos[1])

		context.closePath()
		context.stroke()
		#context.fill()

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
			console.log(@lastKeyPressed)
			val = 0

		@course = @course + val
		if @course > 2*Math.PI
			@course -= 2*Math.PI

p = new Player()

# boucle principale
delay = 1/30
main = ->
	# context.clearRect(0, 0, canvas.width, canvas.height)
	p.paint()
setInterval(main, delay)