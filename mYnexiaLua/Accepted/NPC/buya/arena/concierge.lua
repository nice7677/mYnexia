concierge = {

click = async(function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local opts = {}
	table.insert(opts, "Set HP MP distribution")
	table.insert(opts, "Rent a private arena")
	table.insert(opts, "Enter private arena")
	table.insert(opts, "Watch private arena")
	table.insert(opts, "Exit")
	
	menu = player:menuString("<b>[Concierge]\n\nWelcome to Buya arena, what can i help you?", opts)
	
	if menu == "Set HP MP distribution" then
		choice = player:menuString("<b>[Concierge]\n\nSelect status distribution", {"Normal", "HP +", "MP +"})
		if choice == "Normal" then
			player:dialogSeq({t, "<b>[Concierge]\n\nDisabled !"}, 1)
		elseif choice == "HP +" then
			player:dialogSeq({t, "<b>[Concierge]\n\nDisabled !"}, 1)
		elseif choice == "MP +" then
			player:dialogSeq({t, "<b>[Concierge]\n\nDisabled !"}, 1)
		end
	elseif menu == "Rent a private arena" then
		local p = {}
		table.insert(p, "15 Minutes - 250.000 coins")
		table.insert(p, "30 Minutes - 500.000 coins")
		table.insert(p, "1 Hour     - 1.500.000 coins")
		table.insert(p, "Exit")
		choice = player:menuString("How long do you want to rent this arena?", p)
		if choice == "15 Minutes - 250.000 coins" then
			player:dialogSeq({t, "<b>[Concierge]\n\nDisabled !"})
		elseif choice == "30 Minutes - 500.000 coins" then
			player:dialogSeq({t, "<b>[Concierge]\n\nDisabled !"})
		elseif choice == "1 Hour     - 1.500.000 coins" then
			player:dialogSeq({t, "<b>[Concierge]\n\nDisabled !"})
		end
	elseif menu == "Enter private arena" then
		player:dialogSeq({t, "<b>[Concierge]\n\nDisabled !"}, 1)
	elseif menu == "Watch private arena" then
		player:dialogSeq({t, "<b>[Concierge]\n\nDisabled !"}, 1)
	end
	
	
end)
}
	
	
	
rentArena = function(player, graphic, price)

	local price = tonumber(price)
	if price == 0 then return end
	if graphic == 0 then graphic = 0 end
	
	if price == 250000 then
		if player:removeGold(25000) == false then player:dialogSeq({graphic, "You don't have enough money!"}) return end
		for i = 1, 3 do
			if player.mapRegistry["arena_15_"..i] == 1 then
				player:dialogSeq({graphic, "<b>[Concierge]\n\nSorry, but there's no arena room left."}, 1)
				return
			else
				txt =      "<b>[Arena "..i.." - "..player.name.."]\n\n"
				txt = txt.."You must to enter arena lock pin!"
				txt = txt.."- Number only\n"
				txt = txt.."- Contains 6 digits numbers\n"
				txt = txt.."- DO NOT use 0 (zero) as first digit"
				player:dialogSeq({graphic, txt..""}, 1)
				input = player:input("Enter your arena lock pin: ")
				if string.len(tonumber(input)) == 6 then
					player.mapRegistry["arena_15_"..i] = player.ID
					player.mapRegistry["arena_15_"..i.."_pin"] = tonumber(input)
					player.mapRegistry["arena_15_"..i.."_timer"] = os.time()+900
					player:removeGold(250000)
					player:dialogSeq({graphic, "<b>[Concierge]\n\nPin registration success!\nPlease enter your arena."}, 1)
					return
				end
			end
		end

	elseif price == 500000 then
		if player:removeGold(50000) == false then player:dialogSeq({graphic, "You don't have enough money!"}) return end
		for i = 1, 3 do
			if player.mapRegistry["arena_30_"..i] == 1 then
				player:dialogSeq({graphic, "<b>[Concierge]\n\nSorry, but there's no arena room left."}, 1)
				return
			else
				txt =      "<b>[Arena "..i.." - "..player.name.."]\n\n"
				txt = txt.."You must to enter arena lock pin!"
				txt = txt.."- Number only\n"
				txt = txt.."- Contains 6 digits numbers\n"
				txt = txt.."- DO NOT use 0 (zero) as first digit"
				player:dialogSeq({graphic, txt..""}, 1)
				input = player:input("Enter your arena lock pin: ")
				if string.len(tonumber(input)) == 6 then
					player.mapRegistry["arena_30_"..i] = player.ID
					player.mapRegistry["arena_30_"..i.."_pin"] = tonumber(input)
					player.mapRegistry["arena_30_"..i.."_timer"] = os.time()+1800
					player:removeGold(500000)
					player:dialogSeq({graphic, "<b>[Concierge]\n\nPin registration success!\nPlease enter your arena."}, 1)
					return
				end
			end
		end	
	elseif price == 1500000 then
		if player:removeGold(1500000) == false then player:dialogSeq({graphic, "You don't have enough money!"}) return end
		for i = 1, 3 do
			if player.mapRegistry["arena_1_"..i] == 1 then
				player:dialogSeq({graphic, "<b>[Concierge]\n\nSorry, but there's no arena room left."}, 1)
				return
			else
				txt =      "<b>[Arena "..i.." - "..player.name.."]\n\n"
				txt = txt.."You must to enter arena lock pin!"
				txt = txt.."- Number only\n"
				txt = txt.."- Contains 6 digits numbers\n"
				txt = txt.."- DO NOT use 0 (zero) as first digit"
				player:dialogSeq({graphic, txt..""}, 1)
				input = player:input("Enter your arena lock pin: ")
				if string.len(tonumber(input)) == 6 then
					player.mapRegistry["arena_1_"..i] = player.ID
					player.mapRegistry["arena_1_"..i.."_pin"] = tonumber(input)
					player.mapRegistry["arena_1_"..i.."_timer"] = os.time()+3600
					player:removeGold(1500000)
					player:dialogSeq({graphic, "<b>[Concierge]\n\nPin registration success!\nPlease enter your arena."}, 1)
					return
				end
			end
		end
	end
end

	
	
	
	
	
	
	
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	