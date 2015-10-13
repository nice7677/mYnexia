relief = {
on_learned = function(player) player.registry["learned_relief"]=1 end,
on_forget = function(player) player.registry["learned_relief"] = 0 end,


cast = function(player)

	local heal = math.random(player.maxHealth*.002, player.maxHealth*.001)
	local magicCost = 100

	if (not player:canCast(1, 1, 0)) then return end
	if (player.magic < magicCost) then notEnoughMP(player) return end
	
	player:sendAnimation(5, 0)
	player.magic = player.magic - magicCost
	player.attacker = player.ID
	player:addHealthExtend(heal, 0, 0, 0, 0, 0)
	player:sendStatus()
	player:sendAction(6, 40)
end,

requirements = function(player)

	txt = "\n- 50 Chesnut \n"
	txt = txt.."- 10 Snake meat \n"
	txt = txt.."- 1 Mountain Ginseng \n"
	txt = txt.."- 50 Coins"

	local level = 23
	local item = {43, 49, 46, 0}
	local amounts = {50, 10, 1, 50}
	local desc = {"Heal a small amount of health", "To learn this spell you must to sacriface"..txt..""}
	
	return level, item, amounts, desc
end
}