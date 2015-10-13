blitz_beat = {

cast = function(player, target)

	local weap = player:getEquippedItem(EQ_WEAP)
	
	if weap ~= nil and weap.yname == "wooden_bow" then
		if target:hasDuration("blitz_beat") then
			player:sendAnimation(246)
			player:sendMinitext("Spell already Cast!")
			return
		else
			player:playSound(705)
			player:talk(2, "Blitz Beat~!!!")
			player:sendAction(2, 30)
			target:sendAnimationXY(244, target.x, target.y)
			if target.blType == BL_MOB then
				target:setDuration("blitz_beat", 4000, player.ID, 1)
			elseif target.blType == BL_PC then
				if player:canPK(target) then
					target:setDuration("blitz_beat", 4000, player.ID, 1)
				end
			end
			-- player:setAether("blitz_beat", 60000)
		end
	else
		anim(player)
		player:sendMinitext("Require a bow to use this spell")
	end
end,


while_cast_250 = function(block, caster)

	local damage = caster.health*.05 + caster.magic*.05
	local threat

	local pc = block:getObjectsInArea(BL_PC)	
	local mob = block:getObjectsInArea(BL_MOB)	
	if #pc > 0 then	
		for i = 1, #pc do	
			if distanceSquare(block, pc[i], 2) then	
				if caster:canPK(pc[i]) then
					if pc[i].state ~= 1 then
						pc[i].attacker = caster.ID	
						pc[i]:removeHealthExtend(damage,1,1,1,1,0)
					end
				end	
			end	
		end	
	elseif #mob > 0 then	
		for i = 1, #mob do	
			if distanceSquare(block, mob[i], 2) then	
				mob[i].attacker = caster.ID	
				threat = mob[i]:removeHealthExtend(damage,1,1,1,1,2)	
				caster:addThreat(mob[i].ID, threat)	
				mob[i]:removeHealthExtend(damage,1,1,1,1,0)	
			end	
		end	
	end	
	
	block:removeHealthExtend(damage, 1,1,1,1,0)
end,

while_cast_125 = function(block)

	local x = math.random(block.x-2, block.x+2)
	local y = math.random(block.y-2, block.y+2)

	block:playSound(705)
	block:playSound(105)
	block:playSound(364)
	block:playSound(343)
	block:sendAnimationXY(244, x, y)
	block:sendAnimationXY(332, x, y)
end,

uncast = function(block)

	block:calcStat()
	block:playSound(508)
	block:playSound(511)
end
}
