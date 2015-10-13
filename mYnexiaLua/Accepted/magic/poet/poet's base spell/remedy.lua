remedy = {

on_learn = function(player) player.registry["learn_remedy"] = 1 end,
on_forget = function(player) player.registry["learn_remedy"] = 0 end,

cast = function(player)

	local magicCost = 1000
	local g = player.group
	local heal = math.random(3000, 5500)
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendAnimation(66)
	player:playSound(4)
	player:sendAction(6, 20)
	player:sendMinitext("You cast Remedy")
	
	if #g > 0 then
		for i = 1, #g do
			if Player(g[i]).state ~= 1 and Player(g[i]).m == player.m then
				if distanceSquare(player, Player(g[i]), 7) then
					Player(g[i]):sendAnimation(66)
					player:playSound(4)
					Player(g[i]):sendMinitext(player.name.." cast Remedy on you")
					addHealth(Player(g[i]), heal)
				end
			end
		end
	end
end,


requirements = function(player)

	txt = "- 60 Chesnut \n"
	txt = txt.."- 20 Fox fur \n"
	txt = txt.."- 500 Coins \n"
	
	local level = 55
	local item = {43, 12, 0}
	local amounts = {60, 20, 500}
	local desc = {"Heal a large amount of health of your party member", "To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}