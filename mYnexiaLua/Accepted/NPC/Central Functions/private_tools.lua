private_tools = {

click = function(player, npc)

	gfxClone(player, npc)
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 2
	
	local opts = {}
	if player.registry["click_by"]  == 0 then
		table.insert(opts, "Click: On")
	else
		table.insert(opts, "Click: Off")
	end
	
	if player.registry["being_approach"] == 0 then
		table.insert(opts, "Approach: On")
	else
		table.insert(opts, "Approach: Off")
	end
	
	if player.registry["being_summon"] == 0 then
		table.insert(opts, "Summon: On")
	else
		table.insert(opts, "Summon: Off")
	end
		
	if player.registry["immortal"] == 0 then
		table.insert(opts, "Immortality: On")
	else
		table.insert(opts, "Immortality: Off")
	end
	
	if player.registry["can_be_push"] == 0 then
		table.insert(opts, "Push: On")
	else
		table.insert(opts, "Push: Off")
	end
	
	table.insert(opts, "Exit")
	
	if player.registry["click_by"] == 0 then
		txt =      "Click       : Off \n"
	else
		txt =      "Click       : On \n"
	end
	
	if player.registry["being_approach"] == 0 then
		txt = txt.."Approach    : Off \n"
	else
		txt = txt.."Approach    : On \n"
	end
	if player.registry["being_summon"] == 0 then
		txt = txt.."Summon      : Off \n"
	else
		txt = txt.."Summon      : On \n"
	end
	if player.registry["can_be_push"] == 0 then
		txt = txt.."Pushed      : Off \n"
	else
		txt = txt.."Pushed      : On \n"
	end	
	if player.registry["immortal"] == 0 then
		txt = txt.."Immortality : Off \n"
	else
		txt = txt.."Immortality : On \n"
	end

	
	menu = player:menuString("<b>[Private tools]\n"..txt, opts)
	if menu ~= nil then
		if menu == "Approach: On" then
			player.registry["being_approach"] = 1
		elseif menu == "Approach: Off" then
			player.registry["being_approach"] = 0
			
			
		elseif menu == "Summon: On" then
			player.registry["being_summon"] = 1
		elseif menu == "Summon: Off" then
			player.registry["being_summon"] = 0
			
			
		elseif menu == "Immortality: On" then
			player.registry["immortal"] = 1
		elseif menu == "Immortality: Off" then
			player.registry["immortal"] = 0
			
			
		elseif menu == "Push: On" then
			player.registry["can_be_push"] = 1
		elseif menu == "Push: Off" then
			player.registry["can_be_push"] = 0
		
		elseif menu == "Click: On" then
			player.registry["click_by"] = 1
		elseif menu == "Click: Off" then
			player.registry["click_by"] = 0
		end
			
		private_tools.click(player, npc)
	end
end
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		