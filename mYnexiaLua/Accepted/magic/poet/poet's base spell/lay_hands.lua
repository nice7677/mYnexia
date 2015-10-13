lay_hands = {

on_learn = function(player) player.registry["learned_lay_hands"] = 1 end,
on_forget = function(player) player.registry["learned_lay_hands"] = 0 end,

cast = function(player, target)

	local magicCost = 500
	local heal = math.random(1000, 2040)
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if player.blType ~= BL_PC then anim(player) player:sendMinitext("Invalid target!") return end
	if target.state == 1 then anim(player) player:sendMinitext("Target already die!") return end

	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Lay hands")
	target:sendAnimation(66)
	player:playSound(34)
	addHealth(target, heal)
	target:sendMinitext(player.name.." cast Lay Hands on you")

end,


requirements = function(player)
	
	txt = "- 10 Chesnut \n"
	txt = txt.."- 20 Mountain Ginseng \n"
	txt = txt.."- 300 Coins \n"
	
	local level = 20
	local item = {43, 46, 0}
	local amounts = {10, 20, 300}
	local desc = {"Heal a small amount of Health","To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}