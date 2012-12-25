all: test.js

test.js: ../src/Position.coffee ../src/Player.coffee test.coffee
	coffee --join test.js --compile ../src/Position.coffee ../src/Player.coffee test.coffee
	d8 test.js