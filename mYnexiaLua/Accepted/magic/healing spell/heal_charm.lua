heal_charm = {

cast = function(player)

	local magicCost = 13500
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end

	player:sendAction(6, 20)
	player:sendMinitext("You cast Heal Charm")
	
	if player:hasDuration("heal_charm") then
		player:setDuration("heal_charm", 0)
		player:sendAnimation(166)
		player:playSound(62)
		return
	else
		player:setDuration("heal_charm", 90000)
		player:sendAnimation(168)
		player:playSound(62)
	end
end,

while_cast = function(player)

	local magicCost = 20000 + player.wisdom*.5
	
	if player.magic < magicCost or player.magic - magicCost < 0 then player:setDuration("heal_charm", 0) return end
	
	player.magic = player.magic - magicCost
	player:sendStatus()

	local wisdom = player.wisdom
	--local dam = math.random(20000, 20000)
	local dam = 25000
	local g = player.group
	local heal = dam + math.random(wisdom*.5, wisdom*.9)
	
	player:sendAnimation(168)
	player:sendAnimation(132)

	if #g > 0 then
		for i = 1, #g do
			if Player(g[i]) ~= nil then
				local gp = Player(g[i])
				if Player(g[i]).m == player.m then
					if distanceSquare(player, Player(g[i]), 7) then
						Player(g[i]):sendAnimation(132)
						Player(g[i]):sendAnimation(422)	
						Player(g[i]):addHealthExtend(heal, 0,0,0,0,0)
					end
				end
			end
		end
	end
end,


uncast = function(player)

	player:calcStat()
end
}
