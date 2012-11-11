class CrashController
	activeRound: null
	constructor: (@controller) ->

	setActiveRound: (round) ->
		@activeRound = round

	checkForCrashes: (player) ->
		# Check for boundaries collisions
		if player.pos.x < ((@controller.bitmap.boundariesWidth / 2) / 2) or player.pos.x > @controller.bitmap.width - (@controller.bitmap.boundariesWidth / 2) or player.pos.y < (@controller.bitmap.boundariesWidth / 2) or player.pos.y > @controller.bitmap.height - (@controller.bitmap.boundariesWidth / 2)
			@activeRound.notifyPlayerDeath(player)

		# Else
		#	Check for collisions in bitmap
		#	If Bonus
		#		Call bonus.play(player)
		#	Else 
		#		Notify controller (snake collision)