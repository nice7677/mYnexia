fastbetninenine = {


cast = function(player, mob)


		player:spawn(1014, player.x, player.y, 1)
		a = player:getObjectsInCell(player.m, player.x, player.y, BL_MOB)
		if #a > 0 then
			for i = 1, #a do
				if a[i].yname == "fastbetninenine" then
					a[i].gfxHair = 131
					a[i].gfxHairC = 20
					a[i].gfxName = a[i].name
					a[i].gfxFace = 226
					a[i].gfxFaceA = 65535
					a[i].gfxFaceAT = 65535
					a[i].gfxNeck = 65535
					a[i].gfxArmor = 10058
					a[i].gfxArmorC = 20
					a[i].gfxCrown = 51
					a[i].gfxHelm = 255
					a[i].gfxCape = 65535
					a[i].gfxShield = 65535
					a[i].gfxWeap = 65535
					a[i].gfxBoots = a[i].sex
					a[i].gfxClone = 1
					player:refresh()
					player.registry["fastbetninenine"] = a[i].ID
				end
			end
		end

	player:refresh()
	player:sendAction(6, 20)
end,

move = function(mob, target)
	
	local moved = true
	local side = math.random(0,3)
	local pc = mob:getObjectsInArea(BL_PC)
	local g = math.random(10)
	
	caller = mob.registry["called_by"]
	if mob.registry["timer_called_by_"..caller] > 0 then
		if Player(caller) ~= nil then
			moved = FindCoords(mob, Player(caller))
			return
		end
		if mob:moveIntent(Player(caller).ID) == 1 then
			mob:talk(0, mob.name..": Apa boss "..Player(caller).name.."?")
		end
	end
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
	mob:sendHealth(attacker.damage, attacker.critChance)	

	if mob.health < 5000000 then
		fastbetninenine.callMeicia(mob)
	end
	
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
	if r == 2 then mob:talk(0, "Fastbetninenine: opomene?") end
end,

say = function(player, mob)
	
	local moved = true
	local q = string.lower(player.speech)
	call = {"dias", "diaz", "fb99", "fastbetninenine"}
	answer = {"Ya,", "opomene,", "apa sih,"}
	jerk = {"kimak", "anjeng", "babi", "kontol", "pepek", "cibai", "lanciau", "lan", "lelan"}
	lu = {"lu", "kau", "kao", "kamu", "elu"}
	
	for i = 1, #call do
		if q == call[i].." "..jerk[i] then
			fastbetninenine.hf(player, mob)
		end
	end
	for i = 1, #jerk do
		if string.find(q, "(.*)"..jerk[i].."(.*)") ~= nil then
			mob.registry["jerk_by"] = player.ID
			mob.registry["timer_jerk_by_"..mob.registry["jerk_by"]] = os.time() + 7
			mob:talk(0, mob.name..": Siapa "..jerk[i].."?")
		end	
	end
	
	if distanceSquare(mob, player, 7) then
		for i = 1, #call do
			if q == call[i] then
				mob.registry["called_by"] = player.ID
				mob.registry["called_by_"..mob.registry["called_by"]] = os.time()+7
				mob:talk(0, mob.name..": "..answer[math.random(#answer)].." "..player.name.."?")
			end
		end
		if mob.registry["called_by"] > 0 and mob.registry["called_by_"..mob.registry["called_by"]] >= os.time() then
			if q == "sini" then
				if player.ID == mob.registry["called_by"] then
					moved = FindCoords(mob, player)
					mob.registry["come_to_"..mob.registry["called_by"]] = os.time()+7
					return
				end
			end
		end
	end
	
	for i = 1, #lu do
		if q == lu[i] or string.find(q, "(.*)"..lu[i].."(.*)") ~= nil then
			if mob.registry["timer_jerk_by_"..mob.registry["jerk_by"]] >= os.time() then
				if mob.registry["jerk_by"] == player.ID then
					fastbetninenine.hf(player, mob)
				return else
					mob:talk(0, mob.name..": Ga tanya ke lu "..player.name.."!")
				end
			end
		end
	end
end,



hf = function(player, mob)
	
	local words = {"Apa kau??", "Mati kau!", "GRRRR", "Huss huss"}
	
	if mob.registry["hf_delay"] >= os.time() then
		if mob.registry["bomb_hell"] < os.time() then 
			fastbetninenine.bomb_hell(mob)
		return else
			mob:sendAction(18, 60)
			mob:talk(0, mob.name..": Lagi delay nih. kalo ga, dah w hf kau "..player.name)		
		end
	return else
		mob.registry["kimak_by"] = 0
		mob.registry["timer_kimak_by_"..player.ID] = 0
		mob.registry["hf_delay"] = os.time()+9
		damage = math.random(500000, 600000)
		player:sendAnimation(112)
		player:playSound(73)
		player.attacker = mob.ID
		mob:sendAction(6, 40)
		player:removeHealthExtend(damage, 1,1,1,1,0)
		mob:talk(0, mob.name..": "..words[math.random(#words)])
		fastbetninenine.invoke(mob)
	end
end,

sonhi = function(mob)

	mob:sendAction(8, 50)
	mob.registry["eat_sonhi"] = os.time()+2
	if mob.registry["eat_sonhi"] < os.time() then
		fastbetninenine.invoke(mob)
	end
end,

invoke = function(mob)

	mob:sendAction(6, 40)
	mob:playSound(65)
	mob:sendAnimation(70)
	mob.health = mob.health - mob.health*.01
	mob:sendStatus()
end,

bomb_hell = function(mob)
	
	local pc = mob:getObjectsInMap(mob.m, BL_PC)
	local mobs = mob:getObjectsInMap(mob.m, BL_MOB)
	
	mob.registry["bomb_hell"] = os.time()+30
	mob:sendAction(6, 40)
	mob:talk(2, "Bomb Hell!")
	mob:playSound(500)
	mob:playSound(107)
	mob:sendAnimation(134)
	mob:playSound(99)
	mob:playSound(73)
		
	if #pc > 0 then
		for i = 1, #pc do
			if pc[i].state ~= 1 then
				pc[i]:sendAnimation(104)
				pc[i]:sendAnimationXY(352, pc[i].x, pc[i].y)			
				pc[i].attacker = mob.ID
				pc[i]:removeHealthExtend(math.random(300000, 500000), 1,1,1,1,0)
			end
		end
	end
	if #mobs > 0 then
		for i = 1, #mobs do
			mob[i]:sendAnimation(104)
			mob[i]:sendAnimationXY(352, mobs[i].x, mobs[i].y)
			mob[i].attacker = mob.ID
			mob[i]:removeHealthExtend(math.random(100000, 200000), 1,1,1,1,0)
		end
	end
end,

callMeicia = function(mob)
	
	if mob.registry["call_meicia"] >= os.time() then return else
		mob.registry["call_meicia"] = os.time() + 60
		mob:spawn(1002, mob.x, mob.y, 1)
		a = mob:getObjectsInCell(mob.m, mob.x, mob.y, BL_MOB)
		pc = mob:getObjectsInMap(mob.m, BL_PC)
		if #a > 0 then
			for i = 1, #a do
				if a[i].yname == "meicia" then
					a[i].gfxShield = 7
					a[i].gfxWeap = 54
					a[i].gfxWeapC = 13
					a[i].gfxFaceA = 65535
					a[i].gfxFaceAT = 65535
					a[i].gfxNeck = 65535
					a[i].gfxHelm = 65535
					a[i].gfxCape = 12
					a[i].gfxCrown = 51
					a[i].gfxName = a[i].name
					a[i].gfxHair = 88
					a[i].gfxHairC = 5
					a[i].gfxFace = 201
					a[i].gfxArmor = 10007
					a[i].gfxArmorC = 30			
					a[i].gfxBoots = a[i].sex
					a[i].gfxClone = 1
					mob.registry["meicia"] = a[i].ID
					a[i]:updateState()	
				end
			end
		end
		if #pc > 0 then
			for i = 1, #pc do
				pc[i]:refresh()
			end
		end
		if Mob(mob.registry["meicia"]) ~= nil then
			Mob(mob.registry["meicia"]):talk(0, Mob(mob.registry["meicia"]).name..": Haiiiii say")
			mob:talk(0, mob.name..": Hello say")
			fastbetninenine.heal_charm(Mob(mob.registry["meicia"]), mob)
			mob:sendAnimationXY(385, math.random(mob.x-2, mob.x+2), math.random(mob.y-2, mob.y+2))
			mob:sendAnimationXY(385, math.random(mob.x-2, mob.x+2), math.random(mob.y-2, mob.y+2))
			mob:sendAnimationXY(386, math.random(mob.x-2, mob.x+2), math.random(mob.y-2, mob.y+2))
			mob:sendAnimationXY(386, math.random(mob.x-2, mob.x+2), math.random(mob.y-2, mob.y+2))
		end
	end
end,


heal_charm = function(mob1, mob2)
	
	mob1:sendAction(6, 20)
	mob1:playSound(62)
	mob1:sendAnimation(168)
	mob1:setDuration("fastbetninenine", 30000)
	mob2:setDuration("fastbetninenine", 30000)
	
end,

while_cast = function(mob)
	
	if mob.yname == "meicia" then
		mob:sendAnimation(168)
	end
	mob:sendAnimation(132)
	mob:sendAnimation(422)
	addHealth(mob, math.random(30000, 50000))
end,

uncast = function(mob)
	
	mob:calcStat()
end


}


























