


npc_add_item = {
click = function(player, npc)

	local t = {graphic = 776, color = 0}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	local txt, confirm, check, amount, inven, ask, choice, icon, price, name, x
	local item = {}
	
	menu = player:menuString("What to do?", {"Add item", "Show item", "Registry", "Exit"})

	if menu == "Add item" then
		
		for i = 1, player.maxInv do
			inven  = player:getInventoryItem(i)
			if inven ~= nil and inven.id > 10 then
				if inven.dura == inven.maxDura then
					if inven.exchangeable == false and inven.owner == 0 then
						table.insert(item, inven.id)
					end
				end
			end
		end
		ask = player:sell("What item would you sell?", item)
		choice = player:getInventoryItem(ask - 1)		
		icon = {graphic = choice.icon, color = choice.iconC}
		
		if choice ~= nil then
			if choice.maxAmount > 1 and choice.amount > 1 then
				amount = math.abs(tonumber(math.floor(player:input("How many "..choice.name.."?"))))
				if player:hasItem(choice.id, amount) ~= true then
					check = player:hasItem(choice.id, amount)
					amount = check
				end
			else
				amount = 1
			end
			price = math.abs(tonumber(math.floor(player:input("How much money for "..amount.." "..choice.name.." ?"))))
			if price < 0 then player:dialogSeq({"Invalid number!!"}) return end
			name = choice.name
			confirm = player:menu("Item : "..name.."\nQuantity: "..amount.."\nSelling Price: "..format_number(price).."\nIs this correct?", {"Yes", "No"})
			if (confirm == "Yes" and player:hasItem(choice.id, amount) == true) then
				for x = 1, player.gameRegistry["max_vending_slots"] do
					if player.registry["v_item"..x.."id"] == 0 and player.registry["v_item"..x.."price"] == 0 and player.registry["v_item"..x.."count"] == 0 then
						player.registry["v_item"..x.."id"] = choice.id
						player.registry["v_item"..x.."price"] = price
						player.registry["v_item"..x.."count"] = amount
						player:updateInv()
						player:sendStatus()
						player:removeItem(choice.id, amount)
						player:dialogSeq({ib, "Your "..name.." added for sell"})
					end
				end
			end
		end

		
	end
	
	
	
end
}




function Player.addItemToSell(player, item, amount, price)
	
	local max = player.registry["max_vending_slots"]
	
	if tonumber(item) <= 0 then
		return false
	end
	
	if tonumber(amount) <= 0 then
		return false
	end
	
	if tonumber(price) < 0 then
		return false
	end
	
	if tonumber(item) > 10 and tonumber(amount) > 0 and tonumber(price) >= 0 then
		for i = 1, #max do
			if player.registry["v_item"..i] > 10 and player.registry["v_item"..i.."count"] > 0 and player.registry["v_item"..i.."price"] >= 0 then return else
				player.registry["v_item"..i] = item
				player.registry["v_item"..i.."count"] = amount
				player.registry["v_item"..i.."price"] = price
			end
		end
	end
	return item, amount, price
end
