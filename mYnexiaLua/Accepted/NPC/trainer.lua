

trainer = {

click = async(function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local spell, class, menuOpt
	local opts = {}
	local users = player:getUsers()
	
	if player.baseClass == 0 then
		if player.mapTitle == "Knight Yebaek" then
			table.insert(opts, "About warrior")
			
		elseif player.mapTitle == "Thief Maro" then
			table.insert(opts, "About rogue")
			
		elseif player.mapTitle == "Wizard Eldritch" then
			table.insert(opts, "About mage")
			
		elseif player.mapTitle == "Bard Song" then
			table.insert(opts, "About poet")
		end
	else
		if player.mapTitle == "Knight Yebaek" and player.baseClass == 1
		or player.mapTitle == "Thief Maro" and player.baseClass == 2
		or player.mapTitle == "Wizard Eldritch" and player.baseClass == 3
		or player.mapTitle == "Bard Song" and player.baseClass == 4 then
			table.insert(opts, "Learn Spell")
		end
		table.insert(opts, "Forget Spell")
	end
	
	table.insert(opts, "Exit")
	
	menu = player:menuString("How may i assist you, young fledgling?", opts)
	
	if menu == "Exit" then
		return
		
-- Learn Spell		
	elseif menu == "Learn Spell" then
		if player.mapTitle == "Knight Yebaek" and player.baseClass == 1 then
			spell = player:learnSpell2(1)
		elseif player.mapTitle == "Thief Maro" and player.baseClass == 2 then
			spell = player:learnSpell2(2)
		elseif player.mapTitle == "Wizard Eldritch" and player.baseClass == 3 then
			spell = player:learnSpell2(3)
		elseif player.mapTitle == "Bard Song" and player.baseClass == 4 then
			spell = player:learnSpell2(4)
		end

	elseif menu == "Forget Spell" then
		player:forgetSpell()
		
	else
		if menu == "About warrior" then
			class = "Warrior"
			player:dialogSeq({t, "Warriors are a path of great AoE damage and superior tankiness. They can charge into battle hitting every monster around them. Warriors are the best fighter in short range in the world!!"}, 1)
		elseif menu == "About rogue" then
			class = "Rogue"
			player:dialogSeq({t, "Rogues are a path of great speed, cunning, and deceit. Through their traps, tricks, and invisibility they are able to do high amounts of single target damage and get out of danger in a flash."}, 1)
		elseif menu == "About mage" then
			class = "Mage"
			player:dialogSeq({t, "Mages are a path of extremely high single target damage and crowd control. Their ability to manipulate the enemies around them is unrivaled and their burst unmatched."}, 1)
		elseif menu == "About poet" then
			class = "Poet"
			player:dialogSeq({t, "Poets are a path of supporting healers, through buffs, heals, and smaller amounts of damage they are a necessity in all groups and can often function as impressive tanks as well."}, 1)
		end
		
		if player.level >= 5 then
    		menuOpt = player:menu("Would you like to become a "..class.."?", {"Yes", "No"})
    		if menuOpt == 1 then
				if class == "Warrior" then
					player.class = 1
				elseif class == "Rogue" then
					player.class = 2
				elseif class == "Mage" then
					player.class = 3
				elseif class == "Poet" then
					player.class = 4
				end
				
            	player:playSound(20)
            	player:sendAnimation(2)
            	player:status()
				player:sendMinitext("You have become a "..class.."!")
				for i = 1, #users do users[i]:msg(12, "-------------- "..player.name.." has become a "..class.."!! --------------", users[i].ID) end
			end
		end
	end
end)
}


