	--[[ On Events ]]-----------------------------------------------------------------------------------
	--> onClick(player, target)						--> onBreak(player)
	--> onSwing(player)                			    --> onThrow(player,item)
	--> onViewBoard(player)             			--> onAction(player)
	--> onTradeButton(player)           			--> onSign(player, signType)
	--> onLevel(player)                 			--> onLook(player, block)
	--> onPickUp(player,item)           			--> onDismount(player)
	--> onDrop(player,item)             			--> remount(player)
	--> onEquip(player,item)            			--> onSummonedMount(player)
	--> onUnequip(player,item)          			--> onCreation(player)
	--> onDeathPlayer(player)           			--> onTurn(player)
	--> onCast(player)								--> onF5Key(player)
	--> onLeaveGroup(player)						--> onGroupXP(player, target)
	--> onWalk(player)								--> onSpecialMapAttack(player)

onLevel = function(player)

	local primary = math.ceil(((player.level) * 1.000))
	local secondary = math.floor((primary * .395))
	local tertiary = math.ceil((secondary * .15))

	if (player.level >= 99) then return end
	
	if (player.class == 0) then
		if (player.level == 4) then
			player:msg(8, "You have reached level 5, you must now choose a path to continue.", player.ID)
		elseif (player.level >= 5) then
			player:sendMinitext("You cannot increase your level without choosing a path first.")
			return
		end
	end
	
	if (player.baseClass == 1) then
		player.registry["base_might"] = primary
		player.registry["base_grace"] = secondary
		player.registry["base_will"] = tertiary

    	player.baseHealth = player.baseHealth + (50 + math.random(25))
    	player.baseMagic = player.baseMagic + (10 + math.random(15))

	elseif (player.baseClass == 2) then
		player.registry["base_might"] = tertiary
		player.registry["base_grace"] = primary
		player.registry["base_will"] = secondary

    	player.baseHealth = player.baseHealth + (25 + math.random(15))
    	player.baseMagic = player.baseMagic + (35 + math.random(25))

	elseif (player.baseClass == 3) then
		player.registry["base_might"] = tertiary
		player.registry["base_grace"] = secondary
		player.registry["base_will"] = primary

    	player.baseHealth = player.baseHealth + (10 + math.random(15))
    	player.baseMagic = player.baseMagic + (50 + math.random(25))

	elseif (player.baseClass == 4) then
		player.registry["base_might"] = secondary
		player.registry["base_grace"] = tertiary
		player.registry["base_will"] = primary

    	player.baseHealth = player.baseHealth + (25 + math.random(25))
    	player.baseMagic = player.baseMagic + (35 + math.random(15))

	elseif (player.baseClass == 0 or player.baseClass == 5) then
		player.registry["base_might"] = math.ceil(player.level / 2)
		player.registry["base_grace"] = math.ceil(player.level / 2)
		player.registry["base_will"] = math.ceil(player.level / 2)

    	player.baseHealth = player.baseHealth + (30 + math.random(20))
    	player.baseMagic = player.baseMagic + (30 + math.random(20))

	end

    --level 98 -> 99 base health/magic round it to nearest hunderd
    if (player.level == 98) then
        player.baseHealth = math.floor(player.baseHealth * 10^-2 + 0.5) / 10^-2
        player.baseMagic = math.floor(player.baseMagic * 10^-2 + 0.5) / 10^-2
    end
	
	player.level = player.level + 1
	player.baseAC = 0
	player:calcStat()
	player.health = player.maxHealth
	player.magic = player.maxMagic
	player:sendStatus()
	player:sendAnimation(253)
--	player:playSound(20)
	player:playSound(123)
	player:talk(2, "Level up!!")
end



onPickUp = function(player,item)

--[[
	if (player.pickUpType == 1) then--< Big pick up all.
		if player:hasSpace(item.id, item.amount) then
			player:talk(2, ""..item.amount.." - "..Item(item.id).name.."")
		end		
		if((player.gmLevel >= 1) and (player.pickUpType==1)) then
			player:talk(2,"Mengambil "..item.amount.." "..Item(item.id).name.."("..item.id..")")
		elseif(player.gmLevel >= 1 and player.pickUpType ~= 1) then
			player:talk(2,"Mengambil 1 "..Item(item.id).name.."("..item.id..")")
		end
	else
		if player:hasSpace(item.id, item.amount) then
			player:talk(2, ""..item.amount.." - "..Item(item.id).name.."")
		end
	end
]]--
	if player.gmLevel == 0 then
		for script = 18114, 18119 do
			if item.id == script then
				anim(player)
				player:sendMinitext("You cannot pickup this item")
				return
			end
		end
	end
	
	if player.quest["deludge_revenge"] == 1 then
		if player.registry["get_do_sword"] == 0 and not player:hasLegend("deludge_revenge") then
			if item.yname == "fox_tails" then
				player:msg(4, "=== [Quest - Finished] - 'Deludge revenge' - Get item 'fox tails' (1/1) ===", player.ID)
			end
		end
	end

	if player.quest["quest_churua"] == 2 then
		if player.quest["say_hello"] == 1 and player.quest["say_ginseng"] == 1 and player.quest["talk_to_rocks"] == 1 then
			if player.quest["talk_to_tiger"] == 1 and item.yname == "chu_rua_ginseng" then
				player:sendAnimation(248)
				player:sendMinitext("You found the turtle's ginseng! let's take it back to that turtle!")
				finishedQuest(player)
			end
		end
	end
	if (Item(item.id).type ~= 10) then player:pickUp(item.ID) end
