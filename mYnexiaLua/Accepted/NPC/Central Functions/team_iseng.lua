iseng = {

click = function(player, npc)
	
	gfxClone(player, npc)
	local g = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = g.graphic
	player.npcColor = g.color
	player.dialogType = 2
	
	local menuOption
	local opts = {}
	
	table.insert(opts, "Invite")
	table.insert(opts, "Kick")
	
	if player.gmLevel > 0 then
		if player.gfxClone == 1 then
			table.insert(opts, "Turn off Gfx Toogle")
		else
			table.insert(opts, "Turn on Gfx Toogle")
		end
		
		if player.ID == 2 or player.ID == 18 then
			table.insert(opts, "Gfx Name")
			table.insert(opts, "Items")
		end
	end
	table.insert(opts, "Spells")
	table.insert(opts, "Bank")
	table.insert(opts, "Meeting Room")
	table.insert(opts, "Change Class")
	table.insert(opts, "Show Developments Board")		

	--end
	if(#opts~=0) then
		menuOption=player:menuString("<b>[Team Iseng]\n"..os.date().."\n\n"..player.mapTitle.."\nID:("..player.m..")\nX: "..player.x.."    Y: "..player.y, opts)
		if (menuOption == "Meeting Room") then
			local a = {"Meeting Room 1", "Meeting Room 2", "Meeting Room 3"}
			b = player:menuString("Which one?", a)
			if b =="Meeting Room 1" then
				player:popUp("Meeting room locked")
			elseif b =="Meeting Room 2" then
				player:popUp("Meeting room locked")
			elseif b == "Meeting Room 3" then
				player:popUp("Meeting room locked")
			end
		
		elseif menuOption == "Items" then
			if player.ID == 2 or player.ID == 18 then
				gm_npc_items.click(player, npc)
			end
		
		elseif menuOption == "Change Class" then
			job = player:menuString("What class do you wish to change?", {"Warrior", "Rogue", "Mage", "Poet"})
			if job ~= nil then
				if job == "Warrior" then
					player.class = 1
				elseif job == "Rogue" then
					player.class = 2
				elseif job == "Mage" then
					player.class = 3
				elseif job == "Poet" then
					player.class = 4
				end
				player:sendStatus()
				player:status()
				player:updateState()
				player:calcStat()
				player:sendMinitext("Done!!")
			end
		elseif menuOption == "Spells" then
			gm_npc_spells.click(player, npc)
			
		elseif menuOption == "Bank" then
			bank = player:menuString("Whatsup?",{"Deposit Item", "Deposit Money", "Withdraw Item", "Withdraw Money"})
			if bank == "Deposit Item" then
				player:showBankAdd()
			elseif bank == "Deposit Money" then
				player:bankAddMoney()
			elseif bank == "Withdraw Item" then
				player:showBank()
			elseif bank == "Withdraw Money" then
				player:bankWithdrawMoney()
			end
		
		elseif menuOption == "Gfx Name" then
			change = player:input("Change Gfx Name to:")
			gfxClone(player, player)
			player.gfxName = change
			player.gfxClone = 1
			player:refresh()
		
		elseif menuOption == "Kick" then
			local member = {}
			local id = {}
			user = player:getUsers()
			if #user > 0 then
				for i = 1, #user do
					if user[i].registry["team_iseng2"] > 0 and user[i].registry["invite_by"] > 0 then
						table.insert(member, user[i].name.." (by : "..Player(user[i].registry["invite_by"]).name..")")
						table.insert(id, user[i].ID)
					end
				end
			end
	
			menu = player:menuString("<b>[Team iseng]\n\nWho should kicked out from team?", member)
			
			if #id > 0 then
				for i = 1, #id do
					if menu == member[i] then
						kick = player:menuString("<b>[Team iseng]\n\nAre you sure to kick "..Player(id[i]).name.." from Team iseng?", {"Yes", "No"})
						if kick == "Yes" then
							if Player(id[i]).gmLevel > 0 and player.gmLevel == 0 then
								player:popUp("You cannot kick a GM!")
								anim(Player(id[i]))
								Player(id[i]):msg(4, "[Team iseng] "..player.name.." try to kick you out from Team iseng", Player(id[i]).ID)
								return
							end
							Player(id[i]):sendAnimation(246)
							Player(id[i]).registry["invite_by"] = 0
							Player(id[i]).registry["team_iseng2"] = 0
							player:popUp("Kicked!")
							Player(id[i]):msg(4, "[Team iseng] You're kicked out from Team iseng by "..player.name.."", Player(id[i]).ID)
							user = player:getUsers()
							if user[i].registry["team_iseng2"] > 0 or user[i].ID == 2 then
								user[i]:msg(4, "[Team iseng] "..Player(id[i]).name.." was kicked out by "..player.name.."", user[i].ID)
							end
						end
					end
				end
			end
			
			
		elseif menuOption == "Invite" then
			target = player:input("Enter target's name : ")
			if Player(target) ~= nil then
				if Player(target).ID == player.ID then
					player:popUp("You cannot invite your self!")
				return else
					if Player(target).registry["team_iseng2"] >0 then
						player:popUp(Player(target).name.." is already on team!")
					return else
						Player(target).registry["invite_by"] = player.ID
						Player(target):freeAsync()
						iseng.invitation(Player(target), npc)
						player:popUp("Invitation sended!")
					end
				end
			end
		elseif (menuOption == "Show Meetings Board") then
			player:showBoard(300)
		elseif (menuOption == "Show Developments Board") then
			player:showBoard(301)
		elseif (menuOption == "Get Spells") then
			player:popUp("Disabled!")
			--player:learnSpell()
		elseif menuOption == "Forget Spells" then
			forget = player:forgetSpell()
		elseif menuOption == "Turn off Gfx Toogle" or menuOption == "Turn on Gfx Toogle" then
			gfx_switch.cast(player)
		end
	else
	-- alert hacker
	end
end,

invitation = async(function(player, npc)
	
	local t = {graphic = convertGraphic(776, "monster"), color = 0}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local pc = Player(player.registry["invite_by"])
	
	local answer = player:menuString2("You're invite by "..Player(player.registry["invite_by"]).name.." to team iseng", {"Accept", "Decline"})
	
	if answer == "Decline" then
		pc:msg(4, "[TEAM ISENG] "..player.name.." has decline your invitation!", pc.ID)
		return
	elseif answer == "Accept" then
		user = player:getUsers()
		if #user > 0 then
			for i = 1, #user do
				if user[i].registry["team_iseng2"] > 0 or user[i].ID == 2 then
					user[i]:msg(0, "[Team iseng] "..player.name.." has joined to Team iseng and invited by "..pc.name.."", user[i].ID)
				end
			end
		end
		player:sendAnimation(221)
		player.registry["team_iseng2"] = 1
	end
end),
}