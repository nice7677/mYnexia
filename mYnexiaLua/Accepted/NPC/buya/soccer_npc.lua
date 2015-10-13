

soccer_npc = {

click = async(function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local pc = player.group
	local opts = {}
	table.insert(opts, "Match info")
	table.insert(opts, "Register my team")
	table.insert(opts, "Exit")
	
	menu = player:menuString("<b>[Soccer]\n\nHello, what can i do for you?", opts)
	
	if menu == "Register my team" then
		soccer_core.registerTeam(player, npc)
	
	elseif menu == "Match info" then
		red1 = Player(npc.registry["red_team1"])
		red2 = Player(npc.registry["red_team2"])
		white1 = Player(npc.registry["white_team1"])
		white2 = Player(npc.registry["white_team2"])
		
		txt = "Red Team : "
		
		player:popUp("<b>[MATCH INFO]: \n\n"..txt)
	
	end
end)	
}



soccer_core = {

registerTeam = function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	if npc.registry["white_team1"] == player.ID or npc.registry["white_team2"] == player.ID or npc.registry["red_team1"] == player.ID or npc.registry["red_team2"] == player.ID then
		player:dialogSeq({t, "Anda sudah terdaftar sebagai player"})
		return
	end
	
	if player.mapRegistry["soccer_match"] > 0 then
		player:dialogSeq({t, "Sorry, you must to wait until their match finished"})
		return
	end

	local party = player.group
	
	if player.group == 0 then
		player:talk(2, "tak ada party")
		return
	end

	nama = player:input("Masukan nama team mu")
	if string.len(nama) >= 12 then
		player:dialogSeq({t, "Nama tidak boleh lebih dari 12 karakter"}, 1)
		soccer_core.registerTeam(player, npc)
		return
	else
		ok = player:menuString("Kamu akan mendaftarkan dengan nama team '"..nama.."'\nconfirm?", {"Ya", "Tidak"})
		if ok == "Ya" then
			if #party > 0 then
				for i = 1, #party do
					pc = Player(party[i])
					if pc.ID == player.ID then return else
						if pc.m ~= player.m then player:dialogSeq({t, "Your party member must in same map"}) return end
					
						if npc.registry["white_team1"] > 0 and npc.registry["white_team2"] > 0 then
							if npc.registry["red_team1"] > 0 and npc.registry["red_team2"] > 0 then
								player:dialogSeq({t, "Tunggu sampai pertandingan mereka selesai"})
							return else
								npc.registry["red_team1"] = player.ID
								npc.registry["red_team2"] = pc.ID
								team = "merah"
								pc1 = Player(npc.registry["red_team1"]).name
								pc2 = Player(npc.registry["red_team2"]).name
							end
						else
							npc.registry["white_team1"] = player.ID
							npc.registry["white_team2"] = pc.ID
							team = "putih"
							pc1 = Player(npc.registry["white_team1"]).name
							pc2 = Player(npc.registry["white_team2"]).name
						end

						player.f1Name = nama
						pc.f1Name = nama
						broadcast(1000, "[INFO]  '"..player.f1Name.."' team registered in buya soccer court! - waiting for chalengers!")
						player:playSound(20)
						
--[[						
						txt =      "\nKamu terdaftarkan kedalam team "..team.."\n\n"
						txt = txt.."Nama team  : "..nama.."\n"
						txt = txt.."Personil 1 : "..pc1.."\n"
						txt = txt.."Personil 2 : "..pc2.."\n\n"
						txt = txt.."Pertandingan akan di mulai jam : \n"
						player:dialogSeq({t, txt}, 1)
						pc:dialogSeq({t, txt}, 1)
]]--						
						player:freeAsync()
						soccer_core.showTeamInfo(player, team, nama, pc1, pc2)
						pc:freeAsync()
						soccer_core.showTeamInfo(pc, team, nama, pc1, pc2)
					end
				end
			else
				player:dialogSeq({t, "Kamu harus membuat party maksimal 2 orang player untuk bermain"})
			end
		end
	end
end,

showTeamInfo = async(function(player, team, nama, pc1, pc2)
	
	player:sendAnimation(246)
	txt =      "\nKamu terdaftarkan kedalam team "..team.."\n\n"
	txt = txt.."Nama team  : "..nama.."\n"
	txt = txt.."Personil 1 : "..pc1.."\n"
	txt = txt.."Personil 2 : "..pc2.."\n\n"
	txt = txt.."Pertandingan akan di mulai jam : \n"
	player:dialogSeq({txt})
end)
}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	






