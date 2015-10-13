
add_warp = {

click = function(player, npc)
	
	gfxClone(player, npc)
	
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 2
	
	local opts = {}

	frommap = player.registry["frommap"]
	fromx = player.registry["fromx"]
	fromy = player.registry["fromy"]
		
	tomap = player.registry["tomap"]
	tox = player.registry["tox"]
	toy = player.registry["toy"]
	
	-- if frommap > 0 and tomap > 0 then table.insert(opts, "Write into file") end
	
	-- table.insert(opts, "From  : "..frommap..", "..fromx..", "..fromy.."")
	-- table.insert(opts, "To    : "..tomap..", "..tox..", "..toy.."")
	
	for i = 1, 5 do
		if player.registry["from"..i.."map"] > 0 and player.registry["from"..i.."x"] >= 0 and player.registry["from"..i.."y"] >= 0 then
			table.insert(opts, i.." From: "..player.registry["from"..i.."map"]..", "..player.registry["from"..i.."x"]..", "..player.registry["from"..i.."y"].."")
		end
	end
	
	
	table.insert(opts, "Insert 'From' Coord")
	table.insert(opts, "Insert 'To' Coord")
	table.insert(opts, "Clear Coordinat")
	
	menu = player:menuString("", opts)

	if menu == "Insert 'From' Coord" then
		for i = 1, 5 do
			if player.registry["from"..i.."map"] > 0 and player.registry["from"..i.."x"] >= 0 and player.registry["from"..i.."y"] >= 0 then return else
				player.registry["from"..i.."map"] = player.m
				player.registry["from"..i.."x"] = player.x
				player.registry["from"..i.."y"] = player.y
			end
			add_warp.click(player, npc)
		end

	elseif menu == "Clear Coordinat" then
		for i = 1, 5 do
			player.registry["from"..i.."map"] = 0
			player.registry["from"..i.."x"] = 0
			player.registry["from"..i.."y"] = 0
		end
		add_warp.click(player, npc)
	end

	
end
}


















	