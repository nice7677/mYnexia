fleshspeak = {
on_learn = function(player) player.registry["learned_fleshspeak"] = 1 end,
on_forget = function(player) player.registry["learned_fleshspeak"] = 0 end,

cast = function(player, target)

	local heal = math.random(100, 120)
	local magicCost = player.magic*.05
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if target.blType ~= BL_PC then anim(player) player:sendMinitext("Invalid target") return end
	if target.state == 1 then anim(player) player:sendMinitext("Target already die") return end
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	addHealth(target, heal)
	target:sendAnimation(5)
	player:playSound(3)
	target:sendMinitext(player.name.." cast Fleshspeak on you.")
	player:sendMinitext("You cast Fleshspeak")
end,

requirements = function(player)
	
	txt = "- 70 Chesnut"
	txt = "- 100 Coins"
	
	local level = 13
	local item = {43, 0}
	local amounts = {70, 100}
	local desc = {"Heal a small amount to target", "To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}