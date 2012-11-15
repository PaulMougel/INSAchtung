class CrashController
	activeRound: null
	constructor: (@controller) ->

	setActiveRound: (round) ->
		@activeRound = round

	checkForCrashes: (player) ->
		# Check for boundaries collisions
		if player.pos(-1).x < @controller.boundariesWidth or player.pos(-1).x > @controller.canvasWidth - @controller.boundariesWidth or player.pos(-1).y < @controller.boundariesWidth or player.pos(-1).y > @controller.canvasHeight - @controller.boundariesWidth
			@activeRound.notifyPlayerDeath(player)
		else
			for otherPlayer in @activeRound.players
				if otherPlayer isnt player
					for position in otherPlayer.positions
						if Math.sqrt(Math.pow(position.x - player.pos().x, 2) + Math.pow(position.y - player.pos().y, 2)) <= position.radius + player.pos().radius
							@activeRound.notifyPlayerDeath(player)
							return

			ignoreOwnPositions = true
			for i in [0..(player.positions.length - 1)]
				if ignoreOwnPositions and Math.sqrt(Math.pow(player.pos(-i).x - player.pos().x, 2) + Math.pow(player.pos(-i).y - player.pos().y, 2)) > player.pos(-i).radius + player.pos().radius
					ignoreOwnPositions = false
				if not ignoreOwnPositions
					if Math.sqrt(Math.pow(player.pos(-i).x - player.pos().x, 2) + Math.pow(player.pos(-i).y - player.pos().y, 2)) <= player.pos(-i).radius + player.pos().radius
							@activeRound.notifyPlayerDeath(player)
							return