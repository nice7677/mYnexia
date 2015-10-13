demon_body = {

on_learn = function(player) player.registry["learned_demon_body"] = 1 end,
on_forget = function(player) player.registry["learned_demon_body"] = 0 end,

cast = function(player, target)
	
	local magicCost = player.magic*.1
	
	if not player:canCast(1,1,0) then return end
	
	if target:hasDuration("demon_body") then
		anim(player)
		player:sendMinitext("Spell already cast!")
	return else
		if target.blType == BL_MOB then
			player:sendAction(6, 20)
			target:sendAnimation(96)
			player:playSound()
			target:setDuration("demon_body", 15000, player.ID, 1)
			player:sendMinitext("You cast Demon body")
			player:setAether("demon_body", 20000)
			player.magic = player.magic - magicCost
		elseif target.blType == BL_PC then
			if target.state ~= 1 and player:canPK(target) then
				player:sendAction(6, 20)
				target:sendAnimation(96)
				player:playSound()
				target:setDuration("demon_body", 15000, player.ID, 1)
				target:sendMinitext(player.name.." attack you with Demon body")
				player:sendMinitext("You cast Demon body")
				player:setAether("demon_body", 20000)
				player.magic = player.magic - magicCost
			end
		end
	end
	
	player:sendStatus()
end,


while_cast = function(block, caster)

	if caster ~= nil then
		local damage = math.ceil(caster.magic*.3)
		if block.blType == BL_PC then
			if caster:canPK(block) then
				block.attacker = caster.ID
				block:sendAnimation(97)
				block:removeHealthExtend(damage, 1,1,1,1,0)
			end
		elseif block.blType == BL_MOB then
			block.attacker = caster.ID
			block:sendAnimation(97)			
			block:removeHealthExtend(damage, 1,1,1,1,0)
		end
	end
end,


uncast = function(block)

	block:calcStat()
end
}




















