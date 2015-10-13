backstab = {
on_learn = function(player) player.registry["learned_backstab"] = 1 end,
on_forget = function(player) player.registry["learned_backstab"] = 0 end,

cast = function(player)
	local duration = 160000
	local magicCost = 1000

	if (not player:canCast(1, 1, 0)) then return end
	if (player.magic < magicCost) then notEnoughMP(player) return end
	
	if player:hasDuration("backstab") then
		player:sendAnimation(246, 0)
		player:sendMinitext("Spell already cast")
	else
		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendAnimation(56, 0)
		player:playSound(5)
		player:sendMinitext("You cast Backstab")
		player:setDuration("backstab", duration)
	end
end,

while_cast = function(player)

	local mob = getTargetFacing(player, BL_MOB)
	local pc = getTargetFacing(player, BL_PC)
	
	if pc == nil and mob == nil then player.backstab = false return end
	player.backstab = true
	
end,

uncast = function(player)
	
	if player.backstab == true then player.backstab = false end
	player:calcStat()
end,

requirements = function(player)

	txt = "\n- 80 Chesnut \n"
	txt = txt.."- 5 Snake Meat"

	local level = 20
	local item = {43, 49} --chesnut, raw_snake_meat		ini id di database 
	local amounts = {80, 5}	-- ini jumlah nya berurut , , , 
	local desc = {"Ability to damage enemy at your back", "To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}