class Controller
	constructor: () ->
		@bitmap = new Bitmap(800, 800, 20)
		@painter = new Painter(@bitmap)
		@crashController = new CrashController(@, @bitmap)
		@players = [
			new Player("Greenlee", "green", [79, 80]),
			new Player("Pinkney", "pink", [75, 76])
		]

		@alivePlayers = []
		for player in @players
			@alivePlayers.push(player)

	notifyPlayerDeath: (deadPlayer) ->
		for player in @players
			if player isnt deadPlayer
				player.score += 1
			else
				tmp = new Array()
				for p in @alivePlayers
					if p isnt deadPlayer
						tmp.push(p)
				@alivePlayers = tmp

	run: () ->
		@painter.paintBoundaries()

		delay = 1/30
		main = =>
			# Play turn
			for player in @alivePlayers

				# No wall will be painted
				if (Math.random()*10) < 0.015
					player.bonuses.push(new NoWall(25))

				player.play()
			
			# Collision detection
			for player in @alivePlayers
				@crashController.checkForCrashes(player)

			# Paint
			for player in @alivePlayers
				@painter.paintPlayer(player)

		setInterval(main, delay)