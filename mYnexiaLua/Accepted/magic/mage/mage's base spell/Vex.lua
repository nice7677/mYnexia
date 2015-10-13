vex = {
on_learn = function(player) player.registry["learned_vex"] = 1 end,
on_forget = function(player) player.registry["learned_vex"] = 0 end,


cast = function(player, target)
	local duration = 120000
	local magicCost = 100
	
	if (target.state == 1) then player:sendMinitext("Invalid Target") return end
	if (not player:canCast(1, 1, 0)) then return end
	if (player.magic < magicCost) then notEnoughMP(player) return end
	if (target:hasDuration("scourge") or target:hasDuration("vex")) then player:sendMinitext("Spell already cast") return end
	
	if target.blType == BL_MOB then
		player:sendAction(6,20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		target:sendAnimation(13)
		player:playSound(24)
		target:setDuration("vex", duration)
		player:sendMinitext("You cast Vex")
	elseif target.blType == BL_PC then
		if player:canPK(target) then
			player:sendAction(6,20)
			player.magic = player.magic - magicCost
			player:sendStatus()
			target:sendAnimation(13)
			player:playSound(24)
			target:setDuration("vex", duration)
			player:sendMinitext("You cast Vex")	
			target:sendMinitext(player.name.." cast Vex on you")
		end
	end
end,

while_cast = function(block)
	if (block.blType == BL_MOB and block.charState ~= 2) then
		block:sendAnimation(34, 0)
	elseif (block.blType == BL_PC and block.state ~= 2) then
		block:sendAnimation(34, 0)
	end
end,


recast = function(block)
	block.armor = block.armor * .6
end,


requirements = function(player)

	txt = "- 70 Chesnut \n"
	txt = txt.. "- 1 Lucky Coin \n"
	txt = txt.. "- 10 Great Tiger Pelt \n"
	txt = txt.. "- 250 coins \n"

	local level = 1
	local items = {43, 70, 7047, 0}
	local amounts = {70, 1, 10, 250}
	local desc = {"Make your target weaken.", "To learn this spell you must to sacriface:\n"..txt..""}
	return level, items, amounts, desc
end
}