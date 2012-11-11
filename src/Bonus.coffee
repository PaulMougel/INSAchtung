# Abstract class
class Bonus
	constructor: (@player, @duration) ->

class NoWall extends Bonus
	play: () ->
		@player.static.painter.clearTrace(@player)
		@player.static.painter.clearHead(@player)
		@player.static.painter.clearLastHead(@player)
		--@duration