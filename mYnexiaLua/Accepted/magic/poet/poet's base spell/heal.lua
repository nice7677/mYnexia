heal = {

on_learn = function(player) player.registry["learned_heal"] = 1 end,
on_forget = function(player) player.registry["learned_heal"] = 0 end,

cast = function(player, target)

	local magicCost = 500
	local heal = math.random(1500, 2700)
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if target.blType ~= BL_PC then anim(player) player:sendMinitext("Invalid target!") return end
	if target.state == 1 then anim(player) player:sendMinitext("Target already die") return end
	
	player:sendAction(6, 20)
	target:sendAnimation(66)
	player:playSound(5)
	addHealth(target, heal)
	target:sendMinitext(player.name.." cast heal on you")
	player:sendMinitext("You cast heal")
end,


requirements = function(player)
	
	txt = "- 40 Chesnut \n"
	txt = txt.."- 10 Snake Meat \n"
	
	local level = 30
	local item = {43, 49}
	local amounts = {40, 10}
	local desc = {"Heal a medium amount of Health on target","To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}