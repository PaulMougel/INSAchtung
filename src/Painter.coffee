class Painter
	constructor: (@bitmap) ->
		@layer1 = document.getElementById("layer1")
		@layer2 = document.getElementById("layer2")
		@context1 = @layer1.getContext('2d')
		@context2 = @layer2.getContext('2d')

	paintLastPosition: (player) ->
		if player.positions[player.positions.length - 2]
			@drawLine(@context1, player.positions[player.positions.length - 2], player.lastPos(), player.size, player.static.color)

	paintHead: (player) ->
		@drawCircle(@context2, player.lastPos().x, player.lastPos().y, player.size / 2, "yellow")

	drawCircle: (context, x, y, radius, color) ->
		context.beginPath()
		context.arc(x, y, radius, 0, 2 * Math.PI, true)
		context.fillStyle = color
		context.fill()

	drawLine: (context, sourcePos, targetPos, width, color) ->
		context.beginPath()
		context.strokeStyle = color
		context.lineWidth = width
	
		context.moveTo(sourcePos.x, sourcePos.y)
		if targetPos.action is ACTION.LINE_TO
			context.lineTo(targetPos.x, targetPos.y)

		@context1.stroke()

	paintBoundaries: () ->
		@context2.fillStyle = "yellow"
		@context2.fillRect(0, 0, @bitmap.width, @bitmap.height)
		@context2.clearRect(@bitmap.boundariesWidth, @bitmap.boundariesWidth, @bitmap.width - 2 * @bitmap.boundariesWidth, @bitmap.height - 2 * @bitmap.boundariesWidth)

	clearBoard: () ->
		@context1.clearRect(0, 0, @layer1.width, @layer1.height)
		@context2.clearRect(0, 0, @layer2.width, @layer2.height)

	getReadyForNewLap: () ->
		@paintBoundaries()
