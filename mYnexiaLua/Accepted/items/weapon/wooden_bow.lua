

wooden_bow = {

equip = function(player)

	player.attackSpeed = 40
	player:sendStatus()
end,

on_swing = function(player, target)

	player:sendAction(1, 20)
end,


thrown = function(player, target)

	local s = player.side
	local m = player.m
	local x = player.x
	local y = player.y
	local quiver = player:getEquippedItem(EQ_SHIELD)
	local dam = math.random(player.minDam, player.maxDam) + math.random(1500, 3000)
	local threat

	if quiver ~= nil and quiver.id >= 5011 and quiver.id <= 5014 then
		if player:hasItem("arrow", 1) == true then
			player:playSound(336)
			player:removeItem("arrow", 1)
			for i = 1, 8 do
				local pc = getTargetFacing(player, BL_PC,0,i)
				local mob = getTargetFacing(player, BL_MOB,0,i)
				
				if s == 0 then
					if getPass(m,x,y-i) == 1 then return end
				elseif s == 1 then
					if getPass(m,x+i,y) == 1 then return end
				elseif s == 2 then
					if getPass(m,x,y+i) == 1 then return end
				elseif s == 3 then
					if getPass(m,x-i,y) == 1 then return end
				end
			
				if pc ~= nil then
					if player:canPK(pc) then
						pc.attacker = player.ID
						pc:sendAnimation(331)
						pc:removeHealthExtend(dam, 1,1,1,1,0)
						pc:sendMinitext(player.name.." shooting you with Wooden Bow")
						player:playSound(716)
						return
					end
				elseif mob ~= nil then
					mob.attacker = player.ID
					player:playSound(716)
					mob:sendAnimation(331)
					threat = mob:removeHealthExtend(dam,1,1,1,1,2)
					player:addThreat(mob.ID, threat)
					mob:removeHealthExtend(dam,1,1,1,1,0)
					return
				end

				if s == 0 then
					player:throw(x,y-i,6,0,1)
				elseif s == 1 then
					player:throw(x+i,y,7,0,1)
				elseif s == 2 then
					player:throw(x,y+i,8,0,1)
				elseif s == 3 then
					player:throw(x-i,y,9,0,1)
				end
			end
		else
			anim(player)
			player:sendMinitext("Require an arrow")
		end
	else
		anim(player)
		player:sendMinitext("Require a quiver to use this")
	end
end
}