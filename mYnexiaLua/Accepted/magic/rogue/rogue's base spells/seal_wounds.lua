seal_wounds = {

on_learn = function(player) player.registry["learned_seal_wounds"] = 1 end,
on_forget = function(player) player.registry["learned_seal_wounds"] = 0 end,

cast = function(player, target)

	local magicCost = 500
	local heal = math.random(1000, 2400)
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if target.blType ~= BL_PC then anim(player) player:sendMinitext("Invalid target!") return end
	if target.state == 1 then anim(player) player:sendMinitext("Target already die") return end

	player:sendMinitext("You cast Seal Wounds")
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	target:sendAnimation(66)
	player:playSound(3)
	addHealth(target, heal)
	target:sendMinitext(player.name.." cast Seal Wounds on you")
end,


requirements = function(player)
	
	local txt
	txt = "- 10 Hartshorn \n"
	txt = txt.."- 20000 Coins \n"
	
	local level = 90
	local item = {63, 0}
	local amounts = {10, 20000}
	local desc = {"Heal medium amount of Health", "To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}