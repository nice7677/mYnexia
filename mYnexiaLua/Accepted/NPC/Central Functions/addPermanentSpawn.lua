

addPermanentSpawn = {

click = function(player, npc)
	
	local t = {graphic = convertGraphic(776, "monster"), color = 0}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local opts = {}
	if player:hasSpell("addPermanentSpawn") and player:hasSpell("add_script") then
		table.insert(opts, "Delete spell")
		table.insert(opts, "Red script  : "..player.registry["red_script"])
		table.insert(opts, "Blue script : "..player.registry["blue_script"])
		table.insert(opts, "Green script : "..player.registry["green_script"])
		table.insert(opts, "Delete all items on ground")
		if player.registry["permanentSpawnStatus"] == 0 then table.insert(opts, "Active spell") else table.insert(opts, "Deactive spell") end		
	else
		table.insert(opts, "Get spell")
	end

	menu = player:menuString("Set mob to spawn for each script", opts)
	
	if menu == "Red script  : "..player.registry["red_script"] then
		mob = math.abs(tonumber(player:input("Enter mobID : ("..player.registry["red_script"]..")")))
		player.registry["red_script"] = mob
		addPermanentSpawn.click(player, npc)
		
	elseif menu == "Blue script : "..player.registry["blue_script"] then
		mob = math.abs(tonumber(player:input("Enter mobID : ("..player.registry["blue_script"]..")")))
		player.registry["blue_script"] = mob
		addPermanentSpawn.click(player, npc)
		
	elseif menu == "Green script : "..player.registry["green_script"] then
		mob = math.abs(tonumber(player:input("Enter mobID : ("..player.registry["green_script"]..")")))
		player.registry["green_script"] = mob
		addPermanentSpawn.click(player, npc)
		
	elseif menu == "Deactive spell" and player.registry["permanentSpawnStatus"] == 1 then
		player.registry["permanentSpawnStatus"] = 0
		player:sendMinitext("permanentSpawn spell : nonActive")
		addPermanentSpawn.click(player, npc)
		
	elseif menu == "Active spell" then
		player.registry["permanentSpawnStatus"] = 1
		player:sendMinitext("permanentSpawn spell : Active")
		addPermanentSpawn.click(player, npc)
		
	elseif menu == "Delete spell" then
		player.registry["red_script"] = 0
		player.registry["blue_script"] = 0
		player:removeSpell("add_script")
		player:removeSpell("addPermanentSpawn")
		player:removeSpell("delete_spawn")
		player:msg(4, "[INFO] 'addPermanentSpawn' & 'Add script' spell removed!", player.ID)
	
	elseif menu == "Get spell" then
		player:addSpell("add_script")
		player:addSpell("addPermanentSpawn")
		player:addSpell("delete_spawn")
		player:msg(4, "[INFO] 'addPermanentSpawn' spell added!", player.ID)
		player:msg(4, "[INFO] 'Add script' spell added!", player.ID)
		player:msg(4, "[INFO] 'Delete spawn' spell added!", player.ID)
		addPermanentSpawn.click(player, npc)
		
	elseif menu == "Delete all items on ground" then
		
		item = player:getObjectsInMap(player.m, BL_ITEM)
		if #item > 0 then
			for i = 1, #item do
				item[i]:delete()
				player:talk(2, "All items deleted")
			end
		end
	end
end,





cast = function(player)
		
	local item = player:getObjectsInMap(player.m, BL_ITEM)	
	local mobID	
		
	if player.registry["permanentSpawnStatus"] == 0 then
		anim(player)
		player:sendMinitext("permanentSpawn spell : nonActive")
	return else
		if player.registry["red_script"] == 0 and player.registry["blue_script"] == 0 and player.registry["green_script"] == 0 then
			anim(player)
			player:sendMinitext("set mobID for script first!")
		return else
			if #item > 0 then
				for i = 1, #item do
					if item[i].yname == "red_script" then
						if player.registry["red_script"] > 0 then
							mobID = player.registry["red_script"]
							addMob(player.m, item[i].x, item[i].y, mobID)
							player:sendAnimationXY(111, item[i].x, item[i].y)
							player:sendMinitext("Monster added!")							
						end
					elseif item[i].yname == "blue_script" then
						if player.registry["blue_script"] > 0 then
							mobID = player.registry["blue_script"]
							addMob(player.m, item[i].x, item[i].y, mobID)
							player:sendAnimationXY(111, item[i].x, item[i].y)
							player:sendMinitext("Monster added!")							
						end
					elseif item[i].yname == "green_script" then
						if player.registry["green_script"] > 0 then
							mobID = player.registry["green_script"]
							addMob(player.m, item[i].x, item[i].y, mobID)
							player:sendAnimationXY(111, item[i].x, item[i].y)
							player:sendMinitext("Monster added!")
						end
					end
				end
			end
		end
	end
end
}