end



onDrop = function(player,item)

	if player.m == 6000 then
		if player.x == 29 or player.x == 30 and player.y == 25 then
			if item.yname == "white_amber" then
				if player.registry["dropped_white_amber"] > os.time() then anim(player) return else
					if player:hasLegend("star_blessing") then player:removeLegendbyName("star_blessing") end
					player.registry["blessed_by_star"] = player.registry["blessed_by_star"] + 1
					if player.registry["blessed_by_star"] == 1 then
						player:addLegend("Blessed by star for 1 time", "star_blessing", 48, 48)
					else
						player:addLegend("Blessed by star for "..player.registry["blessed_by_star"].." times", "star_blessing", 48, 48)
					end
					player.registry["dropped_white_amber"] = os.time()+86400
					finishedQuest(player)
					player:sendAnimation(18)
					player:playSound(80)
					amber = player:getOBjectsInCell(player.m, player.x, player.y, BL_ITEM)
					if #amber > 0 then
						for i = 1, #amber do
							if amber[i].yname == "white_amber" then
								amber[1]:delete()
								player:refresh()
							end
						end
					end
				end
			end
		end
	end
end



onEquip = function(player, item)
	
	local item = player:getInventoryItem(player.invSlot)
	local pickaxe = {"wooden_pickaxe", "bronze_pickaxe", "silver_pickaxe", "golden_pickaxe"}
	local scissors = {"scissors", "bronze_scissors", "silver_scissors", "golden_scissors"}
	local string = {"wooden_string", "bronze_string", "silver_string", "golden_string"}
	local chisel = {"wooden_chisel", "bronze_chisel", "silver_chisel", "golden_chisel"}
	local axe = {"wooden_axe", "bronze_axe", "silver_axe", "golden_axe"}
	local net = {"wooden_net", "bronze_net", "silver_net", "golden_net"}
	
	for i = 1, 4 do
		if item.yname == pickaxe[i] then
			if player.registry["learned_ore_mining"] == 0 then
				anim(player)
				player:sendMinitext("You don't know how to using this")
				return
			end
		elseif item.yname == scissors[i] then
			if player.registry["learned_sheperd"] == 0 then
				anim(player)
				player:sendMinitext("You don't know how to using this")
				return
			end
		elseif item.yname == string[i] then
			if player.registry["learned_weaving"] == 0 then
				anim(player)
				player:sendMinitext("You don't know how to using this")
				return
			end
		elseif item.yname == chisel[i] then
			if player.registry["learned_gem_cutting"] == 0 then
				anim(player)
				player:sendMinitext("You don't know how to using this")
				return
			end
		elseif item.yname == axe[i] then
			if player.registry["learned_lumberjack"] == 0 then
				anim(player)
				player:sendMinitext("You don't know how to using this")
				return
			end		
		elseif item.yname == net[i] then
			if player.registry["learned_gem_mining"] == 0 then
				anim(player)
				player:sendMinitext("You don't know how to using this")
				return
			end		
		end
	end
	player:equip()
	if player.gfxClone == 1 then gfxClone(player, player) player:updateState() end
end



onUnequip = function(player, item)

	local weap = player:getEquippedItem(EQ_WEAP)
	
	if weap.id == player.takeOffID then
		player:talk(0, "a")
	end
	player.registry["enchant"] = 0
	player.registry["infuse"] = 0
	player.registry["ingress"] = 0
	
	
	player:takeOff()
	if player.gfxClone == 1 then gfxClone(player, player) player:updateState() end
end



onDeathPlayer = function(player)
	
	if player.ID == 2 or player.ID == 18 then
		player.state = 0 
		player:updateState()
		player.health = player.maxHealth
		player:sendStatus()
		return
	end
	
	player.deathFlag = 1
	player.state = 1
	player:updateState()
	
