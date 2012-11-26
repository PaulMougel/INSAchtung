# Base class for bonuses. 
# Bonus' intelligence should placed here to set boundaries between classes.
class Bonus
	constructor: (@player, @duration) ->

# This class represents natural holes when playing to allow other player to escape with.
class NoWall extends Bonus
	play: () ->
		--@duration
		@player.lastPos().action = ACTION.MOVE_TO

# Modifies the player's speed
class SpeedBoost extends Bonus
	constructor: (player, duration, @speedValue) ->
		super(player, duration)

		@player.speed += @speedValue

	play: () ->
		--@duration

		if @duration is 0
			@player.speed -= @speedValue

class DrawnBonus
	constructor: (@bonusType, @x, @y, @size, @color) ->
	paint: (painter) ->
		painter.paintBonus(@)