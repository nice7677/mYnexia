
-- onWalk(player)             -- onLeaveGroup(player)
-- onClick(player, target)    -- onGroupXP(player)
-- onSwing(player)            -- onViewBoard(player)
-- onF4Key(player)            -- 
-- onTradeKey(player)         -- onSpecialMapR(player)


-----------------------------------------------------------------------------------------------------

onNoAfkMap = function(player)
		
	if player.m == 10001 then
		x = math.random(164, 188)
		y = math.random(21, 28)	
		player:warp(10000, x, y)
	end
end



-----------------------------------------------------------------------------------------------------
	
onClick = function(player, target)
	
	player:freeAsync()
	
	if target.registry["v_open"] == 1 and target:hasDuration("vending_menu") then
		if target.ID == player.ID then
			onF4Key(player)
			return
		end
		vending_core.showshop(player, target)
	end
	return
end

-----------------------------------------------------------------------------------------------------

onF4Key = function(player)
	
	local cape = player:getEquippedItem(EQ_MANTLE)

	if cape == nil or not cape.yname == "vending_ransel" or not cape.yname == "vending_cart" then
		anim(player)
		player:popUp("You must to equip vending ransel/cart first!")
		return
	end
	
	player:freeAsync()
	vending_menu.click(player, npc)
end

-----------------------------------------------------------------------------------------------------

onF12Key = function(player)
	
	local npc = NPC(66)
	
	if player.gmLevel == 0 then return else
		player:freeAsync()
		gm_tools.click(player, npc)
	end
end

-----------------------------------------------------------------------------------------------------

onTradeKey = function(player)
	
end

-----------------------------------------------------------------------------------------------------

onLeaveGroup = function(player)

end

-----------------------------------------------------------------------------------------------------
	
onGroupXP = function(player)

end	

-----------------------------------------------------------------------------------------------------

onViewBoard = function(player)
	
	player:sendAction(15, 40)

end

-----------------------------------------------------------------------------------------------------

onSpecialMapR = function(player)

end	
	

-----------------------------------------------------------------------------------------------------

onWalk = function(player)
	
	local m = player.m
	local x = player.x
	local y = player.y
	local s = player.side
	local tile = getTile(player.m, player.x, player.y)
	
	if tile == 17816 or tile == 17765 or tile == 17758 then
		player:sendAnimationXY(142, player.x, player.y)
		player:playSound(73)
	end
	
	
-- Mall	--
	if m == 13 then
		if x >= 14 and x <= 19 then
			if y == 20 then
				if (getObject(13, 15, 19) + getObject(13, 16, 19) + getObject(13, 17, 19) + getObject(13, 18, 19)) > 0 then
					setObject(13, 15, 19, 0)
					setObject(13, 16, 19, 0)
					setObject(13, 17, 19, 0)
					setObject(13, 18, 19, 0)
				end
			elseif y == 22 and s == 0 then
				if getObject(13, 15, 19) == 0 or getObject(13, 16, 19) == 0 or getObject(13, 17, 19) == 0 or getObject(13, 18, 19) == 0 then return else
					NPC(29):talk(2, "~ Welcome ~")
					NPC(31):talk(2, "~ Welcome ~")
					setObject(player.m, 16, 19, 0)
					setObject(player.m, 17, 19, 0)
					player:playSound(361)
				end
			elseif y == 21 and s == 0 then
				setObject(player.m, 15, 19, 0)
				setObject(player.m, 16, 19, 0)
				setObject(player.m, 17, 19, 0)
				setObject(player.m, 18, 19, 0)
			end
		end

-- Tower --		
		
	elseif m == 8 then								
		if x >= 14 and x <= 16 then
			if y == 23 and s == 0 then
				if getObject(player.m, 15, 19) == 15000 then
					setObject(player.m, 15, 19, 0)
					player:playSound(361)
				end
			elseif y == 22 and s == 0 then
				if getObject(player.m, 14, 19) == 15000 and getObject(player.m, 16, 19) == 15000 then
					setObject(player.m, 14, 19, 0)
					setObject(player.m, 16, 19, 0)
				end
			end
		end
		
	elseif m == 20018 then
		bomber_game.onWalk(player)
		
		
	elseif m == 20017 then
--[[
		if x == 160 then
			if y == 142 or y == 143 then maze.finish(player) return end
		elseif x == 0 then
			if y == 55 or y == 56 then maze.finish(player) return end
		elseif x >= 101 and x <= 103 then
			if y == 0 then maze.finish(player) return end
		elseif x >= 54 and x <= 55 then
			if y == 160 then maze.finish(player) return end
		end
]]--		
	elseif m == 2007 then
		tile = {18332, 18322, 18288, 18327, 18338, 18280}
		for i = 1, #tile do
			if getTile(player.m, player.x, player.y) == tile[i] then
				if player.state == 1 then return else
					boots = player:getEquippedItem(EQ_BOOTS)
					if boots ~= nil and boots.yname == "adventurer_shoes" then
						player:sendAnimation(280)
					return else
						player:sendAnimation(188)
						player:playSound(44)
						player.attacker = player.ID
						player:removeHealth(player.health)
					end
				end
			end
		end
	end
end

























