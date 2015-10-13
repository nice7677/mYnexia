prophet = {

click = async(function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0

	if player.state == 1 then
		player.state = 0
		player:updateState()
		player:sendAnimation(425)
		player:playSound(112)
	end
	
	player:dialogSeq({t, "<b>[Prophet]\n\nLife is precious. Please take good care of yourself!"})
end),


say = function(player, npc)

	local q = string.lower(player.speech)
	local txt = {"thank you", "terima kasih", "tq", "thx"}
	
	for i = 1, #txt do
		if string.find(q, txt[i]) ~= nil then
			player.health = player.maxHealth
			player.magic = player.maxMagic
			player:sendStatus()
			player:sendAnimation(425)
			player:playSound(112)
			npc:talk(2, npc.name..": You're welcome "..player.name..", Take care!")
		end
	end
end
}













