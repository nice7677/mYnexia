sevennz = {
cast = function(player, mob)


		player:spawn(1001, player.x, player.y, 1)
		a = player:getObjectsInCell(player.m, player.x, player.y, BL_MOB)
		if #a > 0 then
			for i = 1, #a do
				if a[i].yname == "sevennz" then
					a[i].gfxShield = 65535
					a[i].gfxWeap = 65535
					a[i].gfxFaceA = 65535
					a[i].gfxFaceAT = 65535
					a[i].gfxNeck = 65535
					a[i].gfxHelm = 65535
					a[i].gfxCape = 65535
					a[i].gfxCrown = 65535
					a[i].gfxName = a[i].name
					a[i].gfxHair = 123
					a[i].gfxFace = 210
					a[i].gfxArmor = 216
					a[i].gfxArmorC = 23				
					a[i].gfxBoots = a[i].sex
					a[i].gfxClone = 1
					player.registry["sevennz"] = a[i].ID
				end
			end
		end

	player:refresh()
	player:sendAction(6, 20)
end,


move = function(mob, target)
	
	local side = math.random(0,3)
	local r = math.random(10)

	if mob.x < 68 or mob.y > 143 or mob.x >= 83 or mob.y <= 127 then
		if a == 1 then toXY(mob, 74, 138) end
		if a == 2 then toXY(mob, 78, 138) end
		if a == 3 then toXY(mob, 75, 141) end
	end		
	
	if r <= 3 then
		mob.side = math.random(0,3)
		mob:sendSide()
		if mob.side == side then
			mob:move()
		end
	end
	
end,


on_attacked = function(mob, attacker)

	mob.attacked = 0
	mob.target = 0
	local r = math.random(10)
	
	if attacker ~= nil then
		if attacker.x == mob.x -1 and attacker.side == 1 and attacker.y == mob.y then
			mob.side = 3
		elseif attacker.x == mob.x+1 and attacker.side == 3 and attacker.y == mob.y then
			mob.side = 1
		elseif attacker.x == mob.x and attacker.side == 2 and attacker.y == mob.y-1 then
			mob.side = 0
		elseif attacker.x == mob.x and attacker.side == 0 and attacker.y == mob.y+1 then
			mob.side = 2
		end
		mob:sendSide()
	end
	if r == 2 then mob:talk(0, "SevennZ: Apa??") end
end
}















