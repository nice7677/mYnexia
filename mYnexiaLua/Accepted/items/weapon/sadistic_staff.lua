sadistic_staff = {

on_swing = function(player)
	
	for i = 1, 7 do
		pc = getTargetFacing(player, BL_PC, 0, i)
		mob = getTargetFacing(player, BL_MOB, 0, i)
		if mob ~= nil then
			mob.attacker = player.ID
			mob:removeHealthExtend(damage, 1,1,1,1,0)
			mob:sendAnimation(300)
			if mob:hasDuration("sadistic_staff") or player:hasAether("sadistic_staff") then return else
				player:playSound(111)
				mob:setDuration("sadistic_staff", 2000)
				player:setAether("sadistic_staff", 15000)
			end
			return
		end
		if pc ~= nil then
			if pc.state ~= 1 and player:canPK(pc) then
				pc.attacker = player.ID
				pc:removeHealthExtend(damage, 1,1,1,1,0)
				pc:sendAnimation(300)
				if pc:hasDuration("sadistic_staff") or player:hasAether("sadistic_staff") then return else
					player:playSound(111)
					pc:setDuration("sadistic_staff", 2000)
					player:setAether("sadistic_staff", 10000)
				end
				return
			end
		end
	end
end,

cast = function(player)
	
	local damage = math.random(2500, 3000)
	
	player.paralyed = true
	player:sendAnimation(235)
	player:setDuration("sadistic_staff", 2000)
	player:playSound(111)
	player:removeHealthExtend(damage, 1,1,1,1,0)
end,

while_cast = function(block)

	block.paralyzed = true
	block:sendAnimation(235)
end,

uncast = function(block)
	
	block.paralyzed = false
end
}