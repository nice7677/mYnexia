onKill = function(block, player)
	

	
	
	if (block.blType == BL_MOB) then
		local killTotal
		local total

        if block.mobID == 1 or block.mobID == 2 then		-- Rabbit or White rabbit
			for i = 1, #player.group do
				local pc = Player(player.group[i])
				local rabbit = pc:killCount(1)
				local whiteRabbit = pc:killCount(2)
				
				killTotal = rabbit + whiteRabbit
				
				if pc.state ~= 1 and pc.m == player.m and pc.afk == false then
					if pc.quest["rabbit_hunt"] == 1 and pc.quest["squirrel_hunt"] == 1 then
						if killTotal >= 10 then
							player:msg(4, "(Spirit of Genesis) You have killed 10/10 Rabbit.", pc.ID)
							if pc:killCount(3) >= 10 then
								player:warp(1000, 55, 122)
								player:sendAnimation(16)
								player:playSound(29)
								player:dialogSeq({"Come in when you finished!"})
								return
							end
						elseif killTotal % 1 == 0 then
							player:msg(4, "(Spirit of Genesis) You have killed "..killTotal.."/10 Rabbit.", pc.ID)
						end
					end
				end
			end
		elseif block.mobID == 3 then		-- Squirrel
			for i = 1, #player.group do
				local pc = Player(player.group[i])
				local squirrel = pc:killCount(3)

				if pc.state ~= 1 and pc.m == player.m and pc.afk == false then
					if pc.quest["rabbit_hunt"] == 1 and pc.quest["squirrel_hunt"] == 1 then
						if squirrel >= 10 then
							player:msg(4, "(Spirit of Genesis) You have killed 10/10 Squirrel.", pc.ID)
							rabbitCount = pc:killCount(1) + pc:killCount(2)
							if rabbitCount >= 10 then
								player:warp(1000, 55, 122)
								player:sendAnimation(16)
								player:playSound(29)
								player:dialogSeq({"Come in when you finished!"})
								return
							end
						else
							player:msg(4, "(Spirit of Genesis) You have killed "..squirrel.."/10 Squirrel.", pc.ID)
						end
					end
				end
			end
		elseif block.mobID == 33 then
			for i = 1, #player.group do
				member = Player(player.group[i])
				fox = member:killCount(33)
				if member.state ~= 1 and member.m == player.m and member.afk == false then
					if member.quest["deludge_revenge"] == 1 then
						if fox > 0 then
							player:msg(4, "=== [Quest - Finished] - 'Deludge revenge' - Defeat nine tailed fox (1/1) ===", member.ID)
							finishedQuest(member)
						end
					end
				end
			end
		end

	elseif (block.blType == BL_PC) then

	end
end

-------------- on after killing something ----------------------------------------------------

onKillMsg = function(player, killTotal, total, questType)
	if (player.registry["questCount"] == 0) then
		player:msg(4, "(Spirit of Genesis) You have killed "..killTotal.."/"..total.." "..questType..".", player.ID)
	end
end