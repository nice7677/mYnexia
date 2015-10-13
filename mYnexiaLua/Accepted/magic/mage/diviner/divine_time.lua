divine_time = {
on_learn = function(player) player.registry["learned_divine_time"]=1 end,
on_forget = function(player) player.registry["learned_divine_time"]=0 end,

cast = function(player)

	local mobTarget = player:getObjectsInArea(BL_MOB)
	local pcTarget = player:getObjectsInArea(BL_PC)
	local aether = 60000
	local duration = 10000
	local magicCost = 5000
	
	if not player:canCast(1, 1, 0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player:sendAction(6, 20)
	player:talk(2, "Divine Time ~!!!")
	player:playSound(731)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:setAether("divine_time", aether)
	player:sendMinitext("You cast Divine Time")
		
	if #mobTarget > 0 then	
		for i = 1, #mobTarget do	
			if distanceSquare(player, mobTarget[i], 3) then	
				mobTarget[i]:setDuration("divine_time", 7000)	
				mobTarget[i]:sendAnimation(186)	
				mobTarget[i].paralyzed = true	
			end	
		end	
	end	
	if #pcTarget > 0 then	
		for i = 1, #pcTarget do
			if pcTarget[i].ID == player.ID then return else
				if distanceSquare(player, pcTarget[i], 3) then	
					if player:canPK(pcTarget[i]) then	
						pcTarget[i]:setDuration("divine_time", 7000)	
						pcTarget[i]:sendAnimation(186)	
					end	
				end	
			end
		end	
	end
end,

while_cast = function(block)
	
	if block.blType == BL_PC then
		block.sleep = 2
	elseif block.blType == BL_MOB then
		block.paralyzed = true
	end
	block:sendAnimation(235)
end,


uncast = function(block)
	
	block.sleep = 0
	block.paralyzed = false
	block:calcStat()

end,

recast = function(player) player.paralyzed = true end
}