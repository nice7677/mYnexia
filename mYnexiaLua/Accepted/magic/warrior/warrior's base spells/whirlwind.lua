whirlwind = {
on_learn = function(player) player.registry["learned_whirlwind"] = 1 end,
on_forget = function(player) player.registry["learned_whirlwind"] = 0 end,

cast = function(player)

	local damage = player.health*2
	local mob = getTargetFacing(player,BL_MOB)
	local pc = getTargetFacing(player,BL_PC)
	local minHealth = 10000
	local threat
	local x = player.x
	local y = player.y
	local s = player.side
	
	if not player:canCast(1,1,0) then return end
	if player.health - minHealth <= 0 then return end
	if player.health < minHealth then player:sendAnimation(246) player:sendMinitext("Not Enough HP") return end

	player:sendAction(1, 20)
	player:playSound(1)
	player.health = 10
	player:sendAnimation(422)
	player:sendStatus()
	player:talk(2, "Die~!!!")
	player:setAether("whirlwind", 7000)
	
	if s == 0 then player:sendAnimationXY(7,x,y-1) end
	if s == 1 then player:sendAnimationXY(7,x+1,y) end
	if s == 2 then player:sendAnimationXY(7,x,y+1) end
	if s == 3 then player:sendAnimationXY(7,x-1,y) end
	
	if mob ~= nil then
		mob.attacker = player.ID
		threat = mob:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		player:addThreat(mob.ID, threat)
		mob:sendAnimation(424)
		mob:sendAnimation(423)
		mob:removeHealthExtend(damage, 1, 1, 1, 1, 0)
	elseif pc ~= nil then
		pc:sendAnimation(424)
		pc:sendAnimation(423)
		
		if player:canPK(pc) then
			pc:removeHealthExtend(damage, 1,1,1,1,0)
			pc.attacker = player.ID
			pc:sendMinitext(player.name.. " attack you with Whirlwind.")
		end
	end

end,

requirements = function(player)
	
	txt = "\n- 10000 Coins \n"
	txt = txt.."- 100 Chesnut \n"
	txt = txt.."- 1 Electra \n"
	txt = txt.."- 20 Dark Amber \n"

	local level = 99
	local item = {5, 43, 3015, 18008}
	local amounts = {10000, 100, 1, 20}
	local desc = {"Powerfull attack that based on maxHealth", "To learn this spell you must to sacriface "..txt..""}
	return level, item, amounts, desc
end

}
