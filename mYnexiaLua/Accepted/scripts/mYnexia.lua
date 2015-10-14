

getFrontTarget = function(player, cell, type)
	
	local target = {}
	
	if player.side == 0 then
		target = player:getObjectsInCell(player.m, player.x, player.y-cell, type)
	elseif player.side == 1 then
		target = player:getObjectsInCell(player.m, player.x+cell, player.y, type)
	elseif player.side == 2 then
		target = player:getObjectsInCell(player.m, player.x, player.y+cell, type)	
	elseif player.side == 3 then
		target = player:getObjectsInCell(player.m, player.x-cell, player.y, type)
	end
	return target[1]
end

giveLegend = function(player, text, name, icon, color, type)
	
	local time = "(mYnexia "..curYear()..", "..getCurSeason()..")"
	
	
	if tonumber(icon) == nil then icon = 17 end
	if tonumber(color) == nil then color = 16 end
	
	if player:hasLegend(name) then player:removeLegendbyName(name) end
	if tonumber(type) == 0 then player:addLegend(text, name, icon, color) end
	if tonumber(type) == 1 then player:addLegend(text.." "..time, name, icon, color) end
	finishedQuest(player)
	player:msg(4, "=== New legend added! ===", player.ID)
end


repairAll = function(player, npc)
	
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local items = {}
	for i = 0, 7 do
		eq = player:getEquippedItem(i)
		if eq ~= nil then
			if eq.repairable == false then
				if eq.dura < eq.maxDura then
					table.insert(items, eq.id)
				end
			end
		end
	end
	if #items == 0 then player:popUp("You don't have anything to repair") return end
	
	local weapC, armorC, helmC, shieldC, leftC, rightC, left2C, right2C	
	local weap = player:getEquippedItem(EQ_WEAP)
	local armor = player:getEquippedItem(EQ_ARMOR)
	local helm = player:getEquippedItem(EQ_HELM)
	local shield = player:getEquippedItem(EQ_SHIELD)
	local left = player:getEquippedItem(EQ_LEFT)
	local right = player:getEquippedItem(EQ_RIGHT)
	local left2 = player:getEquippedItem(6)
	local right2 = player:getEquippedItem(7)
	local items = {}
	
-- Weapon
	if weap ~= nil then weapN = weap.name
		if weap.dura < weap.maxDura and weap.repairable == false then
			WeapC = math.ceil(weap.maxDura - weap.dura)
		else
			weapC = 0
		end
	else
		weapN = "None"
	end
-- Armor
	if armor ~= nil then armorN = armor.name
		if armor.dura < armor.maxDura and armor.repairable == false then
			armorC = math.ceil(armor.maxDura - armor.dura)
		else
			armorC = 0
		end
	else
		armorN = "None"
	end
-- Helm
	if helm ~= nil then helmN = helm.name
		if helm.dura < helm.maxDura and helm.repairable == false then
			helmC = math.ceil(helm.maxDura - helm.dura)
		else
			helmC = 0
		end
	else
		helmN = "None"
	end
-- Shield	
	if shield ~= nil then shieldN = shield.name
		if shield.dura < shield.maxDura and shield.repairable == false then
			shieldC = math.ceil(shield.maxDura - shield.dura)
		else
			shieldC = 0
		end
	else
		shieldN = "None"
	end	
-- Left
	if left ~= nil then leftN = left.name
		if left.dura < left.maxDura and left.repairable == false then
			leftC = math.ceil(left.maxDura - left.dura)
		else
			leftC = 0
		end
	else
		leftN = "None"
	end
-- Right	
	if right ~= nil then rightN = right.name
		if right.dura < right.maxDura and right.repairable == false then
			rightC = math.ceil(right.maxDura - right.dura)
		else
			rightC = 0
		end
	else
		rightN = "None"
	end	
-- ScriptL	
	if left2 ~= nil then left2N = left2.name
		if left2.dura < left2.maxDura and left2.repairable == false then
			left2C = math.ceil(left2.maxDura - left2.dura)
		else
			left2C = 0
		end
	else
		left2N = "None"
	end
-- ScriptR
	if right2 ~= nil then right2N = right2.name
		if right2.dura < right2.maxDura and right2.repairable == false then
			right2C = math.ceil(right2.maxDura - right2.dura)
		else
			right2C = 0
		end
	else
		right2N = "None"
	end
	total = math.ceil(weapC + armorC + helmC + shieldC + rightC + leftC + right2C + left2C)
	
	if player:removeGold(total) == false then
		player:dialogSeq({t, "You don't have enough money to repair all.\n'You can try repair items in bag'"})
		return
	end
	if weap ~= nil then
		if weap.dura < weap.maxDura then weap.dura = weap.maxDura end
	end
	if armor ~= nil then
		if armor.dura < armor.maxDura then armor.dura = armor.maxDura end
	end
	if helm ~= nil then
		if helm.dura < helm.maxDura then helm.dura = helm.maxDura end
	end
	if shield ~= nil then
		if shield.dura < shield.maxDura then shield.dura = shield.maxDura end
	end
	if right ~= nil then
		if right.dura < right.maxDura then right.dura = right.maxDura end
	end
	if left ~= nil then
		if left.dura < left.maxDura then left.dura = left.maxDura end
	end
	if right2 ~= nil then
		if right2.dura < right2.maxDura then right2.dura = right2.maxDura end
	end
	if left2 ~= nil then
		if left2.dura < left2.maxDura then left2.dura = left2.maxDura end
	end
	player:status()
	player:removeGold(total)
	player:sendMinitext("Paid "..format_number(total).." coins")
	txt =      "\nThe repair cost are :\n\n"
	txt = txt.."----------------------------------------\n"
	txt = txt.."Weapon : "..weapN.." ("..weapC.." coins)\n"
	txt = txt.."Armor  : "..armorN.." ("..armorC.." coins)\n"
	txt = txt.."Helm   : "..helmN.." ("..helmC.." coins)\n"
	txt = txt.."Shield : "..shieldN.." ("..shieldC.." coins)\n"
	txt = txt.."R hand : "..rightN.." ("..rightC.." coins)\n"
	txt = txt.."L hand : "..leftN.." ("..leftC.." coins)\n"
	txt = txt.."R acc  : "..right2N.." ("..right2C.." coins)\n"
	txt = txt.."L acc  : "..left2N.." ("..left2C.." coins)\n\n"
	txt = txt.."----------------------------------------\n"
	txt = txt.."Total  : "..format_number(total).." coins\n"
	player:popUp(txt)
