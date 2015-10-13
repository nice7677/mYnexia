sanctuary = {

on_learn = function(player) player.registry["learned_sanctuary"] = 1 end,
on_forget = function(player) player.registry["learned_sanctuary"] = 0 end,

cast = function(player, target)

	local magicCost = 500
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if target.state == 1 then anim(player) player:sendMinitext("Target already die!") return end
	
	if target.blType == BL_PC then
		if target:hasDuration("sanctuary") then return else
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:sendAction(6, 20)
			player:sendMinitext("You cast Sanctuary")
			target:sendAnimation(11)
			player:playSound(8)
			target:sendMinitext(player.name.." cast Sanctuary on you")
			target:setDuration("sanctuary", 240000)
		end
	end
end,

recast = function(player) player.deduction = player.deduction - .45 end,
uncast = function(player) player:calcStat() end,

requirements = function(player)

	txt = "- 80 Chesnut \n"
	txt = txt.."- 10 Bear's heart \n"

	local level = 24
	local item = {43, 52}
	local amounts = {60, 10}
	local desc = {"Deduction - 0.45", "To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}