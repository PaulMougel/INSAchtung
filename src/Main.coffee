controller = new Controller()

playersConfiguration = new Array(
	{left: undefined, right: undefined, name: "Greenlee", colour: "green"},
	{left: undefined, right: undefined, name: "Greydon", colour: "grey"},
	{left: undefined, right: undefined, name: "Pinkney", colour: "pink"},
	{left: undefined, right: undefined, name: "Fred", colour: "red"},
	{left: undefined, right: undefined, name: "Bluebell", colour: "blue"},
	{left: undefined, right: undefined, name: "Willem", colour: "orange"},
)

window.setLeftKey = (button, playerIndex) ->
	document.onkeydown = (e) =>
		playersConfiguration[playerIndex].left = e.keyCode
		button.value = String.fromCharCode(e.keyCode)
		document.onkeydown = undefined
		
window.setRightKey = (button, playerIndex) ->
	document.onkeydown = (e) =>
		playersConfiguration[playerIndex].right = e.keyCode
		button.value = String.fromCharCode(e.keyCode)
		document.onkeydown = undefined

playerSelectionForm = document.getElementById("playerSelectionForm")
canvas = document.getElementById("canvas")

playerSelectionForm.onsubmit = (event) ->
	# Show canvas
	canvas.style.display = "block"
	
	# Clean the players configuration by removing players
	# without any keys associated
	cleanPlayersConfiguration = new Array()
	for playerConfiguration in playersConfiguration
		if playerConfiguration.left isnt undefined and playerConfiguration.right isnt undefined
			cleanPlayersConfiguration.push(playerConfiguration)

	# Run game
	controller.run(cleanPlayersConfiguration)

	# Hide form
	playerSelectionForm.style.display = "none"