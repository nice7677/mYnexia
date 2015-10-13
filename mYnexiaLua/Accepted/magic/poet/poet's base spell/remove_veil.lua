remove_veil = {

on_learn = function(player) player.registry["learned_remove_veil"] = 1 end,
on_forget = function(player) player.registry["learned_remove_veil"] = 0 end,

cast = function(player, target)

	local magicCost = 100
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if target.state == 1 then anim(player) player:sendMinitext("Invalid target!") return end
	if target:hasDuration("blind") then target:setDuration("blind", 0) end
	
	
	player:sendAction(6, 20)
	target:sendAnimation(259)
	player:playSound(112)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Remove veil")
	target:sendMinitext(player.name.." cast Remove veil on you")
	
end,

requirements = function(player)

	txt = "- 20 Chesnut \n"
	txt = txt.."- 1 Amethyst stone \n"
	txt = txt.."- 200 Coins \n"
	
	local level = 39
	local item = {43, 18015, 0}
	local amounts = {20, 1  ,200}
	local desc = {"Cure Blind effect on target", "To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}