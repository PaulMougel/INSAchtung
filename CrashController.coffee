class CrashController
	constructor: (@controller, @bitmap) ->

	checkForCrashes: (player) ->
		# Check for boundaries collisions
		# 	If not player in map, notify controller
		if player.pos.x < @bitmap.boundariesWidth or player.pos.x > @bitmap.width - @bitmap.boundariesWidth or player.pos.y < @bitmap.boundariesWidth or player.pos.y > @bitmap.height - @bitmap.boundariesWidth
			@controller.notifyPlayerDeath(player)

		# Else
		#	Check for collisions in bitmap
		#	If Bonus
		#		Call bonus.play(player)
		#	Else 
		#		Notify controller (snake collision)