scourge = {
on_learn = function(player) player.registry["learned_scourge"] = 1 end,
on_forget = function(player) player.registry["learned_scourge"] = 0 end,

cast = function(player, target)

	local duration = 320000
	local magicCost = 100
	
	if not player:canCast(1, 1, 0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if target.state == 1 then anim(player) player:sendMinitext("Target already die!") return end
	if target:hasDuration("scourge") then player:sendMinitext("Spell already cast") player:sendAnimation(246) return end
	if target:hasDuration("vex") then target:setDuration("vex", 0) end
	
	
	if target.blType == BL_MOB then
		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		target:sendAnimation(39, 1)
		player:playSound(79)
		target:setDuration("scourge", duration)
		player:sendMinitext("You cast Scourge")

	elseif target.blType == BL_PC and player:canPK(target) then
		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		target:sendAnimation(39,1)
		target:sendMinitext(player.name.." cast scourge on you.")
		target:calcStat()	
		player:playSound(79)
		target:setDuration("scourge", duration)
		player:sendMinitext("You cast Scourge")
	end
end,

while_cast = function(player) player:sendAnimation(34, 0) end,
recast = function(player) player.armor = player.armor*.6 end,
uncast = function(player) player:calcStat() end,

requirements = function(player)
	
	txt = "- 80 Chesnut \n"
	txt = txt.."- 2 Amber \n"
	txt = txt.."- 1000 Coins \n"
	
	local level = 70
	local item = {43, 18012, 0}
	local amounts = {80, 2, 1000}
	local desc = {"Reduces armor by a fair amount on a target", "To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}