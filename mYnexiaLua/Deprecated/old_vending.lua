
-- Add item ----------------------------------------------------------------------------------------------------------

function Player.vendingAddItem(player)
	
	local t = {graphic = convertGraphic(783, "monster"), color = 0}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local total = player.gameRegistry["total_v_item"]
	local max = player.gameRegistry["max_vending_slots"]
	if total >= max then player:dialogSeq({"<b>[Vending]\n\nYour ransel is full! ("..total.."/"..max..")!"}, 1) return end
	local stuff = {}
	local amount = 0
	local found = 0	
	for i = 0, player.maxInv do
		br = player:getInventoryItem(i)
		if br ~= nil and br.id > 0 then
			if #stuff > 0 then found = 0
				for j = 1, #stuff do
					if stuff[j] == br.id then found = 1 break end
				end
				if found == 0 then
					table.insert(stuff, br.id)
				end
			else
				table.insert(stuff, br.id)
			end
		end
	end
	add = player:sell("<b>[Vending]\n\nWhat item would you put on sale?\n\n Total items : ("..total.."/"..max..")", stuff)
	choice = player:getInventoryItem(add - 1)
	local t = {graphic = choice.icon, color = choice.iconC}
	
	if choice.dura < choice.maxDura then player:dialogSeq({t, "<b>[Vending]\n\nYour "..choice.name.." must in perfect condition (100%) to put on sale!"}, 1) player:vendingAddItem() return end
	if choice.amount > 1 and choice.maxAmount > 1 then
		amount = math.abs(tonumber(math.floor(player:input("<b>[Vending]\n\nHow many "..choice.name.."?"))))
		if player:hasItem(choice.id, amount) ~= true then
			check = player:hasItem(choice.id, amount)
			amount = check
		end
	else
		amount = 1
	end
	price = math.abs(tonumber(math.floor(player:input("<b>[Vending]\n\nHow much money for "..amount.." "..choice.name.." ?"))))
	if price < 0 then
		player:dialogSeq({t, "Invalid price number!"},1)
		return
	else
		ok = player:menuString("<b>[Vending]\n\nYou're about to sell "..amount.." "..choice.name.." for "..format_number(price).." coins. Confirm?", {"Yes", "No"})
		if ok == "Yes" and player:hasItem(choice.id, amount) == true then
			for i = 1, max do
				if player.registry["v_id"..i] == 0 and player.registry["v_count"..i] == 0 and player.registry["v_price"..i] == 0 then
					player.registry["v_id"..i] = choice.id
					player.registry["v_count"..i] = amount
					player.registry["v_price"..i] = price
					player:removeItem(choice.id, amount)
					player.gameRegistry["total_v_item"] = total + 1
					player:dialogSeq({t, "<b>[Vending]\n\nItem     : "..Item(player.registry["v_id"..i]).name.."\nQuantity : "..amount.." pcs\nPrice    : "..format_number(price).." coins\n\nThis item will now removed from your inventory and put on sale."},1)
					player:vendingAddItem()
					break
				end
			end			
		end
	end
end

-- Show current items on sale ------------------------------------------------------------------------------------

function Player.vendingShowItem(player)

	local t = {graphic = 783, color = 0}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local cape = player:getEquippedItem(EQ_WEAP)
	local items = {}
	local price = {}
	local name = {}
	local info = {}
	local total = player.gameRegistry["total_v_item"]
	local max = player.gameRegistry["max_vending_slots"]
	if total == 0 then
		player:dialogSeq({"<b>[Vending]\n\nThat's currently no things for sell!!"})
		return
	end	
	for i = 1, max do
		if player.registry["v_id"..i] > 0 and player.registry["v_count"..i] > 0 and player.registry["v_price"..i] >= 0 then
			table.insert(items, Item(player.registry["v_id"..i]).id)
			table.insert(price, player.registry["v_price"..i])
			table.insert(name, Item(player.registry["v_id"..i]).name)
			table.insert(info, "   "..player.registry["v_count"..i].." "..Item(player.registry["v_id"..i]).name.." >> "..format_number(player.registry["v_price"..i]).." coins.")
		end
	end
	
	local choice = player:buy("<b>[Vending]\n\n\nCurrent Items for sale: ("..total.."/"..max..")", items, price, name, info, {}, {}, {}, {})
	for i = 1, #items do
		if Item(choice).id == choice then
			x = i
			break
		end
	end
	if x == 0 then return nil end
	local t = {graphic = Item(items[x]).icon, color = Item(items[x]).iconC}
	for i = 1, max do
		change = player:menuString("<b>[Vending]\n\nWhat to do with your "..player.registry["v_count"..i].." pcs of "..Item(items[x]).name.."?", {"Remove", "Change price", "Exit"})
		break
	end
	if change == "Remove" then
		for i = 1, max do
			if Item(items[x]).id == player.registry["v_id"..i] then
				if player:hasSpace(Item(player.registry["v_id"..i]).id, player.registry["v_count"..i]) == true then
					player:dialogSeq({t, "<b>[Vending]\n\nTo continue get your "..player.registry["v_count"..i].." pcs of "..Item(items[x]).name.." back to inventory, Click 'Next' or 'Close' to cancel"},1)
					player:addItem(player.registry["v_id"..i], player.registry["v_count"..i])
					player.registry["v_id"..i] = 0
					player.registry["v_count"..i] = 0
					player.registry["v_price"..i] = 0
					player.gameRegistry["total_v_item"] = total - 1					
					player:vendingShowItem()
					break
				else
					player:dialogSeq({t, "<b>[Vending]\n\nYou don't have enough inventory slot for it!"})
				end
			end
		end
	end
