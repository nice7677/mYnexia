welcome_npc = {
click = async(function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"),color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	if player.registry["bank_pin"] > 0 then
		player:warp(1015,5,4)		-- Jadespear
		player:sendAnimation(16)
		player:playSound(29)
		return
	else
		npc:sendAction(1, 20)
		player:dialogSeq({t, "<b>[Welcome]\n\nWelcome to mynexia fun server. before to get in, you must to create a bank PIN first. Bank Pin consists of a 6 digit number that you must to remember",
							"<b>[Welcome]\n\nBecause this will be the password for the recovery of your character if you're in Hacked / forgot your password. Do NOT give your Pin Bank to ANYONE, including GM.",
							"<b>[Welcome]\n\nMissing an item and other losses will not be replaced by the GM. Bank PIN also needed to open your storage where you're deposit your money / items."}, 1)
		register_bankPin.click(player, npc)
	end
end),


say = async(function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"),color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	local q = string.lower(player.speech)
	
	if player.ID == 2 and player.gmLevel == 99 then
		if string.find(q, "(.*)reset(.*)") ~= nil then
			menu = player:menuString("<b>[Bank]\n\nDo you want to reset your Pin Bank?", {"Yes", "No"})
			if menu == "Yes" then
				npc:sendAction(1, 20)
				player.registry["bank_pin"] = 0		
				npc:talk(2, npc.name..": Bank Pin reset!")
			end
		end
	end
end)
}