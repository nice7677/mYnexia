ice_guardian = {
click = async(function(player,npc)

	local t = {graphic = convertGraphic(npc.look, "monster"),color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0

        if player.registry["pedang_salju"] ~= 1 then
        	player:dialogSeq({t, "<b>[Ice Guardian]\n\nDo you know that our village has been attacked by Ice Monster?."}, 1)

        	player:dialogSeq({t, "<b>[Ice Guardian]\n\nNo one can kill this monster. they are untouchable. the only way to defeat them is by luring them into lava."}, 1)

        	player:dialogSeq({t, "<b>[Ice Guardian]\n\nCan you help me to kill this monster ?."}, 1)
	
   	end

	local r = math.random(1,3)
	local opts = {}
        table.insert(opts, "Ice Monster")       -- 1
        table.insert(opts, "Warm drinks from Japan")     -- 2
        table.insert(opts, "Exit")              -- 3
		
	menu = player:menuString("<b>[Ice Guardian]\n\nCan you help me kid?", opts)
	
	if menu ~= nil then
		if menu == "Warm drinks from Japan" then 
			respond = player:menuString("<b>[Ice Guardian]\n\nYou manage to find it ?", {"I think this is the drink", "No I am still looking for it..."})
                        if respond ~= nil then
				player.talk(0, "In progress...")
			end
		elseif menu == "Ice Monster" then 
			player.registry["warp"] = 500
			player.registry["warp_x"] = math.random(34, 38)
			player.registry["warp_y"] = 24
			player.registry["warp_cost"] = 10
			player.registry["warp_x"] = 34
			player.registry["warp_y"] = 1
			player.registry["warp_cost"] = 150000
			
		else
			return
		end
	end
end)
}

