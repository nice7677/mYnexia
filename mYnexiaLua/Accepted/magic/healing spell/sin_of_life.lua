sin_of_life = {
on_learn = function(player) player.registry["learned_sin_of_life"] = 1 end,
on_forget = function(player) player.registry["learned_sin_of_life"] = 0 end,

cast = function(player, target)

	local heal = player.magic*.005 + 10000
	local magicCost = 1500
	
	if not player:canCast(1, 1, 0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if target.blType ~= BL_PC then anim(player) player:sendMinitext("Invalid target!") return end
	if target.state == 1 then anim(player) player:sendMinitext("Target already die") return end
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()	
	player:playSound(97)
	target:sendAnimation(107, 0)
	player:sendMinitext("You cast Sin of Life")
	addHealth(target, heal)
	target:sendMinitext(player.name.." cast Sin of life on you")
end,

requirements = function(player)
	local level = 0
	local items = {}
	local itemAmounts = {}
	local description = {"Heals amount of health damage based on magic", "To learn this spell you must to sacriface\n"..txt..""}
	return level, items, itemAmounts, description
end
}