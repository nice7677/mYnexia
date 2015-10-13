

shadow_sword = {

cast = function(player)

	local bow = player:getEquippedItem(EQ_WEAP)
	
	if bow ~= nil and bow.yname == "wooden_bow" then shadow_sword_bow.cast(player) return end
	
	local healthCost = player.health*.5
	local magicCost = 5000
	local x = player.x
	local y = player.y
	
	if player.registry["combo3"] >= os.time() then
		player.registry["combo3"] = 0
		combo4.cast(player)
		return
	else
		if not player:canCast(1,1,0) then player:sendAnimation(246) return end
		if player.magic < magicCost then notEnoughMP(player) return end
		
		player.magic = player.magic - magicCost
		player.health = player.health - healthCost
		player:sendStatus()
		
		ss_warp(player)

		player:playSound(358)
		player:sendAnimationXY(285,x,y)
		player:playSound(357)
		player:talk(2, "Shadow Sword~!!!!")
		player:setAether("shadow_sword", 15000)
	end
end
}


combo4 = {

cast = function(player)

	local x = player.x
	local y = player.y

	ss_warp(player)
	player:playSound(358)
	player:sendAnimationXY(285,x,y)
	player:playSound(357)
	player:talk(2, "!!!!~Combo~!!!!")
end
}



