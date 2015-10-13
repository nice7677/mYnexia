scissors = {

equip = function(player) player.attackSpeed = 75 end,
while_equipped = function(player) player.attackSpeed = 75 end,
unequip = function(player) player:calcStat() end,
on_swing = function(player)

	local mob = getTargetFacing(player, BL_MOB)
	local sheep = {50101, 50102, 50103}
	local r = math.random(70)

	if mob ~= nil then
		if mob.yname == "auto_sheep" then
			if player:hasDuration("sheperd") then return else
				sheperd.cast(player)
				return
			end
		end
		for i = 1, #sheep do
			if mob.mobID == sheep[i] then
				player:sendAnimation(311)
				player:playSound(math.random(336, 337))
				player:deductDura(EQ_WEAP, 100)
				player:sendAnimationXY(204, mob.x, mob.y)
				mob:removeHealth(25)
				ability.leveling(player, math.random(1,3), "sheperd")
				if r <= 40 then
					player:addItem("wool", 1)
				elseif r >= 70 then
					player:addItem("wool", 2)
				end
			end
		end
	end
end
}


bronze_scissors = {

equip = function(player) player.attackSpeed = 75 end,
while_equipped = function(player) player.attackSpeed = 75 end,
unequip = function(player) player:calcStat() end,
on_swing = function(player)

	local mob = getTargetFacing(player, BL_MOB)
	local sheep = {50101, 50102, 50103}
	local r = math.random(70)
	local exp = math.random(2, 3)
	
	if mob ~= nil then
		if mob.yname == "auto_sheep" then
			if player:hasDuration("sheperd") then return else
				sheperd.cast(player)
				return
			end
		end
		for i = 1, #sheep do
			if mob.mobID == sheep[i] then
				player:sendAnimation(311)
				player:playSound(math.random(336, 337))
				player:deductDura(EQ_WEAP, 50)
				player:sendAnimationXY(204, mob.x, mob.y)
				mob:removeHealth(50)
				ability.leveling(player, math.random(2,3), "sheperd")
				if r <= 40 then
					player:addItem("wool", 1)
				elseif r >= 70 then
					player:addItem("wool", 2)
				end
			end
		end
	end
end
}


silver_scissors = {

equip = function(player) player.attackSpeed = 75 end,
while_equipped = function(player) player.attackSpeed = 75 end,
unequip = function(player) player:calcStat() end,
on_swing = function(player)

	local mob = getTargetFacing(player, BL_MOB)
	local sheep = {50101, 50102, 50103}
	local r = math.random(70)
	
	if mob ~= nil then
		if mob.yname == "auto_sheep" then
			if player:hasDuration("sheperd") then return else
				sheperd.cast(player)
				return
			end
		end
		for i = 1, #sheep do
			if mob.mobID == sheep[i] then
				player:sendAnimation(311)
				player:playSound(math.random(336, 337))
				player:deductDura(EQ_WEAP, 30)
				player:sendAnimationXY(204, mob.x, mob.y)
				mob:removeHealth(75)
				if mob.yname == "medium_sheep" then exp = math.random(3, 4)end
				if mob.yname == "large_sheep" then exp = math.random(4, 5) end
				
				ability.leveling(player, exp, "sheperd")
				if r <= 40 then
					player:addItem("wool", 1)
				elseif r >= 70 then
					player:addItem("wool", 2)
				end
			end
		end
	end
end
}


golden_scissors = {

equip = function(player) player.attackSpeed = 75 end,
while_equipped = function(player) player.attackSpeed = 75 end,
unequip = function(player) player:calcStat() end,
on_swing = function(player)

	local mob = getTargetFacing(player, BL_MOB)
	local sheep = {50101, 50102, 50103}
	local r = math.random(70)
	
	if mob ~= nil then
		if mob.yname == "auto_sheep" then
			if player:hasDuration("sheperd") then return else
				sheperd.cast(player)
				return
			end
		end
		for i = 1, #sheep do
			if mob.mobID == sheep[i] then
				player:sendAnimation(311)
				player:playSound(math.random(336, 337))
				player:deductDura(EQ_WEAP, 10)
				player:sendAnimationXY(204, mob.x, mob.y)
				mob:removeHealth(100)
				if mob.yname == "medium_sheep" then exp = 5 end
				if mob.yname == "large_sheep" then exp = 7 end
				ability.leveling(player, exp, "sheperd")
				if r <= 40 then
					player:addItem("wool", 1)
				elseif r >= 70 then
					player:addItem("wool", 2)
				end
			end
		end
	end
end
}