end
	

buyAdvancedTools = function(player, dialog, items, prices, with)
	
	if items == nil then items = {} end
	if prices == nil then prices = {} end
	local x = 0
	local amount = 1
	local t = {graphics = player.npcGraphic, color = player.npcColor}
	if #prices == 0 then
		for i = 1, #items do
			table.insert(prices, Item(items[i]).price)
		end
	end
	local choice = player:buy(dialog, items, prices, {}, {})
	for i = 1, #items do
		if Item(items[i]).id == choice then
			x = i
			break
		end
	end
	if x==0 then return nil end
	amount=player:input("How many do you wish to buy?")
	amount = amount * 1
	if with == "bp" then
		if player.registry["battle_point"] < (prices[x]*amount) then
			player:dialog("You don't have enough BP",{})
			return nil
		end
	elseif with == "pp" then
		if player.registry["play_point"] < (prices[x]*amount) then
			player:dialog("You don't have enough PP",{})
			return nil
		end
	end
	amount = math.abs(amount)
	local newChoice = player:menuString("The cost of " .. amount .. " " .. Item(choice).name .. " are " .. prices[x]*amount .. " "..with..". Do we have a deal?",{"Yes", "No"})
	if(newChoice=="Yes") then
		if player:hasSpace(Item(choice).name, amount) then
			if with == "bp" then
				if player.registry["battle_point"] >= (prices[x]*amount) then
					buy = {Item(choice).id, amount}
					player:addItem(Item(choice).name, amount)
					player.registry["battle_point"] = player.registry["battle_point"] - (prices[x]*amount)
					player:sendStatus()
					return buy
				else
					player:sendMinitext("Your inventory is full!")
				end
			elseif with == "pp" then
				if player.registry["play_point"] >= (prices[x]*amount) then
					buy = {Item(choice).id, amount}
					player:addItem(Item(choice).name, amount)
					player.registry["play_point"] = player.registry["play_point"] - (prices[x]*amount)
					player:sendStatus()
					return buy
				else
					player:sendMinitext("Your inventory is full!")
				end
			end
		else
			player:sendMinitext("Your inventory is full!")
		end
	end
end	


function Player.depositItemMall(player)
	
	local inven = {}
	local total = player.registry["wardrobe_total"]
	local max = player.registry["max_wardrobe"]
	local t = {graphic = player.npcGraphic, color = player.npcColor}
	player.dialogType = 0
	
--	if total >= max then player:dialogSeq({t, "<b>[Wardrobe]\n\nSorry, your wardrobe is full!\n\n\nWardrobe space: "..total.."/"..max}) return end
	for i = 0, player.maxInv do
		item = player:getInventoryItem(i)
		if item ~= nil and item.id > 10 then
			if item.type >= 12 and item.type <= 14 or item.type == 16 then
				table.insert(inven, item.id)
			end
		end
	end
	local ask = player:sell("<b>[Wardrobe]\n\nWhat item do you want to deposit?\n\nWardrobe space: "..total.."/"..max, inven)
	local choice = player:getInventoryItem(ask - 1)
	if choice == nil then return false end
	if amount == 0 then return false end
	if choice.maxAmount > 1 and choice.amount > 1 then return false end
	if choice.depositable then player:dialogSeq({t, "<b>[Wardrobe]\n\nYou cannot deposit this item!"}) return false end
	
	for i = 1, max do
		if player.registry["wardrobe"..i] == 0 then
			if player:hasItem(choice.id, 1) == true then
				player.registry["wardrobe"..i] = choice.id
				player.registry["wardrobe_total"] = player.registry["wardrobe_total"] + 1
				player:removeItem(choice.id, 1)
				player:depositItemMall()
			end
		end
	end
	return true
end
			

function Player.withdrawItemMall(player)

	local item
	local amount = {}
	local stuff = {}
	local total = player.registry["wardrobe_total"]
	local max = player.registry["max_wardrobe"]
	local t = {graphic = player.npcGraphic, color = player.npcColor}
	player.dialogType = 0

	for i = 1, max do
		if player.registry["wardrobe"..i] > 10 then
			item = Item(player.registry["wardrobe"..i])
			if item.type >= 12 and item.type <= 14 or item.type == 16 then
				table.insert(stuff, item.id)
			end
		end
	end
	if #stuff > 0 then
		for i = 1, #stuff do
			table.insert(amount, 1)
		end
	end
	local ask = player:buy("<b>[Wardrobe]\n\nWhat item would you withdraw?\n\nWardrobe space: "..total.."/"..max, stuff, amount, {}, {})
	for i = 1, #stuff do
		if stuff[i] == ask then
			x = i
			break
		end
	end
	if x == 0 then return nil end
	for i = 1, max do
		if Item(stuff[x]).id == player.registry["wardrobe"..i] then
			if player:hasSpace(Item(stuff[x]).id, 1) == true then
				player.registry["wardrobe"..i] = 0
				player:addItem(Item(stuff[x]).id, 1)
				player.registry["wardrobe_total"] = player.registry["wardrobe_total"] - 1
				player:withdrawItemMall()
				break
			else
				player:dialogSeq({t, "<b>[Wardrobe]\n\nYou don't have enough inventory slot"})
			end
		end
	end
	return true
end
			
			




----------------------------------------------------------------------------------------------------------------

gateWarp = function(player, region, gate)
	
	if not player:canCast(1,1,0) then return end
	local m, x, y
-- Region 1 - Buya		
	if region == 1 then m = 1000
		if gate == "u" then x = math.random(71,76)		y = math.random(24,27) 		end
		if gate == "s" then x = math.random(74, 77)		y = math.random(145, 147) 	end
		if gate == "b" then x = math.random(8, 10) 		y = math.random(89, 91) 	end
		if gate == "t" then x = math.random(133, 135) 	y = math.random(88, 90) 	end
-- Region 2 - Kugnae
	elseif region == 2 then m = 2000
		if gate == "u" then x = math.random(108, 110)	y = math.random(13, 15) 	end
		if gate == "s" then x = math.random(109, 111)	y = math.random(209, 211) 	end
		if gate == "b" then x = math.random(15, 17)		y = math.random(106, 108) 	end
		if gate == "t" then x = math.random(204, 206)	y = math.random(106, 108) 	end
