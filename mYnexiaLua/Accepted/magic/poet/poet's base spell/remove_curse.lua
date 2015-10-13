remove_curse = {

on_learn = function(player) player.registry["learned_remove_curse"] = 1 end,
on_forget = function(player) player.registry["learned_remove_curse"] = 0 end,

cast = function(player, target)

	local magicCost = 100
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if target.state == 1 then anim(player) player:sendMinitext("Target already die!") return end
	
	player:sendAction(6, 20)
	target:sendAnimation(22)
	player:playSound(67)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast remove curse")
	target:sendMinitext(player.name.." cast remove curse on you")
	
	if target:hasDuration("vex") then target:setDuration("vex", 0) end
	
end,

requirements = function(player)

	txt = "- 100 Chesnut \n"
	txt = txt.."- 60 Snake Meat \n"
	txt = txt.."- 100 Coins \n"
	
	local level = 25
	local item = {43, 49, 0}
	local amounts = {100, 60 ,100}
	local desc = {"Cure Vex on target", "To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}