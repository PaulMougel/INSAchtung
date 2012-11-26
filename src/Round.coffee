class Round
	constructor: (@controller) ->
		@isOver = false
		@players = []
		for player in @controller.players
			@players.push(new PlayerInstance(player))
		@alivePlayers = @players.slice()
		@controller.crashController.setActiveRound(@)

	launch: () ->
		@controller.painter.clearBoard()

		delay = 1000 / CONSTANTS.FRAMERATE
		main = =>
			if not @isOver
				# loop on this function until round is over
				setTimeout(main, delay)

				@controller.painter.getReadyForNewLap()

				# Play turn
				for player in @alivePlayers
					player.play()
					# Collision detection
					@controller.crashController.checkForCrashes(player)

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
