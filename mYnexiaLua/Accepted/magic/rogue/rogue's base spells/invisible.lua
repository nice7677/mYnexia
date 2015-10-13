invisible = {
on_learned = function(player) player.registry["learned_invisible"]=1 end,
on_forget = function(player) player.registry["learned_invisible"]=0 end,


cast = function(player, target)
	local duration = 30000
	local magicCost = 80
	
	if not player:canCast(1, 1, 1) then return end	
	if player.magic < magicCost then notEnoughMP(player) return end
	if player:hasDuration("invisible") or player.state == 2 then player:sendAnimation(246) player:sendMinitext("Spell already Cast") return end

	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendAction(6, 20)
	player:sendAnimation(21, 0)
	player:playSound(28)
	player.state = 2
	player:updateState()
	player:sendMinitext("You cast Invisible.")
	player:setDuration("invisible", duration)
end,

on_swing_while_cast = function(player)
	player.state = 0
	player:updateState()
	player:setDuration("invisible", 0)
end,

while_cast=function(player)
	player.state = 2
	player:updateState()
end,

uncast = function(player)
	player.state = 0
	player:updateState()
end,


requirements = function(player)
	
	local txt
	txt = "- 200 Chesnut \n"
	txt = txt.."- 2 Tiger Meat \n"
	txt = txt.."- 1 Fox Tail \n"
	txt = txt.."- 400 Coins"

	local level = 34
	local item = {43, 55, 68, 0}
	local amounts = {200, 2, 1, 400}
	local desc = {"Disapear", "To learn this spell you must to sacriface:\n"..txt..""}
	return level, item, amounts, desc
end
}