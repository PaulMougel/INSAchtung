# Bonus drawn on screen
#
# Contains its position, size and bonus type
# The bonus type is the class that will be instantiated when
# a player collides with it
class DrawnBonus
	constructor: (@bonusType, x, y) ->
		@color = @bonusType.color
		size = 10
		@pos = new Position(x, y, size, ACTION.LINE_TO)
	
	attachTo: (player) ->
		player.bonuses.push(new @bonusType(player, 60))

	paint: (painter) ->
		painter.paintBonus(@)

# Base class for bonuses. 
# Bonus' intelligence should placed here to set boundaries between classes.
class Bonus
	constructor: (@player, @duration) ->

# This class represents natural holes when playing to allow other player to escape with.
class NoWall extends Bonus
	play: () ->
		--@duration
		@player.lastPos().action = ACTION.MOVE_TO

# Speeds up the player !
class SpeedBoost extends Bonus
	@color = "yellow"

	constructor: (player, duration) ->
		super(player, duration)
		@speedValue = 1.5

		@player.speed *= @speedValue

	play: () ->
		--@duration

		if @duration is 0
			@player.speed /= @speedValue

# Slows down the player !
class SlowDown extends Bonus
	@color = "red"

	constructor: (player, duration) ->
		super(player, duration)
		@speedValue = 0.5

		@player.speed *= @speedValue

	play: () ->
		--@duration

		if @duration is 0
			@player.speed /= @speedValue

# Make the player fatter !
class BeFat extends Bonus
	@color = "green"

	constructor: (player, duration) ->
		super(player, duration)

		@sizeValue = 2
		@player.size *= @sizeValue

	play: () ->
		--@duration

		if @duration is 0
			@player.size /= @sizeValue