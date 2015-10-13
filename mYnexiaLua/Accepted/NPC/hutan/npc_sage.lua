npc_sage = {

click = async(function(player, npc)
	
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	player:dialogSeq({t, "<b>[Sage Mode]\n\nMaaf, sage mode nya masih kacau balau. Sementara ini cuma lengkapi NPC doang.. hehe."}, 1)
	
	if player.registry["sage_mode_timer"] >= os.time() then
		timer = player.registry["sage_mode_timer"]
		r = timer-os.time()
		z = os.date("%X")
		tx =     "Countdown   : "..showTimer(r).."\n\n"
		tx = tx.."Finish time : "..z.."\n\n\n"
		tx = tx.."You'll not get an experience from hunting on sage mode!!"
		
		player:dialogSeq({t, "<b>[Sage Mode - INFO]\n\n"..tx}, 1)
		cancel = player:menuString("<b>[Sage Mode]\n\nAbort sage mode?", {"Abort sage mode", "Exit"})
		if cancel == "Abort sage mode" then
			confirm = player:menuString("<b>[Sage Mode]\n\nYou will not get your Coins/BP/PP back!\nAre you sure?", {"Yes, im sure", "No, i don't"})
			if confirm == "Yes, im sure" then
				player.registry["sage_mode_timer"] = 0
				player:dialogSeq({t, "<b>[Sage Mode]\n\nSage mode aborted"}, 1)
			end
		end
		return
	end		
	local opts = {}
	if player.registry["sage_mode_timer"] < os.time() then
		if player.registry["on_sage_mode"] == 0 then
			table.insert(opts, "Sage Mode")
		else
			table.insert(opts, "Finish sage mode")
		end
	end
	table.insert(opts, "What is Sage Mode?")
	table.insert(opts, "Exit")
	
	menu = player:menuString("<b>[Sage Mode]\n\nSst.. Feel the nature around you. amazing isn't it? What do you need from me?", opts)
	local txt
	txt =      "Wood  -> Coins-1 Hour-2x a day\n"
	txt = txt.."Water -> BP-2 Hours-1x a day\n"
	txt = txt.."Wind  -> BP-Instant-1x a day\n"
	txt = txt.."Fire  -> PP-Instant-1x a day"
	
	if menu == "What is Sage Mode?" then
		player:dialogSeq({t, "Sage Mode is a mode where you could remove your astral spirit temporarily from your body. You cannot hunting monster while your astral spirit conjure with nature.",
							"Four Natures of sage mode:\n\n"..txt.."\n\nNote: Price of coins and BP fluctuates based on prowess"},1)
	elseif menu == "Sage Mode" then
		if player.registry["sage_mode_timer"] >= os.time() then return end
		local pws = tonumber((player.baseMagic*2)+(player.baseHealth))
		local cost = math.floor(pws/99)
		local wood = player.registry["sage_wood"]
		local sage = {}
		table.insert(sage, "("..wood.."/2) Wood ["..format_number(cost).." coins - 1 Hour]")
		if player.registry["sage_wood"] == 0 and player.registry["on_sage_mode"] == 0 then 
			table.insert(sage, "(0/1) Water ["..format_number(cost).." coins - 2 Hour]")
			table.insert(sage, "(0/1) Wind [25 BP - Instant]")
			table.insert(sage, "(0/1) Fire [2500 PP - Instant]")
		end
		local x = math.random(164, 188)
		local y = math.random(21, 28)		
		txt =      "Wood -> Coin-1Hour-2x a day\n"
		txt = txt.."Water-> BP-2Hours-1x a day\n"
		txt = txt.."Wind -> BP-Instant-1x a day\n"
		txt = txt.."Fire -> PP-Instant-1x a day"
		element = player:menuString("<b>[Sage Mode]\n\n"..txt, sage)
		if element == "("..wood.."/2) Wood ["..format_number(cost).." coins - 1 Hour]" then
			if player:removeGold(cost) == true then
				player:removeGold(cost)
				player:sendMinitext("You've paid "..format_number(cost).." coins")
				player.registry["sage_wood"] = player.registry["sage_wood"] + 1
				player.registry["sage_mode_timer"] = os.time()+3600
				player:warp(10000, x, y)
				player:sagePopUp()
			else
				player:dialogSeq({t, "You don't have enough money!"})
			end
		elseif element == "(0/1) Water ["..format_number(cost).." coins - 2 Hour]" then
			if player:removeGold(cost) == true then
				player:removeGold(cost)
				player:sendMinitext("You've paid "..format_number(cost).." coins")
				player.registry["sage_mode_timer"] = os.time()+7200
				player:warp(10000, x, y)
				player:sagePopUp()
			else
				player:dialogSeq({t, "You don't have enough money!"})
			end
		elseif element == "(0/1) Wind [25 BP - Instant]" then
			if player.registry["on_sage_mode"] == 0 and player.registry["sage_wood"] == 0 then
				if player.registry["battle_point"] >= 25 then
					player.registry["battle_point"] = player.registry["battle_point"] - 25
					player:sendMinitext("- 25 BP")
					player.registry["on_sage_mode"] = 1
					npc_sage.click(player, npc)
				else
					player:dialogSeq({t, "<b>[Sage Mode]\n\nYou don't have enough BP!"})
				end
			end
		elseif element == "(0/1) Fire [2500 PP - Instant]" then
			if player.registry["on_sage_mode"] == 0 and player.registry["sage_wood"] == 0 then
				if player.registry["play_point"] >= 2500 then
					player.registry["play_point"] = player.registry["play_point"] - 2500
					player:sendMinitext("- 2500 PP")
					player.registry["on_sage_mode"] = 1
					npc_sage.click(player, npc)
				else
					player:dialogSeq({t, "<b>[Sage Mode]\n\nYou don't have enough PP!"})
				end
			end
		end
	end
end),

say = function(player, npc)

	local say = string.lower(player.speech)

	if player.gmLevel > 0 then
		if say == "reset" then
			player.registry["sage_mode_timer"] = 0
			player.registry["sage_mode_wood"] = 0
			player.registry["on_sage_mode"] = 0
			npc:talk(2, "Sage mode reset done for "..player.name)
		end
	end
end
}
	
	
	
	
	
	
	
	
	
