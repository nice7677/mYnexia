revitalize ={

on_learn = function(player) player.registry["learned_revitalize"] = 1 end,
on_forget = function(player) player.registry["learned_revitalize"] = 0 end,

cast = function(player, target)

	local magicCost = 500
	local heal = math.random(2000, 3000)
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if target.blType ~= BL_PC then anim(player) player:sendMinitext("Invalid target!") return end
	if target.state == 1 then anim(player) player:sendMinitext("Target already die!") return end

	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()	
	target:sendAnimation(66)
	player:playSound(21)
	addHealth(target, heal)
	player:sendMinitext("You cast Revitalize")
	target:sendMinitext(player.name.." cast Revitalize on you")

end,

requirements = function(player)

	txt = "- 20 Chesnut \n"
	txt = txt.."- 10 Bear's heart \n"
	txt = txt.."- 1 Sacred ring \n"
	
	local level = 45
	local item = {43, 52, 7039}
	local amounts = {20, 10, 1}
	local desc = {"Heal 2000 - 3000 amounts of health", "To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}
	