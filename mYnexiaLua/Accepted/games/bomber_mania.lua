bomber_mania = {

click = async(function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local name = "<b>[Bomber mania]\n\n"
	local opts = {}
--	if player.gmLevel > 0 then table.insert(opts, "Set max players") end
	if not npc:hasDuration("bomber_mania") then table.insert(opts, "Play") end
	table.insert(opts, "How to play")
	table.insert(opts, "Leave map")
	table.insert(opts, "Exit")
	
	menu = player:menuString(t, name.."What can i help you kid?", opts)
	
	if menu == "How to play" then
		player:dialogSeq({t, name.."...",
						t, name.."...",
						t, name.."..."})
	elseif menu == "Play" then
		if not npc:hasDuration("bomber_mania") then npc:setDuration("bomber_mania", 60000) end
		player:dialogSeq({t, name.."Your name will registered as a bomber mania player's\nPlease wait until the game is starting or you can use 'return scroll' to leave this map. You will now warped to our waiting zone."}, 1)
		player:warp(player.m, math.random(15, 30), math.random(28, 40))
		player:msg(4, "[Bomber Mania] Please wait.. The game will start automatically in a few minutes.", player.ID)
		
	elseif menu == "Leave map" then
		player:warp(11, math.random(13, 14), 10)
		player:sendAnimation(16)
		player:playSound(29)
	
	elseif menu == "Set max players" then
		input = math.abs(tonumber(player:input("Enter max players to play : ("..npc.registry["max_players"]..")")))
		if input > 0 then
			npc.registry["max_players"] = input
			player:popUp("Max players for Bomber game : "..npc.registry["max_players"])
		end
	end

	
end),



uncast = function(player)

	local pc = player:getObjectsInMap(player.m, BL_PC)
	
	if #pc > 0 then
		for i = 1, #pc do
			if pc[i].x >= 9 and pc[i].x <= 38 then
				if pc[i].y >= 26 and pc[i].y <= 42 then
					bomber_mania.warp(pc[i])
				end
			end
		end
	end
end,

warp = function(player, npc)

	local x = {68, 75, 81}
	local y = {19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39}
	
	player:warp(player.m, x[math.random(#x)], y[math.random(#y)])
	player.state = 0 
	player:updateState()
	if not player:hasDuration("bomber_start") then npc:setDuration("bomber_start", 10000) end
	player:broadcast(player.m, "=== Bomber mania will start in 10 seconds ===")
end
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	