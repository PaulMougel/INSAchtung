class CrashController
	activeRound: null
	constructor: (@controller) ->

	setActiveRound: (round) ->
		@activeRound = round

	checkForCrashes: (player) ->
		# Check for boundaries collisions
		if player.lastPos().x < @controller.bitmap.boundariesWidth or player.lastPos().x > @controller.bitmap.width - @controller.bitmap.boundariesWidth or player.lastPos().y < @controller.bitmap.boundariesWidth or player.lastPos().y > @controller.bitmap.height - @controller.bitmap.boundariesWidth
			@activeRound.notifyPlayerDeath(player)
		else
			# Check for collisions in bitmap
			x = Math.floor(player.pos().x)
			y = Math.floor(player.pos().y)

			if @controller.bitmap.bitmap[@controller.bitmap.width * y + x] isnt undefined
				console.log("collision !")

			#	If Bonus
			#		Call bonus.play(player)
			#	Else 
			#		Notify controller (snake collision)