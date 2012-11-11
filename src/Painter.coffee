class Painter
	constructor: (@bitmap) ->
		@canvas = document.getElementById("canvas")
		@context = @canvas.getContext('2d')

	paintTrace: (player) ->
		@drawLine(player.lastPos.x, player.lastPos.y, player.pos.x, player.pos.y, player.size, player.static.color)
	
	clearTrace: (player) ->
		@drawLine(player.lastPos.x, player.lastPos.y, player.pos.x, player.pos.y, player.size, "white")

	paintHead: (player) ->
		@drawCircle(player.pos.x, player.pos.y, player.size / 2, "yellow")

	clearHead: (player) ->
		@drawCircle(player.pos.x, player.pos.y, player.size / 2, "white")

	paintLastHead: (player) ->
		@drawCircle(player.lastPos.x, player.lastPos.y, player.size / 2, player.static.color)

	clearLastHead: (player) ->
		@drawCircle(player.lastPos.x, player.lastPos.y, player.size / 2, "white")

	drawLine: (x1, y1, x2, y2, size, color) ->
		@context.beginPath()
		@context.strokeStyle = color
		@context.lineWidth = size
		@context.moveTo(x1, y1)
		@context.lineTo(x2, y2)
		@context.stroke()

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