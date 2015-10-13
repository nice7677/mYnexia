vigor = {

on_learn = function(player) player.registry["learned_vigor"] = 1 end,
on_forget = function(player) player.registry["learned_vigor"] = 0 end,

cast = function(player)
	
	local heal = player.health*.01
	local magicCost = 1000
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:addHealthExtend(heal, 1,1,1,1,0)
	player:sendAnimation(66)
	player:playSound(34)
	player:sendAction(6, 20)
	player:sendMinitext("You cast Vigor")
	
end,

requirements = function(player)

	txt = "\n- 2 Dry Centipede \n"
	txt = txt.."- 2 Centipede \n"
	txt = txt.."- 1 God Slice \n"

	local level = 90
	local item = {75, 74}
	local amounts = {2,2,1}
	local desc = {"Heal 1% of max Vita", "To learn this spell you must to sacriface "..txt..""}
	return level, item, amounts, desc
end
}