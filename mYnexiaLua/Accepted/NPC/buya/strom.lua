strom = {

click = async(function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	if player.state == 1 then
		player.state = 0
		player.health = player.maxHealth
		player.magic = player.maxMagic
		player:sendStatus()
		player:updateState()
		player:sendAnimation(348)
		player:sendAnimation(349)
		player:playSound(112)		
	end
	
	player:dialogSeq({t, "Life is precious. Please take care of your self."},1)
end),


say = function(player, npc)

	local say = string.lower(player.speech)
	
	local txt = {}
	table.insert(txt, "(.*)terima kasih(.*)")
	table.insert(txt, "(.*)thank you(.*)")
	table.insert(txt, "(.*)tq(.*)")
	table.insert(txt, "(.*)thx(.*)")
	
	if string.find(say, txt) then
		if player.state ~= 1 then
			player.health = player.maxHealth
			player.magic = player.maxMagic
			player:sendAnimation(348)
			player:sendAnimation(349)
			player:playSound(112)
			player:sendStatus()
		end
	end
	
end
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	