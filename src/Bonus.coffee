# Abstract class
class Bonus
	constructor: (@player, @duration) ->

class NoWall extends Bonus
	play: () ->
		--@duration
		@player.lastPos().action = ACTION.MOVE_TO