mend_wounds = {

on_learn = function(player) player.registry["learned_mend_wounds"] = 1 end,
on_forget = function(player) player.registry["learned_mend_wounds"] = 0 end,

cast = function(player, target)

	local magicCost = 300
	local heal = math.random(200, 240)
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if target.blType ~= BL_PC then anim(player) player:sendMinitext("Invalid target!") return end
	if target.state == 1 then anim(player) player:sendMinitext("Target already die") return end

	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	target:sendAnimation(66)
	player:playSound(3)
	addHealth(target, heal)
	target:sendMinitext(player.name.." cast Mend Wounds on you")
	player:sendMinitext("You cast Mend Wounds")
end,


requirements = function(player)
	
	local txt
	txt = "- 50 Chesnut \n"
	txt = txt.."- 100 Coins \n"
	
	local level = 20
	local item = {43, 0}
	local amounts = {50, 100}
	local desc = {"Heal a small amount of Health","To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}