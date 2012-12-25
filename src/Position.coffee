ACTION = {
  MOVE_TO: 1, 
  LINE_TO: 2	
}

class Position
	constructor: (@x, @y, @radius, @action) ->

	collides: (otherPos) ->
		@action is ACTION.LINE_TO and otherPos.action is ACTION.LINE_TO and Math.sqrt(Math.pow(@x - otherPos.x, 2) + Math.pow(@y - otherPos.y, 2)) <= @radius + otherPos.radius


test_position = () ->
	pos1 = new Position 0, 0, 0, ACTION.LINE_TO
	if pos1.collides pos1
		throw "Position with zero-radius collides with itself"

	pos2 = new Position 0, 0, 1, ACTION.LINE_TO
	if not pos2.collidespos2
		throw "Position with non-zero-radius doesn't collide with itself"

	pos3 = new Position 0, 0, 1, ACTION.MOVE_TO
	if pos3.collides pos3
		throw "Position with MOVE_TO action collides with itself"

	pos4 = new Position 0, 0, 1, ACTION.LINE_TO
	pos5 = new Position 0, 1, 1, ACTION.LINE_TO
	if not (pos4.collides pos5 and pos5.collides pos4)
		throw "Position doesn't collide with other position"