class Bitmap
	constructor: (@width, @height, @boundariesWidth) ->
		@bitmap = new Array(@width*@height)

	reset: () ->
		for i in [0 .. @width * @height]
			@bitmap[i] = undefined

	updatePlayer: (player) ->
		centerX = Math.floor(player.pos().x)
		centerY = Math.floor(player.pos().y)

		for x in [centerX - player.size .. centerX + player.size]
			for y in [centerY - player.size .. centerY + player.size]
				if x < 0 or y < 0 or x > @width or y > @height
					continue

				distance = Math.sqrt(Math.pow(x - centerX, 2) + Math.pow(y - centerY, 2))
				course = Math.acos(Math.abs(x - centerX) / distance)

				if player.course - Math.PI/2 < course and course < Math.PI/2  + player.course
					if distance < player.size
						@bitmap[@width * y + x] = player
