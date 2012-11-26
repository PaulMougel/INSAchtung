ACTION = {
  MOVE_TO: 1, 
  LINE_TO: 2	
}

class Position
	constructor: (@x, @y, @radius, @action) ->

	collidesWith: (otherPos) ->
		@action is ACTION.LINE_TO and otherPos.action is ACTION.LINE_TO and Math.sqrt(Math.pow(@x - otherPos.x, 2) + Math.pow(@y - otherPos.y, 2)) <= @radius + otherPos.radius
