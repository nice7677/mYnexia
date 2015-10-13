ambush = {

on_learned = function(player) player.registry["learned_ambush"]=1 end,
on_forget = function(player) player.registry["learned_ambush"]=0 end,

cast = function(player)

	local mob = getTargetFacing(player, BL_MOB)
	local pc = getTargetFacing(player, BL_PC)
	local s = player.side
	
	if mob ~= nil then
		for ability = 50101, 50113 do
			if mob.mobID == ability then
				anim(player)
				player:sendMinitext("!!")
				return
			end
		end
		ambush.casted(player, mob)
		mob:sendAnimation(224)
		player:playSound(124)
	elseif pc ~= nil then
		if pc.state ~= 1 then
			ambush.casted(player, pc)
			player:playSound(124)
			if player:canPK(pc) then
				pc:sendAnimation(224)
				pc:sendMinitext(player.name.." attack you with Ambush!")
			end
		end
	end	
end,

requirements = function(player)
	
	local txt
	txt = "- 180 Chesnut \n"
	txt = txt.."- 40 Tiger Meat \n"
	txt = txt.."- 400 Coins \n"
	
	local level = 38
	local item = {43, 55, 0}
	local amounts = {180, 40, 400}
	local desc = {"Fast moving to other side and hit target", "To learn this spell you must to sacriface:\n"..txt..""}
	return level, item, amounts, desc
end,



casted = function(player, t)
	
	local side = player.side
	local m, x, y
	local passAtas = getPass(t.m, t.x, t.y-1)
	local passBawah = getPass(t.m, t.x, t.y+1)
	local passKiri = getPass(t.m, t.x-1, t.y)
	local passKanan = getPass(t.m, t.x+1, t.y)
	
	local mobAtas = player:getObjectsInCell(t.m, t.x, t.y-1, BL_MOB)
	local pcAtas =  player:getObjectsInCell(t.m, t.x, t.y-1, BL_PC)
	local npcAtas = player:getObjectsInCell(t.m, t.x, t.y-1, BL_NPC)
	
	local mobBawah = player:getObjectsInCell(t.m, t.x, t.y+1, BL_MOB)
	local pcBawah =  player:getObjectsInCell(t.m, t.x, t.y+1, BL_PC)
	local npcBawah = player:getObjectsInCell(t.m, t.x, t.y+1, BL_NPC)

	local mobKiri= player:getObjectsInCell(t.m, t.x-1, t.y, BL_MOB)
	local pcKiri =  player:getObjectsInCell(t.m, t.x-1, t.y, BL_PC)
	local npcKiri = player:getObjectsInCell(t.m, t.x-1, t.y, BL_NPC)

	local mobKanan = player:getObjectsInCell(t.m, t.x+1, t.y, BL_MOB)
	local pcKanan =  player:getObjectsInCell(t.m, t.x+1, t.y, BL_PC)
	local npcKanan = player:getObjectsInCell(t.m, t.x+1, t.y, BL_NPC)
	
	m = t.m
	x = t.x
	y = t.y
	
	if side == 0 then
		if passAtas == 0 and #mobAtas == 0 and #pcAtas == 0 and #npcAtas == 0 then
			player:warp(m, x, y - 1)
			player.side = 2
		else
			if passKanan == 0 and #mobKanan == 0 and #pcKanan == 0 and #npcKanan == 0 then
				player:warp(m, x + 1, y)
				player.side = 3
			else
				if passKiri == 0 and #mobKiri == 0 and #pcKiri == 0 and #npcKiri == 0 then
					player:warp(m, x - 1, y)
					player.side = 1
				end
			end
		end
	elseif side == 1 then
		if passKanan == 0 and #mobKanan == 0 and #pcKanan == 0 and #npcKanan == 0 then
			player:warp(m, x+1, y)
			player.side = 3
		else
			if passAtas == 0 and #mobAtas == 0 and #pcAtas == 0 and #npcAtas == 0 then
				player:warp(m, x, y - 1)
				player.side = 2
			else
				if passBawah == 0 and #mobBawah == 0 and #pcBawah == 0 and #npcBawah == 0 then
					player:warp(m, x, y + 1)
					player.side = 0
				end
			end
		end
	elseif side == 2 then
		if passBawah == 0 and #mobBawah == 0 and #pcBawah == 0 and #npcBawah == 0 then
			player:warp(m, x, y + 1)
			player.side = 0
		else
			if passKanan == 0 and #mobKanan == 0 and #pcKanan == 0 and #npcKanan == 0 then
				player:warp(m, x+1, y)
				player.side = 3
			else
				if passKiri == 0 and #mobKiri == 0 and #pcKiri == 0 and #npcKiri == 0 then
					player:warp(m, x-1, y)
					player.side = 1
				end
			end
		end
	elseif side == 3 then
		if passKiri == 0 and #mobKiri == 0 and #pcKiri == 0 and #npcKiri == 0 then
			player:warp(m, x-1, y)
			player.side = 1
		else
			if passBawah == 0 and #mobBawah == 0 and #pcBawah == 0 and #npcBawah == 0 then
				player:warp(m, x, y + 1)
				player.side = 0
			else
				if passAtas == 0 and #mobAtas == 0 and #pcAtas == 0 and #npcAtas == 0 then
					player:warp(m, x, y - 1)
					player.side = 2
				end
			end
		end
	end
	player:swing()
	return player:sendSide()
end
}