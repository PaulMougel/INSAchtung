class Round
	constructor: (@controller) ->
		@isOver = false
		@alivePlayers = []
		for player in @controller.players
			@alivePlayers.push(new PlayerInstance(player))
		@controller.crashController.setActiveRound(@)

	launch: () ->
		@controller.painter.clearBoard()
		@controller.painter.paintBoundaries()

		delay = 1/30
		main = =>
			if not @isOver
				# loop on this function until round is over
				setTimeout(main, delay)

				# Play turn
				for player in @alivePlayers

					# No wall will be painted
					#if (Math.random()*10) < 0.015
						#player.bonuses.push(new NoWall(25))

					player.play()
				
				# Collision detection
				for player in @alivePlayers
					@controller.crashController.checkForCrashes(player)

				# Paint
				for player in @alivePlayers
					@controller.painter.paintPlayer(player)

		setTimeout(main, delay)

	notifyPlayerDeath: (deadPlayer) ->
		for player in @alivePlayers
			if player isnt deadPlayer
				player.static.score += 1
			else
				tmp = new Array()
				for p in @alivePlayers
					if p is deadPlayer
						tmp.push(p)
				@alivePlayers = tmp
		if @alivePlayers.length is 1
			@isOver = true
			@controller.notifyRoundIsDone()
