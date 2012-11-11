class Controller
	constructor: () ->
		@bitmap = new Bitmap(800, 800, 20)
		@painter = new Painter(@bitmap)
		@crashController = new CrashController(@)
		@players = [
			new Player("Greenlee", "green", [79, 80]),
			new Player("Pinkney", "pink", [75, 76])
		]

	notifyRoundIsDone: () ->
		for player in @players
			console.log(player.name + ": " + player.score)
		for player in @players
			if player.score >= (@players.length - 1) * 10
				return
		round = new Round(@)
		round.launch()

	run: () ->
		round = new Round(@)
		round.launch()