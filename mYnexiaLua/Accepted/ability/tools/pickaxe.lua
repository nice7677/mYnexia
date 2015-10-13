------------------------------------------------------------------------------------------------ Wooden Pickaxe

wooden_pickaxe = {

equip = function(player) player.attackSpeed = 75 end,
while_equipped = function(player) player.attackSpeed = 75 end,
unequip = function(player) player:calcStat() end,
on_swing = function(player)

	local mob = getTargetFacing(player, BL_MOB)
	local ore = {50106, 50107, 50108}
	local r = math.random(70)
	local exp = math.random(1,3)
	
	player:playSound(math.random(352, 353))
	if mob ~= nil then
		if mob.yname == "auto_ore" then
			if player:hasDuration("ore_mining") then return else
				ore_mining.cast(player)
				return
			end
		end
		for i = 1, #ore do
			if mob.mobID == ore[i] then
				player:sendAnimation(315)
				player:deductDura(EQ_WEAP, 100)
				player:sendAnimationXY(331, mob.x, mob.y)
				mob.attacker = player.ID
				mob:removeHealth(25)
				ability.leveling(player, exp, "ore_mining")
				if r <= 2 then player:addItem("mineral_stone_a+", 1)
					elseif r >= 3 and r <= 5 then player:addItem("mineral_stone_a", 1)
					elseif r >= 6 and r <= 9 then player:addItem("mineral_stone_b+", 1)
					elseif r >= 10 and r <= 14 then player:addItem("mineral_stone_b", 1)
					elseif r >= 15 and r <= 25 then player:addItem("mineral_stone_c+", 1)
					elseif r >= 26 and r <= 41 then player:addItem("mineral_stone_c", 1)
				end
			end
		end
	end
end
}
------------------------------------------------------------------------------------------------ Bronze Pickaxe

bronze_pickaxe = {

equip = function(player) player.attackSpeed = 75 end,
while_equipped = function(player) player.attackSpeed = 75 end,
unequip = function(player) player:calcStat() end,
on_swing = function(player)
	
	player:playSound(math.random(352, 353))
	local mob = getTargetFacing(player, BL_MOB)
	local ore = {50106, 50107, 50108}
	local tools  player:getEquippedItem(EQ_WEAP)
	local r = math.random(70)
	local exp = math.random(2,3)
	
	if mob ~= nil then
		if mob.yname == "auto_ore" then
			if player:hasDuration("ore_mining") then return else
				ore_mining.cast(player)
				return
			end
		end	
		for i = 1, #ore do
			if mob.mobID == ore[i] then
				player:sendAnimation(315)
				player:deductDura(EQ_WEAP, 50)
				player:sendAnimationXY(331, mob.x, mob.y)
				mob.attacker = player.ID
				mob:removeHealth(50)
				ability.leveling(player, exp, "ore_mining")
				if r <= 2 then player:addItem("mineral_stone_a+", 1)
					elseif r >= 3 and r <= 5 then player:addItem("mineral_stone_a", 1)
					elseif r >= 6 and r <= 9 then player:addItem("mineral_stone_b+", 1)
					elseif r >= 10 and r <= 14 then player:addItem("mineral_stone_b", 1)
					elseif r >= 15 and r <= 25 then player:addItem("mineral_stone_c+", 1)
					elseif r >= 26 and r <= 41 then player:addItem("mineral_stone_c", 1)
				end
			end
		end
	end
end
}

------------------------------------------------------------------------------------------------ Silver Pickaxe

silver_pickaxe = {

equip = function(player) player.attackSpeed = 50 end,
while_equipped = function(player) player.attackSpeed = 50 end,
unequip = function(player) player:calcStat() end,
on_swing = function(player)

	local mob = getTargetFacing(player, BL_MOB)
	local ore = {50106, 50107, 50108}
	local tools  player:getEquippedItem(EQ_WEAP)
	local r = math.random(70)
	local exp = math.random(3,4)
	
	player:playSound(math.random(352, 353))
	if mob ~= nil then
		if mob.yname == "auto_ore" then
			if player:hasDuration("ore_mining") then return else
				ore_mining.cast(player)
				return
			end
		end	
		for i = 1, #ore do
			if mob.mobID == ore[i] then
				player:sendAnimation(315)
				player:deductDura(EQ_WEAP, 30)
				player:sendAnimationXY(331, mob.x, mob.y)
				mob.attacker = player.ID
				mob:removeHealth(75)
				ability.leveling(player, exp, "ore_mining")
				if r <= 2 then player:addItem("mineral_stone_a+", 1)
					elseif r >= 3 and r <= 5 then player:addItem("mineral_stone_a", 1)
					elseif r >= 6 and r <= 9 then player:addItem("mineral_stone_b+", 1)
					elseif r >= 10 and r <= 14 then player:addItem("mineral_stone_b", 1)
					elseif r >= 15 and r <= 25 then player:addItem("mineral_stone_c+", 1)
					elseif r >= 26 and r <= 41 then player:addItem("mineral_stone_c", 1)
				end
			end
		end
	end
end
}

------------------------------------------------------------------------------------------------ Golden Pickaxe

golden_pickaxe = {

equip = function(player) player.attackSpeed = 50 end,
while_equipped = function(player) player.attackSpeed = 50 end,
unequip = function(player) player:calcStat() end,
on_swing = function(player)

	local mob = getTargetFacing(player, BL_MOB)
	local ore = {50106, 50107, 50108}
	local tools  player:getEquippedItem(EQ_WEAP)
	local r = math.random(70)
	local exp = 5
	
	player:playSound(math.random(352, 353))
	if mob ~= nil then
		if mob.yname == "auto_ore" then
			if player:hasDuration("ore_mining") then return else
				ore_mining.cast(player)
				return
			end
		end	
		for i = 1, #ore do
			if mob.mobID == ore[i] then
				player:sendAnimation(315)
				player:deductDura(EQ_WEAP, 10)
				player:sendAnimationXY(331, mob.x, mob.y)
				mob.attacker = player.ID
				mob:removeHealth(100)
				ability.leveling(player, exp, "ore_mining")
				if r <= 2 then player:addItem("mineral_stone_a+", 1)
					elseif r >= 3 and r <= 5 then player:addItem("mineral_stone_a", 1)
					elseif r >= 6 and r <= 9 then player:addItem("mineral_stone_b+", 1)
					elseif r >= 10 and r <= 14 then player:addItem("mineral_stone_b", 1)
					elseif r >= 15 and r <= 25 then player:addItem("mineral_stone_c+", 1)
					elseif r >= 26 and r <= 41 then player:addItem("mineral_stone_c", 1)
				end
			end
		end
	end
end
}