shadow_figure = {

on_learn = function(player) player.registry["learned_shadow_figure"] = 1 end,
on_forget = function(player) player.registry["learned_shadow_figure"] = 0 end,

cast = function(player)
	
	local magicCost = 1000
	local dura = 180000
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end

	if player:hasDuration("shadow_figure") or player.registry["shadow_figure"] == 1 then
		player:sendMinitext("Spell already cast!")
		player:sendAnimation(246)
		return
	else
		player.magic = player.magic - magicCost
		player:setDuration("shadow_figure", dura)
		player:sendMinitext("You cast Shadow Figure")
		player:sendAction(6, 20)
		player.registry["shadow_figure"] = 1
		player:sendAnimation(21)
		player:playSound(28)
		player:sendStatus()
	end
end,

while_cast = function(player)

	player.registry["shadow_figure"] = 1
end,

uncast = function(player)
	
	player.registry["shadow_figure"] = 0
end,


requirements = function(player)
	
	local txt
	txt = "- 100 Chesnut \n"
	txt = txt.."- 10 Red Fox Fur \n"
	txt = txt.."- 200 Coins \n"
	
	local level = 24
	local item = {43, 69, 0}
	local amounts = {100, 10, 200}
	local desc = {"Increasing ability to evade","To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}