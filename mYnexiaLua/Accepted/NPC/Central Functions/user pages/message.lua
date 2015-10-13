messages = {

click = function(player, npc)

	local pc = Player(player.registry["on_page"])
	
	if pc == nil then user_pages.click(player, npc) return end
	gfxClone(pc, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 2

	local txt, text
	txt =      "Gold         : "..format_number(pc.money).."\n"
	txt = txt.."Gold in bank : "..format_number(pc.bankMoney).."\n"
	txt = txt.."Location: "..pc.mapTitle.."("..pc.m..")\n"
	txt = txt.."X:"..pc.x.." , Y:"..pc.y..""

	msg = player:menuString("<b>[Send messages]\n"..txt.."", {"Pop up", "Minitext", "Warning (Yellow)", "Whisp   (Blue)"})
	if msg == "Pop up" then
		player.registry["send_msg_type"] = 1
	elseif msg == "Minitext" then
		player.registry["send_msg_type"] = 2
	elseif msg == "Warning (Yellow)" then
		player.registry["send_msg_type"] = 3
	elseif msg == "Whisp   (Blue)" then
		player.registry["send_msg_type"] = 4
	end
	text = player:input("Msg: ")
	if text ~= nil then
		if player.registry["send_msg_type"] == 1 then
			pc:popUp(text)
		elseif player.registry["send_msg_type"] == 2 then
			pc:sendMinitext(text)
		elseif player.registry["send_msg_type"] == 3 then
			pc:msg(4, text, pc.ID)
		elseif player.registry["send_msg_type"] == 4 then
			pc:msg(0, text, pc.ID)
		end
		player:sendMinitext("Done!!")
		messages.click(player, npc)
	end
end
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	