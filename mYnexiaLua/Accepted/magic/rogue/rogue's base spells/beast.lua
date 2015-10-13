beast = {

on_learn = function(player) player.registry["learned_beast"] = 1 end,
on_forget = function(player) player.registry["learned_beast"] = 0 end,

cast = function(player, question)
	
	local magicCost = 500
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	if player.state ~= 0 or player:hasDuration("beast") or player:hasDuration("feral") or player:hasDuration("rodent") or player:hasDuration("gangrel") then
		player:sendMinitext("You can't do it")
		player:sendAnimation(246)
		return
	else
		if player.question ~= nil then
			q = string.lower(player.question)	
			if q == "b" then
				player:sendAnimation(178)
				player.magic = player.magic - magicCost
				player.disguise = 622
				player.disguiseColor = 0
				player:playSound(92)
				player:sendMinitext("You cast beast")	
				player.registry["beast_bear"] = 1
				player:setDuration("beast", 60000)
				player.state = 4
				
			elseif q == "t" then
				player:sendAnimation(178)
				player.magic = player.magic - magicCost
				player.disguise = 869
				player.disguiseColor = 0		
				player:playSound(92)
				player:sendMinitext("You cast beast")			
				player.registry["beast_tiger"] = 1
				player:setDuration("beast", 60000)
				player.state = 4

			end
			player:sendStatus()
			player:updateState()
		end
	end
end,

while_cast = function(player)

	if player.registry["beast_bear"] == 1 then
		player.disguise = 622
		player.disguiseColor = 0
	elseif player.registry["beast_tiger"] == 1 then
		player.disguise = 869
		player.disguiseColor = 0
	end	
	player.attackSpeed = 20
end,


uncast = function(player)
	
	player.disguise = 0
	player.disguiseColor = 0
	player:calcStat()
	player.registry["beast_bear"] = 0
	player.registry["beast_tiger"] = 0
	if player.state == 4 then player.state = 0 player:updateState() end
end,


requirements = function(player)
	
	local txt
	txt = "- 80 Chesnut \n"
	txt = txt.."- 20 Bear's Heart \n"
	txt = txt.."- 20 Tiger's Meat \n"
	txt = txt.."- 100 Coins \n"
	
	local level = 40
	local item = {43, 52, 55, 0}
	local amounts = {80, 20, 20, 100}
	local desc = {"Transform to Bear/Tiger", "To learn this spell you must to sacriface "..txt..""}
	return level, item, amounts, desc
end
}
	