end

-- Show target's shop --------------------------------------------------------------------------------------

function Player.showShop(player, target)

	local total = target.gameRegistry["total_v_item"]
	local max = target.gameRegistry["max_vending_slots"]
	local items = {}
	local price = {}
	local name = {}
	local info = {}
	for i = 1, max do
		if target.registry["v_id"..i] > 0 and target.registry["v_count"..i] > 0 and target.registry["v_price"..i] >= 0 then
			table.insert(items, Item(target.registry["v_id"..i]).id)
			table.insert(price, target.registry["v_price"..i])
			table.insert(name, Item(target.registry["v_id"..i]).name)
			table.insert(info, "   "..target.registry["v_count"..i].." "..Item(target.registry["v_id"..i]).name.." >> "..format_number(target.registry["v_price"..i]).." coins.")
		end
	end
	local choice = player:buy("<b>[Vending]\n\n"..target.vendingMsg.."\n\nItems on sale : ("..total.."/"..max..")", items, price, name, info, {}, {}, {}, {})
	for i = 1, #items do
		if Item(choice).id == choice then
			x = i
			break
		end
	end
	if x == 0 then return nil end
	local t = {graphic = Item(items[x]).icon, color = Item(items[x]).iconC}
	for i = 1, max do
		if Item(items[x]).id == target.registry["v_id"..i] then
			player:dialogSeq({t, "<b>[Vending]\n\nItem - INFO\nItem     : "..Item(target.registry["v_id"..i]).name.."\nQuantity : "..target.registry["v_count"..i].." pcs\nPrice    : "..format_number(target.registry["v_price"..i]).." coins"}, 1)
			buy = player:menuString("<b>[Vending]\n\nYou're about to buy "..target.registry["v_count"..i].." pcs of "..Item(target.registry["v_id"..i]).name.." for "..format_number(target.registry["v_price"..i]).." coins.", {"Buy it", "Cancel"})
			if buy == "Buy it" then
				player:vendingBuyItem(player, target, target.registry["v_id"..i], target.registry["v_count"..i], target.registry["v_price"..i])
				return
			elseif buy == "Cancel" then
				player:showShop(player, target)
			end
		end
	end
end
	

-- Buy item -------------------------------------------------------------------------------------------------------
	
function Player.vendingBuyItem(player, target, item, amount, price)
	
	if target == nil or item == nil or amount == nil or price == nil then return false end
	local total = target.gameRegistry["total_v_item"]
	local max = target.gameRegistry["max_vending_slots"]

	for i = 1, max do
		local brg = target.registry["v_id"..i]
		local jml = target.registry["v_count"..i]
		local hrg = target.registry["v_price"..i]
		if brg == Item(item).id and jml == amount and hrg == price then
			local t = {graphic = Item(item).icon, color = Item(item).iconC}
			if player:removeGold(hrg) == true then
				if player:hasSpace(Item(item).id, jml) == true then
					player:msg(12, "================ Item Transaction Info ================", player.ID)
					player:msg(12, "Item name    : "..item.name.."", player.ID)
					player:msg(12, "Quantity     : "..target.registry["v_count"..i].." pcs.", player.ID)
					player:msg(12, "Price        : "..format_number(target.registry["v_price"..i]).." coins.", player.ID)
					player:msg(12, "Gold         - "..format_number(player.money).." coins.", player.ID)
					player:msg(12, "-------------------------------------------------------", player.ID)
					player:msg(12, "Current gold : "..format_number(player.money-target.registry["v_price"..i]).." coins.", player.ID)
					player:removeGold(hrg)
					player:sendMinitext("You've paid "..format_number(hrg).." coins to "..target.name)					
					target:addGold(hrg)
					target:dialogSeq({t, "<b>[Vending]\n\nItem sold - INFO\nItem     : "..Item(target.registry["v_id"..i]).name.."\nQuantity : "..target.registry["v_count"..i].." pcs\nPrice    : "..format_number(target.registry["v_price"..i]).." coins\n\nBuyer name : "..player.name}, 1)
					target.registry["v_id"..i] = 0
					target.registry["v_count"..i] = 0
					target.registry["v_price"..i] = 0
					target.gameRegistry["total_v_item"] = target.gameRegistry["total_v_item"] - 1
					break
				else
					player:dialogSeq({t, "You don't have enough inventory slot for that!"})
				end
			else
				player:dialogSeq({t, "<b>[Vending]\n\nItem - INFO\nItem     : "..Item(target.registry["v_id"..i]).name.."\nQuantity : "..target.registry["v_count"..i].." pcs\nPrice    : "..format_number(target.registry["v_price"..i]).." coins\n\nYou don't have enough money!"})
			end
		end
	end
end