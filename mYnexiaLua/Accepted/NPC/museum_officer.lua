museum_officer = {

click = async(function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local opts = {}
	table.insert(opts, "I want to give donation")
	table.insert(opts, "Exit")
	
	menu = player:menuString("<b>[Museum Nexia]\n\nWhat can i help you?", opts)
	
	if menu == "I want to give donation" then
		if player.registry["museum_donation"] >= os.time() then
			player:dialogSeq({t, "<b>[Museum Nexia]\n\nThank you for donating."})
		return else
			player:dialogSeq({t, "<b>[Museum Nexia]\n\nThere's a lot of memories and histories in this museum. We collected and kept them for years, so people will know about our past histories",
							"<b>[Museum Nexia]\n\nHowever, in order to keep this museum alive, we need a lot of money. I hope you can help us with giving a donation for this museum. Hope that will keep our history alive forever"}, 1)
			donate = player:menuString("<b>[Museum Nexia]\n\nWould you help us?", {"I would love to donate", "No, i won't"})
			if donate == "I would love to donate" then
				amount = math.abs(tonumber(player:input("<b>[Museum Nexia]\n\nEnter how much you want to give donation:")))
				if amount <= 0 then
					player:popUp("Invalid number")
				return else
					museum_officer.donateLevel(player, amount)
					player.registry["museum_donation"] = os.time() + 86400
					player:dialogSeq({t, "<b>[Museum Nexia]\n\nThanks a lot! Hope we will see you again!"}, 1)
				end
			end
		end
	end
end),

say = function(player, npc)

	local word = string.lower(player.speech)
	
	if word == "reset" then
		if player.gmLevel > 0 then
			player.registry["total_donated_museum"] = 0
			player.registry["museum_donation"] = 0
			npc:talk(2, "Reset done for "..player.name)
		end
	end
end,


donateLevel = function(player, amount)

	local level
	local total = player.registry["total_donated_museum"] 

	if amount <= 0 then return end
	
	total = total + amount
	
	if total < 1000000 then
		level = "Carring"
	elseif total > 1000000 then
		level = "Nice"
	elseif total > 5000000 then
		level = "Kind"
	elseif total > 25000000 then
		level = "Great"
	elseif total > 100000000 then
		level = "Charming"
	elseif total > 500000000 then
		level = "Generous"
	elseif total > 1000000000 then
		level = "Bilyuner"
	elseif total >= 2000000000 then
		level = "Conglomerate"
	end
	if player:hasLegend("museum_donate") then player:removeLegendbyName("museum_donate") end
	giveLegend(player, "The "..level.." donated "..format_number(total).." coins for museum", "museum_donate", 20, 16, 0)
end
}		

				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				