annoint = {

on_learn = function(player) player.registry["learn_annoint"] = 1 end,
on_forget = function(player) player.registry["learn_annoint"] = 0 end,

cast = function(player)

	local magicCost = 500
	local g = player.group
	local heal = math.random(1500, 3000)
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendAnimation(66)
	player:playSound(4)
	player:sendAction(6, 20)
	player:sendMinitext("You cast Annoint")
	
	if #g > 0 then
		for i = 1, #g do
			if Player(g[i]).state ~= 1 and Player(g[i]).m == player.m then
				if distanceSquare(player, Player(g[i]), 7) then
					Player(g[i]):sendAnimation(66)
					player:playSound(4)
					Player(g[i]):sendMinitext(player.name.." cast Annoint on you")
					addHealth(Player(g[i]), heal)
				end
			end
		end
	end
end,


requirements = function(player)

	txt = "- 30 Chesnut \n"
	txt = txt.."- 5 Hartshorn \n"
	txt = txt.."- 100 Coins \n"
	
	local level = 33
	local item = {43, 63, 0}
	local amounts = {30, 5, 100}
	local desc = {"Heal a medium amount of health of your party member", "To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}