vital_spark = {

on_learn = function(player) player.registry["learn_vital_spark"] = 1 end,
on_forget = function(player) player.registry["learn_vital_spark"] = 0 end,

cast = function(player)

	local magicCost = 100
	local g = player.group
	local heal = math.random(200, 250)
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendAnimation(5)
	player:playSound(3)
	player:sendAction(6, 20)
	player:sendMinitext("You cast Vital Spark")

	if #g > 0 then
		for i = 1, #g do
			if Player(g[i]).state ~= 1 and Player(g[i]).m == player.m then
				if distanceSquare(player, Player(g[i]), 7) then
					Player(g[i]):sendAnimation(5)
					player:playSound(3)
					Player(g[i]):sendMinitext(player.name.." cast Vital Spark on you")
					addHealth(Player(g[i]), heal)
				end
			end
		end
	end
end,


requirements = function(player)

	txt = "- 50 Chesnut \n"
	txt = txt.."- 100 Coins \n"
	
	local level = 23
	local item = {43, 0}
	local amounts = {50, 100}
	local desc = {"Heal a small amount of health of your party member", "To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}