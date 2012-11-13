class Bitmap
	constructor: (@width, @height, @boundariesWidth) ->
		@bitmap = new Array(@width*@height)

	reset: () ->
		for i in [0 .. @width * @height]
			@bitmap[i] = undefined

	updatePlayer: (player) ->
		x = Math.floor(player.pos().x)
		y = Math.floor(player.pos().y)
		@bitmap[@width * y + x] = player