--	expDeduction = math.ceil(player.exp * math.ceil((player.level+1)/2) / 100)
	local lost = 0
	if player.exp - lost <= 0 then
		lost = 0
	else
		lost = math.ceil((player.exp*.01)/10)
		player.exp = player.exp - lost
	end
	player:sendStatus()
	player:sendMinitext("You've lost "..format_number(lost).." hunt exp!")
end


onBreak = function(player)
	player:msg(12, "[INFO]: Your "..Item(player.breakID).name.." destroyed !!!", player.ID)
end



onThrow = function(player,item)
	--local y = player:getInventoryItem(player.invSlot) --returns inventory slot
	--player:talk(0,"Slot: "..player.invSlot.." Item returned "..y.name)
	player:throwItem()
end

onAction = function(player)
	
	if player.state == 2 then
		if player:hasDuration("shadow") then return else
			player.state = 0
			player:updateState()
		end
	end
end

onSign = function(player, signType)
	
	local objFacing = getObjFacing(player)
	local m = player.m
	local x = player.x
	local y = player.y
	local s = player.side
	local moved = true
	local mob = getTargetFacing(player, BL_MOB)

	if (signType == 1) then--onLook
		
	elseif (signType == 2) then--onScriptedTile
		if mob ~= nil and mob.owner > 0 then
			mob:warp(player.m, player.x, player.y)
			mob:sendAnimation(248)
		end	
	elseif (signType == 3) then--onTurn
		if mob ~= nil and mob.owner > 0 then
			mob:warp(player.m, player.x, player.y)
			mob:sendAnimation(248)
		end
	end
end

onLook = function(player, block)

	onSign(player, 1)
	player:lookAt(block.ID)
	local str = ""
	
	--if (player:staff("script") >= 3 and player:staff("pm") == -1 and player.gmLevel < 50) then

	if player.gmLevel > 0 then
		if (block.blType == BL_PC) then
			str = ""..block.classNameMark.." | "..block.name.." ("..string.format("%.2f", (block.health / block.maxHealth * 100)).."%) ID: "..block.id
			player:msg(0, ""..str, player.id)
		elseif (block.blType == BL_MOB) then
			str = ""..block.name.." | "..block.yname.." ("..string.format("%.2f", (block.health / block.maxHealth * 100)).."%) id: "..block.id.." ID: "..block.ID.." mobID: "..block.mobID
			player:msg(0, ""..str, player.id)
		elseif (block.blType == BL_NPC) then
			str = ""..block.name.." | "..block.yname.." "..block.id
			player:msg(0, ""..str, player.id)
		elseif (block.blType == BL_ITEM) then
			str = ""..block.name.." | "..block.yname.." "..block.id
			player:msg(0, ""..str, player.id)
		end
	end
end

onDismount = function(player)

	local kuda  = player.registry["mounted_id"]	
	local s = player.side
	local m = player.m
	local x = player.x
	local y = player.y
	reg = player.registry["on_mounted_horseID"]	
		
	if kuda > 0 and player.state == 3 and player.disguise == 26 then
		if Mob(reg) ~= nil then
			Mob(reg):warp(player.m, player.x, player.y)
		end
	end
	player.registry["mounted_id"] = 0
	
	if player.speed < 80 then player.speed = 80 end
	if player.state == 3 then player.state = 0 end
	player:updateState()
	player:sendStatus()
end

remount = function(player)

	if player.state == 3 then
		if player.registry["mount_speed"] > 0 then
			player.speed = player.registry["mount_speed"]
			player:updateState()
			player:sendStatus()
		end
	end
end


onSummonedMount = function(player)

	local mount = player.registry["summoned_mount"]
	local mob = getTargetFacing(player, BL_MOB)
	
	if mob ~= nil and mob.yname == "soccer_ball" then
		shoot.cast(player)
		return
	end
	
	if player.m == 1000 then
		if player.x >= 32 and player.x <= 46 and player.y >= 114 and player.y >= 120 then
			anim(player)
			player:sendMinitext("You cannot riding at here")
			return
		end
	end
	
	if player.state == 0 and mount > 0 and player.registry["mount_speed"] > 0 then
		player.speed = player.registry["mount_speed"]
		player.disguise = mount
		player.state = 3
		player:sendAnimation(16)
		player:updateState()
		player:sendStatus()
	end
end



onCreation = function(player)
	
	player:sendAnimation(246)
    player:sendMinitext("Wrong recipes!")
	
end



onTurn = function(player)

	onSign(player, 3)
	
	if player:hasDuration("amnesia") or player:hasDuration("confuse") then
		if player.side == 0 then
			player.side = 2
		elseif player.side == 1 then
			player.side = 3
		elseif player.side == 3 then
			player.side = 1
		elseif player.side == 2 then
			player.side = 0
		end
		player:sendSide()
	end
end