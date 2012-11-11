class Painter
	constructor: (@bitmap) ->
		@canvas = document.getElementById("canvas")
		@context = @canvas.getContext('2d')

	paintPlayer: (player) ->
		# body
		if not Bonus.listContainsBonus(player.bonuses, NoWall)
			# paint trace
			@context.beginPath()
			@context.strokeStyle = player.static.color
			@context.lineWidth = player.size
			@context.moveTo(player.lastPos.x, player.lastPos.y)
			@context.lineTo(player.pos.x, player.pos.y)
			@context.stroke()

			# clear last head
			x = player.lastPos.x
			y = player.lastPos.y
			radius = (player.size / 2)
			startAngle = 0
			endAngle = (2 * Math.PI)
			anticlockwise = true
			@context.beginPath()
			@context.arc(x, y, radius, startAngle, endAngle, anticlockwise)
			@context.fillStyle = player.static.color
			@context.fill()

			# paint head
			x = player.pos.x
			y = player.pos.y
			radius = (player.size / 2)
			startAngle = 0
			endAngle = (2 * Math.PI)
			anticlockwise = true
			@context.beginPath()
			@context.arc(x, y, radius, startAngle, endAngle, anticlockwise)
			@context.fillStyle = "yellow"
			@context.fill()

	paintBonus: (bonus) ->

	paintBoundaries: () ->
		@context.strokeStyle = "yellow"
		@context.lineWidth = @bitmap.boundariesWidth
		@context.strokeRect(0, 0, @bitmap.width, @bitmap.height)

	paintUI: () ->
		
	clearBoard: () ->
		@context.clearRect(0, 0, @canvas.width, @canvas.height)