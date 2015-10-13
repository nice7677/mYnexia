yuri = {

cast = function(player, mob)
	
	local m = player.m
	local x = player.x
	local y = player.y
	local reg = player.registry["spawned_yuri"]
	
	player:sendAction(6, 20)
	
	if player.registry["spawned_yuri"] > 0 then
		if Mob(reg) ~= nil then
			Mob(reg):removeHealth(Mob(reg).health)
		end
		player.registry["spawned_yuri"] = 0
		return
	else
		player:sendAnimationXY(292, x, y)
		for i = 1, 2 do player:playSound(73) end
		player:spawn(10000, x, y, 1)
		mob = player:getObjectsInCell(m,x,y, BL_MOB)
		if #mob > 0 then
			for i = 1, #mob do
				mob[i].side = 2
				mob[i]:sendSide()
				mob[i].gfxFace = 202
				mob[i].gfxHair = 49
				mob[i].gfxArmor = 10118
				mob[i].gfxShield = 65535
				mob[i].gfxBoots = 65535
				mob[i].gfxCape = 65535
				mob[i].gfxCrown = 65535
				mob[i].gfxHelm = 65535
				mob[i].gfxCoat = 65535
				mob[i].gfxWeap = 10085
				mob[i].gfxName = "Yuri"
				mob[i].gfxFaceA = 65535
				mob[i].gfxFaceAT = 65535
				mob[i].gfxFaceC = 0
				mob[i].gfxHairC = 0
				mob[i].gfxArmorC = 0
				mob[i].gfxClone = 1
				player.registry["spawned_yuri"] = mob[i].ID
			end
		end
		player:refresh()
	end
end,

move = function(mob, target)

	local r = math.random(10)
	local side = math.random(0,3)
	local chance = math.random(3)
	local pc = getTargetFacing(mob, BL_PC)
	
	if chance == 2 then
		if pc ~= nil then
			mob:sendAction(1, 20)
			canPush(mob, pc)
			if mob.side == 0 then
				mob:sendAnimationXY(192, mob.x, mob.y-1)
			elseif mob.side == 1 then
				mob:sendAnimationXY(192, mob.x+1, mob.y)
			elseif mob.side == 2 then
				mob:sendAnimationXY(192, mob.x, mob.y+1)
			elseif mob.side == 3 then
				mob:sendAnimationXY(192, mob.x-1, mob.y)
			end
			mob:playSound(10)
			mob:talk(0, "Yuri: Awas! halangin aja lu.")
		end
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
	
	if r == 2 then mob:talk(0, "Yuri: ??") end
end,

say = function(player, mob)

	local q = string.lower(player.speech)
	
	if string.find(q, "(.*)yuri kantal(.*)") or string.find(q, "(.*)yuri anjeng(.*)") or string.find(q, "(.*)yuri anjing(.*)") then
		if distanceSquare(mob, player, 3) then
			mob:talk(0, "Yuri: Apa kaw?")
			mob:sendAction(6, 50)
			mob:sendAnimationXY(162, mob.x, mob.y)
			player:playSound(118)
			player:playSound(70)
			player:playSound(71)
			pc = mob:getObjectsInArea(BL_PC)
			if #pc > 0 then
				for i = 1, #pc do
					if pc[i].state ~= 1 then
						if pc[i]:hasDuration("yuri") then return else
							pc[i]:setDuration("yuri", 5000)
						end
					end
				end
			end
		else
			mob:talk(0, "Yuri: Sini kaw kalo berani. jangan jauh2")
		end
	elseif string.find(q, "(.*)yuri(.*)") then
		mob:talk(0, "Yuri: Apa?")
		
	end
end,

while_cast_250 = function(block)

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

while_cast_125 = function(player)
	
	player:playSound(353)
	player:playSound(88)
	player:playSound(90)	
	player:sendAnimationXY(403, player.x, player.y)
end,
	
uncast = function(player)

	player:calcStat()
end
}