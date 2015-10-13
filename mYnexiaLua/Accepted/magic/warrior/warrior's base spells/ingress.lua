

ingress = {

cast = function(player)
		
	local weap = player:getEquippedItem(EQ_WEAP)	
	if not player:canCast(1,1,0) then return end	
		
	if weap == nil then
		anim(player)
		player:sendMinitext("No weapon to enchant!")
	return else		
		if player.enchant >= 4 then
			anim(player)
			player:sendMinitext("An enchantment is already in effect")
			return
		elseif player.enchant < 3 then
			anim(player)
			player:sendMinitext("You must to cast Infuse first!")
			return
		elseif player.enchant == 3 then
			player:sendAction(6, 20)
			player:sendAnimation(74)
			player:playSound(13)
			player.enchant = 4
			player:sendMinitext("You cast Ingress")
		end
	end
end
}

---------------------------------------------------------------------------------------------------------------



---------------------------------------------------------------------------------------------------------------



