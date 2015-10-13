invoke = {
on_learn = function(player) player.registry["learned_invoke"] = 1 end,
on_forget = function(player) player.registry["learned_invoke"] = 0 end,

cast = function(player)

	local aether = 0
	local healthCost = (player.maxMagic * .05)
	local magicCost = 100
	local chance = math.random(100)
	
	if (not player:canCast(1, 1, 0)) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	if 	player.health - healthCost < 1 then
		player.health = 100 
	else
		player.health = player.health - healthCost
	end
	
	player:sendStatus()
	if chance <= 65 then
		player.magic = player.magic - magicCost
		player:sendMinitext("Invoke Failed.")
		return
	else
		player:setAether("invoke", aether)
		player:sendAction(6, 20)
		player:sendAnimation(70)
		player:playSound(65)
		player.magic = player.maxMagic
		player:sendStatus()
		player:sendMinitext("You cast Invoke.")
	end
end,

requirements = function(player)
	
	txt = "- 100 Chesnut \n"
	txt = txt.. "- 5 Fresh Snake Meat \n"
	txt = txt.. "- 100 Coins \n"
	
	local level = 34
	local item = {43, 73, 0}		-- chesnut, fresh snake meat
	local amounts = {100, 5, 100}
	local desc = {"Convert your health into mana", "To learn this spell you must to sacriface:\n"..txt..""}
	return level, item, amounts, desc
end
}