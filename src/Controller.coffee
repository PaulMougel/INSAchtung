class Controller
	constructor: () ->
		@canvasWidth = 800;
		@canvasHeight = 800;
		@boundariesWidth = 20
		@players = []
		@painter = new Painter(@)
		@crashController = new CrashController(@)
		@roundInProgress = false

	notifyRoundIsDone: () ->
		for player in @players
			console.log(player.name + ": " + player.score)
		@roundInProgress = false

	run: (playersConfiguration) ->
		@players = new Array()
		for player in playersConfiguration
			@players.push(new Player(player.name, player.colour, new Array(player.left, player.right), @painter))
		
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
			if player.score >= (@players.length - 1) * 10
				true
		false