
from_coor = {
cast = function(player)
	
	local path
	if player.registry["insert_coord"] == 1 then
		path = "/root/mynexia/mYnexiaMaps/warps.txt"
	elseif player.registry["insert_coord"] == 2 then
		path = "/root/mynexia/mYnexiaMaps/mythic1.txt"
	end
	local file = io.open(path, "a+")
	local insert = player.m.. ",	" ..player.x.. ",	" ..player.y
	local t = "\n"
	
	if player.ID == 2 and player.gmLevel == 99 then
		player:sendAction(6, 20)
		player:talk(0, "-> From"..player.mapTitle.." ("..player.m.. "), X: " ..player.x.. ", Y: " ..player.y)
		file:write(insert)
		file:write(t)
		file:close()
		player:playSound(6)
		player:sendAnimationXY(228, player.x, player.y, 25)
		player:msg(4, "[INFO]: Insert (From) - "..player.mapTitle.." (" ..player.m.. "), X: " ..player.x.. ", Y: " ..player.y, player.ID)
	end
end
}
	
to_coor = {
cast = function(player)

	local path
	if player.registry["insert_coord"] == 1 then
		path = "/root/mynexia/mYnexiaMaps/warps.txt"
	elseif player.registry["insert_coord"] == 2 then
		path = "/root/mynexia/mYnexiaMaps/mythic1.txt"
	end
	local file = io.open(path, "a+")
	local insert = ",	"..player.m.. ",	" ..player.x.. ",	" ..player.y
	local t = "\n"
	
	if player.ID == 2 and player.gmLevel == 99 then
		player:sendAction(6, 20)
		player:talk(0, "To ->"..player.mapTitle.." ("..player.m.. "), X: " ..player.x.. ", Y: " ..player.y)
		file:write(insert)
		file:write(t)
		file:close()
		player:playSound(6)
		player:sendAnimationXY(235, player.x, player.y, 25)
		player:msg(4, "[INFO]: Insert (To) - "..player.mapTitle.." (" ..player.m.. "), X: " ..player.x.. ", Y: " ..player.y, player.ID)
	end
end
}