
fascinate = {
on_learned = function(player) player.registry["learned_fascinate"] = 1 end,
on_forget = function(player) player.registry["learned_fascinate"] = 0 end,

cast =function(player)

	local pc = getTargetFacing(player, BL_PC)
	local mob = getTargetFacing(player, BL_MOB)
		
	if player.state == 2 then player:sendAnimation(246) player:sendMinitext("Tidak bisa melakukannya saat ini") return end
	if not player:canCast(1,1,0) then return end
	if player.magic < 2500 then player:sendAnimation(246) player:sendMinitext("Mp tidak cukup") return end
		
	player:sendAction(14, 40)
	player:playSound(84)
	player.magic = player.magic - 2500
	player:sendStatus()
	player:sendMinitext("Kamu menggunakan Fascinate")
	player:setAether("fascinate", 20000)
	
	
	if pc ~= nil then
		pc:sendAnimation(287)
		pc:sendAnimation(248)
		pc:sendAction(14, 40)
		if player:canPK(pc) then
			pc:sendMinitext("Kamu terpesona dengan pandangan " ..player.name)
			pc:setDuration("fascinate", 5000)
		end
	elseif mob ~= nil then
		mob:sendAnimation(287)
		mob:sendAnimation(248)
		mob:setDuration("fascinate", 5000)
	end
end,
	
while_cast = function(player)
	player:sendAnimation(304)
	player.paralyzed = true
end,		

uncast = function(player)
	player.paralyzed = false
	player:calcStat()
end
}
		
		
		
		
		
		
		
		
		
		
		
		
		
		