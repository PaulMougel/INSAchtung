# Base class for bonuses. 
# Bonus' intelligence should placed here to set boundaries between classes.
class Bonus
	constructor: (@player, @duration) ->

# This class represents natural holes when playing to allow other player to escape with.
class NoWall extends Bonus
	play: () ->
		--@duration
		@player.lastPos().action = ACTION.MOVE_TO
