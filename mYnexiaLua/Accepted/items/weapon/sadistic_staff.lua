
sadistic_staff = {

on_swing = function(player)

	sadistic_staff.cast(player)
end,

cast = function(player)
	
	local damage = math.random(1000, 2000)
	
	for i = 1, 7 do
		pc = getTargetFacing(player, BL_PC, 0, i)
		mob = getTargetFacing(player, BL_MOB, 0, i)
		if pc ~= nil then
			pc:sendAnimation(300)
			if player:hasAether("sadistic_staff") then return else
				if player:canPK(pc) and pc.state ~= 1 then
					pc.attacker = player.ID
					pc:removeHealthExtend(damage, 1,1,1,1,0)
					if pc:hasDuration("sadistic_staff") then return else
						player:playSound(111)
						pc:sendAnimation(235)
						pc:setDuration("sadistic_staff", 2000)
						player:setAether("sadistic_staff", 15000)
						return
					end
				end
			end

		elseif mob ~= nil then
			mob:sendAnimation(300)
			if player:hasAether("sadistic_staff") then return else
				mob:sendAnimation(235)
				mob:removeHealthExtend(damage, 1,1,1,1,0)
				if mob:hasDuration("sadistic_staff") then return else
					player:playSound(111)
					mob:sendAnimation(235)
					mob:setDuration("sadistic_staff", 2000)
					player:setAether("sadistic_staff", 15000)
					return
				end
			end
		end
	end	
end,


while_cast = function(player)

	player.paralyzed = true
	player:sendAnimation(235)
end,

uncast = function(player)

	player:calcStat()
	player.paralyzed = false
end,

effect = function(player, target)

	if player:hasAether("sadistic_staff") or target:hasDuration("sadistic_staff") then return else
		player:playSound(111)
		target:sendAnimation(235)
		target:setDuration("sadistic_staff", 2000)
		player:setAether("sadistic_staff", 15000)
	end
end
}