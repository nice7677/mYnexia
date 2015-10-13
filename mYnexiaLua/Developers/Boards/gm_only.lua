gm_only = {
check = function(player)
	if player.gmLevel == 99 and player.ID == 2  then
		player.boardWrite = 1
		player.boardDel = 1
		player.pbColor = 1
	end
end
}

team_iseng_meeting = {
check = function(player)

	if player.gmLevel > 0 then
		player.boardWrite = 1
		player.boardDel = 1
		if player.ID == 2 then player.pbColor = 1 end
	end

	if player.registry["team_iseng"] > 0 then
		player.boardWrite = 1
		player.boardDel = 0
	end
end
}
	


team_iseng_dev = {
check = function(player)

	if player.gmLevel > 0 then
		player.boardWrite = 1
		player.boardDel = 1
		if player.ID == 3 or player.ID == 8 then player.pbColor = 1 end
	end

	if player.registry["team_iseng"] > 0 then
		player.boardWrite = 1
		player.boardDel = 0
	end
end
}