-- Region 5 - Vortex
	elseif region == 5 then m = 5000
		if gate == "u" then x = math.random(32, 33) 	y = math.random(13, 14) 	end
		if gate == "s" then x = math.random(33, 35) 	y = math.random(50) 		end
		if gate == "b" then x = math.random(10,12) 		y = math.random(33,35) 		end
		if gate == "t" then x = math.random(57,59) 		y = math.random(34, 36) 	end
-- Region 6 -  Mythic I
	elseif region == 6 then m = 6000
		if gate == "u" then x = math.random(28, 30) 	y = 14 						end
		if gate == "s" then x = math.random(28, 30) 	y = 50 						end
		if gate == "b" then x = math.random(8, 9) 		y = math.random(22, 24) 	end
		if gate == "t" then x = math.random(46, 48) 	y = math.random(33, 34) 	end
-- Region 7 - Mythic II
	elseif region == 7 then m = 7000
		if gate == "u" then x = math.random(29, 31)		y = math.random(8, 10) end
		if gate == "s" then x = math.random(28, 32)		y = math.random(49, 53) end
		if gate == "b" then x = math.random(4, 8)		y = math.random(33, 37) end
		if gate == "t" then x = math.random(53, 57)		y = math.random(31, 35) end
		
-- Region 10 - Castle
	elseif region == 10 then m = 10000
		if gate == "u" then x = math.random(29, 31) 	y = math.random(27, 29) 	end
		if gate == "s" then x = math.random(30,31) 		y = 60 						end
		if gate == "b" then x = math.random(6,7) 		y = 60 						end
		if gate == "t" then x = math.random(53,54) 		y = 60 						end
	end
	player:warp(m,x,y)
	player:playSound(29)
	player:sendAnimation(16)
	player:sendAction(6, 20)
	player:sendMinitext("You cast Gateway")
	return
end	

-------------------------------------------------------------------------------------------------------------------

showTimer = function(value)
	
	local h,m,s
	value = tonumber(value)
	
	if value == 0 then
		return "00:00:00"
	else
		h = string.format("%02.f", math.floor(value / 3600))
		m = string.format("%02.f", math.floor(value / 60 - (h * 60)))
		s = string.format("%02.f", math.floor(value - h * 3600 - m * 60))
		return h..":"..m..":"..s
	end
end
	
-----------------------------------------------------------------------------------------------------------

canEnter = function(player, lv)
	
	if player.level < lv then
		pushBack(player)
		anim(player)
		player:sendMinitext("You're not strong enough to enter (min Lv: "..lv..")")
		return
	end
end

-----------------------------------------------------------------------------------------------------------


function Player.buyIMresult(player, price)	
	
	local result
	local pp = player.registry["play_point"]
	local ep = player.registry["event_point"]	

	result =         "<b>            [mYnexia Mall]\n\n"
	result = result.."----------------------------------------\n\n"
	result = result.."Item cost   : "..format_number(price).."\n"
	result = result.."Play Point  : "..format_number(pp).."\n"
	result = result.."Event Point : "..format_number(ep).."\n\n"

	if player:canBuyIM("PP", price) then
		result = result.."Pay With Play Point  ("..format_number(pp).." - "..format_number(price)..")\n"
		result = result.."Current Play Point  = "..format_number(pp - price).."\n\n"
	end
		
	if player:canBuyIM("EP", price) then
		result = result.."Pay With Event Point ("..format_number(ep).." - "..format_number(price)..")\n"
		result = result.."Current Event Point = "..format_number(ep - price).."\n\n"
	end
	
	result = result.."----------------------------------------\n\n"
	result = result.."        Thank You for shoping\n"
	
	player:sendAnimation(348)
	player:playSound(67)
	player:popUp(result)
	
	return player
end

function Player.canBuyIM(player, with, price)
	
	if with == "PP" and price > player.registry["play_point"] then return false end
	if with == "EP" and price > player.registry["event_point"] then return false end
	return true
end

gfxClone = function(player, npc)

	local weap = player:getEquippedItem(EQ_WEAP)
	local coat = player:getEquippedItem(EQ_COAT)
	local armor = player:getEquippedItem(EQ_ARMOR)
	local helm = player:getEquippedItem(EQ_HELM)
	local crown = player:getEquippedItem(EQ_CROWN)
	local cape = player:getEquippedItem(EQ_MANTLE)
	local shield = player:getEquippedItem(EQ_SHIELD)
	local boots = player:getEquippedItem(EQ_BOOTS)
	local facea = player:getEquippedItem(EQ_FACEACC)
	local neck = player:getEquippedItem(EQ_NECKLACE)

	if player.title ~= nil then
		if player.registry["show_title"] == 1 then
			npc.gfxName = player.title.." "..player.name
		else
			npc.gfxName = player.name
		end
	else
		npc.gfxName = player.name
	end
	npc.gfxFace = player.face
	npc.gfxFaceC = player.faceColor
	npc.gfxHair = player.hair
	npc.gfxHairC = player.hairColor
	npc.gfxSkin = player.skinColor
	npc.gfxDye = player.armorColor
	npc.gfxFaceAT = 65535
	npc.gfxHelm = 255
	
	if weap ~= nil then npc.gfxWeap = weap.look npc.gfxWeapC = weap.lookC else npc.gfxWeap = 65535 end
	if crown ~= nil then npc.gfxCrown = crown.look npc.gfxCrownC = crown.lookC else npc.gfxCrown = 65535 end
	if cape ~= nil then npc.gfxCape = cape.look npc.gfxCapeC = cape.lookC else npc.gfxCape = 65535 end
	if shield ~= nil then npc.gfxShield = shield.look npc.gfxShieldC = shield.lookC else npc.gfxShield = 65535 end
	if boots ~= nil then npc.gfxBoots = boots.look npc.gfxBootsC = boots.lookC else npc.gfxBoots = player.sex end
	if facea ~= nil then npc.gfxFaceA = facea.look npc.gfxFaceAC = facea.lookC else npc.gfxFaceA = 65535 end
	if neck ~= nil then npc.gfxNeck = neck.look npc.gfxNeckC = neck.lookC else npc.gfxNeck = 65535 end
	if coat ~= nil then
		npc.gfxArmor = coat.look
		npc.gfxArmorC = coat.lookC
	else
		if armor ~= nil then
			npc.gfxArmor = armor.look
			npc.gfxArmorC = armor.lookC
		else
			npc.gfxArmor = player.sex
		end
	end
	return npc
