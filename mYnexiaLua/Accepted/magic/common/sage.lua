sage = {

on_learn = function(player) player.registry["learned_sage"] = 1 end,
on_forget = function(player) player.registry["learned_sage"] = 0 end,

cast=function(player)

	local question = player.question
	local aether = 15000
	local magicCost = 100

	if (not player:canCast(1, 1, 0)) then return end
	if (player.magic < magicCost) then notEnoughMP(player) return end	
	
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendAction(6, 80)

	if(string.len(question) > 0) then
		pc = player:getUsers()
		if #pc > 0 then
			for i = 1, #pc do
				pc[i]:msg(11, "["..player.name.."]: "..question, pc[i].ID)
			end
		end

		player:sendAnimation(267)
		player:playSound(20)
	else
		player:sendMinitext("Can't send an empty broadcast")
	end
	if player.gmLevel == 0 then player:setAether("sage", aether) end
	
end,

requirements = function(player)

	txt = "- 100 Chesnut \n"
	txt = txt.."- 20 Dark Amber \n"
	
	local level = 99
	local item = {43, 18008}	-- chesnut, dark amber
	local amounts = {100, 20}
	local desc = {"Broadcast a message to all players on this server!", "To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
		
end
}