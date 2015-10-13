gangrel = {

on_learn = function(player) player.registry["learned_gangrel"] = 1 end,
on_forget = function(player) player.registry["learned_gangrel"] = 0 end,

cast = function(player, question)
	
	local magicCost = 500
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	if player.state ~= 0 or player:hasDuration("gangrel") or player:hasDuration("feral") or player:hasDuration("rodent") or player:hasDuration("beast") then
		player:sendMinitext("You can't do it")
		player:sendAnimation(246)
		return
	else
		if player.question ~= nil then
			q = string.lower(player.question)	
			if q == "w" then
				player.magic = player.magic - magicCost
				player:sendAnimation(3)
				player:playSound(36)
				player:sendMinitext("You cast gangrel")			
				player.registry["gangrel_wolf"] = 1
				player.disguise = 23
				player.disguiseColor = 5
				player:setDuration("gangrel", 60000)
				player.state = 4 
			elseif q == "f" then
				player.magic = player.magic - magicCost
				player:sendAnimation(3)
				player:playSound(36)
				player:sendMinitext("You cast gangrel")			
				player.registry["gangrel_fox"] = 1
				player.disguise = 22
				player.disguiseColor = 9
				player:setDuration("gangrel", 60000)
				player.state = 4
			end
			player:sendStatus()
			player:updateState()
		end
	end
end,

while_cast = function(player)

	if player.registry["gangrel_wolf"] == 1 then
		player.disguise = 23
		player.disguiseColor = 5
	elseif player.registry["gangrel_fox"] == 1 then
		player.disguise = 22
		player.disguiseColor = 9
	end
end,


uncast = function(player)
	
	player.disguise = 0
	player.disguiseColor = 0
	player:calcStat()
	player.registry["gangrel_fox"] = 0
	player.registry["gangrel_wolf"] = 0
	if player.state == 4 then player.state = 0 player:updateState() end
end,


requirements = function(player)
	
	local txt
	txt = "- 80 Chesnut \n"
	txt = txt.."- 10 Fox Fur \n"
	txt = txt.."- 100 Coins \n"
	
	local level = 25
	local item = {43, 12, 0}
	local amounts = {80, 10, 100}
	local desc = {"Transform to Wolf/Fox for manipulating your enemy", "To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}
	