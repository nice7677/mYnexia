

npc_castle_warp = {

click = async(function(player, npc)

    local t = { graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor }
    player.npcGraphic = t.graphic
    player.npcColor = t.color
    player.dialogType = 0
    
	local opts = {}
	table.insert(opts, "mY - castle")
	table.insert(opts, "mY - Clan's info")
	table.insert(opts, "Trinity War")
	table.insert(opts, "Exit")
	
	local health = player.maxHealth*.5
	local magic = player.maxMagic*.5

	menu = player:menuString("What can i help you?", opts)
	if menu == "mY - castle" then
		player:warp(20012,14,26)
		player:sendAnimation(121)
		player:playSound(80)
		player:addHealth(health)
		player:addMagic(magic)
	elseif menu == "mY - Clan's info" then
		player:dialogSeq({t, "Castle and Clan system are in progress, please be patient!"}, 1)
	elseif menu == "Trinity War" then
		x = math.random(60,70)
		y = math.random(76,83)
		player:warp(10012, x, y)
		player:sendAnimation(121)
		player:playSound(80)
		player:addHealth(health)
		player:addMagic(magic)		
	end
end)
}
























