

target_do = {

cast = function(player, target)

	player.registry["target_do"] = target.ID
	player:sendAction(6, 20)
	target_do.click(player, npc)
	
end,


click = function(player, npc)

	pc = Player(player.registry["target_do"])
	
	if pc == nil then
		player:sendMinitext("Target not found!")
	return else
		gfxClone(pc, npc)
		player.dialogType = 2
		
		local opts = {}
		table.insert(opts, "Move Up")
		table.insert(opts, "Move Right")
		table.insert(opts, "Move Left")
		table.insert(opts, "Move Down")
		
		menu = player:menuString("<b>[Remote control]\n\nWhat to do?", opts)
		
		if menu ~= nil then
			if menu == "Move Up" then
				moveUp(pc)
			elseif menu == "Move Right" then
				moveRight(pc)
			elseif menu == "Move Left" then
				moveLeft(pc)
			elseif menu == "Move Down" then
				moveDown(pc)
			end
			pc:updateState()
			pc:talk(2, "Remoted")
		end
	end
end
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	