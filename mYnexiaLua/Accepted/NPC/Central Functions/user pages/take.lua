user_pages_take = {

click = function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 2
	
	local opts = {}
	local txt
	local pc = Player(player.registry["on_page"])
	
	gfxClone(pc, npc)
	txt =      "Gold         : "..format_number(pc.money).."\n"
	txt = txt.."Gold in bank : "..format_number(pc.bankMoney).."\n"
	txt = txt.."Location:\n		"..pc.mapTitle.."("..pc.m..")\n"
	txt = txt.."X:"..pc.x.." , Y:"..pc.y..""
	
	table.insert(opts, "pilihan 1")
	table.insert(opts, "pilihan 2")
	table.insert(opts, "pilihan 3")	
	table.insert(opts, "<< Back")	

	menu = player:menuString("<b>[Take]\n"..txt.."", opts)
	
	------------------------------------------------------------------------------------------
	-- INFO:
	-- pc  =  si target  ,  cth usages : pc:sendMinitext("Hello")
	-- pilihan 1, 2, 3  =  pilihan ketika menu gold, gold in bank, location mncul
	--	
	
	
	
	
	
	if menu == "pilihan 1" then
	
	elseif menu == "pilihan 2" then
	
	elseif menu == "pilihan 3" then
	
	elseif menu == "<< Back" then
		user_pages.click(player, npc)
	end
	
	
	
end
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	