end

gfxLook = function(block1, block2)

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


function Player.learnSpell2(player, class)
	
	local opts = {}
	local lv = player.level
	local menu
	
-- [[ Common ]]-------------------------------------------------------------------------------------------------------------------------
	
	if class >= 0 then
		if lv >= 5 then
			if not player:hasSpell("silver_thread") then table.insert(opts, "Silver thread") end
			if not player:hasSpell("gateway") then table.insert(opts, "Gateway") end
			if not player:hasSpell("soothe") then table.insert(opts, "Soothe") end
		end
		if lv >= 8 and not player:hasSpell("fleshspeak") then table.insert(opts, "Fleshspeak") end
		if lv >= 35 and not player:hasSpell("home") then table.insert(opts, "Return") end
	end
	
--[[ Warrior ]]-------------------------------------------------------------------------------------------------------------------------
	
	if class == 1 then
		if lv >= 15 and not player:hasSpell("wolf_fury") then table.insert(opts, "Wolf's fury") end
		if lv >= 18 and not player:hasSpell("bless") then table.insert(opts, "Bless") end
		if lv >= 20 and not player:hasSpell("backstab") then table.insert(opts, "Backstab") end
		if lv >= 25 and not player:hasSpell("flank") then table.insert(opts, "Flank") end
		if lv >= 30 and not player:hasSpell("tiger_fury") then table.insert(opts, "Tiger's fury") end
		if lv >= 35 and not player:hasSpell("relief") then table.insert(opts, "Relief") end
		if lv >= 45 and not player:hasSpell("enchant") then table.insert(opts, "Enchant") end
		if lv >= 50 and not player:hasSpell("potence") then table.insert(opts, "Potence") end
		if lv >= 55 and not player:hasSpell("slash") then table.insert(opts, "Slash") end
		if lv >= 62 and not player:hasSpell("dragon_fury") then table.insert(opts, "Dragon's fury") end
		if lv >= 65 and not player:hasSpell("infuse") then table.insert(opts, "Infuse") end
		if lv >= 72 and not player:hasSpell("berserk") then table.insert(opts, "Berserk") end
		if lv >= 78 and not player:hasSpell("ingress") then table.insert(opts, "Ingress") end
		if lv >= 80 and not player:hasSpell("soul_fly") then table.insert(opts, "Soul fly") end
		if lv >= 90 and not player:hasSpell("vigor") then table.insert(opts, "Vigor") end
		if lv >= 99 and not player:hasSpell("whirlwind") then table.insert(opts, "Whirlwind") end
	end	
	
	
	
--[[ ROGUE ]]-------------------------------------------------------------------------------------------------------------------------
	
	if class == 2 then	
		if lv >= 12 and not player:hasSpell("frisk") then table.insert(opts, "Frisk") end
		if lv >= 14 and not player:hasSpell("feral") then table.insert(opts, "Feral") end
		if lv >= 15 and not player:hasSpell("might") then table.insert(opts, "Might") end
		if lv >= 17	and not player:hasSpell("judge") then table.insert(opts, "Judge") end
		if lv >= 18 then	
			if player.totem == 0 and not player:hasSpell("jujak_fire") then table.insert(opts, "Jujak fire") end	
			if player.totem == 1 and not player:hasSpell("baekho_surge") then table.insert(opts, "Baekho surge") end	
			if player.totem == 2 and not player:hasSpell("hyunmoo_snow") then table.insert(opts, "Hyunmoo snow") end	
			if player.totem == 3 and not player:hasSpell("chungryong_ray") then table.insert(opts, "Chungryong ray") end	
		end	
		if lv >= 20 and not player:hasSpell("mend_wounds") then table.insert(opts, "Mend wounds") end	
		if lv >= 24 then	
			if not player:hasSpell("shadow_figure") then table.insert(opts, "Shadow figure") end	
			if not player:hasSpell("ignite") then table.insert(opts, "Ignite") end	
		end	
		if lv >= 25 and not player:hasSpell("rodent") then table.insert(opts, "Rodent") end	
		if lv >= 26 and not player:hasSpell("set_trap") then table.insert(opts, "Set trap") end	
		if lv >= 28 and not player:hasSpell("spy") then table.insert(opts, "Spy") end	
		if lv >= 33 then	
			if not player:hasSpell("wolf_fury") then table.insert(opts, "Wolf's fury") end	
			if not player:hasSpell("gangrel") then table.insert(opts, "Gangrel") end	
		end	
		if lv >= 34 and not player:hasSpell("invisible") then table.insert(opts, "Invisible") end
		if lv >= 35 and not player:hasSpell("approach") then table.insert(opts, "Approach") end
		if lv >= 36 then	
			if player.totem == 0 and not player:hasSpell("jujak_inferno") then table.insert(opts, "Jujak inferno") end	
			if player.totem == 1 and not player:hasSpell("baekho_disaster") then table.insert(opts, "Baekho disaster") end	
			if player.totem == 2 and not player:hasSpell("hyunmoo_deathrain") then table.insert(opts, "Hyunmoo deathrain") end	
			if player.totem == 3 and not player:hasSpell("chung_thunderbolt") then table.insert(opts, "Chung thunderbolt") end	
		end	
		if lv >= 38 and not player:hasSpell("ambush") then table.insert(opts, "Ambush") end	
		if lv >= 40 and not player:hasSpell("beast") then table.insert(opts, "Beast") end	
		if lv >= 43 and not player:hasSpell("amnesia") then table.insert(opts, "Amnesia") end	
		if lv >= 48 and not player:hasSpell("recover") then table.insert(opts, "Recover") end	
		if lv >= 50 and not player:hasSpell("desperate_attack") then table.insert(opts, "Desperate attack") end
		if lv >= 53 and not player:hasSpell("summon") then table.insert(opts, "Summon") end
		if lv >= 56 and not player:hasSpell("tiger_fury") then table.insert(opts, "Tiger's fury") end	
		if lv >= 58 then	
			if player.totem == 0 and not player:hasSpell("jujak_blaze") then table.insert(opts, "Jujak blaze") end	
			if player.totem == 1 and not player:hasSpell("baekho_cataclysm") then table.insert(opts, "Baekho cataclysm") end	
			if player.totem == 2 and not player:hasSpell("hyunmoo_blaspheme") then table.insert(opts, "Hyunmoo blaspheme") end	
			if player.totem == 3 and not player:hasSpell("chungryong_slice") then table.insert(opts, "Chungryong slice") end	
		end	
		if lv >= 65 and not player:hasSpell("flich") then table.insert(opts, "Flich") end		
		if lv >= 75 then	
			if player.totem == 0 and not player:hasSpell("jujak_abomination") then table.insert(opts, "Jujak abomination") end	
			if player.totem == 1 and not player:hasSpell("baekho_in_hell") then table.insert(opts, "Baekho in hell") end	
			if player.totem == 2 and not player:hasSpell("hyun_blizzard") then table.insert(opts, "Hyun blizzard") end	
			if player.totem == 3 and not player:hasSpell("chungryong_cyclone") then table.insert(opts, "Chungryong cyclone") end	
		end	
		if lv >= 80 and not player:hasSpell("drain") then table.insert(opts, "Drain") end	
		if lv >= 85 and not player:hasSpell("slow") then table.insert(opts, "Slow") end	
		if lv >= 90 and not player:hasSpell("seal_wounds") then table.insert(opts, "Seal wounds") end	
		if lv >= 99 then	
			if not player:hasSpell("shadow_dance_old") then table.insert(opts, "Shadow dance old") end	
			if not player:hasSpell("lethal_strike") then table.insert(opts, "Lethal strike") end	
		end
	end



	
