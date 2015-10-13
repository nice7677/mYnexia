start_sumo = {

cast = function(player)

	player:sendAction(6, 20)
end,



click = async(function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local pc = player:getObjectsInMap(player.m, BL_PC)

	local opts = {}
	if player.registry["sumo_member"] > 0 then
		table.insert(opts, "Quit sumo")
	elseif player.registry["sumo_member"] == 0 then
		table.insert(opts, "Play sumo")
	end
	
	table.insert(opts, "Ranking")
	table.insert(opts, "How to play?")
	table.insert(opts, "Exit")
	
	menu = player:menuString("Hello, what can i help you?", opts)
	
	if menu == "Play sumo" then
		player.registry["sumo_member"] = 1
		player:dialogSeq({t, "Okay! go in!"},1)
		player:broadcast(1000, "== [Water sumo]: "..player.name.." has joined to play in water sumo !!")
		player:playSound(20)
		
	elseif menu == "Quit sumo" then
		player.registry["sumo_member"] = 0
		player:warp(1000, 65, 127)
		player:playSound(29)
		player:sendAnimation(16)
	end
	
	
end)
}
		
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
