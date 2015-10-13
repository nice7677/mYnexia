myvoes = {
cast = function(player, mob)


		player:spawn(1000, player.x, player.y, 1)
		a = player:getObjectsInCell(player.m, player.x, player.y, BL_MOB)
		if #a > 0 then
			for i = 1, #a do
				if a[i].yname == "myvoes" then
					a[i].gfxHair = 30
					a[i].gfxName = a[i].name
					a[i].gfxFace = 207
					a[i].gfxFaceA = 65535
					a[i].gfxFaceAT = 65535
					a[i].gfxNeck = 65535
					a[i].gfxArmor = 10114
					a[i].gfxCrown = 239
					a[i].gfxCrownC = 5
					a[i].gfxHelm = 65535
					a[i].gfxCape = 65535
					a[i].gfxArmorC = 37
					a[i].gfxShield = 65535
					a[i].gfxWeap = 65535
					a[i].gfxBoots = a[i].sex
					a[i].gfxClone = 1
					player:refresh()
					player.registry["myvoes"] = a[i].ID
				end
			end
		end

	player:refresh()
	player:sendAction(6, 20)
end,

move = function(mob, target)
	
	local side = math.random(0,3)
	local a = math.random(5)
	local r = math.random(20)
	local pc = mob:getObjectsInArea(BL_PC)
	
	if mob:hasDuration("minal_aidin") then return end

	if #pc > 0 then
		for i = 1, #pc do
			if pc[i].registry["called_myvoes"] >= os.time() then
				if mob[i].registry["myvoes_called"] >= os.time() then
					if toXY(pc[i].m, pc[i].x, pc[i].y) then
						return
					end
				end
			end
		end
	end
	
	if mob.x < 68 or mob.y > 143 or mob.x >= 83 or mob.y <= 127 then
		if a == 1 then toXY(mob, 74, 138) end
		if a == 2 then toXY(mob, 78, 138) end
		if a == 3 then toXY(mob, 75, 141) end
	end	
	
	local g = math.random(10)

	if g <= 3 then
		mob.side = math.random(0,3)
		mob:sendSide()
		if mob.side == side then
			mob:move()
		end
	end
	
	mob:sendSide()
	
	if mob.registry["invoke_timer"] > os.time() then
		mob.registry["invoke_timer"] = 0
		mob.registry["timer_kimak_by_"..mob.registry["kimak_by"]] = 0
		mob.registry["kimak_by"] = 0
		mob:sendAction(8, 50)
		--mob:sendAction(6, 20)
		mob:sendAnimation(70)
		mob:playSound(65)
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
	if r == 2 then mob:talk(0, "mYvoes: Kenapa kk?") end
end,

say = function(player, mob)
	
	local q = string.lower(player.speech)
	
	if distanceSquare(mob, player, 7) then
		if string.find(q, "(.*)myvoes(.*)") then
			mob.registry["called_by"] = player.ID
			caller = mob.registry["called_by"]
			mob.registry["timer_called_by_"..caller] = os.time()+5	
			mob:talk(0, mob.name..": ya, "..player.name.."?")	
		end
		
		if mob.registry["called_by"] > 0 and mob.registry["timer_called_by_"..caller] >= os.time() then
			if string.find(q, "(.*)sini(.*)") then
				mob.registry["myvoes_call"] = os.time()+5
				player.registry["called_myvoes"] = os.time()+5
				mob:talk(0, mob.name..": Ada apa kk?")
				mob:sendAction(1, 20)
			end
		end
	end
	
	if string.find(q, "(.*)myvoes kimak(.*)") or string.find(q,"(.*)kimak myvoes(.*)") then
		damage = math.random(500000, 600000)
		player:sendAnimation(112)
		player:playSound(73)
		player.attacker = mob.ID
		mob:sendAction(6, 40)
		player:removeHealthExtend(damage, 1,1,1,1,0)
		mob.registry["invoke_timer"] = os.time()+2
		mob:talk(0, mob.name..": Apa kau??")
	elseif string.find(q, "(.*)kimak(.*)") then
		mob.registry["kimak_by"] = player.ID
		mob.registry["timer_kimak_by_"..mob.registry["kimak_by"]] = os.time()+7
		mob:talk(0, mob.name.. ": Siapa kimak?")
	elseif string.find(q, "(.*)kau(.*)") or string.find(q, "(.*)lu(.*)") then
		if mob.registry["timer_kimak_by_"..mob.registry["kimak_by"]] >= os.time() then
			if Player(mob.registry["kimak_by"]) ~= nil then
				damage = math.random(500000, 600000)
				pc = Player(mob.registry["kimak_by"])
				pc:sendAnimation(112)
				player:playSound(73)
				pc.attacker = mob.ID
				mob:sendAction(6, 40)
				player:removeHealthExtend(damage, 1,1,1,1,0)
				mob.registry["invoke_timer"] = os.time()+2
			end
		end	
	end
end
}
			
	
