--[[ Mage ]]-------------------------------------------------------------------------------------------------------------------------
	if class == 3 then
		
		if lv >= 6 then	
			if player.totem == 0 and not player:hasSpell("jujak_fire") then table.insert(opts, "Jujak fire") end	
			if player.totem == 1 and not player:hasSpell("baekho_surge") then table.insert(opts, "Baekho surge") end	
			if player.totem == 2 and not player:hasSpell("hyunmoo_snow") then table.insert(opts, "Hyunmoo snow") end	
			if player.totem == 3 and not player:hasSpell("chungryong_ray") then table.insert(opts, "Chungryong ray") end	
		end	
		if lv >= 13 and not player:hasSpell("harden_armor") then table.insert(opts, "Harden armor") end
		if lv >= 14 then	
			if player.totem == 0 and not player:hasSpell("jujak_holyfire") then table.insert(opts, "Jujak holyfire") end	
			if player.totem == 1 and not player:hasSpell("baekho_death_realm") then table.insert(opts, "Baekho death realm") end	
			if player.totem == 2 and not player:hasSpell("hyun_deathstorm") then table.insert(opts, "Hyun deathstorm") end	
			if player.totem == 3 and not player:hasSpell("chung_tornado") then table.insert(opts, "Chung tornado") end
		end	
		if lv >= 16 and not player:hasSpell("lay_hands") then table.insert(opts, "Lay hands") end
		if lv >= 17 and not player:hasSpell("might") then table.insert(opts, "Might") end
		if lv >= 18 and not player:hasSpell("mend_wounds") then table.insert(opts, "Mend wounds") end
		if lv >= 19 and not player:hasSpell("valor") then table.insert(opts, "Valor") end
		if lv >= 20 and not player:hasSpell("approach") then table.insert(opts, "Approach") end
		if lv >= 23 and not player:hasSpell("relief") then table.insert(opts, "Relief") end
		if lv >= 24 then	
			if player.totem == 0 and not player:hasSpell("jujak_fireclaw") then table.insert(opts, "Jujak fireclaw") end	
			if player.totem == 1 and not player:hasSpell("baekho_revenge") then table.insert(opts, "Baekho revenge") end	
			if player.totem == 2 and not player:hasSpell("hyun_ice_bomb") then table.insert(opts, "Hyun ice bomb") end	
			if player.totem == 3 and not player:hasSpell("chungryong_typhoon") then table.insert(opts, "Chungryong typhoon") end
		end	
		if lv >= 25 and not player:hasSpell("purge") then table.insert(opts, "Purge") end
		if lv >= 27 and not player:hasSpell("recover") then table.insert(opts, "Recover") end
		if lv >= 30 and not player:hasSpell("summon") then table.insert(opts, "Summon") end
		if lv >= 31 then
			if not player:hasSpell("cure_paralysis") then table.insert(opts, "Cure paralysis") end
			if player.totem == 0 and not player:hasSpell("jujak_blaze") then table.insert(opts, "Jujak blaze") end	
			if player.totem == 1 and not player:hasSpell("baekho_cataclysm") then table.insert(opts, "Baekho cataclysm") end	
			if player.totem == 2 and not player:hasSpell("hyunmoo_blaspheme") then table.insert(opts, "Hyun blaspheme") end	
			if player.totem == 3 and not player:hasSpell("chungryong_slice") then table.insert(opts, "Chungryong slice") end			
		end
		
		if lv >= 32 and not player:hasSpell("sanctuary") then table.insert(opts, "Sanctuary") end
		if lv >= 34 and not player:hasSpell("invoke") then table.insert(opts, "Invoke") end
		if lv >= 35 and not player:hasSpell("heal") then table.insert(opts, "Heal") end
		if lv >= 36 then	
			if player.totem == 0 and not player:hasSpell("jujak_hellraiser") then table.insert(opts, "Jujak hellraiser") end	
			if player.totem == 1 and not player:hasSpell("baekho_bloodline") then table.insert(opts, "Baekho bloodline") end	
			if player.totem == 2 and not player:hasSpell("hyun_waterstorm") then table.insert(opts, "Hyun waterstorm") end	
			if player.totem == 3 and not player:hasSpell("death_lighting") then table.insert(opts, "Death lighting") end
		end	
		if lv >= 43 and not player:hasSpell("remove_curse") then table.insert(opts, "Remove curse") end
		if lv >= 45 then	
			if player.totem == 0 and not player:hasSpell("jujak_abomination") then table.insert(opts, "Jujak abomination") end	
			if player.totem == 1 and not player:hasSpell("baekho_in_hell") then table.insert(opts, "Baekho in hell") end
			if player.totem == 2 and not player:hasSpell("hyun_blizzard") then table.insert(opts, "Hyun blizzard") end
			if player.totem == 3 and not player:hasSpell("chungryong_cyclone") then table.insert(opts, "Chungryong cyclone") end
		end
		if lv >= 50 and not player:hasSpell("venom") then table.insert(opts, "Venom") end
		if lv >= 55 and not player:hasSpell("vex") then table.insert(opts, "Vex") end
		if lv >= 58 and not player:hasSpell("blind") then table.insert(opts, "Blind") end
		if lv >= 60 and not player:hasSpell("paralyze") then table.insert(opts, "Paralyze") end
		if lv >= 62 then	
			if player.totem == 0 and not player:hasSpell("jujak_blood_fire") then table.insert(opts, "Jujak blood fire") end	
			if player.totem == 1 and not player:hasSpell("lava_of_baekho") then table.insert(opts, "Lava of baekho") end
			if player.totem == 2 and not player:hasSpell("hyun_death_ice") then table.insert(opts, "Hyun death ice") end	
			if player.totem == 3 and not player:hasSpell("chungryong_blast") then table.insert(opts, "Chungryong blast") end
		end
		if lv >= 65 and not player:hasSpell("confuse") then table.insert(opts, "Confuse") end
		if lv >= 70 and not player:hasSpell("sleep") then table.insert(opts, "Sleep") end
		if lv >= 74 then	
			if player.totem == 0 and not player:hasSpell("jujak_firestorm") then table.insert(opts, "Jujak firestorm") end	
			if player.totem == 1 and not player:hasSpell("baekho_deathsoul") then table.insert(opts, "Baekho deathsoul") end
			if player.totem == 2 and not player:hasSpell("stormbringer") then table.insert(opts, "Stormbringer") end
			if player.totem == 3 and not player:hasSpell("calamity_of_chungryong") then table.insert(opts, "Calamity of chungryong") end
		end
		if lv >= 80 and not player:hasSpell("doze") then table.insert(opts, "Doze") end
		if lv >= 85 then	
			if player.totem == 0 and not player:hasSpell("jujak_massacre") then table.insert(opts, "Jujak massacre") end	
			if player.totem == 1 and not player:hasSpell("angel_of_death") then table.insert(opts, "Angel of death") end
			if player.totem == 2 and not player:hasSpell("ice_storm") then table.insert(opts, "Ice storm") end
			if player.totem == 3 and not player:hasSpell("call_of_thunder") then table.insert(opts, "Call of thunder") end
		end
		if lv >= 90 and not player:hasSpell("rejuvenate") then table.insert(opts, "Rejuvenate") end
		if lv >= 99 and not player:hasSpell("hell_fire") then table.insert(opts, "Hell fire") end
	end

	
	
