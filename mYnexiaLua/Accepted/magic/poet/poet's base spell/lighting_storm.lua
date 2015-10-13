lighting_storm = {

on_learn = function(player) player.regstry["learned_lighting_storm"] = 1 end,
on_forget = function(player) player.regstry["learned_lighting_storm"] = 0 end,

cast = function(player)

	local mob = player:getObjectsInMap(player.m, BL_MOB)
	local pc = player:getObjectsInMap(player.m, BL_PC)
	
	local threat
	local magicCost = 5000
	local damage = player.wisdom*.5 + math.random(7000, 10000)
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player:sendAction(6, 20)
	player:setAether("lighting_storm", 60000)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Lighting storm")
	player:playSound(44)
	
	if #mob > 0 then
		for i = 1, #mob do
			mob[i].attacker = player.ID
			mob[i]:sendAnimation(256)
			threat = mob[i]:removeHealthExtend(damage, 1,1,1,1,2)
			player:addThreat(mob[i].ID, threat)
			mob[i]:removeHealthExtend(damage, 1,1,1,1,0)
		end
	elseif #pc > 0 then
		for i = 1, #pc do
			if player:canPK(pc[i]) and not pc[i].ID == player.ID then
				pc[i].attacker = player.ID
				pc[i]:sendAnimation(256)
				pc[i]:sendMinitext(player.name.." attack you with Lighting storm")
				pc[i]:removeHealthExtend(damage, 1,1,1,1,0)
			end
		end
	end
end
}