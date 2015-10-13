mallDialog = function(player, item)

	d = "What "..item.." would you like to wear today?\n\n"
	d = d.."Event points : "..format_number(player.registry["event_point"]).."\n"
	d = d.."Play points  : "..format_number(player.registry["play_point"]).."\n"
	d = d.."Fame points  : "..format_number(player.registry["fame_point"]).."\n"		

	return d
end

crown_shop = {

click = async(function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local d = mallDialog(player, "hat")
	local opts = {"Common edition (EP / PP)", "FP edition (FP)", "Exit"}
	
	menu = player:menuString(d, opts)	
	if menu == "Common edition (EP / PP)" then
		local hat = {"Hat", "Hairband", "Costume", "Fantasy", "Animal", "Flora", "Crown", "Battle", "International", "Profession", "Casual", "Summer", "Winter", "Casual", "Formal", "Europe", "Oriental"}		
		common = player:menuString(d, hat)
		if common == "Hat" then
			crown_shop.hat(player, npc)
		elseif common == "Hairband" then
			crown_shop.hairband(player, npc)
		elseif common == "Costume" then
			crown_shop.costume(player, npc)
		elseif common == "Fantasy" then
			crown_shop.fantasy(player, npc)
		elseif common == "Animal" then
			crown_shop.animal(player, npc)
		elseif common == "Flora" then
			crown_shop.flora(player, npc)
		elseif common == "Crown" then
			crown_shop.crown(player, npc)
		elseif common == "Battle" then
			crown_shop.battle(player, npc)
		elseif common == "International" then
			crown_shop.international(player, npc)
		elseif common == "Profession" then
			crown_shop.profession(player, npc)
		elseif common == "Casual" then
			crown_shop.casual(player, npc)
		elseif common == "Summer" then
			crown_shop.summer(player, npc)
		elseif common == "Winter" then
			crown_shop.winter(player, npc)
		elseif common == "Casual" then
			crown_shop.casual(player, npc)
		elseif common == "Formal" then
			crown_shop.formal(player, npc)
		elseif common == "Europe" then
			crown_shop.europe(player, npc)
		elseif common == "Oriental" then
			crown_shop.oriental(player, npc)
		end
	elseif menu == "FP edition (FP)" then
		player:popUp("...")
	end
end),


hat = function(player, npc)
	
	player.dialogType = 0
	local d = mallDialog(player, "hat")
	local hat = {"Small hat", "Round hat", "Big round hat", "Fruit hat", "Top hat", "Mortar board", "Birthday hat", "Adventure hat", "Golfer cap"}
	menu = player:menuString(d, hat)

	if menu == "Small hat" then
		hat = player:menuString(d, {"Small hat  [PP: 7500 | Fame: +8]", "Exit"})
		if hat == "Small hat  [PP: 7500 | Fame: +8]" then
			crown_shop.choice(player, "small_hat", 7500)
		end
	elseif menu == "Big round hat" then
		player:popUp("Males buat deh kk.. byk amat..")
	end
end,


choice = function(player, item, price)

	local week = math.abs(tonumber(price/3))
	local month = math.abs(tonumber(price/2))
	local permanent = math.abs(tonumber(price))
	local opts = {}
	table.insert(opts, "Try it (Free)")
	table.insert(opts, "Buy 14 days  [PP: "..week.." | Fame: +3]")
	table.insert(opts, "Buy 30 days  [PP: "..month.." | Fame: +4]")
	table.insert(opts, "Buy Permanent [PP: "..permanent.." | Fame: +8]")
	table.insert(opts, "Exit")
	
	menu = player:menuString("What to do?", opts)
	
	if menu == "Try it (Free)" then
		if item == "small_hat" then player.gfxCrown = 5 end
		
	
	
	
	
	
	
	elseif menu == "Buy 14 days  [PP: "..week.." | Fame: +3]" then
		
	elseif menu == "Buy 30 days  [PP: "..month.." | Fame: +4]" then
		
	elseif menu == "Buy Permanent [PP: "..permanent.." | Fame: +8]" then
		
	
	end
	
	player:updateState()
end





}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	