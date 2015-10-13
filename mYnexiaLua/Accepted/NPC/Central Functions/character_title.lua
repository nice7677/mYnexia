

character_title = {

click = function(player, npc)

	gfxClone(player, npc)
	
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 2
	
	local ti = {}
	if player.registry["show_title"] > 0 then table.insert(ti, "Hide Title") else table.insert(ti, "Show Title") end
	table.insert(ti, "Available Titles")
	table.insert(ti, "Exit")
		
	if player.registry["show_title"] > 0 then txt = "Enabled" else txt = "Disabled" end 
		
	title = player:menuString("<b>[Character Status]\n\nTitle  : "..player.title.."\n\nStatus : "..txt.."", ti)
	
	if title == "Hide Title" then
		player.registry["show_title"] = 0
		player:updateState()
		character_title.click(player, npc)
		
	elseif title == "Show Title" then
		player.registry["show_title"] = 1
		player:updateState()
		character_title.click(player, npc)
		
	elseif title == "Available Titles" then
	
		local av = {}
		table.insert(av, "Tester")
		table.insert(av, "Great")
		if player.ID == 2 then table.insert(av, "Oh my") end	
		
		ch = player:menuString("<b>[Character Status]\n\nYou can get title by finish quest or else.\n\nCurrent Title: "..player.title.."", av)
		
		if ch ~= nil then
			if ch == "Tester" then player.title = "Tester" end
			if ch == "Great" then player.title = "Great" end
			if ch == "Oh my" then player.title = "Oh my" end
			
			
			player:updateState()
			character_title.click(player, npc)
		end
	end


end
}	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	