

state4_potion = {

use = function(player)
	
	player:sendAction(8, 20)
	player.state = 4
	player:updateState()
	player:sendMinitext("You're transformed to state 4!")
end
}


state0_potion = {

use = function(player)

	player:sendAction(8, 20)
	player.state = 0
	player:updateState()
	player:sendMinitext("You get in normal state (state 0)!")
end
}







