class Controller
	constructor: () ->
		@constants = {
			canvasSize: 0,
			boundariesWidth: 0,
			speed: 0,
			courseOffset: 0
		}
		@determineGraphicsConstants(@constants)

		@players = []
		@painter = new Painter(@)
		@crashController = new CrashController(@)
		@roundInProgress = false

	determineGraphicsConstants: (constants) ->
		if window.innerWidth < window.innerHeight
			constants.canvasSize = window.innerWidth
		else
			constants.canvasSize = window.innerHeight

		constants.boundariesWidth = constants.canvasSize / CONSTANTS.TRACE_FACTOR
		constants.playerSpeed = constants.canvasSize / CONSTANTS.FRAMERATE / CONSTANTS.TIME_TO_ROAD
		constants.playerCourseOffset = 2*Math.PI / CONSTANTS.FRAMERATE / CONSTANTS.TIME_TO_ROTATE
		constants.playerSize = constants.canvasSize / CONSTANTS.TRACE_FACTOR

	notifyRoundIsDone: () ->
		for player in @players
			console.log(player.name + ": " + player.score)
		@roundInProgress = false

	run: (playersConfiguration) ->
		for player in playersConfiguration
			@players.push(new Player(player.name, player.colour, new Array(player.left, player.right), @constants, @painter))
		
		document.addEventListener("keypress",
			(event) =>
				if event.keyCode is 32
					if @roundInProgress or @partyIsOver()
						return
					@roundInProgress = true
					round = new Round(@)
					round.launch()
		, false
		)

	partyIsOver: () ->
		for player in @players
			if player.score >= ((@players.length - 1) * 10)
				return true
		return false