--[[ Poet ]]-------------------------------------------------------------------------------------------------------------------------	
	
	if class == 4 then
		if lv >= 6 and not player:hasSpell("lay_hands") then table.insert(opts, "Lay hands") end
		if lv >= 12 then	
			if player.totem == 0 and not player:hasSpell("jujak_fire") then table.insert(opts, "Jujak fire") end	
			if player.totem == 1 and not player:hasSpell("baekho_surge") then table.insert(opts, "Baekho surge") end	
			if player.totem == 2 and not player:hasSpell("hyunmoo_snow") then table.insert(opts, "Hyunmoo snow") end	
			if player.totem == 3 and not player:hasSpell("chungryong_ray") then table.insert(opts, "Chungryong ray") end	
		end	
		if lv >= 14 and not player:hasSpell("invoked") then table.insert(opts, "Invoked") end
		if lv >= 15 and not player:hasSpell("recover") then table.insert(opts, "Recover") end
		if lv >= 18 and not player:hasSpell("purge") then table.insert(opts, "Purge") end
		if lv >= 22 and not player:hasSpell("harden_armor") then table.insert(opts, "Harden armor") end
		if lv >= 23 and not player:hasSpell("vital_spark") then table.insert(opts, "Vital spark") end
		if lv >= 24 and not player:hasSpell("sanctuary") then table.insert(opts, "Sanctuary") end
		if lv >= 25 and not player:hasSpell("remove_curse") then table.insert(opts, "Remove curse") end
		if lv >= 27 and not player:hasSpell("barrier") then table.insert(opts, "Barrier") end	
		if lv >= 30 then
			if not player:hasSpell("valor") then table.insert(opts, "Valor") end
			if not player:hasSpell("approach") then table.insert(opts, "Approach") end
		end	
		if lv >= 33 and not player:hasSpell("annoint") then table.insert(opts, "Annoint") end
		if lv >= 38 and not player:hasSpell("summon") then table.insert(opts, "Summon") end
		if lv >= 39 and not player:hasSpell("remove_veil") then table.insert(opts, "Remove veil") end
		if lv >= 40 and not player:hasSpell("cure_paralysis") then table.insert(opts, "Cure paralysis") end
		if lv >= 42 and not player:hasSpell("steed") then table.insert(opts, "Steed") end
		if lv >= 45 and not player:hasSpell("revitalize") then table.insert(opts, "Revitalize") end
		if lv >= 50 and not player:hasSpell("inspiration") then table.insert(opts, "Inspiration") end
		if lv >= 53 and not player:hasSpell("atone") then table.insert(opts, "Atone") end
		if lv >= 55 and not player:hasSpell("remedy") then table.insert(opts, "Remedy") end
		if lv >= 58 and not player:hasSpell("second_sight") then table.insert(opts, "Second sight") end
		if lv >= 60 and not player:hasSpell("fortify") then table.insert(opts, "Fortify") end
		if lv >= 65 and not player:hasSpell("inspire") then table.insert(opts, "Inspire") end
		if lv >= 68 and not player:hasSpell("call_of_the_wild") then table.insert(opts, "Call of the wild") end
		if lv >= 70 and not player:hasSpell("scourge") then table.insert(opts, "Scourge") end
		if lv >= 74 and not player:hasSpell("thunder_touch") then table.insert(opts, "Thunder touch") end
		if lv >= 80 and not player:hasSpell("heaven_kiss") then table.insert(opts, "Heaven's kiss") end
		if lv >= 85 and not player:hasSpell("harden_body") then table.insert(opts, "Harden body") end
		if lv >= 88 and not player:hasSpell("dispell") then table.insert(opts, "Dispell") end
		if lv >= 90 and not player:hasSpell("flare") then table.insert(opts, "Flare") end
		if lv >= 95 and not player:hasSpell("water_of_life") then table.insert(opts, "Water of life") end
		if lv >= 99 and not player:hasSpell("ressurection") then table.insert(opts, "Ressurection") end
	end
	
	menu = player:menuString("What spell do you want to learn?", opts)
	
	if menu ~= nil then
		if menu == "Silver thread" then player:addSpell("silver_thread") end
		if menu == "Gateway" then player:addSpell("gateway") end
		if menu == "Soothe" then player:addSpell("soothe") end
		if menu == "Fleshspeak" then player:addSpell("fleshspeak") end
		if menu == "Return" then player:addSpell("home") end
		if menu == "Wolf's fury" then player:addSpell("wolf_fury") end
		if menu == "Bless" then player:addSpell("bless") end
		if menu == "Backstab" then player:addSpell("backstab") end
		if menu == "Flank" then player:addSpell("flank") end
		if menu == "Tiger's fury" then player:addSpell("tiger_fury") end
		if menu == "Relief" then player:addSpell("relief") end
		if menu == "Enchant" then player:addSpell("enchant") end
		if menu == "Potence" then player:addSpell("potence") end
		if menu == "Slash" then player:addSpell("slash") end
		if menu == "Dragon's fury" then player:addSpell("dragon_fury") end
		if menu == "Infuse" then player:addSpell("infuse") end
		if menu == "Berserk" then player:addSpell("berserk") end
		if menu == "Ingress" then player:addSpell("ingress") end
		if menu == "Soul fly" then player:addSpell("soul_fly") end
		if menu == "Vigor" then player:addSpell("vigor") end
		if menu == "Whirlwind" then player:addSpell("whirlwind") end
		
		if menu == "Frisk" then player:addSpell("frisk") end
		if menu == "Feral" then player:addSpell("feral") end
		if menu == "Might" then player:addSpell("might") end
		if menu == "Judge" then player:addSpell("judge") end
		if menu == "Mend wounds" then player:addSpell("mend_wounds") end
		if menu == "Shadow figure" then player:addSpell("shadow_figure") end
		if menu == "Ignite" then player:addSpell("ignite") end
		if menu == "Rodent" then player:addSpell("rodent") end
		if menu == "Set trap" then player:addSpell("set_trap") end
		if menu == "Spy" then player:addSpell("spy") end
		if menu == "Gangrel" then player:addSpell("gangrel") end
		if menu == "Invisible" then player:addSpell("invisible") end
		if menu == "Approach" then player:addSpell("approach") end
		if menu == "Ambush" then player:addSpell("ambush") end
		if menu == "Beast" then player:addSpell("beast	") end
		if menu == "Amnesia" then player:addSpell("amnesia") end
		if menu == "Recover" then player:addSpell("recover") end
		if menu == "Desperate attack" then player:addSpell("desperate_attack") end
		if menu == "Summon" then player:addSpell("summon") end
		if menu == "Flich" then player:addSpell("flich") end
		if menu == "Drain" then player:addSpell("drain	") end
		if menu == "Slow" then player:addSpell("slow") end
		if menu == "Seal wounds" then player:addSpell("seal_wounds") end
		if menu == "Shadow dance old" then player:addSpell("shadow_dance_old") end
		if menu == "Lethal strike" then player:addSpell("lethal_strike") end
		
		if menu == "Jujak fire" then player:addSpell("jujak_fire") end
		if menu == "Baekho surge" then player:addSpell("baekho_surge") end
		if menu == "Hyunmoo snow" then player:addSpell("hyunmoo_snow") end
		if menu == "Chungryong ray" then player:addSpell("chungryong_ray") end
		if menu == "Jujak blaze" then player:addSpell("jujak_blaze") end
		if menu == "Hyun blaspheme" then player:addSpell("hyun_blaspheme") end
		if menu == "Baekho cataclysm" then player:addSpell("baekho_cataclysm") end
		if menu == "Chungryong slice" then player:addSpell("chungryong_slice") end
		if menu == "Jujak abomination" then player:addSpell("jujak_abomination") end
		if menu == "Hyun blizzard" then player:addSpell("hyun_blizzard") end
		if menu == "Baekho in hell" then player:addSpell("baekho_in_hell") end
		if menu == "Chungryong cyclone" then player:addSpell("chungryong_cyclone") end
		if menu == "Jujak firestorm" then player:addSpell("jujak_firestorm") end
		if menu == "Stormbringer" then player:addSpell("stormbringer") end
		if menu == "Baekho deathsoul" then player:addSpell("baekho_deathsoul") end
		if menu == "Calamity of chungryong" then player:addSpell("calamity_of_chungryong") end
		if menu == "Jujak holyfire" then player:addSpell("jujak_holyfire") end
		if menu == "Hyun deathstorm	" then player:addSpell("hyun_deathstorm") end
		if menu == "Baekho death realm" then player:addSpell("baekho_death_realm") end
		if menu == "Chung tornado" then player:addSpell("chung_tornado") end
		if menu == "Jujak fireclaw" then player:addSpell("jujak_fireclaw") end
		if menu == "Hyun ice bomb" then player:addSpell("hyun_ice_bomb") end
		if menu == "Baekho revenge" then player:addSpell("baekho_revenge") end
		if menu == "Chungryong typhoon" then player:addSpell("chungryong_typhoon") end
		if menu == "Jujak hellraiser" then player:addSpell("jujak_hellraiser") end
		if menu == "Hyun waterstorm" then player:addSpell("hyun_waterstorm") end
		if menu == "Baekho bloodline" then player:addSpell("baekho_bloodline") end
		if menu == "Death lighting" then player:addSpell("death_lighting") end
		if menu == "Jujak blood fire" then player:addSpell("jujak_blood_fire") end
		if menu == "Hyun death ice" then player:addSpell("hyun_death_ice") end
		if menu == "Lava of baekho" then player:addSpell("lava_of_baekho") end
		if menu == "Chungryong blast" then player:addSpell("chungryong_blast") end
		if menu == "Jujak massacre" then player:addSpell("jujak_massacre") end
		if menu == "Ice storm" then player:addSpell("ice_storm") end
		if menu == "Angel of death" then player:addSpell("angel_of_death") end
		if menu == "Call of thunder" then player:addSpell("call_of_thunder") end
		
		if menu == "Harden armor" then player:addSpell("harden_armor") end
		if menu == "Sanctuary" then player:addSpell("sanctuary") end
		if menu == "Valor" then player:addSpell("valor") end
		if menu == "Lay hands" then player:addSpell("lay_hands") end
		if menu == "Purge" then player:addSpell("purge") end
		if menu == "Cure paralysis" then player:addSpell("cure_paralysis") end
		if menu == "Invoke" then player:addSpell("invoke") end
		if menu == "Heal" then player:addSpell("heal") end
		if menu == "Remove curse" then player:addSpell("remove_curse") end
		if menu == "Venom" then player:addSpell("venom") end
		if menu == "Vex" then player:addSpell("vex") end
		if menu == "Blind" then player:addSpell("blind") end
		if menu == "Paralyze" then player:addSpell("paralyze") end
		if menu == "Confuse" then player:addSpell("confuse") end
		if menu == "Sleep" then player:addSpell("sleep") end
		if menu == "Doze" then player:addSpell("doze") end
		if menu == "Rejuvenate" then player:addSpell("rejuvenate") end
		if menu == "Hell fire" then player:addSpell("hell_fire") end
		if menu == "Invoked" then player:addSpell("invoked") end
		if menu == "Vital spark" then player:addSpell("vital_spark") end
		if menu == "Barrier" then player:addSpell("barrier") end
		if menu == "Annoint" then player:addSpell("annoint") end
		if menu == "Remove veil" then player:addSpell("remove_veil") end
		if menu == "Steed" then player:addSpell("steed") end
		if menu == "Revitalize" then player:addSpell("revitalize") end
		if menu == "Inspiration" then player:addSpell("inspiration") end
		if menu == "Atone" then player:addSpell("atone") end
		if menu == "Remedy" then player:addSpell("remedy") end
		if menu == "Second sight" then player:addSpell("second_sight") end
		if menu == "Fortify" then player:addSpell("fortify") end
		if menu == "Inspire" then player:addSpell("inspire") end
		if menu == "Call of the wild" then player:addSpell("call_of_the_wild") end
		if menu == "Scourge" then player:addSpell("scourge") end
		if menu == "Thunder touch" then player:addSpell("thunder_touch") end
		if menu == "Heaven's kiss" then player:addSpell("heaven_kiss") end
		if menu == "Harden body" then player:addSpell("harden_body") end
		if menu == "Dispell" then player:addSpell("dispell") end
		if menu == "Flare" then player:addSpell("flare") end
		if menu == "Water of life" then player:addSpell("water_of_life") end
		if menu == "Ressurection" then player:addSpell("ressurection") end
		
		player:sendMinitext("New spell learned!")
		player:learnSpell2(player.baseClass)
	end
