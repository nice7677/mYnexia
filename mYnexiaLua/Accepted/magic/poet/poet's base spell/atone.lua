atone = {
on_learn = function(player) player.registry["learned_atone"] = 1 end,
on_forget = function(player) player.registry["learned_atone"] = 0 end,

cast = function(player, target)
	
	local magicCost =500
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	if target.state == 1 then
		anim(player)
		player:sendMinitext("Target already die!")
		return
	else
		player.magic = player.magic - magicCost
		player:sendStatus()
		if target:hasDuration("scourge") then target:setDuration("scourge", 0) end
		player:sendAction(6, 20)
		player:playSound(67)
		target:sendAnimation(259)
		target:sendAnimation(22)
		player:sendMinitext("You cast Atone")
		if target.blType == BL_PC then target:sendMinitext(player.name.." cast Atone on you") end
	end
end,

requirements = function(player)
	
	txt = "- 50 Chesnut \n"
	txt = txt.."- 1 Iron Sword \n"
	txt = txt.."- 100 Coins \n"
	
	local level = 53
	local item = {32, 3003, 0}
	local amounts = {50, 1, 100}
	local desc = {"Cures scourge effect on target", "To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}