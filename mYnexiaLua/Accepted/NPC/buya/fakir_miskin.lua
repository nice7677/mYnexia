fakir_miskin = {

click = async(function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local r = math.random(1,3)
	local txt = ""
	if r == 1 then txt = "Nak minta sedekah... kasihanilah nenek yang tua ini." end
	if r == 2 then txt = "Orang baik di sayang tuhan nak.." end
	if r == 3 then txt = "Uhuk.. uhuk.. Maaf, nenek belum makan dari pagi." end

	npc:talk(2, ""..txt.."")
end),

cast = function(player)
	
	local npc = NPC("fakir_miskin")
	local r = math.random(1,4)
	
	player:sendAction(21, 120)
	if r == 1 then npc:talk(2, "Fakir miskin: Nak minta sedekah... kasihanilah nenek yang tua ini.") end
	if r == 2 then npc:talk(2, "Fakir miskin: Orang baik di sayang tuhan nak..") end
	if r == 3 then npc:talk(2, "Fakir miskin: Uhuk.. uhuk.. Maaf, nenek belum makan dari pagi.") end
	if r == 4 then npc:talk(2, "Fakir miskin: Hai anak muda.. tolong bantulah saya yang tidak berdaya ini..") end
	player:setDuration("fakir_miskin", 3000)
end,

while_cast = function(player)

	player:sendAnimation(248)
	
end,

uncast = function(player)

	player:calcStat()
end,

say = async(function(player, npc)
	
	local moved = true
	local say = string.lower(player.speech)
	
	if string.find(say, "(.*)sini nek(.*)") ~= nil then
		if not npc.x == player.x-1 then
			toXY(npc, player.x-1, player.y)
			npc:talk(0, "Mana sedekah nya nak?")
		end
	end
end)
}




















mangkuk = {

click = async(function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	local n = {graphic = convertGraphic(1159, "monster"), color = 0}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0

	if player.registry["beri_sedekah"] > os.time() then
		player:dialogSeq({t, "Kamu hanya bisa memberi 1 hari sekali."})
		return
	else
		player.registry["beri_sedekah"] = 0
		local opts = {}
		table.insert(opts, "Beri sedekah")
		table.insert(opts, "Exit")
		
		menu = player:menuString("Apa yang akan kamu lakukan?", opts)
		
		if menu == "Beri sedekah" then
			input = player:input("Berapa banyak yang akan kau berikan?")
			input = math.abs(tonumber(input))

			if input > 0 then
				if player:removeGold(tonumber(input)) == false then
					player:dialogSeq({t, "Kamu tidak memiliki jumlah tersebut!"})
					return
				else
					player:removeGold(input)
					player.registry["beri_sedekah"] = os.time()+86400
					finishedQuest(player)
					player:sendMinitext("Karmamu meningkat sedikit")
					player:dialogSeq({n, "Terima kasih banyak anak muda! aku akan mengingat kebaikan mu."}, 1)
					player.registry["has_donated_fakir"] = player.registry["has_donated_fakir"] + input
					player:removeLegendbyName("help_fakir_miskin")
					player:addLegend("Donated "..format_number(player.registry["has_donated_fakir"]).." coins to fakir miskin (mYnexia "..curYear()..", "..getCurSeason()..")", "help_fakir_miskin", 20, 16)
					player:msg(4, "=== New Legend Added! ===", player.ID)
				end
			end
		end
	end
end)
}
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
