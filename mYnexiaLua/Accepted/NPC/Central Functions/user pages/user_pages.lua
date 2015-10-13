user_pages = {
click = function(player, npc)
	
	player.npcGraphic = 0
	player.npcColor = 0
	player.dialogType = 0
	
	local reg = Player(player.registry["on_page"])
	
	if player.registry["on_page"] == 0 then
		pc = player:input("Enter target name:")
		if Player(pc) ~= nil then
			player.registry["on_page"] = Player(pc).ID
			user_pages.click2(player, npc)
		else
			player:dialogSeq({"User not found!"})
			user_pages.click(player, npc)
		end
	else
		if reg ~= nil then
			user_pages.click2(player, npc)
		else
			pc = player:input("Enter Target name:")
			if Player(pc) ~= nil then
				player.registry["on_page"] = Player(pc).ID
				user_pages.click2(player, npc)
			else
				player:dialogSeq({"User not found!"})
				user_pages.click(player, npc)
			end
		end
	end
end,





click2 = function(player, npc)
	
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 2
	
	local pc = Player(player.registry["on_page"])
	
	if pc == nil then user_pages.click(player, npc) return end
	gfxClone(pc, npc)

	local opts = {}
	table.insert(opts, "Change Target - < "..pc.name.." >")
	table.insert(opts, "Status")
	table.insert(opts, "Give")
	table.insert(opts, "Take")	
	table.insert(opts, "Bank")
	table.insert(opts, "look")
	table.insert(opts, "Equipment")
	table.insert(opts, "Inventory")
	table.insert(opts, "Spell book")
	table.insert(opts, "Send message")
		
	txt =      "Gold         : "..format_number(pc.money).."\n"
	txt = txt.."Gold in bank : "..format_number(pc.bankMoney).."\n"
	txt = txt.."Location:\n		"..pc.mapTitle.."("..pc.m..")\n"
	txt = txt.."X:"..pc.x.." , Y:"..pc.y..""
	
	menu = player:menuString("<b>[User's Pages]\n"..txt.."", opts)
	 
	if menu == "Change Target - < "..pc.name.." >" then
		player.registry["on_page"] = 0
		user_pages.click(player, npc)
		
	elseif menu == "Status" then
		user_pages_status.click(player, npc)

	elseif menu == "Give" then
		give.click(player, npc)
		
	elseif menu == "Take" then
		user_pages_take.click(player, npc)

	elseif menu == "Bank" then
		bank.click(player, npc)		
		
	elseif menu == "look" then
		user_pages_status_look.click(player, npc)
		
	elseif menu == "Equipment" then
		user_pages_equipment.click(player, npc)	
		
	elseif menu == "Inventory" then
		inventory.click(player, npc)	
		
	elseif menu == "Spell book" then
		spell_book.click(player, npc)
		
	elseif menu == "Send message" then
		messages.click(player, npc)
	end
end
}
		



	














