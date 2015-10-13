burst = {
on_learned = function(player) player.registry["learned_burst"] = 1 end,
on_forget = function(player) player.registry["learned_burst"] = 0 end,

cast = function(player)

	local magicCost = 1000
	local m = player.m
	local x = player.x
	local y = player.y
	local s = player.side
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player.magic = player.magic - magicCost
	player:sendStatus()
--	player:sendAnimationXY(279, player.x, player.y)

	if s == 0 then
		pc = player:getObjectsInCell(m,x,y-3, BL_PC)
		mob = player:getObjectsInCell(m,x,y-3, BL_MOB)
		npc = player:getObjectsInCell(m,x,y-3, BL_NPC)
	
		if player:objectCanMoveFrom(x,y,0) then
			if getPass(m,x,y-1) == 0 and player:objectCanMove(x,y-1,0) then
				if getPass(m,x,y-2) == 0 and player:objectCanMove(x,y-2,0) then
					if getPass(m,x,y-3) == 0 and player:objectCanMove(x,y-3,0) then
						if pc[1] ~= nil or mob[1] ~= nil or npc[1] ~= nil then player:warp(m,x,y-2) else
							player:warp(m,x,y-3)
						end
					else
						player:warp(m,x,y-2)
					end
				else
					player:warp(m,x,y-1)
				end
			end
		end
	elseif s == 1 then
		pc = player:getObjectsInCell(m,x+3,y, BL_PC)
		mob = player:getObjectsInCell(m,x+3,y, BL_MOB)
		npc = player:getObjectsInCell(m,x+3,y, BL_NPC)
		
		if getPass(m,x+1,y) == 0 then	
			if getPass(m,x+2,y) == 0 then	
				if getPass(m,x+3,y) == 0 then
					if pc[1] ~= nil or mob[1] ~= nil or npc[1] ~= nil then player:warp(m,x+2,y) else
						player:warp(m,x+3,y)
					end
				else	
					player:warp(m,x+2,y)	
				end	
			else	
				player:warp(m,x+1,y)	
			end	
		end	
	elseif s == 2 then
		pc = player:getObjectsInCell(m,x,y+3, BL_PC)
		mob = player:getObjectsInCell(m,x,y+3, BL_MOB)
		npc = player:getObjectsInCell(m,x,y+3, BL_NPC)
		
		if getPass(m,x,y+1) == 0 and player:objectCanMove(x,y+1,0) then
			if getPass(m,x,y+2) == 0 and player:objectCanMove(x,y+2,0) then
				if getPass(m,x,y+3) == 0 and player:objectCanMove(x,y+3,0) then
					if pc[1] ~= nil or mob[1] ~= nil or npc[1] ~= nil then player:warp(m,x,y+2) else
						player:warp(m,x,y+3)
					end
				else
					player:warp(m,x,y+2)	
				end	
			else	
				player:warp(m,x,y+1)	
			end	
		end	
	elseif s == 3 then
		pc = player:getObjectsInCell(m,x-3,y, BL_PC)
		mob = player:getObjectsInCell(m,x-3,y, BL_MOB)
		npc = player:getObjectsInCell(m,x-3,y, BL_NPC)
		
		if getPass(m,x-1,y) == 0 then	
			if getPass(m,x-2,y) == 0 then	
				if getPass(m,x-3,y) == 0 then
					if pc[1] ~= nil or mob[1] ~= nil or npc[1] ~= nil then player:warp(m,x-2,y) else
						player:warp(m,x-3,y)
					end
				else	
					player:warp(m,x-2,y)	
				end	
			else	
				player:warp(m,x-1,y)	
			end	
		end	
	end
	
	player:sendAction(6, 20)
	player:playSound(30)
	player:sendAnimation(280)
	player:sendAnimationXY(279, player.x, player.y)
	player:sendMinitext("You cast Burst")
end
}