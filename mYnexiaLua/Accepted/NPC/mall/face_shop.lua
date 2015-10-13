face_shop = {

click = async(function(player, npc)
	
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType =0
	
	local opts = {}
	table.insert(opts, "Face surgery")
	table.insert(opts, "Eye color")
	table.insert(opts, "Exit")
	
	pp = format_number(player.registry["play_point"])
	ep = format_number(player.registry["event_point"])
	fp = format_number(player.registry["fame_point"])
	
	menu = player:menuString("<b>[Face shop]\n\nEvent Points: "..ep.."\nPlay Points: "..pp.."\nFame Points: "..fp, opts)
	
	if menu == "Face surgery" then
		local model = {}
		table.insert(model, "Model A [PP: 7500 | Fame +8]")
		table.insert(model, "Model B [PP: 10000 | Fame +10]")
		table.insert(model, "Model C [PP: 14000 | Fame +15]")
	
		modelChoice = player:menuString("<b>[Face surgery]\n\nEvent Points: "..ep.."\nPlay Points: "..pp.."\nFame Points: "..fp, model)
		
		if modelChoice == "Model A [PP: 7500 | Fame +8]" then
			if player.gfxFace > 211 then player.gfxFace = 200 end
			if player.gfxClone == 0 then player.gfxClone = 1 gfxClone(player, player) end
			player:updateState()
			player.registry["browse_face_limit"] = 211
			face_browse.click(player, npc)
			
		elseif modelChoice == "Model B [PP: 10000 | Fame +10]" then
			if player.gfxFace > 224 then player.gfxFace = 211 end
			if player.gfxClone == 0 then player.gfxClone = 1 gfxClone(player, player) end
			player:updateState()
			player.registry["browse_face_limit"] = 224
			face_browse.click(player, npc)
			
		elseif modelChoice == "Model C [PP: 14000 | Fame +15]" then	
			if player.gfxFace > 238 then player.gfxFace = 224 end
			if player.gfxClone == 0 then player.gfxClone = 1 gfxClone(player, player) end
			player:updateState()
			player.registry["browse_face_limit"] = 238
			face_browse.click(player, npc)
			
		end
	end
end)
}
	

face_browse = {
click = function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 2
	
	local opts = {}
	table.insert(opts, "Next ->>")
	table.insert(opts, "I want this face")
	table.insert(opts, "<<- Previous")

	local limit = player.registry["browse_face_limit"]
	local pp = format_number(player.registry["play_point"])
	local ep = format_number(player.registry["event_point"])
	local fp = format_number(player.registry["fame_point"])
	local model
	local price
	
	if limit == 211 then 
		model = " Face Model A "
	elseif limit == 224 then
		model = " Face Model B "
	elseif limit == 238 then
		model = " Face Model C "
	end
	
	menu = player:menuString("<b>[".. model .."]\n\nEvent Points: "..ep.."\nPlay Points: "..pp.."\nFame Points: "..fp, opts)	
	
	if menu == "Next ->>" then
		player.gfxFace = player.gfxFace + 1
		if limit == 211 then
			if player.gfxFace > limit then player.gfxFace = 200 end
			if player.gfxFace < 200 then player.gfxFace = 211 end
		elseif limit == 224 then
			if player.gfxFace > limit then player.gfxFace = 212 end
			if player.gfxFace < 212 then player.gfxFace = 224 end
		elseif limit == 238 then
			if player.gfxFace > limit then player.gfxFace = 225 end
			if player.gfxFace < 225 then player.gfxFace = 238 end
		end
		
		player:updateState()
		face_browse.click(player, npc)
	
	elseif menu == "I want this face" then
		if limit == 211 then		-- Model A = 7500
			price = 7500
		elseif limit == 224 then	-- Model B = 10000
			price = 10000
		elseif limit == 238 then	-- Model C = 14000
			price = 14000
		end
		local buy = {"Buy with Play Point (PP: "..pp..")", "Buy with Event Point (EP: "..ep..")"}	
		ok = player:menuString("<b>["..model.."]\n\nEvent Points: "..ep.."\nPlay Points: "..pp.."\nFame Points: "..fp.."\nThe cost is "..price.." PP/EP", buy)
		if ok == "Buy with Play Point (PP: "..pp..")" then
			if player:canBuyIM("PP", price) then
				player:buyIMresult(price)
				player.registry["play_point"] = player.registry["play_point"] - price
				player.face = player.gfxFace
				player:updateState()
				player:sendMinitext("You changed your face look!")	-- To make sure script are running untill the end.
			else
				player:popUp("Not Enough PP !")
			end
		end
	elseif menu == "<<- Previous" then
		player.gfxFace = player.gfxFace - 1
		if limit == 211 then
			if player.gfxFace > limit then player.gfxFace = 200 end
			if player.gfxFace < 200 then player.gfxFace = 211 end
		elseif limit == 224 then
			if player.gfxFace > limit then player.gfxFace = 212 end
			if player.gfxFace < 212 then player.gfxFace = 224 end
		elseif limit == 238 then
			if player.gfxFace > limit then player.gfxFace = 225 end
			if player.gfxFace < 225 then player.gfxFace = 238 end
		end
		player:updateState()
		face_browse.click(player, npc)
	end
end
}
	
	
	
	
	
	
	
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	