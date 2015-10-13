give = {

click = function(player, npc)
	
	local pc = Player(player.registry["on_page"])
	gfxClone(pc, npc)
	
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 2
	
	local opts = {}
	local choice = {"Ok", "Cancel"}
	local txt, menu, amount, give, ok, pp, ep
	local point = "PP : "..format_number(pc.registry["play_point"]).."\nEP : "..format_number(pc.registry["event_point"]).."\n\nHow much of PP you want to give to "..pc.name.."?"
	local error = "Please enter amount in number / User not found!"

	txt =      "Gold         : "..format_number(pc.money).."\n"
	txt = txt.."Gold in bank : "..format_number(pc.bankMoney).."\n"
	txt = txt.."Location:\n"..pc.mapTitle.."("..pc.m..")\n"
	txt = txt.."X:"..pc.x.." , Y:"..pc.y..""
	
	table.insert(opts, "Item")
	table.insert(opts, "Spell")
	table.insert(opts, "Gold")
	table.insert(opts, "Karma")
	table.insert(opts, "Experience")
	table.insert(opts, "Play Points")
	table.insert(opts, "Event Points")
	table.insert(opts, "<< Back")

	menu = player:menuString("<b>[Give]\n"..txt.."", opts)
	
	if menu == "Gold" then
            amount = player:input("How much:\n\nCurrent gold : "..format_number(pc.gold).."")
            if tonumber(amount) > 0 and pc ~= nil then
				give =       "Gold in bank: "..format_number(pc.bankMoney).." \n"
				give = give.."Current gold: "..format_number(pc.gold).."\n"
				give = give.."Give        : "..format_number(tonumber(amount)).."\n"
				give = give.."----------------------------------------------------- +\n"
				give = give.."            = "..format_number(pc.gold+tonumber(amount))
			
				ok = player:menuString(give.."", choice)
				if ok == "Ok" then
					pc:addGold(tonumber(amount))
					player:sendMinitext(format_number(tonumber(amount)).." coins gived to "..pc.name)
					give.click(player, npc)
				else
					give.click(player, npc)
				end
            else
                player:popUp(error)
            end
	elseif menu == "Karma" then
		player:popUp("Not implemented!")
	
	elseif menu == "Item" then
		give_item.click(player, npc)
		
	elseif menu == "Spell" then
		gm_npc_spells.click(player, npc)
		
	elseif menu == "Play Points" then
		amount = player:input(point)
		pp = tonumber(amount)
		if pp > 0 and pc ~= nil then
			give = pc.name.."'s PP : "..format_number(pc.registry["play_point"]).."\n"
			give = give.."Give     : "..format_number(pp).."\n"
			give = give.."---------------------- +\n"
			give = give.."         = "..format_number(pc.registry["play_point"] + pp)		
		
			ok = player:menuString(give.."", choice)
			if ok == "Ok" then
				pc.registry["play_point"] = pc.registry["play_point"] + pp
				player:sendMinitext(format_number(pp).." pp gived to "..pc.name)
				give.click(player, npc)
			else
				give.click(player, npc)
			end
		else
			 player:popUp(error)
		end
	elseif menu == "Event Points" then
		amount = player:input(point)
		ep = tonumber(amount)
		if ep > 0 and pc ~= nil then
			give = pc.name.."'s EP : "..format_number(pc.registry["event_point"]).."\n"
			give = give.."Give     : "..format_number(ep).."\n"
			give = give.."---------------------- +\n"
			give = give.."         = "..format_number(pc.registry["event_point"] + ep)		
		
			ok = player:menuString(give.."", choice)
			if ok == "Ok" then
				pc.registry["event_point"] = pc.registry["event_point"] + ep
				player:sendMinitext(format_number(ep).." ep gived to "..pc.name)
				give.click(player, npc)
			else
				give.click(player, npc)
			end
		else
			 player:popUp(error)
		end
	elseif menu == "<< Back" then
		user_pages.click(player, npc)
	end
end
}
	
	
give_item = {

click = function(player, npc)
	
	local pc = Player(player.registry["on_page"])
	gfxClone(pc, npc)
	
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 2
	
	local item = player:input("What item? (yname only!)\n\nEx: return_scroll")
	if Item(item) == nil then
		player:dialogSeq({"Item not found in database!"}, 1)
		give_item.click(player, npc)
	else
		if Item(item).maxAmount > 1 then
			amount = player:input("How many "..Item(item).name.."?")
			if tonumber(amount) > 0 then
				if tonumber(amount) > Item(item).maxAmount then
					player:dialogSeq({"You cannot do that!\n\nMax: "..Item(item).maxAmount.."!!"})
					return
				else
					if not pc:hasSpace(Item(item).id, tonumber(amount)) == true then
						player:dialogSeq({""..pc.name.."'s inventory is full!"})
					else
						pc:addItem(Item(item).id, tonumber(amount))
						player:sendMinitext("Done!!")
						give.click(player, npc)
					end
				end
			else
				player:dialogSeq({"Please enter amount in number!"}, 1)
				give.click(player, npc)
			end
		end
	end
end
}
		
	
	
gm_npc_spells = {

click = function(player, npc)

	local pc = Player(player.registry["on_page"])
	local t = {graphic = player.npcGraphic, color = player.npcColor}
	player.dialogType = 2
	
	local spell = player:input("What spell? (yname only!)\n\nEx: lethal_strike")
	
	if pc:hasSpell(spell) then
		player:dialogSeq({t, ""..pc.name.." already has that spell/spell not found in database"}, 1)
		gm_npc_spells.click(player, npc)
	else
		pc:addSpell(spell)
		player:sendMinitext("Done!!")
		gm_npc_spells.click(player, npc)
	end
end
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
