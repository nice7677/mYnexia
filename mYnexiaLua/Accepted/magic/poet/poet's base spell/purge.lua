purge = {

on_learn = function(player) player.registry["learned_purge"] = 1 end,
on_forget = function(player) player.registry["learned_purge"] = 0 end,

cast = function(player, target)

	local magicCost = 100
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if target.state == 1 then anim(player) player:sendMinitext("Target already die!") return end
	
	if target:hasDuration("venom") then target:setDuration("venom", 0) end
	player:sendAction(6, 20)
	target:sendAnimation(22)
	player:playSound(67)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Purge")
	target:sendMinitext(player.name.." cast purge on you")
	
end,

requirements = function(player)

	txt = "- 50 Chesnut \n"
	txt = txt.."- 10 Snake Meat \n"
	txt = txt.."- 100 Coins \n"
	
	local level = 18
	local item = {43, 49, 0}
	local amounts = {50, 10 ,100}
	local desc = {"Cure venom on target", "To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}