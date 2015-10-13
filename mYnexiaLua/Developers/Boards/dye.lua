dye = {

check = function(player)

	if player.ID == 91 then
		player.boardDel = 1
		player.boardWrite = 1
	else
		player:popUp("Test")
	end
	
end
}