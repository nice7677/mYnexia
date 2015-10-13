boy_taylor = {
click = async(function(player,npc)
	local i = 0
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	local opts = {"Buy Boy Clothes", "Sell Boy Clothes"}
	local menuOption
	local buyitemsWarrior = {4051, 4052, 4053, 4054, 4055, 4056, 4057}
	local buyitemsRogue = {4058, 4059, 4060, 4061, 4062, 4063, 4064}
	local buyitemsMage = {4065, 4066, 4067, 4068, 4069, 4070, 4071}
	local buyitemsPoet = {4072, 4073, 4074, 4075, 4076, 4077, 4078}
	
	local sellitems = {}
	
	for i = 4051, 4078 do
		table.insert(sellitems, i)
	end
	
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	if (#opts ~= 0) then
		menuOption = player:menuString("What can i help you?", opts)
		
		if (menuOption == "Buy Boy Clothes") then
			local optss = {"Warrior", "Rogue", "Mage", "Poet"}
			local menuOption2
			
			if(#optss ~=0) then
				menuOption2 = player:menuString("What type of clothes do you looking for?", optss)
					if(menuOption2 == "Warrior") then
						player:buyExtend("This is Warrior's clothes, which one do you want to buy?", buyitemsWarrior)
					elseif(menuOption2 == "Rogue") then
						player:buyExtend("This is Rogue's clothes, which one do you want to buy?", buyitemsRogue)
					elseif(menuOption2 == "Mage") then
						player:buyExtend("This is Mage's clothes, which one do you want to buy?", buyitemsMage)
					elseif(menuOption2 == "Poet") then
						player:buyExtend("This is Poet's clothes, which one do you want to buy?", buyitemsPoet)
					end
			end
		elseif (menuOption == "Sell Boy Clothes") then
			player:sellExtend("What clothes do you have?", sellitems)
		end
	end
end)
}





girl_taylor = {
click = async(function(player,npc)
	local i = 0
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	local opts = {"Buy Girl Clothes", "Sell Girl Clothes"}
	local menuOption
	local buyitemsWarrior = {4019, 4020, 4021, 4022, 4023, 4024, 4025}
	local buyitemsRogue = {4026, 4027, 4028, 4029, 4030, 4031, 4032}
	local buyitemsMage = {4033, 4034, 4035, 4036, 4037, 4038, 4039}
	local buyitemsPoet = {4040, 4041, 4042, 4043, 4044, 4045, 4046}
	
	local sellitems = {}
	
	for i = 4019, 4046 do
		table.insert(sellitems, i)
	end
	
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	if (#opts ~= 0) then
		menuOption = player:menuString("What can i help you?", opts)
		
		if (menuOption == "Buy Girl Clothes") then
			local optss = {"Warrior", "Rogue", "Mage", "Poet"}
			local menuOption2
			
			if(#optss ~=0) then
				menuOption2 = player:menuString("What type of clothes do you looking for?", optss)
					if(menuOption2 == "Warrior") then
						player:buyExtend("This is Warrior's clothes, which one do you want to buy?", buyitemsWarrior)
					elseif(menuOption2 == "Rogue") then
						player:buyExtend("This is Rogue's clothes, which one do you want to buy?", buyitemsRogue)
					elseif(menuOption2 == "Mage") then
						player:buyExtend("This is Mage's clothes, which one do you want to buy?", buyitemsMage)
					elseif(menuOption2 == "Poet") then
						player:buyExtend("This is Poet's clothes, which one do you want to buy?", buyitemsPoet)
					end
			end
		elseif (menuOption == "Sell Girl Clothes") then
			player:sellExtend("What kind of clothes do you have?", sellitems)
		end
	end
end)
}