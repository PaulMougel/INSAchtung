all:
	coffee --join insachtung.js --compile Bitmap.coffee Painter.coffee Bonus.coffee Round.coffee Player.coffee Controller.coffee CrashController.coffee Main.coffee
watch:
	coffee --join insachtung.js --watch --compile Bitmap.coffee Painter.coffee Bonus.coffee Round.coffee Player.coffee Controller.coffee CrashController.coffee Main.coffee