vending_menu = {

click = async(function(player, npc)
	
	local cape = player:getEquippedItem(EQ_MANTLE)

	if cape == nil or not cape.yname == "vending_ransel" or not cape.yname == "vending_cart" then
		anim(player)
		player:popUp("You must to equip vending ransel/cart first!")
		return
	end
	
	local t = {graphic = convertGraphic(783, "monster"), color = 0}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local m = player.m
	local x = player.x
	local y = player.y
	
	local opts = {}
	if player.registry["v_open"] == 1 then table.insert(opts, "Close shop") else table.insert(opts, "Open shop") end
	table.insert(opts, "Set promotion text")
	table.insert(opts, "Add item")
	table.insert(opts, "Show item")
	table.insert(opts, "Exit")
	
	menu = player:menuString("<b>[Vending]\n\n"..player.vendingMsg.."\n\nItems Sale : ("..player.registry["total_v_item"].."/"..player.registry["max_vending_slots"]..")", opts)
	
	if menu == "Add item" then
		vending.addItem(player)
		
	elseif menu == "Show item" then
		vending.showItem(player)
		
	elseif menu == "Set promotion text" then
		text = player:input("Type your shop promotion text:\nEX:(Selling wooden sword @2k!)\n\n"..player.vendingMsg.."")
		if text ~= nil then
			player.vendingMsg = text
			player:sendMinitext("Done!")
			if player.registry["total_v_item"] > 0 then
				ok = player:menuString("<b>[Vending]\n\n"..player.vendingMsg.."\n\nItems Sale : ("..player.registry["total_v_item"].."/"..player.registry["max_vending_slots"]..")\nOpen shop now?", {"Open shop", "Exit"})
				if ok == "Open shop" then
					vending.openShop(player)
				end
			end
		end
	elseif menu == "Open shop" and player.registry["v_open"] == 0 then
		vending.openShop(player)
		
	elseif menu == "Close shop" and player.registry["v_open"] == 1 then
		player:setDuration("vending_menu", 0)
	end
end),

while_cast = function(player)
	
	player.paralyzed = true
	player.registry["v_open"] = 1
	player.gfxClone = 1	
	if string.len(player.vendingMsg) < 1 then
		player:talk(2, ""..player.name.."'s shop")
	else
		player:talk(2, player.vendingMsg.."")
	end
end,

uncast = function(player)
	
	player.paralyzed = false
	player:calcStat()
	player:sendAnimationXY(251, player.x, player.y)
	player.registry["v_open"] = 0
	player.gfxClone = 0
	player:updateState()
	player:talk(2, "Shop closed!")
end
}












-- vending -- 

