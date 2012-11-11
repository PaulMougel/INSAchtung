class Controller
	constructor: () ->
		@players
		@bitmap = new Bitmap(800, 800, 20)
		@painter = new Painter(@bitmap)
		@crashController = new CrashController(@)

	notifyRoundIsDone: () ->
		for player in @players
			console.log(player.name + ": " + player.score)
		for player in @players
			if player.score >= (@players.length - 1) * 10
				return
		round = new Round(@)
		round.launch()

	run: (playersConfiguration) ->
		@players = new Array()
		for player in playersConfiguration
			@players.push(new Player(player.name, player.colour, new Array(player.left, player.right), @painter))
		round = new Round(@)
		round.launch()