

compass = {

click = async(function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local opts = {}
	table.insert(opts, "I need a giftbox")
	table.insert(opts, "Compass exchange")
	table.insert(opts, "Exit")
	
	menu = player:menuString("<b>[Compass collector]\n\nHi there, what do you need from me?", opts)
	
	if menu == "I need a giftbox" then
		local key = {}
		table.insert(key, "Yes, i do")
		table.insert(key, "No, i don't")
		gift = player:menuString("<b>[Compass collector]\n\nYou can exchange your 1 set treasure key for 1 giftbox.\n\nDo you've the require items?", key)
		
		if gift == "Yes, i do" then
			key1 = player:hasItem("treasure_key1", 1)
			key2 = player:hasItem("treasure_key2", 1)
			key3 = player:hasItem("treasure_key3", 1)
			key4 = player:hasItem("treasure_key4", 1)
			if key1 == true and key2 == true and key3 == true and key4 == true then
				player:removeItem("treasure_key1", 1)
				player:removeItem("treasure_key2", 1)
				player:removeItem("treasure_key3", 1)
				player:removeItem("treasure_key4", 1)
				player:addItem("gift_box", 1)
				player:dialogSeq({t, "<b>[Compass collector]\n\nHere you go."})
			else
				darkShadow(player)
				player:dialogSeq({t, "<b>[Compass collector]\n\nLooks like you don't have the items yet.."})
			end
		end
	end
end)
}
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				