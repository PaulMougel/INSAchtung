class Painter
	constructor: (@bitmap) ->
		@canvas = document.getElementById("canvas")
		@context = @canvas.getContext('2d')

	paintPlayer: (player) ->
		# addedCourse = (player.course > Math.PI and player.course < 2*Math.PI) ? -Math.PI/2 : Math.PI/2
		# circleCenterX = player.pos.x + Math.cos(player.course + addedCourse)*player.radius
		# circleCenterY = player.pos.y + Math.sin(player.course + addedCourse)*player.radius
		# startAngle = Math.acos((player.lastPos.x - circleCenterX) / player.radius)
		# endAngle = Math.acos((player.pos.x - circleCenterX) / player.radius)
		# context.arc(circleCenterX, circleCenterY, player.radius, startAngle, endAngle, false)

		# body
		if not Bonus.listContainsBonus(player.bonuses, NoWall)
			@context.beginPath()
			@context.strokeStyle = player.static.color
			@context.lineWidth = player.size
			@context.moveTo(player.lastPos.x, player.lastPos.y)
			@context.lineTo(player.pos.x, player.pos.y)
			@context.closePath()
			@context.stroke()

	paintBonus: (bonus) ->
	paintBoundaries: () ->
		@context.strokeStyle = "yellow"
		@context.lineWidth = @bitmap.boundariesWidth
		@context.strokeRect(0, 0, @bitmap.width, @bitmap.height)
	paintUI: () ->
	clearBoard: () ->
		@context.clearRect(0, 0, @canvas.width, @canvas.height)