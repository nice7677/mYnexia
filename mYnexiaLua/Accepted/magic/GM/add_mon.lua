add_mon = {

click = function(player, npc)

	local opts = {}
	table.insert(opts, "Change mobID ("..player.registry["spawn_mob"]..")")
	table.insert(opts, "Exit")
	
	local reg = player.registry["spawn_mob"]
	
	if reg > 0 then
		mob = Mob(reg)
		local p = {graphic = convertGraphic(0, "monster"), color = 0}
		player.npcGraphic = p.graphic
		player.npcColor = p.color
	else
		local t = {graphic = convertGraphic(776, "monster"), color = 0}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
	end
	player.dialogType = 0
	menu = player:menuString("What to do?", opts)
	if menu == "Change mobID ("..player.registry["spawn_mob"]..")" then
		id = player:input("Enter mob ID : ")
		id = tonumber(id)
		if id ~= nil then
			player.registry["spawn_mob"] = id
			player:sendMinitext("Done!")
			add_mon.click(player, npc)
		end
	end
end,



equip = function(player)

--	if player.gmLevel > 0 then
		if not player:hasSpell("add_mon") then player:addSpell("add_mon") end	
		player:msg(4, "=== New spell & Option on F1npc added! ===", player.ID)
--	end
end,

unequip = function(player)

	if player:hasSpell("add_mon") then player:removeSpell("add_mon") end
	player:msg(4, "=== Spell & F1Npc removed! ===", player.ID)
end,

cast = function(player)

	local mob = player.registry["spawn_mob"]
	
	if mob > 0 then
		player:spawn(Mob(mob).id, player.x, player.y, 1)
		player:sendMinitext("Monster added!")
	else
		anim(player)
		player:msg(4, "Enter mobID to spawn from F1npc >> mob tools", player.ID)
	end
end
}

		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		