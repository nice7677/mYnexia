inventory = {

click = function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 2
	
	local txt
	local pc = Player(player.registry["on_page"])
	
	gfxClone(pc, npc)
	
	local opts = {}
	
	for i = 0, pc.maxInv do
		local inven = pc:getInventoryItem(i)
		
		if inven ~= nil then
			table.insert(opts, i.." - "..inven.name.."")
		end
	end
		
	table.insert(opts, "<< Back")
		
	txt =      "Gold         : "..format_number(pc.money).."\n"
	txt = txt.."Gold in bank : "..format_number(pc.bankMoney).."\n"
	txt = txt.."Location:\n"..pc.mapTitle.."("..pc.m..")\n"
	txt = txt.."X:"..pc.x.." , Y:"..pc.y..""		
		
	menu = player:menuString("<b>["..pc.name.."'s inventory]:\n"..txt.."", opts)
		
	if menu == "<< Back" then
		user_pages.click2(player, npc)
		
	elseif menu == i.." - "..inven.name.."" then
		ok = player:menuString("What to do with "..pc.name.."'s "..inven.name.." ?", {"Change", "Unequip", "Delete"})
		if ok ~= nil then
			player:popUp("Not implemented yet!")
		end
	end
end
}






















