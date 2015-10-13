warper = {
click = async(function(player,npc)

	local t = {graphic = convertGraphic(npc.look, "monster"),color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local r = math.random(1,3)
	local opts = {}
	table.insert(opts, "Mall      - 10 coins")			-- 1
	table.insert(opts, "Market    - 10 coins")			-- 2
	table.insert(opts, "Kugnae    - 10 coins")			-- 3
	table.insert(opts, "Buya      - 10 coins")			-- 4
	table.insert(opts, "Arena     - 500 coins")			-- 5
	table.insert(opts, "PyungYang - 5,000 coins")		-- 6
	table.insert(opts, "DongBuya  - 7,500 coins")		-- 7
	table.insert(opts, "Mythic I  - 25,000 coins")		-- 8
	table.insert(opts, "Mythic II - 75,000 coins")		-- 9
	table.insert(opts, "Sanhae    - 50,000 coins")		-- 10
	table.insert(opts, "Uruzgard  - 100,000 coins")		-- 11
	table.insert(opts, "Vortex    - 150,000 coins")		-- 12
	table.insert(opts, "Sunset    - 1,000 coins")		-- 13
		
	menu = player:menuString("<b>[Warper]\n\nWhere you want to teleport kid?", opts)
	
	if menu ~= nil then
		if menu == "Mall      - 10 coins" then town = "Nexia Mall"
			player.registry["warp"] = 13
			player.registry["warp_x"] = math.random(16, 17)
			player.registry["warp_y"] = 26
			player.registry["warp_cost"] = 10
			
		elseif menu == "Market    - 10 coins" then town = "Nexia Market"
			player.registry["warp"] = 500
			player.registry["warp_x"] = math.random(34, 38)
			player.registry["warp_y"] = 24
			player.registry["warp_cost"] = 10
			
		elseif menu == "Kugnae    - 10 coins" then town = "Kugnae"
			r = math.random(1, 3)
			if r == 1 then player.registry["warp"] = 2003 end -- Walsuk	
			if r == 2 then player.registry["warp"] = 2004 end -- Ginger
			if r == 3 then player.registry["warp"] = 2005 end -- Bamboo
			player.registry["warp_x"] = math.random(3, 4)
			player.registry["warp_y"] = 5
			player.registry["warp_cost"] = 10
			
		elseif menu == "Buya      - 10 coins" then town = "Buya"
			r = math.random(1, 3)
			if r == 1 then player.registry["warp"] = 1001 end -- Yunsil inn	
			if r == 2 then player.registry["warp"] = 1002 end -- Spring inn	
			if r == 3 then player.registry["warp"] = 1006 end -- Pepper inn
			player.registry["warp_x"] = math.random(3, 4)
			player.registry["warp_y"] = 5
			player.registry["warp_cost"] = 10
			
		elseif menu == "Arena     - 500 coins" then town = "Arena"
			player.registry["warp"] = 1104
			player.registry["warp_x"] = 13
			player.registry["warp_y"] = 13
			player.registry["warp_cost"] = 500
			
		elseif menu == "PyungYang - 5,000 coins" then town = "Pyung Yang"
			player:popUp("Map is under construction")
			return
		elseif menu == "DongBuya  - 7,500 coins" then town = "Dong Buya"
			player:popUp("Map is under construction")
			return
		elseif menu == "Mythic I  - 25,000 coins" then town = "Mythic I"
			player.registry["warp"] = 6000
			player.registry["warp_x"] = math.random(29, 30)
			player.registry["warp_y"] = 1
			player.registry["warp_cost"] = 25000
			
		elseif menu == "Mythic II - 75,000 coins" then town = "Mythic II"
			player:popUp("Map is under construction")
			return
		elseif menu == "Sanhae    - 50,000 coins" then town = "Sanhae"
			player:popUp("Map is under construction")
			return
		elseif menu == "Uruzgard  - 100,000 coins" then town = "Uruzgard"
			player:popUp("Map is under construction")
			return
		elseif menu == "Vortex    - 150,000 coins" then town = "Vortex"
			player.registry["warp"] = 5000
			player.registry["warp_x"] = 34
			player.registry["warp_y"] = 1
			player.registry["warp_cost"] = 150000
			
		elseif menu == "Sunset    - 1,000 coins" then
			player.registry["warp"] = 1011
			player.registry["warp_x"] = math.random(5, 6)
			player.registry["warp_y"] = 10
			player.registry["warp_cost"] = 1000
		end
		
		if player:removeGold(player.registry["warp_cost"]) == true then
			player:warp(player.registry["warp"], player.registry["warp_x"], player.registry["warp_y"])
			player:sendAnimation(16)
			player:playSound(29)
			player:sendMinitext("You've been warped to "..town)
		else
			anim(player)
			player:dialogSeq({t, "You don't have enough money!"},1)
		end
	end
end)
}

