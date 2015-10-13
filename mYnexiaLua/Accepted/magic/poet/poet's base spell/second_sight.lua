second_sight = {

on_learn = function(player) player.registry["learned_second_sight"] = 1 end,
on_forget = function(player) player.registry["learned_second_sight"] = 0 end,

cast = function(player)

	local magicCost = 3000

	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	if player:hasDuration("second_sight") then
		anim(player)
		player:sendMinitext("Spell already cast")
		return
	else
		player:sendAction(6, 20)
		player:sendMinitext("You cast Second Sight")
		player:sendAnimation(88)
		player:playSound(78)
		player:setDuration("second_sight", 30000)
	end
end,

while_cast = function(player) player.seeInvis = 1 end,
uncast = function(player) player.seeInvis = 0 player:calcStat() end,

requirements = function(player)

	txt = "- 100 Chesnut \n"
	txt = txt.."- 1 Iron saber \n"
	txt = txt.."- 500 Coins \n"
	
	local level = 58
	local item = {43, 3034, 0}
	local amounts = {100, 1, 500}
	local desc = {"Can see people invisible"}
	return level, item, amounts, desc
end
}