print "Starting tests"

# Position
try
	print "Testing Position... "
	test_position
	print "OK"
catch e
	print "Failed (" + e + ")"

# Player
try
	print "Testing Player... "
	test_player
	print "OK"
catch e
	print "Failed (" + e + ")"

print "Tests finished"
