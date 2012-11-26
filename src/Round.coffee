class Round
	constructor: (@controller) ->
		@isOver = false
		@players = []
		for player in @controller.players
			@players.push(new PlayerInstance(player))
		@alivePlayers = @players.slice()

		@bonusesTypes = new Array(SpeedBoost, SlowDown)
		@activeDrawnBonuses = []

		@controller.crashController.setActiveRound(@)

	launch: () ->
		@controller.painter.clearBoard()

		delay = 1000 / CONSTANTS.FRAMERATE
		main = =>
			if not @isOver
				# loop on this function until round is over
				setTimeout(main, delay)

				@controller.painter.getReadyForNewLap()

				# Play players' turn
				for player in @alivePlayers
					player.play()
					# Collision detection
					@controller.crashController.checkForCrashes(player)
				
				# Draw bonuses
				for activeDrawnBonus in @activeDrawnBonuses
					activeDrawnBonus.paint(@controller.painter)

				# Add random bonuses
				if (Math.random() < 0.1)
					# Choose a new bonus
					bonusType = @bonusesTypes[Math.floor(Math.random() * @bonusesTypes.length)]
					x = Math.random() * @controller.constants.canvasSize
					y = Math.random() * @controller.constants.canvasSize
					@activeDrawnBonuses.push(new DrawnBonus(bonusType, x, y))

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

	notifyBonusCollision: (player, drawnBonus) ->
		# Delete the bonus from screen
		i = 0
		while (i < @activeDrawnBonuses.length)
			if @activeDrawnBonuses[i] is drawnBonus
				@activeDrawnBonuses.splice(i, 1)
			else
				i++
		
		# Attach behavior to player
		drawnBonus.attachTo(player)