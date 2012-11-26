# Painter is a class that helps game's components to take advantage of the canvas.
# There is two canvas in the page, in order to draw separately persistent items in the first one and non-persistent ones in the second one.
# The second canvas is thus redrawn in each lap of Round.main() that calls @.getReadyForNewLap() and is used for snakes's heads and boundaries - that could blink, while the snakes's traces are drawn on the first one.
# In order to have no artefacts or bad paintings, the second canvas has a z-index greater than the first one.
class Painter
	constructor: (@controller) ->
		@layer1 = document.getElementById("layer1")
		@layer1.width = @controller.constants.canvasSize
		@layer1.height = @controller.constants.canvasSize
		@layer2 = document.getElementById("layer2")
		@layer2.width = @controller.constants.canvasSize
		@layer2.height = @controller.constants.canvasSize
		@context1 = @layer1.getContext('2d')
		@context2 = @layer2.getContext('2d')

		@clearBoard()
		@paintBoundaries()

	paintLastPosition: (player) ->
		if player.pos(0).action is ACTION.LINE_TO and player.pos(-1)
			@drawLine(@context1, player.pos(-1), player.pos(), player.size, player.static.color)

	paintHead: (player) ->
		@drawCircle(@context2, player.pos().x, player.pos().y, player.size / 2, "yellow")

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
		context.lineTo(targetPos.x, targetPos.y)

		context.stroke()

	paintBonus: (bonus) ->
		@drawCircle(@context2, bonus.x, bonus.y, bonus.size / 2, bonus.color)

	paintBoundaries: () ->
		@context2.fillStyle = "yellow"
		@context2.fillRect(0, 0, @layer2.width, @layer2.height)
		@context2.clearRect(@controller.constants.boundariesWidth, @controller.constants.boundariesWidth, @layer2.width - 2 * @controller.constants.boundariesWidth, @layer2.height - 2 * @controller.constants.boundariesWidth)

	clearBoard: () ->
		@context1.fillStyle = "black"
		@context1.fillRect(0, 0, @layer1.width, @layer1.height)
		@context2.clearRect(0, 0, @layer2.width, @layer2.height)

	getReadyForNewLap: () ->
		@paintBoundaries()