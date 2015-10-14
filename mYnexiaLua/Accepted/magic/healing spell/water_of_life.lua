water_of_life = {

on_learn = function(player) player.registry["learned_water_of_life"] = 1 end,
on_forget = function(player) player.registry["learned_water_of_life"] = 0 end,

cast = function(player, target)

	local magicCost = 1000
	local heal = math.random(5000, 8000)
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if target.blType ~= BL_PC then anim(player) player:sendMinitext("Invalid target!") return end
	if target.state == 1 then anim(player) player:sendMinitext("Target already die") return end
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	target:sendAnimation(65)
	player:playSound(98)
	addHealth(target, heal)
	target:sendMinitext(player.name.." cast Water of life on you")
	player:sendMinitext("You cast Water of life")
end,


requirements = function(player)
	
	txt = "- 40 Chesnut \n"
	txt = txt.."- 10 Snake Meat \n"
	
	local level = 30
	local item = {43, 49}
	local amounts = {40, 10}
	local desc = {"water_of_life a medium amount of water_of_lifeth on target","To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}