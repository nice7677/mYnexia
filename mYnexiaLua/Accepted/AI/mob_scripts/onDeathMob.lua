

onDeathMob = function(mob)

	local attacker = mob.attacker
	local rate = math.random(100000)
	
	if mob.yname == "king_of_sheep" then
		mob:dropItem(2, 10000)
	
	elseif mob.yname == "god_of_dog" then
		
	elseif mob.yname == "do_horse" then
		
	elseif mob.yname == "king_of_snake" then
		
	elseif mob.yname == "fanatic_rabbit" then
		
	elseif mob.yname == "king_of_tiger" then
		
	elseif mob.yname == "king_of_ox" then
		
	elseif mob.yname == "king_of_monkey" then
		
	elseif mob.yname == "napoleon" then
		
	elseif mob.yname == "pollo_rey" then
		
	elseif mob.yname == "king_of_rat" then
		
	elseif mob.yname == "" then
	
	end
end


dropCoins = function(mob, amount, attacker)

	if math.abs(tonumber(amount)) == nil then return nil end
	mob:dropItem(0, math.abs(tonumber(amount)), attacker)
end

