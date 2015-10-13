sho_spirit = {

on_learn = function(player) player.registry["learned_sho_spirit"] = 1 end,
on_forget = function(player) player.registry["learned_sho_spirit"] = 0 end,

cast = function(player)

	local m = player.m
	local x = player.x
	local y = player.y
	local s = player.side
	local healthCost = player.health*.5
	local magicCost = 5000
	local mob
	local pass
	local dam = player.health*1.2
	local threat
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player:setAether("sho_spirit", 60000)
	player.health = player.health - healthCost
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Sho Spirit")
	player:playSound(101)
	player:sendAction(1, 20)
	
	for i = 1, 3 do
		mob = getTargetFacing(player, BL_MOB, 0, i)
		pc = getTargetFacing(player, BL_PC, 0, i)
		
		if mob ~= nil then
			player:sendAction(1, 20)
			mob:sendAnimation(153)
			mob:sendAnimation(97)
			player:playSound(101)
			mob.attacker = player.ID
			threat = mob:removeHealthExtend(dam, 1,1,1,1,2)
			player:addThreat(mob.ID, threat)
			mob:removeHealthExtend(dam, 1,1,1,1,0)
			return
		elseif pc ~= nil then
			player:sendAction(1, 20)
			pc:sendAnimation(153)
			pc:sendAnimation(97)
			player:playSound(101)
			if player:canPK(pc) and pc.state ~= 1 then
				pc.attacker = player.ID
				pc:removeHealthExtend(dam, 1,1,1,1,0)
				pc:sendMinitext(player.name.." hit you with Sho Spirit!")
				return
			end
		end
		
		if s == 0 then
			if getPass(m,x,y-i) == 1 then player:sendAction(1, 20) return else
				if getWarp(m,x,y-i) and player:objectCanMove(x,y-i,1) then player:sendAction(1, 20) return else
					player:warp(m,x,y-i)
				end
			end
		elseif s == 1 then
			if getPass(m,x+i,y) == 1 then player:sendAction(1, 20) return else
				player:warp(m,x+i,y)
			end
		elseif s == 2 then
			if getPass(m,x,y+i) == 1 then player:sendAction(1, 20) return else
				if getWarp(m,x,y+i) and player:objectCanMove(x,y+i,1) then player:sendAction(1, 20) return else
					player:warp(m,x,y+i)
				end
			end
		elseif s == 3 then
			if getPass(m,x,y) == 1 then player:sendAction(1, 20) return else
				player:warp(m,x-i,y)
			end
		end
	end
	
	player:sendAnimationXY(285, x,y)
	player:playSound(101)
	player:sendAction(1, 20)
	if s == 0 then
		player:sendAnimationXY(153, x, y-4)
	elseif s == 1 then
		player:sendAnimationXY(153, x+4, y)
	elseif s == 2 then
		player:sendAnimationXY(153, x, y+4)
	elseif s == 3 then
		player:sendAnimationXY(153, x-4, y)
	end
	player:talk(2, "Sho Spirit~!!!")
end
}






