god_tools = {
f1click = function(player, npc)

	gfxClone(player, npc)
	player:refresh()
	
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 2

	local a = {}
	
	table.insert(a, "Target's info")
	table.insert(a, "No move / cure")
	table.insert(a, "Kill")
	table.insert(a, "Spawn")
	table.insert(a, "Icon Thrower")
	if player.ID == 2 or player.ID == 18 or player.ID == 24 then table.insert(a, "Spawn tool") end

	menu=player:menuString("<b>["..player.name.."]:\n\n"..os.date().."\nLocation: "..player.mapTitle.."\n(ID: "..player.m.." , X: "..player.x.." , Y: "..player.y..")", a)
	
	if menu == "Approach" then
		target = player:input("Enter Target Name: ")
		if Player(target) ~= nil then
			player:warp(Player(target).m, Player(target).x, Player(target).y)
		else
			player:popUp("User not found")
		end
	elseif menu == "Test Script" then
		test_script.click(player, npc)
	
	elseif menu == "Walk Through (Status: OFF)" and player.registry["walk_through"] > 0 then
		player.optFlags = 128
		player.registry["walk_through"] = 0
		player:sendMinitext("Walk Through: ON")
		player:calcStat()
	
	elseif menu == "No move / cure" then
		move = player:menuString("What to do?", {"Nomove/cure All mobs in map", "Nomove/cure All players in map", "Nomove/cure Target (player)"})
		if move == "Nomove/cure All mobs in map" then
			mob = player:getObjectsInMap(player.m, BL_MOB)
			if #mob > 0 then
				for i = 1, #mob do
					if mob[i].paralyzed == false then
						mob[i]:sendAnimation(1)
						mob[i].paralyzed = true
					else
						mob[i]:sendAnimation(10)
						mob[i].paralyzed = false
					end
				end
			end
			player:sendMinitext("Done!")
		elseif move == "Nomove/cure All players in map" then
			pc = player:getObjectsInMap(player.m, BL_PC)
			if #pc > 0 then
				for i = 1, #pc do
					if pc[i].paralyzed == false then
						pc[i]:sendAnimation(1)
						pc[i].paralyzed = true			
					else
						pc[i]:sendAnimation(10)
						pc[i].paralyzed = false
					end
				end
			end
			player:sendAnimation("Done!")
		elseif move == "Nomove/cure Target (player)" then
			pc = player:input("Enter target's name :")
			if Player(pc) ~= nil then
				if Player(pc).paralyzed == false then
					if Player(pc).ID ~= player.ID then
						Player(pc):sendAnimation(1)
						Player(pc).paralyzed = true
					end
				else
					Player(pc):sendAnimation(10)
					Player(pc).paralyzed = false
				end
				player:sendMinitext("Done!")
			else
				anim(player)
				player:sendMinitext("User not found!")
			end
		end
		
	elseif menu == "Spawn tool" then
		addPermanentSpawn.click(player, npc)
	
	elseif menu == "Target's info" then
		user_pages.click(player, npc)
	
	elseif menu == "Icon Thrower" then
		icon = player.registry["throw_icon"]
		if icon >= 0 then
			a = {graphic = convertGraphic(icon, "item"), color = 0}
			player.npcGraphic = a.graphic
			player.npcColor = a.color
			player.dialogType = 0
			
			opts = {}
			if player.registry["throw_icon"] > 0 then
				table.insert(opts, "Disable")
			elseif player.registry["throw_icon"] == 0 then
				table.insert(opts, "Enable")
			end
				table.insert(opts, "Exit")
			
			menu = player:menuString("<b>[Icon Thrower]:\n\nIcon: "..player.registry["throw_icon"], opts)
			
			if menu == "Change" or menu == "Set Icon" or menu == "Enable" then
				input = player:input("Icon Number:\n0 for disable")
				if tonumber(input) > 0 then
					player.registry["throw_icon"] = tonumber(input)
					a = {graphic = convertGraphic(tonumber(input), "item"), color = 0}
					player:dialogSeq({a, "Icon : "..tonumber(input)},1)	
					player:sendMinitext("Throw Icon : "..tonumber(input))
				elseif tonumber(input) == 0 then
					player.registry["throw_icon"] = 0
					player:popUp("Throw icon disabled.")
				end
			elseif menu == "Disable" then
				player.registry["throw_icon"] = 0
				player:popUp("Throw icon disabled")
			end
		else
			input = player:input("Icon Number:\n0 for disable")
			if tonumber(input) > 0 then
				player.registry["throw_icon"] = tonumber(input)
				a = {graphic = convertGraphic(tonumber(input), "item"), color = 0}
				player:dialogSeq({a, "Icon : "..tonumber(input)},1)	
				player:sendMinitext("Throw Icon : "..tonumber(input))
			elseif tonumber(input) == 0 then
				player.registry["throw_icon"] = 0
				player:popUp("Throw icon disabled.")
			end
		end
	elseif menu == "Alter Stats" then
		--	npc_alter_stats_input.click(player, npc)
			npc_alter_stats_menu.f1click(player, npc)
	
	elseif menu == "Take" then
		target = player:input("Enter Target name: ")
		if Player(target) ~= nil then
			menu = player:menuString("Take What?", {"Spell", "Item"})
			if menu == "Spell" then
				spel = player:input("What Spell?")
				if string.lower(spel) ~= nil then
					if Player(target):hasSpell(string.lower(spel)) then
						ok = player:menuString("Delete "..string.lower(spel).." from "..Player(target).name.."?", {"Yes", "No"})
						if ok == "Yes" then
							Player(target):removeSpell(string.lower(spel))
							Player(target):sendMinitext(string.lower(spel).." has removed!")
							player:sendMinitext("Removed!")
						end
					else
						player:popUp("Target do not have that spell")
					end
				end
			elseif menu == "Item" then
			
			end
		else
			player:popUp("User not found!")
		end
				
				
	
	elseif menu == "Spawn" then
		spawn = player:input("Spawn(mobID) : ")
		if tonumber(spawn) > 0 then
			if Mob(tonumber(spawn)) ~= nil then
				amount = player:input("How many "..Mob(tonumber(spawn)).name.." ?")
				if tonumber(amount) > 0 and tonumber(amount) <= 20 then
					player:spawn(tonumber(spawn), player.x, player.y, tonumber(amount))
				else
					player:popUp("Max: 20")
				end
			else
				player:popUp("Mob ID not found!")
			end
		else
			player:popUp("Numberic only")
		end
		
	elseif menu == "Player's Info" then
		player_info.click(player, npc)
		
	elseif menu == "Heal" then
		heal = player:menuString("How do you Healing?", {"All players on Map", "Target"})
		if heal == "All players on Map" then
			pc = player:getObjectsInMap(player.m, BL_PC)
			if #pc >= 0 then
				for i = 1, #pc do
					pc[i]:sendAnimation(427)
					pc[i]:playSound(112)
					pc[i]:addHealth(pc[i].maxHealth)
					pc[i]:sendMinitext("Heal by God")
				end
			end
		elseif heal == "Target" then
			target = player:input("Enter Target Name:")
			if Player(target) ~= nil then
				Player(target):sendAnimation(427)
				Player(target):playSound(112)
				Player(target):addHealth(Player(target).maxHealth)
				Player(target):sendMinitext("Heal by God")
			else
				player:popUp("User not found")
			end
		end
	elseif menu == "Summon" then
		sum = player:menuString("What do you want to summon?", {"Player", "Npc"})
		if sum == "Player" then
			target = player:input("Enter Target Name: ")
			if Player(target) ~= nil then
				Player(target):warp(player.m, player.x, player.y)
				Player(target):sendAnimation(16)
				Player(target):sendMinitext("You've summoned by "..player.name)
			else
				player:popUp("User not found")
			end
		elseif sum == "Npc" then
			npc = player:input("Enter Npc ID: ")
			if tonumber(npc) > 0 then
				if Npc(tonumber(npc)) ~= nil then
					Npc(tonumber(npc)):warp(player.m, player.x, player.y)
					Npc(tonumber(npc)):talk(2, "Watzuppp boss?")
					player:sendAnimation(16)
					player:playSound(29)
				else
					player:sendAnimation(246)
					player:sendMinitext("ID not found in database")
				end
			else
				player:popUp("Numberic only sir!")
			end
		end
	elseif menu == "Give" then
		give = player:menuString("What do you want to give?",{"Item", "Spell", "Gold","Legend"})
		if give == "Item" then
			item = player:input("What item? (item.yname)\n\nEX: return_scroll")
			if item ~= nil then
				amount = player:input("How many "..Item(item).name.." ?")
				if tonumber(amount) > 0 then
					target = player:input("Enter the name of player who you want to give "..Item(item).name.." :")
					if Player(target) ~= nil then
						if (Player(target):hasSpace(item, tonumber(amount), 0, 0) == true) then
							z = player:menuString("How you want to give "..tonumber(amount).." "..Item(item).name.." to "..Player(target).name.."?", {"With Msg to target","Without Msg","Cancel"})
							if z == "With Msg to target" then
								msg = player:input("Msg : ")
								if msg ~= nil then
									Player(target):addItem(item, tonumber(amount))
									Player(target):popUp("GM("..player.name.."): "..msg.."")
									Player(target):msg(4, "== [GM]: Added "..tonumber(amount).." "..Item(item).name.." into inventory", Player(target).ID)
									player:popUp(tonumber(amount).." "..Item(item).name.." gived to "..Player(target).name.." !!")
								end
							elseif z == "Without Msg" then
								Player(target):addItem(item, tonumber(amount))
								player:popUp(tonumber(amount).." "..Item(item).name.." gived to "..Player(target).name.." !!")
							end
						else
							player:popUp(Player(target).name.. " do not have enough space for this / Item not found")
						end
					else
						player:popUp("User not found")
					end
				else
					player:popUp("Numberic only!")
				end
			end
		elseif give == "Spell" then
			spell = player:input("What Spell? (spell.yname) \nEX: lethal_strike")
			if spell ~= nil then
				target = player:input("Enter The name of player you want to give "..spell..":")
				if Player(target) ~= nil then
					if not Player(target):hasSpell(spell) then
						a = player:menuString("Give "..spell.." to "..Player(target).name.."?",{"With Msg", "Without Msg", "Cancel"})
						if a == "With Msg" then
							msg = player:input("Msg : ")
							if msg ~= nil then
								Player(target):addSpell(spell)
								Player(target):popUp(msg)
								player:popUp(spell.." spell added to "..Player(target).name.."!")
							end
						elseif a == "Without Msg" then
							Player(target):addSpell(spell)
							player:popUp(spell.." spell added to "..Player(target).name.."!")
						end
					else
						player:popUp(Player(target).name.. " already has this spell / Spell not found in database")
					end
				else
					player:popUp("User not found!")
				end				
			end
		elseif give == "Legend" then
			target = player:input("kepada siapa?")
			if Player(target) ~= nil then
				leg = player:input("Masukkan legend nya \n\n EX: Telah menyelamatkan Chu Rua")
				if leg ~= nil then
					name = player:input("Masukkan nama dari legend itu \n\n EX: chu_rua")
					if name ~= nil then
						Player(target):addLegend(leg, name, 1, 1)
						Player(target):popUp("New Legend Added by " ..player.name)
					end
				end
			else
				player:popUp("User not found!")
			end
			
			
		elseif give == "Gold" then
			amount = player:input("How much: ")
			if tonumber(amount) > 0 then
				target = player:input("Enter the name you want to give this "..tonumber(amount).." coins")
				if Player(target) ~= nil then
					ok = player:menuString("How you want to give to target?",{"With Msg", "Without Msg", "Cancel"})
					if ok == "With Msg" then
						msg = player:input("Msg : ")
						if msg ~= nil then
							Player(target):addGold(tonumber(amount))
							Player(target):popUp(msg)
							player:popUp("Gived "..tonumber(amount).." coins to "..Player(target).name)
						end
					elseif ok == "Without Msg" then
						Player(target):addGold(tonumber(amount))
						player:popUp("Gived "..tonumber(amount).." coins to "..Player(target).name)
					end
				else
					player:popUp("User not found!")
				end
			else
				player:popUp("Numberic only!")
			end
		end
	

	elseif menu == "Common Tools" then
		common_tools.click(player, npc)
	
	elseif menu == "Ressurection" then
		v = player:menuString("How do you want to Ressurect?",{"All players in this map", "Player"})
		if v == "All players in this map" then
			pc = player:getObjectsInMap(player.m, BL_PC)
			if #pc > 0 then
				for i = 1, #pc do
					player:sendAction(6, 20)
					player:playSound(112)
					pc[i]:sendAnimation(427)
					pc[i]:playSound(112)
					pc[i].state = 0
					pc[i].health = 1
					pc[i]:sendStatus()
					pc[i].updateState()
					pc[i]:sendMinitext("Ressurect by God")
					player:refresh()
				end
			end
		elseif v == "Player" then
			input = player:input("Enter Player Name:")
			if Player(input) ~= nil then
				player:sendAction(6, 20)
				Player(input):sendAnimation(427)
				Player(input):playSound(112)
				Player(input).state = 0
				Player(input).health = 1
				Player(input):sendStatus()
				Player(input):updateState()
				Player(input):sendMinitext("Ressurect by God")
				player:refresh()
			else
				player:popUp("User not found")
			end
		end
	elseif menu == "Kill" then
		what = player:menuString("What do you want to kill?", {"All Mobs in this Map", "All Players in this Map","Target(player)"})
		if what == "All Mobs in this Map" then
			mob = player:getObjectsInMap(player.m, BL_MOB)
			if #mob > 0 then
				for i = 1, #mob do
					player:sendAction(6, 20)
					mob[i].attacker = 0
					mob[i]:removeHealth(mob[i].health)
				end
			end
		elseif what == "All Players in this Map" then
			pc = player:getObjectsInMap(player.m, BL_PC)
			if #pc > 0 then
				for i = 1, #pc do
					if pc[i].ID ~= player.ID then
						player:sendAction(6, 20)
						pc[i]:sendAnimation(420)
						pc[i]:sendAnimation(143)
						pc[i]:playSound(59)
						pc[i].attacker = 0
						pc[i]:removeHealth(pc[i].health)
						pc[i]:sendStatus()
						pc[i]:sendMinitext("Killed by God")
					end
				end
			end
		else
			a = player:input("Enter Target Name:")
			if Player(a) ~= nil then
				Player(a):sendAnimation(420)
				Player(a):sendAnimation(143)
				Player(a):playSound(59)
				Player(a).attacker = player.ID
				Player(a):removeHealth(Player(a).health)
				Player(a):sendStatus()
				Player(a):sendMinitext("killed by God")
			else
				player:popUp("User not found!")
			end
		end
	end
end
}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	
	
	
	
	
	
	
	
	
	
	
	
	