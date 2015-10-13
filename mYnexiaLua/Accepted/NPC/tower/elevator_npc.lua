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
	
	menu = player:menuString("Elevator Operator", opts)
	
	if menu == "[GF] Lobby" then
		player.mapRegistry["lift_lobby"] = 1
		player.mapRegistry["lift_mod"] = 0
		player.mapRegistry["lift_bridge"] = 0
		player.mapRegistry["lift_meeting"] = 0
		player.mapRegistry["lift_gamecenter"] = 0
		player.mapRegistry["lift_gm_office"] = 0
		player.mapRegistry["lift_rooftop"] = 0
		player:dialogSeq({t, "[GF] Lobby"}, 1)
		
	elseif menu == "[3F] Moderator Office" then
		player.mapRegistry["lift_lobby"] = 0
		player.mapRegistry["lift_mod"] = 1
		player.mapRegistry["lift_bridge"] = 0
		player.mapRegistry["lift_meeting"] = 0
		player.mapRegistry["lift_gamecenter"] = 0
		player.mapRegistry["lift_gm_office"] = 0
		player.mapRegistry["lift_rooftop"] = 0
		player:dialogSeq({t, "[3F] Moderator Office"}, 1)
		
	elseif menu == "[4F] Bridge" then
		player.mapRegistry["lift_lobby"] = 0
		player.mapRegistry["lift_mod"] = 0
		player.mapRegistry["lift_bridge"] = 1
		player.mapRegistry["lift_meeting"] = 0
		player.mapRegistry["lift_gamecenter"] = 0
		player.mapRegistry["lift_gm_office"] = 0
		player.mapRegistry["lift_rooftop"] = 0
		player:dialogSeq({t, "[4F] Bridge"}, 1)
		
	elseif menu == "[5F] Meeting Room" then
		player.mapRegistry["lift_lobby"] = 0
		player.mapRegistry["lift_mod"] = 0
		player.mapRegistry["lift_bridge"] = 0
		player.mapRegistry["lift_meeting"] = 1
		player.mapRegistry["lift_gamecenter"] = 0
		player.mapRegistry["lift_gm_office"] = 0
		player.mapRegistry["lift_rooftop"] = 0
		player:dialogSeq({t, "[5F] Meeting Room"}, 1)
		
	elseif menu == "[6F] Game Center" then
		player.mapRegistry["lift_lobby"] = 0
		player.mapRegistry["lift_mod"] = 0
		player.mapRegistry["lift_bridge"] = 0
		player.mapRegistry["lift_meeting"] = 0
		player.mapRegistry["lift_gamecenter"] = 1
		player.mapRegistry["lift_gm_office"] = 0
		player.mapRegistry["lift_rooftop"] = 0
		player:dialogSeq({t, "[6F] Game Center"}, 1)
	elseif menu == "[PH] Game Master Office" then
		player.mapRegistry["lift_lobby"] = 0
		player.mapRegistry["lift_mod"] = 0
		player.mapRegistry["lift_bridge"] = 0
		player.mapRegistry["lift_meeting"] = 0
		player.mapRegistry["lift_gamecenter"] = 0
		player.mapRegistry["lift_gm_office"] = 1
		player.mapRegistry["lift_rooftop"] = 0
		player:dialogSeq({t, "[PH] Game Master Office"}, 1)
		
	elseif menu == "[RF] Rooftop" then
		player.mapRegistry["lift_lobby"] = 0
		player.mapRegistry["lift_mod"] = 0
		player.mapRegistry["lift_bridge"] = 0
		player.mapRegistry["lift_meeting"] = 0
		player.mapRegistry["lift_gamecenter"] = 0
		player.mapRegistry["lift_gm_office"] = 0
		player.mapRegistry["lift_rooftop"] = 1
		player:dialogSeq({t, "[RF] Rooftop"}, 1)
	end
end)
}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		