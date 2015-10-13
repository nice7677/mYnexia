love_wand1 = {
on_swing = function(player)
	local pc = {}
	local mob = {}

--[[		
	for i = 1, 5 do
		if player.side == 0 then player:sendAnimationXY(339, player.x, player.y-i) end
		if player.side == 1 then player:sendAnimationXY(339, player.x+i, player.y) end
		if player.side == 2 then player:sendAnimationXY(339, player.x, player.y+i) end
		if player.side == 3 then player:sendAnimationXY(339, player.x-i, player.y) end
		
		if target ~= nil then
			target[i]:sendAction(14, 20)
		end
		
]]--	
	
	if player.side == 2 then
		player:sendAnimationXY(339, player.x, player.y+1)
		player:sendAnimationXY(339, player.x, player.y+2)
		player:sendAnimationXY(339, player.x-1, player.y+3)
		player:sendAnimationXY(339, player.x-2, player.y+4)
		player:sendAnimationXY(339, player.x-1, player.y+5)
		player:sendAnimationXY(339, player.x, player.y+6)
		player:sendAnimationXY(339, player.x+1, player.y+5)
		player:sendAnimationXY(339, player.x+2, player.y+4)
		player:sendAnimationXY(339, player.x+1, player.y+3)
	elseif player.side == 3 then
		player:sendAnimationXY(339, player.x-1, player.y)
		player:sendAnimationXY(339, player.x-2, player.y)
		player:sendAnimationXY(339, player.x-3, player.y-1)
		player:sendAnimationXY(339, player.x-4, player.y-2)
		player:sendAnimationXY(339, player.x-5, player.y-1)
		player:sendAnimationXY(339, player.x-6, player.y)
		player:sendAnimationXY(339, player.x-5, player.y+1)
		player:sendAnimationXY(339, player.x-4, player.y+2)
		player:sendAnimationXY(339, player.x-3, player.y+1)
	elseif player.side == 0 then
		player:sendAnimationXY(339, player.x, player.y-1)
		player:sendAnimationXY(339, player.x, player.y-2)
		player:sendAnimationXY(339, player.x+1, player.y-3)
		player:sendAnimationXY(339, player.x+2, player.y-4)
		player:sendAnimationXY(339, player.x+1, player.y-5)
		player:sendAnimationXY(339, player.x, player.y-6)
		player:sendAnimationXY(339, player.x-1, player.y-5)
		player:sendAnimationXY(339, player.x-2, player.y-4)
		player:sendAnimationXY(339, player.x-1, player.y-3)
	elseif player.side == 1 then
		player:sendAnimationXY(339, player.x+1, player.y)
		player:sendAnimationXY(339, player.x+2, player.y)
		player:sendAnimationXY(339, player.x+3, player.y+1)
		player:sendAnimationXY(339, player.x+4, player.y+2)
		player:sendAnimationXY(339, player.x+5, player.y+1)
		player:sendAnimationXY(339, player.x+6, player.y)
		player:sendAnimationXY(339, player.x+5, player.y-1)
		player:sendAnimationXY(339, player.x+4, player.y-2)
		player:sendAnimationXY(339, player.x+3, player.y-1)			
	end	
end

		



}
