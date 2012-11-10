class Bitmap
	constructor: (@width, @height, @boundariesWidth) ->
		@bitmap = new Array(@width*@height)
