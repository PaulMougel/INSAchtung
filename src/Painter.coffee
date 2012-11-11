class Painter
	constructor: (@bitmap) ->
		@canvas = document.getElementById("canvas")
		@context = @canvas.getContext('2d')

	paintPositions: (player) ->
		@context.beginPath()
		@context.strokeStyle = player.static.color
		@context.lineWidth = player.size

		for position in player.positions
			if position.action is ACTION.MOVE_TO
				@context.moveTo(position.x, position.y)
			else if position.action is ACTION.LINE_TO
				@context.lineTo(position.x, position.y)

		@context.stroke()

	paintHead: (player) ->
		@drawCircle(player.lastPos().x, player.lastPos().y, player.size / 2, "yellow")

	drawCircle: (x, y, radius, color) ->
		@context.beginPath()
		@context.arc(x, y, radius, 0, 2 * Math.PI, true)
		@context.fillStyle = color
		@context.fill()

	paintBoundaries: () ->
		@context.fillStyle = "yellow"
		@context.fillRect(0, 0, @bitmap.width, @bitmap.height)
		@context.clearRect(@bitmap.boundariesWidth, @bitmap.boundariesWidth, @bitmap.width - 2 * @bitmap.boundariesWidth, @bitmap.height - 2 * @bitmap.boundariesWidth)

	clearBoard: () ->
		@context.clearRect(0, 0, @canvas.width, @canvas.height)
		@paintBoundaries()