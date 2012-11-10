class Bitmap
	constructor: (@width, @height) ->
		@bitmap = new Array(@width*@height)
	