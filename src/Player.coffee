class Player
	constructor: (@name, @color) ->
		@score = 0
		@env = 
			positions: [],
			angle: 0,
			dead: true

	# pos() = pos(0) = current position
	# pos(-1) =  last position
	# etc.
	pos: (index = 0) ->
		@env.positions[@positions.length - 1 + index]

	addPosition: (position) ->
		@env.positions.push(position)

test_player = () ->
	player1 = new Player "Greydon", "grey"
	if player1.pos
		throw "Player's positions list not empty after instanciation"

	pos1 = new Position 0, 0, 1, ACTION.LINE_TO
	player1.addPosition pos1
	if player1.pos is not pos1
		throw "Position not added to Player"
	