end


function Player.browseGfxColor(block, type, command)
	
	local b = block
	local command = ""
	
	if type == "weap" then
		if command == "n" then b.gfxWeapC = b.gfxWeapC + 1 end
		if command == "p" then b.gfxWeapC = b.gfxWeapC - 1 end
	elseif type == "armor" then
		if command == "n" then b.gfxArmorC = b.gfxArmorC + 1 end
		if command == "p" then b.gfxArmorC = b.gfxArmorC - 1 end
	elseif type == "shield" then
		if command == "n" then b.gfxShieldC = b.gfxShieldC + 1 end
		if command == "p" then b.gfxShieldC = b.gfxShieldC - 1 end
	elseif type == "helm" then
		if command == "n" then b.gfxHelmC = b.gfxHelmC + 1 end
		if command == "p" then b.gfxHelmC = b.gfxHelmC - 1 end
	elseif type == "face" then
		if command == "n" then b.gfxFaceC = b.gfxFaceC + 1 end
		if command == "p" then b.gfxFaceC = b.gfxFaceC - 1 end
	elseif type == "hair" then
		if command == "n" then b.gfxHairC = b.gfxHairC + 1 end
		if command == "p" then b.gfxHairC = b.gfxHairC - 1 end
	elseif type == "neck" then
		if command == "n" then b.gfxNeckC = b.gfxNeckC + 1 end
		if command == "p" then b.gfxNeckC = b.gfxNeckC - 1 end
	elseif type == "cape" then
		if command == "n" then b.gfxCapeC = b.gfxCapeC + 1 end
		if command == "p" then b.gfxCapeC = b.gfxCapeC - 1 end	
	elseif type == "boots" then
		if command == "n" then b.gfxBootsC = b.gfxBootsC + 1 end
		if command == "p" then b.gfxBootsC = b.gfxBootsC - 1 end	
	elseif type == "facea" then
		if command == "n" then b.gfxFaceAC = b.gfxFaceAC + 1 end
		if command == "p" then b.gfxFaceAC = b.gfxFaceAC - 1 end	
	elseif type == "faceat" then
		if command == "n" then b.gfxFaceATC = b.gfxFaceATC + 1 end
		if command == "p" then b.gfxFaceATC = b.gfxFaceATC - 1 end	
	elseif type == "skin" then
		if command == "n" then b.gfxSkin = b.gfxSkin + 1 end
		if command == "p" then b.gfxSkin = b.gfxSkin - 1 end	
	end
	
	block:updateState()
	return b
end
miniText = function(player, text) player:sendMinitext(text) end
anim = function(player) player:sendAnimation(246) end
finishedQuest = function(player, npc) player:sendAnimation(133) player:playSound(67) end
notEnoughMP = function(block) anim(block) block:sendMinitext("Not Enough MP!")	end
notEnoughHP = function(block) anim(block) block:sendMinitext("Not Enough HP!") end		
darkShadow = function(block) block:sendAnimation(149) block:playSound(31) block:sendMinitext("Dark shadow took your souls!") end
bold = function(text) return "<b>"..text end
addHealth = function(player, amount) player:addHealthExtend(amount, 0,0,0,0,0) end

swap = function(player, target)

	player.registry["swap_x"] = player.x
	player.registry["swap_y"] = player.y
	player:warp(target.m, target.x, target.y)
	target:warp(player.m, player.registry["swap_x"], player.registry["swap_y"])
end

mallDialog = function(player, item)

	d = "What "..item.." would you like to wear today?\n\n"
	d = d.."Event points : "..format_number(player.registry["event_point"]).."\n"
	d = d.."Play points  : "..format_number(player.registry["play_point"]).."\n"
	d = d.."Fame points  : "..format_number(player.registry["fame_point"]).."\n"		

	return d
end