vending = {

click = async(function(player)
	
	
	menu = player:menuString("<b>["..target.name.."'s Shop]\n\n"..target.vendingMsg.."\n\nSale items : "..total.."/"..max, {"Hello 1", "Hello 2"})
	
	if menu == "Hello 1" then
		player:popUp("Hello 1")
	elseif menu == "Hello 2" then
		player:popUp("Hello 2")
	end
	
end),




-- Open Shop ----------------------------------------------------------------------------------------------------------

openShop = function(player)
	
	local x = player.x
	local y = player.y
	
	if player.registry["total_v_item"] == 0 then player:popUp("You don't have anything to sell!") return end
	if player.state ~= 0 then player:popUp("You cannot do that right now!") return end
	if string.len(player.vendingMsg) < 1 then
		msg = player:input("Set your shop promotion text :")
		if msg ~= nil then
			player.vendingMsg = msg
		end
	end
	vending.randomVendingCostume(player)
	player:sendAnimationXY(16, x, y-1)
	player:sendAnimationXY(16, x, y+1)
	player:sendAnimationXY(16, x+1, y)
	player:sendAnimationXY(16, x-1, y)
	player.paralyzed = true
	player:playSound(29)
	player:talk(2, "Shop Opened!")
	player:setDuration("vending_menu", 7200000)
end,

-- Add item ----------------------------------------------------------------------------------------------------------

addItem = function(player)
--function Player.vendingAddItem(player)
	
	local t = {graphic = convertGraphic(783, "monster"), color = 0}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local total = player.registry["total_v_item"]
	local max = player.registry["max_vending_slots"]
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
					player.registry["total_v_item"] = total + 1
					player:dialogSeq({t, "<b>[Vending]\n\nItem     : "..Item(player.registry["v_id"..i]).name.."\nQuantity : "..amount.." pcs\nPrice    : "..format_number(price).." coins\n\nThis item will now removed from your inventory and put on sale."},1)
					vending.addItem(player)
					break
				end
			end			
		end
	end
	return
end,

-- Show current items on sale ------------------------------------------------------------------------------------


showItem = function(player)

	local t = {graphic = 783, color = 0}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local cape = player:getEquippedItem(EQ_WEAP)
	local items = {}
	local price = {}
	local name = {}
	local info = {}
	local total = player.registry["total_v_item"]
	local max = player.registry["max_vending_slots"]
	if total == 0 then
		player:popUp("There's empty!")
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

	change = player:menuString("<b>[Vending]\n\nWhat to do with your "..Item(items[x]).name.."?", {"Remove", "Change price", "Exit"})
	if change == "Remove" then
		for i = 1, max do
			if Item(items[x]).id == player.registry["v_id"..i] then
				if player:hasSpace(Item(player.registry["v_id"..i]).id, player.registry["v_count"..i]) == true then
					player:dialogSeq({t, "<b>[Vending]\n\nTo get your "..player.registry["v_count"..i].." pcs of "..Item(items[x]).name.." back to inventory, Click 'Next' or 'Close' to cancel"},1)
					player:addItem(player.registry["v_id"..i], player.registry["v_count"..i])
					player.registry["v_id"..i] = 0
					player.registry["v_count"..i] = 0
					player.registry["v_price"..i] = 0
					player.registry["total_v_item"] = total - 1					
					vending.showItem(player)
					break
				else
					player:dialogSeq({t, "<b>[Vending]\n\nYou don't have enough inventory slot for it!"})
				end
			end
		end
	end
	return

end,

-- Show target's shop --------------------------------------------------------------------------------------

showShop = async(function(player, target)
	
	local npc = NPC(66)
	vending.getNpcGraphic(target, npc)
	npc.gfxClone = 1
	player.lastClick = npc.ID
	player.dialogType = 2
	
	local opts = {}
	for i = 1, target.registry["max_vending_slots"] do
		if target.registry["v_id"..i] > 0 and target.registry["v_count"..i] > 0 and target.registry["v_price"..i] >= 0 then
			table.insert(opts, target.registry["v_count"..i].." "..Item(target.registry["v_id"..i]).name.." -> "..format_number(target.registry["v_price"..i]).." coins")
		end
	end
	menu = player:menuString("What do do?", opts)
	for i = 1, target.registry["max_vending_slots"] do
		if menu == target.registry["v_count"..i].." "..Item(target.registry["v_id"..i]).name.." -> "..format_number(target.registry["v_price"..i]).." coins" then
			id = target.registry["v_id"..i]
			amount = target.registry["v_count"..i]
			price = target.registry["v_price"..i]
			local icon = {graphic = Item(id).icon, color = Item(id).iconColor}
			txt =      "<b>[Vending]\n\n"
			txt = txt.."Item : "..Item(id).name.."\n"
			txt = txt.."Quantity : "..amount.." pcs\n"
			txt = txt.."Price    : "..price.."\n"
			player:dialogSeq({icon, txt..""}, 1)
			player.dialogType = 2
			ok = player:menuString("You're about to buy "..amount.." pcs of "..Item(id).name.." for "..price.." coins\n\nConfirm?", {"Buy it", "Cancel"})
			if ok == "Buy it" then
				if player:removeGold(price) == true then
					if player:hasSpace(id, amount) == true then
						player:addItem(id, amount)
						player:removeGold(price)
						target:addGold(price)
						player:sendMinitext("You paid "..format_number(price).." coins to "..target.name)
						target:sendMinitext("You earn "..format_number(price).." coins from vending")
						vending.transactionInfo(player, target, id, amount, price)
						vending.clearRegistry(target, id, amount, price)
					end
				end
			end
		end
	end
	return
end),
	
	
transactionInfo = function(player, target, id, amount, price)
	
	local item, mail
	if target == nil then return nil end
	
	for i = 1, target.registry["max_vending_slots"] do
		if target.registry["v_id"..i] > 0 and target.registry["v_count"..i] > 0 and target.registry["v_price"..i] >= 0 then
			if (id == target.registry["v_id"..i] and amount == target.registry["v_count"..i] and price == target.registry["v_price"..i]) then
				item = Item(id)
				player:msg(4, "================ Item Transaction Info ================", player.ID)
				player:msg(4, "Seller       : "..target.name.."", player.ID)
				player:msg(4, "Item         : "..item.name.."", player.ID)
				player:msg(4, "Quantity     : "..amount.." pcs.", player.ID)
				player:msg(4, "Price        : "..format_number(price).." coins.", player.ID)
				player:msg(4, "-------------------------------------------------------", player.ID)
				
				mail =       "===[ Vending Transaction Info ]===\n"
				mail = mail.."==================================\n"
				mail = mail.."Item        : "..item.name.."\n"
				mail = mail.."Quantity    : "..amount.." pcs\n"
				mail = mail.."sell price  : "..format_number(price).." coins\n"
				mail = mail.."Buyer       : "..player.name.."\n"
				mail = mail.."==================================\n"
				mail = mail.."Location, Date & Time : \n"
				mail = mail..""..target.mapTitle.."(X: "..target.x..", y: "..target.y.."), "..os.date().."\n"
				player:sendMail(target.name, "Transaction Info", mail.."") 
			end
		end
	end
	return
end,

clearRegistry = function(block, id, amount, price)
	
	local total = block.registry["total_v_item"]
	local max = block.registry["max_vending_slots"]
	
	for i = 1, max do
		if id == block.registry["v_id"..i] and amount == block.registry["v_count"..i] and price == block.registry["v_price"..i] then
			block.registry["v_id"..i] = 0
			block.registry["v_count"..i] = 0
			block.registry["v_price"..i] = 0
			block.registry["total_v_item"] = block.registry["total_v_item"] - 1
		end
	end
	if block.registry["total_v_item"] == 0 then
		block:setDuration("vending_menu", 0)
		block:popUp("<b>[Vending]\n\nAll your items has been sold out!")
	end
	return
end,
	
-- Get costume for vending ---------------------------------------------------------------------------------------------------------

randomVendingCostume = function(player)

	local cape = player:getEquippedItem(EQ_MANTLE)
	local boy = {171,173,181,183,185,187,189,191}
	local girl = {172,174,182,184,186,188,190,192}
	player.gfxFaceAT = 65535
	player.gfxFaceA = 65535
	player.gfxNeck = 65535
	player.gfxCoat = 65535
	player.gfxShield = 65535
	player.gfxCrown = 65535
	player.gfxWeap = 65535
	player.gfxFace = player.face
	player.gfxFaceC = player.faceColor
	player.gfxHair = player.hair
	player.gfxHairC = player.hairColor
	player.gfxDye = player.armorColor
	player.gfxSkinC = player.skinColor
	player.gfxHelm = 255
	if cape ~= nil then
		player.gfxCape = cape.look
		player.gfxCapeC = cape.lookC
	end
	if player.sex == 0 then
		player.gfxArmor = boy[math.random(#boy)]
	elseif player.sex == 1 then
		player.gfxArmor = girl[math.random(#girl)]
	end
	player.gfxClone = 1
	player:updateState()
end,

getNpcGraphic = function(block1, block2)

	block2.gfxFace = block1.gfxFace
	block2.gfxFaceC = block1.gfxFaceC
	block2.gfxFace = block1.gfxFace
	block2.gfxHair = block1.gfxHair
	block2.gfxHairC = block1.gfxHairC
	block2.gfxFaceC = block1.gfxFaceC 
	block2.gfxSkinC = block1.gfxSkinC
	block2.gfxDye = block1.gfxDye
	block2.gfxWeap = block1.gfxWeap
	block2.gfxWeapC = block1.gfxWeapC
	block2.gfxArmor = block1.gfxArmor
	block2.gfxArmorC = block1.gfxArmorC
	block2.gfxShield = block1.gfxShield
	block2.gfxShieldC = block1.gfxShieldC
	block2.gfxHelm = block1.gfxHelm
	block2.gfxHelmC = block1.gfxHelmC
	block2.gfxCape = block1.gfxCape
	block2.gfxCapeC = block1.gfxCapeC
	block2.gfxCrown = block1.gfxCrown
	block2.gfxCrownC = block1.gfxCrownC
	block2.gfxFaceA = block1.gfxFaceA
	block2.gfxFaceAC = block1.gfxFaceAC
	block2.gfxFaceAT = block1.gfxFaceAT
	block2.gfxFaceATC = block1.gfxFaceATC
	block2.gfxBoots = block1.gfxBoots
	block2.gfxBootsC = block1.gfxBootsC
	block2.gfxNeck = block1.gfxNeck
	block2.gfxNeckC = block1.gfxNeckC
end
}




























