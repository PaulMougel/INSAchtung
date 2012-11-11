class CrashController
	activeRound: null
	constructor: (@controller) ->

	setActiveRound: (round) ->
		@activeRound = round

	checkForCrashes: (player) ->
		# Check for boundaries collisions
		if player.lastPos().x < @controller.bitmap.boundariesWidth or player.lastPos().x > @controller.bitmap.width - @controller.bitmap.boundariesWidth or player.lastPos().y < @controller.bitmap.boundariesWidth or player.lastPos().y > @controller.bitmap.height - @controller.bitmap.boundariesWidth
			@activeRound.notifyPlayerDeath(player)

		# Else
		#	Check for collisions in bitmap
		#	If Bonus
		#		Call bonus.play(player)
		#	Else 
		#		Notify controller (snake collision)