rodent = {

on_learn = function(player) player.registry["learned_rodent"] = 1 end,
on_forget = function(player) player.registry["learned_rodent"] = 0 end,

cast = function(player, question)
	
	local magicCost = 500
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	if player.state ~= 0 or player:hasDuration("rodent") or player:hasDuration("feral") or player:hasDuration("gangrel") or player:hasDuration("beast") then
		player:sendMinitext("You can't do it")
		player:sendAnimation(246)
		return
	else
		if player.question ~= nil then
			q = string.lower(player.question)	
			if q == "s" then
				player.magic = player.magic - magicCost
				player:sendAnimation(3)
				player:playSound(36)
				player:sendMinitext("You cast Rodent")			
				player.registry["rodent_squirrel"] = 1
				player.disguise = 25
				player.disguiseColor = 5
				player:setDuration("rodent", 60000)
				player.state = 4 
			elseif q == "r" then
				player.magic = player.magic - magicCost
				player:sendAnimation(3)
				player:playSound(36)
				player:sendMinitext("You cast Rodent")			
				player.registry["rodent_rabbit"] = 1
				player.disguise = 21
				player.disguiseColor = 29
				player:setDuration("rodent", 60000)
				player.state = 4
			end
			player:sendStatus()
			player:updateState()
		end
	end
end,

while_cast = function(player)

	if player.registry["rodent_rabbit"] == 1 then
		player.disguise = 21
		player.disguiseColor = 29
	elseif player.registry["rodent_squirrel"] == 1 then
		player.disguise = 25
		player.disguiseColor = 5
	end
end,


uncast = function(player)
	
	player.disguise = 0
	player.disguiseColor = 0
	player:calcStat()
	player.registry["rodent_rabbit"] = 0
	player.registry["rodent_squirrel"] = 0
	if player.state == 4 then player.state = 0 player:updateState() end
end,


requirements = function(player)
	
	local txt
	txt = "- 80 Chesnut \n"
	txt = txt.."- 10 Rabbit Meat \n"
	txt = txt.."- 100 Coins \n"
	
	local level = 25
	local item = {43, 41, 100}
	local amounts = {80, 10, 100}
	local desc = {"Transform to rabbit/squirrel", "To learn this spell you must to sacriface "..txt.."\n"}
	return level, item, amounts, desc
end
}
	