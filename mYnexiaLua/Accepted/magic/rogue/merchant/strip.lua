strip = {

on_learn = function(player) player.registry["learned_strip"] = 1 end,
on_forget = function(player) player.registry["learned_strip"] = 0 end,

cast = function(player)

	local magicCost = 5000
	local pc = getTargetFacing(player, BL_PC)
	local weap = player:getEquippedItem(EQ_WEAP)
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if weap ~= nil and weap.yname == "wooden_bow" then strip_bow.cast(player) return end
	if player.ID ~= 2 then player:setAether("strip", 60000) end
	player:sendAction(2, 20)
	player:playSound(19)
	player:sendMinitext("You cast strip")
	
	if pc ~= nil and player:canPK(pc) then		
		pc:sendAnimation(376)
		pc:sendAnimation(396)
		if pc.ID == 2 or pc.ID == 18 then anim(player) return end
		for i = 0, 3 do
			eq = pc:getEquippedItem(i)
			if eq ~= nil then
				if not pc:hasSpace(eq.id, 1) then
					pc:msg(4, "[INFO]: You dropped "..eq.name.."!!", pc.ID)
				end
				pc:stripEquip(i, 0, 1)	
			end
			pc:sendMinitext(player.name.. " force you to take off your equipment.")
		end
		pc:sendAnimation(248)
	end
end
			


}













strip_bow = {

cast = function(player)

	local magicCost = 5000
	local weap = player:getEquippedItem(EQ_WEAP)
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	if weap ~= nil and weap.yname == "wooden_bow" then
		if player.ID ~= 2 then player:setAether("strip", 60000) end
		player:sendAction(2, 20)
		player:playSound(19)
		player:sendMinitext("You cast strip")	
	
		for i = 1, 7 do
			pc = getTargetFacing(player, BL_PC, 0, i)
			if pc ~= nil and player:canPK(pc) then		
				pc:sendAnimation(376)
				pc:sendAnimation(396)
				if pc.ID == 2 then anim(player) return end
				for i = 0, 3 do
					eq = pc:getEquippedItem(i)
					if eq ~= nil then
						if not pc:hasSpace(eq.id, 1) then
							pc:msg(4, "[INFO]: You dropped "..eq.name.."!!", pc.ID)
						end
						pc:stripEquip(i, 0, 1)	
					end
					pc:sendMinitext(player.name.. " force you to take off your equipment.")
				end
				pc:sendAnimation(248)
				return
			end
		end
	end
end
			


}








