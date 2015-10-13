steed = {
cast = function(player, mob)

	local magicCost = 100
	local aether
	local m = player.m
	local x = player.x
	local y = player.y
	local s = player.side
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player:setAether("steed", 30000)
	
	if player.side == 0 then
		if getPass(m,x,y-1) == 1 then
			if getPass(m,x+1,y) == 1 then
				if getPass(m,x-1,y) == 1 then
					if getPass(m,x,y+1) == 1 then player:sendAnimationXY(259,x,y) player:spawn(6,x,y,1) else
						player:sendAnimationXY(259,x,y+1)
						player:spawn(6,x,y+1,1)
					end
				else
					player:sendAnimationXY(259,x-1,y)
					player:spawn(6,x-1,y,1)
				end
			else
				player:sendAnimationXY(259,x+1,y)
				player:spawn(6,x+1,y,1)
			end
		else
			player:sendAnimationXY(259,x,y-1)
			player:spawn(6,x,y-1,1)
		end
	elseif player.side == 1 then
		if getPass(m,x+1,y) == 1 then
			if getPass(m,x,y-1) == 1 then
				if getPass(m,x,y+1) == 1 then
					if getPass(m,x-1,y) == 1 then player:sendAnimation(259) player:spawn(6,x,y,1) else
						player:sendAnimationXY(259,x-1,y)
						player:spawn(6,x-1,y,1)
					end
				else
					player:sendAnimationXY(259,x,y+1)
					player:spawn(6,x,y+1,1)
				end
			else
				player:sendAnimationXY(259,x,y-1)
				player:spawn(6,x,y-1,1)
			end
		else
			player:sendAnimationXY(259,x+1,y)
			player:spawn(6,x+1,y,1)
		end
	elseif player.side == 2 then
		if getPass(m,x,y+1) == 1 then
			if getPass(m,x+1,y) == 1 then
				if getPass(m,x-1,y) == 1 then
					if getPass(m,x,y-1) == 1 then player:spawn(6,x,y,1) player:sendAnimation(259) else
						player:sendAnimationXY(259,x,y-1)
						player:spawn(6,x,y-1,1)
					end
				else
					player:sendAnimationXY(259,x-1,y)
					player:spawn(6,x-1,y,1)
				end
			else
				player:sendAnimationXY(259,x+1,y)
			    player:spawn(6,x+1,y,1)
			end
		else
			player:sendAnimationXY(259,x,y+1)
		    player:spawn(6,x,y+1,1)
		end
	elseif player.side == 3 then
		if getPass(m,x-1,y) == 1 then
			if getPass(m,x,y-1) == 1 then
				if getPass(m,x,y+1) == 1 then
					if getPass(m,x+1,y) == 1 then player:sendAnimation(259) player:spawn(6,x,y,1) else
						player:sendAnimationXY(259,x+1,y)
						player:spawn(6,x+1,y,1)
					end
				else
					player:sendAnimationXY(259,x,y+1)
	                player:spawn(6,x,y+1,1)
				end
			else
				player:sendAnimationXY(259,x,y-1)
			    player:spawn(6,x,y-1,1)
			end
		else
			player:sendAnimationXY(259,x-1,y)
	        player:spawn(6,x-1,y,1)
		end
	end
	
	player:playSound(112)
	player:sendAction(6, 20)
	player:sendMinitext("You cast Steed")
end,
	
requirements = function(player)

	local level = 99
	local item = {"biji_kenari", "hartshorn"}	-- coins 100
	local amounts = {200, 10}
	local desc = {"Ability to summon a horse for ride"}
	return level, item, amounts, desc 
end
}