ss_warp = function(player)

	local s = player.side
	local x = player.x
	local m = player.m
	local y = player.y
	local mob

	if s == 0 then
		if getPass(m,x,y-1) == 0 and not getWarp(m,x,y-1) and player:objectCanMove(x,y-1, 0) then
			if getPass(m,x,y-2) == 0 and not getWarp(m,x,y-1) and player:objectCanMove(x,y-2, 0) then
				if getPass(m,x,y-3) == 0 and not getWarp(m,x,y-1) and player:objectCanMove(x,y-3, 0) then
					if getPass(m,x,y-4) == 0 and not getWarp(m,x,y-1) and player:objectCanMove(x,y-4, 0) then
						if getPass(m,x,y-5) == 0 and not getWarp(m,x,y-1) and player:objectCanMove(x,y-5, 0) then
							if getPass(m,x,y-6) == 0 and not getWarp(m,x,y-1) and player:objectCanMove(x,y-6, 0) then
								for i = 1, 6 do player:sendAnimationXY(257,x,y-i)
									mob = getTargetFacing(player, BL_MOB, 0, i)
									pc = getTargetFacing(player, BL_PC, 0, i)
									if pc ~= nil and player:canPK(pc) then removeHealthSS(player, pc) end
									if mob ~= nil then removeHealthSS(player, mob) end
								end
								player:warp(m,x,y-6)
							else
								for i = 1, 5 do player:sendAnimationXY(257,x,y-i)
									mob = getTargetFacing(player, BL_MOB, 0, i)
									pc = getTargetFacing(player, BL_PC, 0, i)
									if pc ~= nil and player:canPK(pc) then removeHealthSS(player, pc) end
									if mob ~= nil then removeHealthSS(player, mob) end									
								end
								player:warp(m,x,y-5)
							end
						else
							for i = 1, 4 do player:sendAnimationXY(257,x,y-i)
								mob = getTargetFacing(player, BL_MOB, 0, i)
								pc = getTargetFacing(player, BL_PC, 0, i)
								if pc ~= nil and player:canPK(pc) then removeHealthSS(player, pc) end
								if mob ~= nil then removeHealthSS(player, mob) end							
							end
							player:warp(m,x,y-4)
						end
					else
						for i = 1, 3 do player:sendAnimationXY(257,x,y-i)
							mob = getTargetFacing(player, BL_MOB, 0, i)
							pc = getTargetFacing(player, BL_PC, 0, i)
							if pc ~= nil and player:canPK(pc) then removeHealthSS(player, pc) end
							if mob ~= nil then removeHealthSS(player, mob) end
						end
						player:warp(m,x,y-3)
					end
				else
					for i = 1, 2 do player:sendAnimationXY(257,x,y-i)
						mob = getTargetFacing(player, BL_MOB, 0, i)
						pc = getTargetFacing(player, BL_PC, 0, i)
						if pc ~= nil and player:canPK(pc) then removeHealthSS(player, pc) end
					    if mob ~= nil then removeHealthSS(player, mob) end	
					end
					player:warp(m,x,y-2)
				end
			else
				player:sendAnimationXY(257,x,y-1)
				player:warp(m,x,y-1)
			end
		end
		player:sendAction(1, 20)
	
	elseif s == 1 then
		if getPass(m,x+1,y) == 0 then
			if getPass(m,x+2,y) == 0 then
				if getPass(m,x+3,y) == 0 then
					if getPass(m,x+4,y) == 0 then
						if getPass(m,x+5,y) == 0 then
							if getPass(m,x+6,y) == 0 then
								for i = 1, 6 do player:sendAnimationXY(257,x+i,y)
									mob = getTargetFacing(player, BL_MOB, 0, i)
									pc = getTargetFacing(player, BL_PC, 0, i)
									if pc ~= nil and player:canPK(pc) then removeHealthSS(player, pc) end
								    if mob ~= nil then removeHealthSS(player, mob) end	
								end
								player:warp(m,x+6,y)
							else
								for i = 1, 5 do player:sendAnimationXY(257,x+i,y)
									mob = getTargetFacing(player, BL_MOB, 0, i)
									pc = getTargetFacing(player, BL_PC, 0, i)
									if pc ~= nil and player:canPK(pc) then removeHealthSS(player, pc) end
									if mob ~= nil then removeHealthSS(player, mob) end	
								end
								player:warp(m,x+5,y)
							end
						else
							for i = 1, 4 do player:sendAnimationXY(257,x+i,y)
								mob = getTargetFacing(player, BL_MOB, 0, i)
								pc = getTargetFacing(player, BL_PC, 0, i)
								if pc ~= nil and player:canPK(pc) then removeHealthSS(player, pc) end
							    if mob ~= nil then removeHealthSS(player, mob) end	
							end
							player:warp(m,x+4,y)
						end
					else
						for i = 1, 3 do player:sendAnimationXY(257,x+i,y)
							mob = getTargetFacing(player, BL_MOB, 0, i)
							pc = getTargetFacing(player, BL_PC, 0, i)
							if pc ~= nil and player:canPK(pc) then removeHealthSS(player, pc) end
						    if mob ~= nil then removeHealthSS(player, mob) end	
						end
						player:warp(m,x+3,y)
					end
				else
					for i = 1, 2 do player:sendAnimationXY(257,x+i,y)
						mob = getTargetFacing(player, BL_MOB, 0, i)
						pc = getTargetFacing(player, BL_PC, 0, i)
						if pc ~= nil and player:canPK(pc) then removeHealthSS(player, pc) end
					    if mob ~= nil then removeHealthSS(player, mob) end	
					end
					player:warp(m,x+2,y)
				end
			else
				player:sendAnimationXY(257,x+1,y)
				player:warp(m,x+1,y)
			end
		end
		
	elseif s == 2 then
		if getPass(m,x,y+1) == 0 and not getWarp(m,x,y+1) and player:objectCanMove(x,y+1,0) then
			if getPass(m,x,y+2) == 0 and not getWarp(m,x,y+1) and player:objectCanMove(x,y+2,0) then
				if getPass(m,x,y+3) == 0 and not getWarp(m,x,y+1) and player:objectCanMove(x,y+3,0) then
					if getPass(m,x,y+4) == 0 and not getWarp(m,x,y+1) and player:objectCanMove(x,y+4,0) then
						if getPass(m,x,y+5) == 0 and not getWarp(m,x,y+1) and player:objectCanMove(x,y+5,0) then
							if getPass(m,x,y+6) == 0 and not getWarp(m,x,y+1) and player:objectCanMove(x,y+6,0) then
								for i = 1, 6 do player:sendAnimationXY(257,x,y+i)
									mob = getTargetFacing(player, BL_MOB, 0, i)
									pc = getTargetFacing(player, BL_PC, 0, i)
									if pc ~= nil and player:canPK(pc) then removeHealthSS(player, pc) end
								    if mob ~= nil then removeHealthSS(player, mob) end
								end
								player:warp(m,x,y+6)
							else
								for i = 1, 5 do player:sendAnimationXY(257,x,y+i)
									mob = getTargetFacing(player, BL_MOB, 0, i)
									pc = getTargetFacing(player, BL_PC, 0, i)
									if pc ~= nil and player:canPK(pc) then removeHealthSS(player, pc) end
								    if mob ~= nil then removeHealthSS(player, mob) end	
								end
								player:warp(m,x,y+5)
							end
						else
							for i = 1, 4 do player:sendAnimationXY(257,x,y+i)
								mob = getTargetFacing(player, BL_MOB, 0, i)
								pc = getTargetFacing(player, BL_PC, 0, i)
								if pc ~= nil and player:canPK(pc) then removeHealthSS(player, pc) end
								if mob ~= nil then removeHealthSS(player, mob) end	
							end
							player:warp(m,x,y+4)
						end
					else
						for i = 1, 3 do player:sendAnimationXY(257,x,y+i)
							mob = getTargetFacing(player, BL_MOB, 0, i)
							pc = getTargetFacing(player, BL_PC, 0, i)
							if pc ~= nil and player:canPK(pc) then removeHealthSS(player, pc) end
						    if mob ~= nil then removeHealthSS(player, mob) end	
						end
						player:warp(m,x,y+3)
					end
				else
					for i = 1, 2 do player:sendAnimationXY(257,x,y+i)
						mob = getTargetFacing(player, BL_MOB, 0, i)
						pc = getTargetFacing(player, BL_PC, 0, i)
						if pc ~= nil and player:canPK(pc) then removeHealthSS(player, pc) end
					    if mob ~= nil then removeHealthSS(player, mob) end	
					end
					player:warp(m,x,y+2)
				end
			else
				player:sendAnimationXY(257,x,y+1)
				player:warp(m,x,y+1)
			end
		end
		
	elseif s == 3 then
		if getPass(m,x-1,y) == 0 then
			if getPass(m,x-2,y) == 0 then
				if getPass(m,x-3,y) == 0 then
					if getPass(m,x-4,y) == 0 then
						if getPass(m,x-5,y) == 0 then
							if getPass(m,x-6,y) == 0 then
								for i = 1, 6 do player:sendAnimationXY(257,x-i,y)
									mob = getTargetFacing(player, BL_MOB, 0, i)
									pc = getTargetFacing(player, BL_PC, 0, i)
									if pc ~= nil and player:canPK(pc) then removeHealthSS(player, pc) end
								    if mob ~= nil then removeHealthSS(player, mob) end	
								end
								player:warp(m,x-6,y)
							else
								for i = 1, 5 do player:sendAnimationXY(257,x-i,y)
									mob = getTargetFacing(player, BL_MOB, 0, i)
									pc = getTargetFacing(player, BL_PC, 0, i)
									if pc ~= nil and player:canPK(pc) then removeHealthSS(player, pc) end
								    if mob ~= nil then removeHealthSS(player, mob) end	
								end
								player:warp(m,x-5,y)
							end
						else
							for i = 1, 4 do player:sendAnimationXY(257,x-i,y)
								mob = getTargetFacing(player, BL_MOB, 0, i)
								pc = getTargetFacing(player, BL_PC, 0, i)
								if pc ~= nil and player:canPK(pc) then removeHealthSS(player, pc) end
							    if mob ~= nil then removeHealthSS(player, mob) end	
							end
							player:warp(m,x-4,y)
						end
					else
						for i = 1, 3 do player:sendAnimationXY(257,x-i,y)
							mob = getTargetFacing(player, BL_MOB, 0, i)
							pc = getTargetFacing(player, BL_PC, 0, i)
							if pc ~= nil and player:canPK(pc) then removeHealthSS(player, pc) end
						    if mob ~= nil then removeHealthSS(player, mob) end	
						end
						player:warp(m,x-3,y)
					end
				else
					for i = 1, 2 do player:sendAnimationXY(257,x-i,y)
						mob = getTargetFacing(player, BL_MOB, 0, i)
							pc = getTargetFacing(player, BL_PC, 0, i)
						if pc ~= nil and player:canPK(pc) then removeHealthSS(player, pc) end
					    if mob ~= nil then removeHealthSS(player, mob) end	
					end
					player:warp(m,x-2,y)
				end
			else
				player:sendAnimationXY(257,x-1,y)
				player:warp(m,x-1,y)
			end
		end
	end
	player:sendAction(1, 20)
end


removeHealthSS = function(player, block)
	
	local damage = player.magic*.5 + player.health*.5
	local threat
	
	block.attacker = player.ID
	if block.blType == BL_MOB then
		threat = block:removeHealthExtend(damage, 1,1,1,1,2)
		player:addThreat(block.ID, threat)
		block:removeHealthExtend(damage, 1,1,1,1,0)
	elseif block.blType == BL_PC then
		if player:canPK(block) and block.state ~= 1 then
			block:removeHealthExtend(damage, 1,1,1,1,0)
			block:sendMinitext(player.name.." attack you with Shadow Sword")
		end
	end
end










































		