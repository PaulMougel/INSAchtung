class CrashController
	constructor: (@controller, @bitmap) ->

	checkForCrashes: (player) ->
		# Check for boundaries collisions
		# 	If not player in map, notify controller
		# Else
		#	Check for collisions in bitmap
		#	If Bonus
		#		Call bonus.play(player)
		#	Else 
		#		Notify controller (snake collision)