

gm_tools = {

click = async(function(player, npc)
	
	local t
	
	if player.gfxClone == 0 then
		gfxClone(player, npc)
	else
		gfxLook(player, npc)
	end
	player.lastClick = npc.ID
	player.dialogType = 2
	
	t = "<b>[God tools]\n\n"
	t = t.."Location : "..player.mapTitle.."("..player.m..", "..player.x..", "..player.y..")\n"
	
	local opts = {}
	if player.ID == 2 or player.ID == 18 then table.insert(opts, "Extended tools") end
	table.insert(opts, "Character info")
	table.insert(opts, "GFX tools")
	table.insert(opts, "Spawn tools")
	table.insert(opts, "Warp tools")
	table.insert(opts, "Give")
	table.insert(opts, "Take")
	table.insert(opts, "Others")
	table.insert(opts, "Show developments board")
	
	menu = player:menuString(t, opts)
	
	if menu == "Character info" then
		if player.registry["character_info"] == 0 then
			target = string.lower(player:input("Enter the name of character:"))
			target = Player(target)
			if target == nil then player:popUp("User not found!") return end
			player.registry["character_info"] = target.ID
			gm_tools.character_info(player, npc)
		return else
			gm_tools.character_info(player, npc)
		end
	
	elseif menu == "GFX tools" then
		gm_tools.gfx_tools(player, npc)
		
	end
	
end),


character_info = function(player, npc)

	local target = Player(player.registry["character_info"])
	gfxClone(target, npc)
	player.lastClick = npc.ID
	player.dialogType = 2

	local opts = {}
	table.insert(opts, "Status")
	
	menu = player:menuString("What to do?", opts)
		

end,


gfx_tools = function(player, npc)

	local npc = NPC(66)
	gfxClone(player, npc)
	player.lastClick = npc.ID
	player.dialogType = 2
	
	local opts = {}
	if player.gfxClone == 1 then table.insert(opts, "Turn off GFX") else table.insert(opts, "Turn on GFX") end
	table.insert(opts, "Change GFX name")
	table.insert(opts, "<< Back")

	menu = player:menuString("What to do?", opts)
	
	if menu == "<< Back" then
		gm_tools.click(player, npc)
		
	end
	
end,


}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	