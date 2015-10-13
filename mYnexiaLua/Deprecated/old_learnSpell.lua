function Player.learnSpell(player)

	--local t = {graphic = 0, color = 0}
	
	local found
	local spellNames = player:getUnknownSpells()
	local spellName = {}
	local spellYName = {}
	local spellFuncs = {}
	local spellItemReq = {}
	local spellItemAmount={}
	local spellLevelReq = {}
	local spellDesc = {}
	
	--player.npcGraphic = t.graphic
	--player.npcColor = t.color
	player.dialogType = 0
	
	for i = 1, #spellNames do
		if (i % 2 == 0 and player.registry["learned_"..spellNames[i]] == 0) then
			table.insert(spellYName, spellNames[i])
		elseif (i % 2 == 1 and player.registry["learned_"..spellNames[i + 1]] == 0) then
			table.insert(spellName, spellNames[i])
		end
	end
	
	for i = 1, #spellYName do
		local level = 1
		local item = {0}
		local amounts = {100}
		local desc = {"A spell"}
		local func = assert(loadstring("return "..spellYName[i]..".requirements"))(player)
		
		if (func ~= nil) then
			level, item, amounts, desc = func(player)
		end
		
		table.insert(spellLevelReq, level)
		table.insert(spellItemReq, item)
		table.insert(spellItemAmount, amounts)
		table.insert(spellDesc, desc)
	end
	
	if (#spellLevelReq > 0) then
		local i = 1
		local level
		local item
		local amounts
		local desc
		local name
		local yname
		
		repeat
			if (i <= #spellLevelReq and (spellLevelReq[i] > player.level or (spellLevelReq[i - 1] ~= nil and spellLevelReq[i] < spellLevelReq[i - 1]))) then
				level = table.remove(spellLevelReq, i)
				item = table.remove(spellItemReq, i)
				amounts = table.remove(spellItemAmount, i)
				desc = table.remove(spellDesc, i)
				name = table.remove(spellName, i)
				yname = table.remove(spellYName, i)
				
				if (level <= player.level) then
					table.insert(spellLevelReq, 1, level)
					table.insert(spellItemReq, 1, item)
					table.insert(spellItemAmount, 1, amounts)
					table.insert(spellDesc, 1, desc)
					table.insert(spellName, 1, name)
					table.insert(spellYName, 1, yname)
				end
				
				i = 1
			else
				i = i + 1
			end
		until i > #spellLevelReq
	end
	
	local c = player:menuString("What would you like to learn?", spellName)
	if(c ~= "" ) then
		for x = 1, #spellName do
			if (spellName[x] == c) then
				found = x
				break
			end
		end	
	end
		
	if(found > 0) then
	
		if(not player:dialogSeq(spellDesc[found], 1)) then
			return false
		end
		
		local c = player:menuString("Do you swear to use this for good?", {"Yes", "No"})
		if (c == "Yes") then
		--[[	
			if (#spellItemReq[found] > 0) then
				if (player:checkitem(spellItemReq[found], spellItemAmount[found])) then
					player:removeitem(spellItemReq[found], spellItemAmount[found])
				else
					player:dialog("You do not have the required item.", {})
					return false
				end
			end
		]]--	
			if (player.level < spellLevelReq[found]) then
				player:dialog("You are too weak to learn that", {})
				return false
			end
			
			player.registry["learned_"..spellYName[found]] = 1
			player:addSpell(spellYName[found])
			player:sendAnimation(350)
			player:playSound(77)
			player:sendMinitext("Your mind expands as you learn "..spellName[found])
			player:learnSpell()
			
		elseif (c == "No") then
			return false
		end
	end
end