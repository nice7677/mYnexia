lethal_strike = {

on_learn = function(player) player.registry["learned_lethal_strike"] = 1 end,
on_forget = function(player) player.registry["learned_lethal_strike"] = 0 end,


cast = function(player)
	
	local weap = player:getEquippedItem(EQ_WEAP)
	if weap ~= nil and weap.yname == "wooden_bow" then
		lethal_strike_bow.cast(player)
		return
	end
	
	local chance = math.random(100)
	local heal = player.baseHealth*.1
	local mob = getTargetFacing(player, BL_MOB)
	local pc = getTargetFacing(player, BL_PC)
	local d = player.health*.5 + player.magic*.5
	local healthCost = player.health*.5
	local magicCost = 1000
	local threat
	
	if (not player:canCast(1, 1, 0)) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if(player.side==0) then player:sendAnimationXY(69, player.x, player.y-1) end
	if(player.side==1) then player:sendAnimationXY(69, player.x+1, player.y) end
	if(player.side==2) then player:sendAnimationXY(69, player.x, player.y+1) end
	if(player.side==3) then player:sendAnimationXY(69, player.x-1, player.y) end
	
	player:sendAction(1, 20)
	player.health = player.health - healthCost
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:playSound(90)
	player:setAether("lethal_strike", 1000)
	player.registry["combo1"] = os.time()+1
	player:sendMinitext("You cast Lethal Strike")
	player:talk(2, "Strike~!!!")
	
	if mob ~= nil then
		if chance > 90 then player:sendAnimation(63) player:addHealth(heal) end
		mob.attacker = player.ID
		threat = mob:removeHealthExtend(d, 1, 1, 1, 1, 2)
		player:addThreat(mob.ID, threat)
		mob:sendAnimation(331)
		mob:removeHealthExtend(d, 1, 1, 1, 1, 0)
			
	elseif pc ~= nil then
		if player:canPK(pc) then
			if chance > 90 then player:sendAnimation(63) player:addHealth(heal) end
			pc.attacker = player.ID
			pc:sendAnimation(331)
			pc:removeHealthExtend(d, 1, 1, 1, 1, 0)
			pc:sendMinitext(player.name.. " attack you with Lethal Strike!!")
		end
	end
end,


requirements = function(player)
	
	local txt
	txt = "- 1 Titanium Glove \n"
	txt = txt.."- 1 Sacred Ring \n"
	txt = txt.."- 1 Whisper Bracelet \n"

	local level = 99
	local item = {7038,7039, 7040}
	local amounts = {1,1,1}
	local desc = {"Strike to target", "To learn this spell you must to sacriface \n"..txt..""}
	return level, item, amounts, desc
end
}






















		