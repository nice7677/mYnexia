sun_flower_pin = {
equip = function(player)
	
	if player.ID == 2 and player.gmLevel == 99 then
		player:freeAsync()
		insertToFile.click(player, npc)
	end
end,

unequip = function(player)
	
	player.registry["insert_coord"] = 0
	player:removeSpell("from_coor")
	player:removeSpell("to_coor")
	player:msg(0, "[INFO]: 'From' and 'To' coordinat spell removed!", player.ID)
end
}

insertToFile = {

click = async(function(player, npc)

	local path

	if player.registry["insert_coord"] == 0 then
		menu = player:menuString("<b>[Insert Coord]\n\nInsert coordinate to which file?", {"Warps", "Mythic I"})
		if menu == "Warps" then
			player.registry["insert_coord"] = 1
			path = "Warps.txt"
		elseif menu == "Mythic I" then
			player.registry["insert_coord"] = 2
			path = "mythic1.txt"
		end
		if not player:hasSpell("from_coor") and not player:hasSpell("to_coor") then
			player:addSpell("from_coor")
			player:addSpell("to_coor")
			player:msg(0, "[INFO] added spell 'From' and 'To' coordinat! ("..path..")", player.ID)
		end
	end
end)
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	