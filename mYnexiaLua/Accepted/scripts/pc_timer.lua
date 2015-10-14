pc_timer = {

tick = function(player)
	
-- player.timeInterval	
	
	local obj, check

	if (player.timerTick%2 == 0) then
		pc_timer.second(player)		
	end		-- 1 second
	
	if (player.timerTick%120 == 0) then pc_timer.minute(player) end 	-- 1 minute
	if (player.timerTick%7200 == 0) then pc_timer.hour(player) end 		-- 1 hour
	
	if player.timerTick%20 == 0 then
		if player.m == 13 then
			pc = player:getObjectsInMap(13, BL_PC)
			if #pc > 0 then
				for i = 1, #pc do
					if pc[i].x >= 15 and pc[i].x <= 18 and pc[i].y >= 20 and pc[i].y <= 22 then return else
						for x = 15, 19 do
							setObject(13, x, 19, 15000)
						end
					end
				end
			end
		end
	end
end,



advice = function(player)

	if (player.timerTick % 2000 == 0) then--200 seconds
		player:msg(12, ""..advice[math.random(#advice)], player.ID)
	end
end,




second = function(player)

    local block = NPC(4294967295)
	local seconds = math.floor(player.timerTick/2)
	local mob = player:getObjectsInMap(500, BL_MOB)
	
	if seconds % 2 == 0 then pc_timer.second2(player) end
	
	local pet = getTargetFacing(player, BL_MOB)
	if pet ~= nil then
		if pet.owner > 0 then
			pet:warp(Player(pet.owner).m, Player(pet.owner).x, Player(pet.owner).y)
			pet:talk(2, "!!!")
		end
	end
	
	if player.m == 2007 then
		player:playSound(math.random(50,53))
		player:sendAnimationXY(math.random(40, 41), math.random(13, 26), math.random(20, 26))
		player:sendAnimationXY(math.random(45, 46), math.random(13, 26), math.random(20, 26))
	end
end,

second2 = function(player)

    local block = NPC(4294967295)
	local seconds = math.floor(player.timerTick/2)	
	
	local m = player.m

	if m == 1000 then
		local r = math.random(10)
		if distanceSquare(player, NPC("fakir_miskin"), 4) then
			if player:hasDuration("fakir_miskin") or player.registry["beri_sedekah"] > 0 then return else fakir_miskin.cast(player) end
		end
		water_sumo.respawn(player)
	end
end,


minute = function(player)

	local minutes = math.floor(player.timerTick/120)
	local spells = player:getSpells()
	local mob
	
	if player.level >= 2 and #spells <= 0 then player:msg(4, "(Spirit of Genesis) You can learn some spells from a nearby path trainer", player.ID) end
	if (minutes < 60) and (minutes%30 == 0) then
		player:msg(2,"You have been playing for "..minutes.." minutes.",player.ID)
	end	
end,


hour = function(player)
	local hours = math.floor(player.timerTick/7200)
	
	if (hours%6==0) then
		--player:msg(4,"You have been playing for "..hours.." hour(s). You should take a break and come back later.",player.ID)
	else
		player:msg(2,"You have been playing for "..hours.." hour(s).",player.ID)
	end
		
end,

display_timer = function(player)
--Executes when a display timer finishes.
	--player:talk(2, "Beep beep, beep beep...")
	if (player.registry["botCheck"] == 1) then
		player.registry["botCheck"] = 0
		player.registry["botFlag"] = player.registry["botFlag"] + 1
		if (player.registry["botFlag"] > 5) then
			player:gmMsg(""..player.name.." should be jailed with "..player.registry["botFlag"].." failed bot checks.")
			addChatLog(player, ""..player.name.." should be jailed with "..player.registry["botFlag"].." failed bot checks.")
			--player:gmMsg(""..player.name.." has been jailed with "..player.registry["botFlag"].." failed bot checks.")
			--addChatLog(player, ""..player.name.." has been jailed with "..player.registry["botFlag"].." failed bot checks.")
			--player.registry["botFlag"] = 0
			--justice.jail(player, player)
		else
			player:gmMsg(""..player.name.." failed bot check within time. ("..player.registry["botFlag"]..")")
			addChatLog(player, ""..player.name.." failed bot check within time. ("..player.registry["botFlag"]..")")
		end
	end
end

}