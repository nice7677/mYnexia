

------------------------------------------------------------------------------------------------ Wooden Pickaxe
net = {

equip = function(player) player.attackSpeed = 75 end,
while_equipped = function(player) player.attackSpeed = 75 end,
unequip = function(player) player:calcStat() end,
on_swing = function(player)

	local mob = getTargetFacing(player, BL_MOB)
	local monkey = {50111, 50112}
	local r = math.random(100)
	local exp = math.random(1,3)
	
	player:playSound(math.random(352, 353))
	if mob ~= nil then
		if mob.yname == "auto_monkey" then
			if player:hasDuration("gem_mining") then return else
				gem_mining.cast(player)
				return
			end
		end
		
		local weap = player:getEquippedItem(EQ_WEAP)
		if weap.yname == "wooden_net" then
			player:deductDura(EQ_WEAP, 100)
		elseif weap.yname == "bronze_net" then
			player:deductDura(EQ_WEAP, 50)
		elseif weap.yname == "silver_net" then
			player:deductDura(EQ_WEAP, 30)
		elseif weap.yname == "golden_net" then
			player:deductDura(EQ_WEAP, 10)
		end
		
		for i = 1, #monkey do
			if mob.mobID == monkey[i] then
				player:sendAnimation(315)
				player:sendAnimationXY(331, mob.x, mob.y)
				mob.attacker = player.ID
				mob:removeHealth(25)
				ability.leveling(player, exp, "gem_mining")
				if r < 10 then return end
				if r > 10 and r < 30 then player:addItem("white_amber", 1) end
				if r > 30 and r < 60 then player:addItem("dark_amber", 1) end
				if r > 60 then player:addItem("amber", 1) end
			end
		end
	end
end
}
------------------------------------------------------------------------------------------------ Bronze Pickaxe