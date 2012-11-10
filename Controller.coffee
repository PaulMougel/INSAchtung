class Controller
	constructor: () ->
		@bitmap = new Bitmap(800, 800)
		@painter = new Painter(@bitmap)
		@crashController = new CrashController(@bitmap)
		@players = [
			new Player("Greenlee", "green", [79, 80]),
			new Player("Pinkney", "pink", [75, 76])
		]

	run: () ->
		@painter.paintBoundaries()

		delay = 1/30
		main = =>
			# Play turn
			for player in @players
				player.play()
			
			# Collision detection

			# Paint
			for player in @players
				@painter.paintPlayer(player)

		setInterval(main, delay)