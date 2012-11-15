all:
	coffee --join static/lib/insachtung.js --compile src/Position.coffee src/Painter.coffee src/Bonus.coffee src/Round.coffee src/Player.coffee src/Controller.coffee src/CrashController.coffee src/Main.coffee
watch:
	coffee --join static/lib/insachtung.js --watch --compile src/Position.coffee src/Painter.coffee src/Bonus.coffee src/Round.coffee src/Player.coffee src/Controller.coffee src/CrashController.coffee src/Main.coffee