hair_stylist = {
click = async(function(player, npc)

	local t = {graphic = convertGraphic(npc.look ,"monster"),color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	--if r == 1 then npc:sendAction(11, 50) end
	
	local opts = {}
	table.insert(opts, "Hair Dresser")
	table.insert(opts, "Hair Color")
	table.insert(opts, "Exit")

	pp = format_number(player.registry["play_point"])
	ep = format_number(player.registry["event_point"])
	fp = format_number(player.registry["fame_point"])	
	
	menu = player:menuString("<b>[Barber shop]\n\nEvent Points: "..ep.."\nPlay Points: "..pp.."\nFame Points: "..fp, opts)
	
	if menu == "Hair Dresser" then
		local model = {}
		table.insert(model, "Model A [PP: 7500 | Fame: +8]")
		table.insert(model, "Model B [PP: 10000 | Fame +10]")
		table.insert(model, "Model C [PP: 14000 | Fame +15]")		

		menu2 = player:menuString("<b>[Barber shop]\n\nEvent Points: "..ep.."\nPlay Points: "..pp.."\nFame Points: "..fp, model)
		

		if menu2 == "Model A [PP: 7500 | Fame: +8]" then
			if player.gfxHair > 44 then player.gfxHair = 0 end
			if player.gfxClone == 0 then player.gfxClone = 1 gfxClone(player, player) end
			player:updateState()
			player.registry["browse_hair_limit"] = 44
			hair_browse.click(player, npc)		
		elseif menu2 == "Model B [PP: 10000 | Fame +10]" then
			if player.gfxHair > 88 then player.gfxHair = 44 end
			if player.gfxClone == 0 then player.gfxClone = 1 gfxClone(player, player) end
			player:updateState()
			player.registry["browse_hair_limit"] = 88
			hair_browse.click(player, npc)
		elseif menu2 == "Model C [PP: 14000 | Fame +15]" then
			if player.gfxHair > 133 then player.gfxHair = 88 end
			if player.gfxClone == 0 then player.gfxClone = 1 gfxClone(player, player) end
			player:updateState()
			player.registry["browse_hair_limit"] = 133
			hair_browse.click(player, npc)			
		end
	end
end)
--[[
say = function(player, npc)

	local say = string.lower(player.speech)
	local txt = {"dias", "diaz", "fastbetninenine", "fb99"}
	local rate = math.random(10)
	local moved = true
	
	for i = 1, #txt do
		if string.find(say, txt[i]) ~= nil then
			if rate == 1 then npc:talk(0, "Fastbetninenine: hmm?") end
			if rate == 2 then npc:talk(0, "Fastbetninenine: Zz, jgn byk cakap la "..player.name.." ganti dolo rambut lu") npc:sendAction(11, 120) end
			if rate == 3 then npc:talk(0, "Fastbetninenine: ZzZz") npc:sendAction(13, 120) end
			if rate == 4 then npc:talk(0, "Fastbetninenine: Apa sih "..player.name.."") npc:sendAction(19, 120) end
		end
	end
	if player.ID == 2 then
		if string.find(say, "(.*)sini lu(.*)") then
			FindCoordsPet(npc, player)
			npc:talk(0, "Fastbetninenine: Napa pek?")
		elseif string.find(say, "(.*)balik sana(.*)") then
			if toXY(npc, 1, 11) then
				npc.side = 2
				npc:sendSide()
			end
		end
	end
end
]]--
}




hair_browse = {
click = function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 2

	local opts = {}
	table.insert(opts, "Next ->>")
	table.insert(opts, "I want this hair")
	table.insert(opts, "<<- Previous")

	local limit = player.registry["browse_hair_limit"]
	local pp = format_number(player.registry["play_point"])
	local ep = format_number(player.registry["event_point"])
	local fp = format_number(player.registry["fame_point"])
	local model
	local price
	
	if limit == 44 then 
		model = " Hair Model A "
	elseif limit == 88 then
		model = " Hair Model B "
	elseif limit == 133 then
		model = " Hair Model C "
	end
	
	menu = player:menuString("<b>[".. model .."]\n\nEvent Points: "..ep.."\nPlay Points: "..pp.."\nFame Points: "..fp, opts)	
	
	if menu == "Next ->>" then
		player.gfxHair = player.gfxHair + 1
		if limit == 44 then
			if player.gfxHair > limit then player.gfxHair = 0 end
			if player.gfxHair < 0 then player.gfxHair = 44 end
		elseif limit == 88 then
			if player.gfxHair > limit then player.gfxHair = 44 end
			if player.gfxHair < 44 then player.gfxHair = 88 end
		elseif limit == 133 then
			if player.gfxHair > limit then player.gfxHair = 88 end
			if player.gfxHair < 88 then player.gfxHair = 133 end
		end
		
		player:updateState()
		hair_browse.click(player, npc)
	
	elseif menu == "I want this hair" then
	
		if limit == 44 then		-- Model A = 7500
			price = 7500
		elseif limit == 88 then	-- Model B = 10000
			price = 10000
		elseif limit == 133 then	-- Model C = 14000
			price = 14000
		end
		
		local buy = {"Buy with Play Point (PP: "..pp..")", "Buy with Event Point (EP: "..ep..")"}	
		ok = player:menuString("<b>["..model.."]\n\nEvent Points: "..ep.."\nPlay Points: "..pp.."\nFame Points: "..fp.."\nThe cost is "..price.." PP/EP", buy)
		if ok == "Buy with Play Point (PP: "..pp..")" then
			if player:canBuyIM("PP", price) then
				player:buyIMresult(price)
				player.registry["play_point"] = player.registry["play_point"] - price
				player.hair = player.gfxHair
				player:updateState()
				player:sendMinitext("You changed your hair style!")	-- To make sure script are running untill the end.
			else
				player:popUp("Not Enough PP !")
			end
		end
	elseif menu == "<<- Previous" then
		player.gfxHair = player.gfxHair - 1
		if limit == 44 then
			if player.gfxHair > limit then player.gfxHair = 0 end
			if player.gfxHair < 0 then player.gfxHair = 44 end
		elseif limit == 88 then
			if player.gfxHair > limit then player.gfxHair = 44 end
			if player.gfxHair < 44 then player.gfxHair = 88 end
		elseif limit == 133 then
			if player.gfxHair > limit then player.gfxHair = 88 end
			if player.gfxHair < 88 then player.gfxHair = 133 end
		end
		player:updateState()
		hair_browse.click(player, npc)
	end
end
}		
		
		
		