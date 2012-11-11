# Abstract class
class Bonus
	constructor: (@duration) ->

class NoWall extends Bonus
	play: (player) ->
		@duration -= 1