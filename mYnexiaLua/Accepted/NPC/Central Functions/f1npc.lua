f1npc = {
click = async(function(player, npc)


	local t = {graphic = convertGraphic(783, "monster"), color = 0}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local opts = {}
	local weap = player:getEquippedItem(EQ_WEAP)
	
	if player.level <= 5 then
		if player.state == 1 then
			table.insert(opts, "Silver thread")
		end
	end
	if player.registry["can_browse_gfx"] == 1 then table.insert(opts, "Browse gfx") end
	if player.gmLevel > 0 then table.insert(opts, "God Tools") else table.insert(opts, "Buya") end
	if player.ID == 2 or player.ID == 18  then table.insert(opts, "Private Tools") end
	if player.registry["team_iseng2"] > 0 or player.ID == 2 or player.ID == 18 then table.insert(opts, "Team Iseng") end
	
	table.insert(opts, "Character Status")
	table.insert(opts, "Character Titles")
	table.insert(opts, "Ability Info")
	table.insert(opts, "Away Mode")
	table.insert(opts, "Delete Item")
	table.insert(opts, "Exit")
	
	if player.gmLevel > 0 then
		menu = player:menuString("<b>[Character Menu]\n\n"..os.date().."\n("..get_totem_time(player).." Time)\n"..player.mapTitle.." ("..player.m..", X: "..player.x.." , Y: "..player.y..")", opts)
	else
		menu = player:menuString("<b>[Character Menu]\n\n"..os.date().."\n("..get_totem_time(player).." Time)\n"..player.mapTitle.."(X: "..player.x.." , Y: "..player.y..")", opts)
	end
	
	if menu == "God Tools" then
		god_tools.f1click(player, npc)
	
	elseif menu == "Browse gfx" then
		browse_gfx.click(player, npc)
 	
	elseif menu == "Ability Info" then
		ability.click(player, npc)
		
	elseif menu == "Mob Tools" then
		add_mon.click(player, npc)
	
	elseif menu == "Silver thread" then
		if player.state == 1 then
			dukun = {graphic = convertGraphic(9, "monster"), color = 0}
			player:warp(1013, 5,4)
			player:dialogSeq({dukun, "<b>[Prophet]\n\nThis option is only available if your level are below Lv.5!"},1)
		end
	
	elseif menu == "Change Pet's name" then
			input = player:input("Current Name: "..player.f1Name.."\n\nChange your pet's name to:")
		local name = tostring(input)
		if name ~= nil then
			if string.len(name) > 12 then
				player:popUp("Name too long! Max:12")
				return
			else
				player.f1Name = name
				player:popUp("Done!")
			end
		end
		
	elseif menu == "Warps write" then
		add_warp.click(player, npc)
	
	elseif menu == "Team Iseng" then
		iseng.click(player, npc)
       
	elseif menu == "Buya" then
		buya = player:menuString("This option will return you to Buya city (Tester period only)", {"Yes", "No"})
		if buya == "Yes" then
			player:warp(1001, 3, 5)
			player:sendAnimation(16)
			player:playSound(29)
		end
    elseif menu == "Test Script" then
        npc_test_vending.click(player, npc)
		
	elseif menu == "Private Tools" then
		private_tools.click(player, npc)
	

	elseif menu == "Character Status" then
		local popup = "<b>[Character Status]:"
		local vitastr = tostring(player.vRegenAmount)
		local manastr = tostring(player.mRegenAmount)
		local vitafind = string.find(vitastr, "%p")
		local manafind = string.find(manastr, "%p")
		local expSold = player.expSold
		local quantifier
		local pkstr = ""
		local pkdurastr = ""
		
		if (vitafind ~= nil) then vitafind = vitafind + 1 end
		if (manafind ~= nil) then manafind = manafind + 1 end
		vitastr = string.sub(vitastr, 0, vitafind)
		manastr = string.sub(manastr, 0, manafind)
		if (player.PK == 0) then
			pkstr = "Normal"
		elseif (player.PK == 1) then
			pkstr = "PK"
			if (player.durationPK / 1000 > 120) then pkdurastr = "\nPK Duration: "..tostring((player.durationPK / 1000) / 60) else pkdurastr = "\nPK Duration: "..tostring(player.durationPK / 1000) end
		else
			pkstr = "Bounty"
			if (player.durationPK / 1000 > 120) then pkdurastr = "\nPK Duration: "..tostring((player.durationPK / 1000) / 60)
				else pkdurastr = "\nPK Duration: "..tostring(player.durationPK / 1000)
			end
		end

		if (expSold < 1000000) then quantifier = "K" expSold = expSold / 1000
			elseif (expSold < 1000000000) then quantifier = "M" expSold = expSold / 1000000 else quantifier = "B" expSold = expSold / 1000000000
		end
		expSold = string.format("%.2f", expSold)
		popup = popup.."\n\n\n"..player.name.."\nLevel: "..player.level.."\nClass: "..player.className.."\nWeapon Damage: "..player.minDam.." - "..player.maxDam.."\n"
		popup = popup.."\BaseHealth / baseMagic : "..format_number(player.baseHealth).. " / "..format_number(player.baseMagic).."\n"
		popup = popup.."\nMight/Grace/Will: "..player.might.."/"..player.grace.."/"..player.will.."\nHit/Miss/Dam: "..player.hit.."/"..(player.miss / 100).."/"..player.dam.."\nArmor/AC: "..math.floor(player.armor + .5).."/"..math.floor(player.ac + .5).."\n"
		popup = popup.."\nProtection: "..player.protection.."\nWisdom: "..player.wisdom.."\nCon: "..player.con.."\nVita/Mana per 5s: "..vitastr.."/"..manastr.."\n\nPK Status: "..pkstr..pkdurastr.."\n\n"
		popup = popup.."\Play Points   : "..format_number(player.registry["play_point"]).. "\nEvent Points  : "..format_number(player.registry["event_point"]).."\nFame Points   : "..format_number(player.registry["fame_points"]).."\nBattle Points : "..player.registry["battle_points"]..""
		--popup = popup.."\n\nExp Sold: "..expSold.." "..quantifier
		player:popUp(popup)
		
	elseif menu == "Character Titles" then
		character_title.click(player, npc)
			
	
	elseif menu == "Away Mode" then
		local afkMessage = player:input("I'm Away Right Now! Please call me later!\n<<Type afk to use current>>\nor Enter New AFK Message:")
		player.afkMessage = afkMessage	
	elseif menu == "Delete Item" then
		local item = player:getInventoryItem(0)
		player:dialogSeq({t, "<b>[ATTENTION]:\n\nThis Option is to delete item on (a)slot in your inventory."},1)
		if item ~= nil then
			if item.amount > 1 then
				amount = player:input("<b>[Delete]\n\nHow many do you want to delete?")
				if tonumber(amount) > 0 then
					if tonumber(amount) > item.amount then
						player:dialogSeq({t, "<b>[Delete]\n\nYou don't have that amount!"},1)
						return
					else
						ok = player:menuString("<b>[Delete]\n\nAre you sure to delete "..tonumber(amount).." of your "..item.name.."?",{"Yes", "No"})
						if ok == "Yes" then
							player:msg(12, "[DELETE]: "..tonumber(amount).." "..item.name.. " removed from your inventory!", player.ID)
							player:removeItem(item.id, tonumber(amount))
						end
					end
				else
					player:dialogSeq({t, "<b>[Delete]\n\nNumber only!"})
				end
			else
				ok = player:menuString("<b>[Delete]\n\nAre you sure to delete your "..item.name.."?",{"Yes", "No"})
				if ok == "Yes" then
					player:msg(12, "[DELETE]: "..item.name.. " removed from your inventory!", player.ID)
					player:removeItem(item.id, 1)
				end
			end
		else
			player:dialogSeq({t, "<b>[Delete]\n\nPlease put the item you want to delete on slot(a) on your inventory"},1)
		end
	end
end)
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
