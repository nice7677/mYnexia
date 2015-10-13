flank = {
on_learn = function(player) player.registry["learned_flank"] = 1 end,
on_forget = function(player) player.registry["learned_flank"] = 0 end,

cast = function(player)
	local duration = 160000
	local magicCost = 1000
	
	if (not player:canCast(1, 1, 0)) then return end
	if (player.magic < magicCost) then notEnoughMP(player) return end
	
	if player:hasDuration("flank") then
		player:sendAnimation(246, 0)
		player:sendMinitext("Spell already cast")
	else
		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendAnimation(2, 0)
		player:playSound(6)
		player:sendMinitext("You cast Flank")
		player:setDuration("flank", duration)
	end
end,

while_cast = function(player)

	local mob = getTargetFacing(player, BL_MOB)
	local pc = getTargetFacing(player, BL_PC)
	
	if mob == nil and pc == nil then player.flank = false return end

	player.flank = true
end,

uncast = function(player)
	
	if player.flank == true then player.flank = false end
	
	player:calcStat()
end,

requirements = function(player)

	txt = "\n- 80 Chesnut \n"
	txt = txt.."- 5 Fox Fur \n"
	txt = txt.."- 20 Snake Meat \n"

	local level = 25
	local item = {43, 12, 49} -- Chesnut, fox_fur, snake_meat
	local amounts = {80, 5, 20}
	local desc = {"Ability to damage your nearby enemy.", "To learn this spell you must to sacriface "..txt..""}
	return level, item, amounts, desc
end
}