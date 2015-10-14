
death_brain = {

on_swing = function(player) death_brain.cast(player) end,

cast = function(player)
	
	local damage = math.random(1000, 2000)
	
	for i = 1, 7 do
		pc = getTargetFacing(player, BL_PC, 0, i)
		mob = getTargetFacing(player, BL_MOB, 0, i)
		if pc ~= nil then
			pc:sendAnimation(300)
			if player:hasAether("death_brain") then return else
				if player:canPK(pc) and pc.state ~= 1 then
					pc.attacker = player.ID
					pc:removeHealthExtend(damage, 1,1,1,1,0)
					if pc:hasDuration("death_brain") then return else
						player:playSound(32)
						pc:sendAnimation(34)
						pc:setDuration("death_brain", 2000)
						player:setAether("death_brain", 15000)
						return
					end
				end
			end

		elseif mob ~= nil then
			mob:sendAnimation(300)
			if player:hasAether("death_brain") then return else
				mob:sendAnimation(235)
				mob:removeHealthExtend(damage, 1,1,1,1,0)
				if mob:hasDuration("death_brain") then return else
					player:playSound(32)
					mob:sendAnimation(34)
					mob:setDuration("death_brain", 2000)
					player:setAether("death_brain", 15000)
					return
				end
			end
		end
	end	
end,


while_cast = function(player)

	player.drunk = 1
	player:sendAnimation(318)
end,

uncast = function(player)

	player:calcStat()
	player.drunk = 0
end,

effect = function(player, target)

	if player:hasAether("death_brain") then return else
		if target:hasDuration("death_brain") then return else
			player:playSound(32)
			target:sendAnimation(34)
			target:setDuration("death_brain", 2000)
			player:setAether("death_brain", 15000)
		end
	end
end
}