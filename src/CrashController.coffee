class CrashController
	activeRound: null
	constructor: (@controller) ->

	setActiveRound: (round) ->
		@activeRound = round

	checkForCrashes: (player) ->
		# Check for boundaries collisions
		if player.pos(-1).x < @controller.constants.boundariesWidth or player.pos(-1).x > @controller.constants.canvasSize - @controller.constants.boundariesWidth or player.pos(-1).y < @controller.constants.boundariesWidth or player.pos(-1).y > @controller.constants.canvasSize - @controller.constants.boundariesWidth
			@activeRound.notifyPlayerDeath(player)
		# Check for traces collisions
		else
			for otherPlayer in @activeRound.players
				if otherPlayer isnt player
					for position in otherPlayer.positions
						if player.pos().collidesWith(position)
							@activeRound.notifyPlayerDeath(player)
							return

			ignoreOwnPositions = true
			for i in [0..(player.positions.length - 1)]
				if ignoreOwnPositions and Math.sqrt(Math.pow(player.pos(-i).x - player.pos().x, 2) + Math.pow(player.pos(-i).y - player.pos().y, 2)) > player.pos(-i).radius + player.pos().radius
					ignoreOwnPositions = false
				if not ignoreOwnPositions
					if player.pos().collidesWith(player.pos(-i))
						@activeRound.notifyPlayerDeath(player)
						return