
elevator_npc = {

click = async(function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local opts = {}
	table.insert(opts, "[GF] Lobby")
	table.insert(opts, "[3F] Moderator Office")
	table.insert(opts, "[4F] Bridge")
	table.insert(opts, "[5F] Meeting Room")
	table.insert(opts, "[6F] Game Center")
	table.insert(opts, "[PH] Game Master Office")
	table.insert(opts, "[RF] Rooftop")
	
	menu = player:menuString(bold("[Elevator Operator]"), opts)
	
	if menu == "[GF] Lobby" then
		elevator_npc.destination(player, "lobby")
		player:dialogSeq({t, "[GF] Lobby"})
	elseif menu == "[3F] Moderator Office" then
		elevator_npc.destination(player, "mod")
		player:dialogSeq({t, "[3F] Moderator Office"})
	elseif menu == "[4F] Bridge" then
		elevator_npc.destination(player, "bridge")
		player:dialogSeq({t, "[4F] Bridge"})
	elseif menu == "[5F] Meeting Room" then
		elevator_npc.destination(player, "meeting")
		player:dialogSeq({t, "[5F] Meeting Room"})
	elseif menu == "[6F] Game Center" then
		elevator_npc.destination(player, "gamecenter")
		player:dialogSeq({t, "[6F] Game Center"})
	elseif menu == "[PH] Game Master Office" then
		elevator_npc.destination(player, "gmoffice")
		player:dialogSeq({t, "[PH] Game Master Office"})
	elseif menu == "[RF] Rooftop" then
		elevator_npc.destination(player, "rooftop")
		player:dialogSeq({t, "[RF] Rooftop"})
	end
end),

warp = function(player)

	if player.m == 10 then
		if player.x >= 6 and player.x <= 10 and player.y == 9 then
			if player.registry["lift_lobby"] == 1 then
				player:warp(9, 8, 4)
			elseif player.registry["lift_mod"] == 1 then
				player:popUp("Map is under construction!")
			elseif player.registry["lift_bridge"] == 1 then
				player:warp(12, 8, 3)
			elseif player.registry["lift_meeting"] == 1 then
				player:popUp("Map is under construction!")
			elseif player.registry["lift_gamecenter"] == 1 then
				player:warp(11, 8, 3)
			elseif player.registry["lift_gmoffice"] == 1 then
				player:popUp("Map is under construction!")
			elseif player.registry["lift_rooftop"] == 1 then
				player:popUp("Map is under construction!")
			end
		end
	end
end,

destination = function(player, dest)
	
	player.registry["lift_lobby"] = 0
	player.registry["lift_mod"] = 0
	player.registry["lift_bridge"] = 0
	player.registry["lift_meeting"] = 0
	player.registry["lift_gamecenter"] = 0
	player.registry["lift_gmoffice"] = 0
	player.registry["lift_rooftop"] = 0
	player.registry["lift_"..dest] = 1
end
}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		