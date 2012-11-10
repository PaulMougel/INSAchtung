class Painter
	constructor: (@bitmap) ->
		@canvas = document.getElementById("canvas")
		@context = @canvas.getContext('2d')

	paintPlayer: (player) ->
		# addedCourse = (player.course > Math.PI and player.course < 2*Math.PI) ? -Math.PI/2 : Math.PI/2
		# circleCenterX = player.pos[0] + Math.cos(player.course + addedCourse)*player.radius
		# circleCenterY = player.pos[1] + Math.sin(player.course + addedCourse)*player.radius
		# startAngle = Math.acos((player.lastPos[0] - circleCenterX) / player.radius)
		# endAngle = Math.acos((player.pos[0] - circleCenterX) / player.radius)
		# context.arc(circleCenterX, circleCenterY, player.radius, startAngle, endAngle, false)

		# body
		@context.beginPath()
		@context.strokeStyle = player.color
		@context.lineWidth = player.size
		@context.moveTo(player.lastPos[0], player.lastPos[1])
		@context.lineTo(player.pos[0], player.pos[1])
		@context.closePath()
		@context.stroke()

	paintBonus: (bonus) ->
	paintBoundaries: () ->
		@context.strokeStyle = "yellow"
		@context.lineWidth = 20
		@context.strokeRect(0, 0, @bitmap.width, @bitmap.height)
	paintUI: () ->
	clearBoard: () ->
		@context.clearRect(0, 0, @canvas.width, @canvas.height)