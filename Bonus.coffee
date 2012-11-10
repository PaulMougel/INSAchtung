# Abstract class
class Bonus
	constructor: (@duration) ->
	play: (player) ->
	@listContainsBonus: (bonusList, bonusClass) ->
		for bonus in bonusList
			if bonus instanceof bonusClass
				return true
		return false

class NoWall extends Bonus
	play: (player) ->
		@duration -= 1