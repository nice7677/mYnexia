approach = {
cast = function(player, question)

	local magicCost = 100
	local input = string.lower(player.question)
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	if Player(input) == nil then anim(player) player:sendMinitext("User not found / not online") return else
		pc = Player(input)
		if pc.registry["being_approach"] == 1 then pc:msg(4, "[GM]: "..player.name.." is trying to approach on you", pc.ID) return end
		if player.gmLevel == 0 then
			if player.m ~= pc.m or player.groupID ~= pc.groupID then anim(player) player:sendMinitext("Target must in same map / party") return else
				player:warp(pc.m, pc.x, pc.y)
				player:sendAnimation(16)
				player:playSound(29)
				player:sendMinitext("You cast approach")
				pc:sendMinitext(player.name.." approach to you")
			end
		else
			player:warp(pc.m, pc.x, pc.y)
			player:sendAnimation(16)
			player:playSound(29)
			pc:sendMinitext(player.name.." approach to you")
		end
	end		
end,


requirements = function(player)
	
	txt = "\n- 50 Chesnut \n"
	txt = txt.."- 20 Fresh Snake Meat \n"
	txt = txt.."- 50 Coins "
	
	local level = 20
	local item = {43, 73, 0}
	local amounts = {50, 20, 50}
	local desc = {"Teleport/warp to party member that has level lower than you in a same map", "To learn this spell you must to sacriface "..txt..""}
	return level, item, amounts, desc
end
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	