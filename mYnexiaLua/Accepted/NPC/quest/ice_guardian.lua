

ice_guardian = {

click = async(function(player, npc)
	
	local sword = {graphic = convertGraphic(642, "item"), color = 17}
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	local ice = {graphic = convertGraphic(2455, "item"), color = 0}
	local monster = {graphic = convertGraphic(158, "monster"), color = 24}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0

	local n = "<b>[Ice Guardian]\n\n"
	
	local opts = {}
	if player.quest["snow_saber"] ~= 2 then table.insert(opts, "Ice Monster") end
	if player.quest["japan_sake"] == 0 then table.insert(opts, "Warm drinks from Japan") end
	table.insert(opts, "Exit")
	
	if player.quest["snow_saber"] == 0 then
		player:dialogSeq({t, "<b>[Ice Guardian]\n\nDon't you know that our village has been attacked by Ice monster?",
							monster, "<b>[Ice Guardian]\n\nNo one can kill this monster! They are untouchable. The only way to defeat them is by luring then into lava.",
							t, "<b>[Ice Guardian]\n\nWould you help us to save our village from this monster?"}, 1)
		player.quest["snow_saber"] = 1
	end
	menu = player:menuString(n.."Yes kid, What can i help you?", opts)
	
	if menu == "Ice Monster" then
		if player.quest["snow_saber"] ~= 2 then
			if player:hasItem("freezing_heart", 1) ~= true then
				player:dialogSeq({monster, "<b>[Ice Guardian]\n\nThe ice monster is come from land of artic at North Pole! I don't know exactly what they looking for. But they are destroying our village.", 
								monster, "<b>[Ice Guardian]\n\nYou've to very be careful of his arms. Once you get hit, i bet you will not be able to standing there again.",
								t, "<b>[Ice Guardian]\n\nSo, what do you think?"}, 1)	
				confirm = player:menuString(n.."Would you help us to kill the ice monster?", {"Yes, i'm not afraid", "No, im busy"})
				if confirm == "Yes, i'm not afraid" then
					player:spawn(40002, 21, 2, 1)
					player:msg(4, "=== The ice monster is coming ===", player.ID)
				end
			return else
				player.quest["snow_saber"] = 2		-- already finish
				player:playSound(121)
				player:dialogSeq({t, "<b>[Ice Guardian]\n\nAMAZING!!\nSo, you got the freezing heart. I'll make a special sword for you from that thing.\nWait a minute.."}, 1)
				player:playSound(123)
				player:addItem("snow_saber", 1)
				giveLegend(player, "Annihilate ice monster", "ice_monster", 38, 16, 1)
				player:dialogSeq({sword, "<b>[Ice Guardian]\n\nI'm finish! here, take it.."}, 1)
			end
		end
	elseif menu == "Warm drinks from Japan" then
		player:popUp("In progress..")


   	end
end),

say = function(player, npc)
	
	if player.gmLevel > 0 then
		if string.lower(player.speech) == "reset" then
			weap = player:getEquippedItem(EQ_WEAP)
			if weap ~= nil and weap.yname == "snow_saber" then
				player:stripEquip(0, 0, 1)
			end
			
			player.quest["snow_saber"] = 0
			player:removeItem("freezing_heart", 100)
			player:removeItem("snow_saber", 100)
			npc:talk(2, "Quest reset done for "..player.name)
		end
	end
end
}

