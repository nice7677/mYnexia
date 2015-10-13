

register_bankPin = {
click = function(player, npc)

	local t = {graphic = convertGraphic(809, "monster"),color = 0}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	pin1 = player:input("Enter new PIN: ")	
	if tonumber(pin1) ~= nil and string.len(tonumber(pin1)) == 6 then	
		pin2 = player:input("Retype to confirm PIN: ")	
		if tonumber(pin2) == tonumber(pin1) then	
			ok = player:menuString("<b>[Bank]\n\nYour Bank Pin : \n<b>"..tonumber(pin2).."\nConfirm?",{"Yes", "No"})	
			if ok == "Yes" then
				npc:sendAction(1, 20)
				player.registry["bank_pin"] = tonumber(pin2)	
				player:dialogSeq({t, "Bank PIN created!!\n\nPin:\n"..tonumber(pin2).."\n\nPlease don't do forget it."},1)	
				player:warp(1015,5,4)	--Jadespear
				player:sendAnimation(16)
				player:playSound(29)
			else
				register_bankPin.click(player, npc)
			end
		else
			player:dialogSeq({t, "<b>[Bank]\n\nConfirm Pin failed (did not match)!"},1)
			register_bankPin.click(player, npc)
		end
	else
		player:dialogSeq({t, "<b>[Bank]\n\nPin must contains 6 digits number!"},1)
		register_bankPin.click(player,npc)
	end
end
}
					
change_pin = function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
		
	local oldpin = player.registry["bank_pin"]

	if oldpin > 0 then
		old = player:input("Enter Old Bank Pin:")
		if tonumber(old) == oldpin then
			new = player:input("Enter New Pin:")
			if tonumber(new) > 0 and string.len(tonumber(new)) == 6 then
				acc = player:input("Enter once again to confirm:")
				if tonumber(acc) == tonumber(new) then
					player.registry["bank_pin"] = tonumber(new)
					player:dialogSeq({t, "<b>[Bank]\n\nChange Pin Success!\n\nYour Pin : "..oldpin.."\n\nPlease don't to forget!"}, 1)
				else
					player:dialogSeq({t, "<b>[Bank]\n\nPin not match! Failed to change Bank PIN"},1)
				end
			else
				player:dialogSeq({t, "<b>[Bank]\n\nPin must in 6 digits number"})
			end
		else
			player:dialogSeq({t, "<b>[Bank]\n\nWrong PIN!"},1)
		end
	end
end
					
					
					
					
					
					
					
					
					
					
					
					
					
					