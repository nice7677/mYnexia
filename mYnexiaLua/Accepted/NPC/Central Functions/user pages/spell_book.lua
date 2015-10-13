spell_book = {

click = function(player, npc)
		
	player:freeAsync()
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 2
	
	local pc = Player(player.registry["on_page"])
	
	gfxClone(pc, npc)
	
	local get
	local magic = pc:getSpellName()
	local yname = player:getSpellYName()
	local id = player:getSpells()
		
	menu = player:menuString("<b>["..pc.name.."'s Spell book]", magic)
	if menu ~= "" then
		for i = 1, #magic do
			if magic[i] == menu then
				get = i
				break
			end
		end
	end
	menu2 = player:menuString("<b>["..pc.name.."'s Spell book]\n\nDelete "..pc.name.."'s "..magic[get].."?", {"Yes", "No"})
	if menu2 == "Yes" then
		pc.registry["learned_"..yname[get]] = 0
		pc:removeSpell(id[get])
	end
end
}
	