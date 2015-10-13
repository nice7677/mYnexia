gm_npc_items = {

click = function(player, npc)
	
	gfxClone(player, npc)
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 2
	
	local opts = {}
	table.insert(opts, "Get item by yname")
	table.insert(opts, "Browse from Categories")
	table.insert(opts, "<< Back")
	
	menu = player:menuString("<b>[Items]\n\nDatabase items: "..Player(2).registry["database_item"].."", opts)
	
	if menu == "Get item by yname" then
		input = player:input("Type item yname\n\nEX: ('return_scroll')")
		if Item(input) ~= nil then	
			if player:hasSpace(Item(input).id, 1) then
					player:addItem(Item(input).id, 1)
					player:sendMinitext("Done!!")
					gm_npc_items.click(player, npc)
			else
				player:dialogSeq({"You don't have enough space in your inventory!"})
			end
		else
			player:dialogSeq({"Item not found in database!"})
		end
	elseif menu == "Browse from Categories" then
		gm_npc_items.click2(player,npc)
	
	elseif menu == "<< Back" then
		iseng.click(player, npc)
	end
end,


click2 = function(player, npc)
	
	gfxClone(player, npc)
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 2
	
	local dialog = "<b>[Items]\n\nWhat items sir?"
	local opts = {}
	table.insert(opts, "Useable items")
	table.insert(opts, "Mount")
	table.insert(opts, "Weapon")
	table.insert(opts, "Armor")
	table.insert(opts, "Shield")
	table.insert(opts, "Helm")
	table.insert(opts, "Hands")
	table.insert(opts, "Accessories")
	table.insert(opts, "Item Mall")
	
	menu = player:menuString(dialog, opts)
	
	local items = {}
	
	if menu == "<< Back" then
		gm_npc_items.click(player, npc)
	elseif menu == "Item Mall" then
		gm_npc_items.item_mall(player, npc)
	else
		if menu == "Useable items" then
			for i = 21, 76 do table.insert(items, Item(i).id) end
		elseif menu == "Mount" then
			for i = 2001, 2018 do table.insert(items, Item(i).id) end
		elseif menu == "Weapon" then
			for i = 3001, 3075 do table.insert(items, Item(i).id) end
		elseif menu == "Armor" then
			for i = 4001, 4099 do table.insert(items, Item(i).id) end
		elseif menu == "Shield" then
			for i = 5001, 5014 do table.insert(items, Item(i).id) end
		elseif menu == "Helm" then
			for i = 6001, 6017 do table.insert(items, Item(i).id) end
		elseif menu == "Hands" then
			for i = 7001, 7065 do table.insert(items, Item(i).id) end
		elseif menu == "Accessories" then
			for i = 9000, 9013 do table.insert(items, Item(i).id) end
		end
		player:browseItemDB("What item do you need sir?", items)
	end
	
end,


item_mall = function(player, npc)

	gfxClone(player, npc)
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 2
	
	player:dialogSeq({t, "Coming soon.."})
end
}
	
	
function Player.browseItemDB(player, dialog, items)
	
	local price = {}
	for x = 1, #items do table.insert(price, 0) end
	local get = player:buy(dialog, items, price, {}, {})
	for i = 1, #items do
		if Item(items[i]).id == get then
			c = i
			break
		end
	end
	if c == 0 then return end
	if Item(get).maxAmount == 1 then
		amount = 1
	else
		q = player:input("How many "..Item(get).name.."?")
		if tonumber(q) > Item(get).maxAmount then
			player:dialogSeq({"You cannot do that!\n\nMax : "..Item(get).maxAmount..""})
			return
		else
			amount = tonumber(q)
		end
	end
	if not player:hasSpace(Item(get).id, amount) == true then
		player:dialogSeq({"You don't have enough space in inventory!"})
		return
	else
		player:addItem(Item(get).id, amount)
	end
	player:browseItemDB("What item do you need sir?", items)
end	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	