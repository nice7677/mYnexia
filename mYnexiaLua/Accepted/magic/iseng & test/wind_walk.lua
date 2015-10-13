wind_walk = {

on_spawn = function(mob)

	mob.maxHealth = 5000000
	mob:sendStatus()
end,


move = function(mob, target)
	
	local moved = true
	local c1 = math.random(0, 20)
	local c2 = math.random(0, 10)
	local owner = mob:getBlock(mob.owner)
	
	if mob.state ~= MOB_HIT and mob.target == 0 then
		if c1 > 3 then return else mob.side = c1 end
		mob:sendSide()
		if c1 < c2 then moved = mob:move() end
	else
		moved = FindCoords(mob, target)
	end
	
	if owner ~= nil then
		if owner.target ~= nil then
			mob.target = owner.target
			mob.state = MOB_HIT
		end
	end
	
end,

attack = function(mob, target)

	local moved
	local block = mob:getBlock(mob.target)
	
	if mob.target == 0 then
		mob.state = MOB_ALIVE
		wind_walk.move(mob, target)
		return
	end
	
	if target then
		threat.calcHighestThreat(mob)
		if (block ~= nil) then target = block end
		moved = FindCoords(mob,target)
		if(moved and mob.target ~= mob.owner) then
			--We are right next to them, so attack!
			mob:attack(target.ID)
		else
			mob.state = MOB_ALIVE
		end
	else
		mob.state = MOB_ALIVE
	end
end,


on_attacked = function(mob, attacker)
	
	mob.attacker = attacker.ID
	mob.target = attacker.ID
	mob:sendHealth(attacker.damage, attacker.critChance)
	attacker.damage = 0
end,

after_death = function(mob)

	mob:sendAnimationXY(292, mob.x, mob.y)
	mob:playSound(73)
end,


cast = function(player, mob)

	local pc = player:getObjectsInMap(player.m, BL_PC)

	player:spawn(10002, player.x, player.y, 1)
	get = player:getObjectsInCell(player.m, player.x, player.y, BL_MOB)
	if #get > 0 then
		for i = 1, #get do
			if get[i].yname == "wind_walk" then
				gfxClone(player, get[i])
				if player.registry["show_title"] == 1 then
					get[i].gfxName = player.title.." "..player.name
				else
					get[i].gfxName = player.name
				end
				get[i].gfxClone = 1
				get[i].side = player.side
				get[i]:sendSide()
				get[i].registry["wind_walk_owner"] = player.ID
				get[i]:setDuration("wind_walk", 60000, player.ID, 1)
				if player.state == 0 then player.state = 2 player:updateState() end
			end
		end
	end
	if #pc > 0 then
		for i = 1, #pc do
			pc[i]:refresh()
		end
	end
end,

while_cast = function(block, caster)
	
	if caster ~= nil then
		if caster.target ~= nil then
			block.target = caster.target
			block.attacker = caster.attacker
		end
	end
end,

uncast = function(block, caster)
	
	block:sendAnimationXY(292, block.x, block.y)
	block:playSound(73)
	block:removeHealth(block.health)
end,


cloneTo = function(player, get)

	weap = player:getEquippedItem(EQ_WEAP)
	armor = player:getEquippedItem(EQ_ARMOR)
	cape = player:getEquippedItem(EQ_MANTLE)
	shield = player:getEquippedItem(EQ_SHIELD)
	mantle = player:getEquippedItem(EQ_MANTLE)
	coat = player:getEquippedItem(EQ_COAT)
	crown = player:getEquippedItem(EQ_CROWN)
	coat = player:getEquippedItem(EQ_HELM)
	coat = player:getEquippedItem(EQ_BOOTS)
	get:setDuration("wind_walk", 20000)
	
	if weap ~= nil then get.gfxWeap = weap.look get.gfxWeapC = weap.lookC else get.gfxWeap = 65535 end
	get.gfxFace = player.face
	get.gfxFaceC = player.faceColor
	get.gfxHair = player.hair
	get.gfxHairC = player.hairColor
	get.gfxName = player.title.." "..player.name
	if coat ~= nil then get.gfxArmor = coat.look get.gfxArmorC = coat.lookC else
		if armor ~= nil then get.gfxArmor = armor.look get.gfxArmorC = armor.lookC else
			get.gfxArmor = player.sex
		end
	end
	if mantle ~= nil then get.gfxCape = mantle.look get.gfxCapeC = mantle.lookC else get.gfxCape = 65535 end
	if shield ~= nil then get.gfxShield = shield.look get.gfxShieldC = shield.lookC else get.gfxShield = 65535 end
	if boots ~= nil then get.gfxBoots = boots.look get.gfxBootsC = boots.lookC else get.gfxBoots = player.sex end
	if crown ~= nil then get.gfxCrown = crown.look get.gfxCrownC = crown.lookC else get.gfxCrown  = 65535 end
	get.gfxNeck = 65535
	get.gfxFaceA = 65535
	get.gfxFaceAT = 65535
	get.gfxHelm = 255
end
}