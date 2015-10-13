sunset = {

click = async(function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local menu, req, max, txt, input, add, ok 
	local xp = player.exp	
	
	if player.level < 99 then player:dialogSeq({t, "<b>[Sunset]\n\nYou are not strong enough for talking to me!"}, 1) return end 	
	
	if player.gmLevel < 99 then
		for i = 0, 7 do
			if player:getEquippedItem(i) ~= nil then
				player:sendAnimation(248)
				player:msg(4, "[INFO]: You need to take off all equipments before talk to him", player.ID)
				return
			end
		end
	end
	
	if player.state == 1 then
		player:dialogSeq({t, "<b>[Sunset]\n\nI won't talking with spirits!!"},1)
		return
	elseif player.state == 0 or player.state == 3 then
		player.health = player.maxHealth
		player.magic = player.maxMagic
		player:sendStatus()
		
		menu = player:menuString("<b>[Sunset]\n\nHow much of experience you want to sacrifice today?", {"Info", "Increase Health", "Increase Magic", "Exit"})
		
		if menu == "Info" then
			player:dialogSeq({t, "While exchanging your experience, the exchanged value is in package form. Those values is different depending on the chosen package. For instance, there are Vita, Mana, Might (not active), Will (not active), Grace (not active).",
							"Limit of the exchanged values are different depending on your path. You can exchange your experience when you reached level 99."}, 1)

	---- Health Exchange ---->>
							
		elseif menu == "Increase Health" then
		
			req = changeXP.getReqXPhealth(player, player.baseClass)
			max = math.floor(xp/req)
			txt =      "How many times of experience do you want to sacrifice?\n\n"
			txt = txt.."Base Vita : "..format_number(player.baseHealth).."\n"
			txt = txt.."1 Times   = Additional 50 vita\n"
			txt = txt.."1 Times   = "..format_number(req).." exp\n"	
			txt = txt.."Max       : "..max.." time(s)"
			input = player:input(txt)

			if tonumber(input) <= 0 then
				return
			elseif tonumber(input) > max then
				player:dialogSeq({t, "You don't have enough EXP!"}, 1)
				return
			else
				add = tonumber(input)*50
				txt = "<b>[Vita exchange]\n\n"
				txt = txt.."Vita before : "..format_number(player.baseHealth).."\n"
				txt = txt.."Add         : "..add.." vita\n"
				txt = txt.."------------------------ +\n"
				txt = txt.."Vita after  : "..format_number(player.baseHealth+add)..""
				ok = player:menuString(txt, {"Confirm", "Cancel"})
				
				if ok == "Confirm" then
					totalRequireXP = req*tonumber(input)
					if xp < totalRequireXP then
						player:dialogSeq({t, "You don't have enough EXP!"}, 1)
						return
					else
						changeXP.showExchange(player, "vita", tonumber(input), req, add)
						player.baseHealth = player.baseHealth + add
						player.exp = player.exp - totalRequireXP
						player:sendMinitext("Exchange success!")
						player:sendStatus()
						player:calcStat()
					end
				end
			end

	---- Magic Exchange ---->>
			
		elseif menu == "Increase Magic"	then
			req = changeXP.getReqXPmagic(player, player.baseClass)
			max = math.floor(xp/req)
			txt =      "How many times of experience do you want to sacrifice?\n\n"
			txt = txt.."Base Mana : "..format_number(player.baseMagic).."\n"
			txt = txt.."1 Times   = Additional 25 mana\n"
			txt = txt.."1 Times   = "..format_number(req).." exp\n"	
			txt = txt.."Max       : "..max.." time(s)"
			input = player:input(txt)

			if tonumber(input) <= 0 then
				return
			elseif tonumber(input) > max then
				player:dialogSeq({t, "You don't have enough EXP!"}, 1)
				return
			else
				add = tonumber(input)*25
				txt = "<b>[Magic exchange]\n\n"
				txt = txt.."Mana before : "..format_number(player.baseMagic).."\n"
				txt = txt.."Add         : "..add.." mana\n"
				txt = txt.."------------------------ +\n"
				txt = txt.."Mana after  : "..format_number(player.baseMagic+add)..""
				ok = player:menuString(txt, {"Confirm", "Cancel"})
				
				if ok == "Confirm" then
					totalRequireXP = req*tonumber(input)
					if xp < totalRequireXP then
						player:dialogSeq({t, "You don't have enough EXP!"}, 1)
						return
					else
						changeXP.showExchange(player, "mana", tonumber(input), req, add)
						player.baseMagic = player.baseMagic + add
						player.exp = player.exp - totalRequireXP
						player:sendMinitext("Exchange success!")
						player:sendStatus()
						player:calcStat()
						player:dialogSeq({t, "<b>[Magic Exchange]\n\n"..format_number(add).." mana increased !"}, 1)
					end
				end
			end		
		end
	end
end),


say = function(player, npc)

	local s = string.lower(player.speech)
	
	if string.find(s, "(.*)thank you(.*)") or string.find(s, "(.*)terima kasih(.*)") or string.find(s, "(.*)tq(.*)") or string.find(s, "(.*)thx(.*)") then
		player:playSound(112)
		player.health = player.maxHealth
		player.magic = player.maxMagic
		player:sendStatus()
		npc:talk(2, "You're welcome "..player.name.." !")
	end
end
}
		
		
		



changeXP = {

getReqXPhealth = function(player, class)	-- Require Exp for 1 times exchange health
	
	local hp = player.baseHealth
	local job = player.baseClass
	local req
	
	if class == 1 and job == 1 then											-- Warrior
        if hp <= 300000 then req = 10000000 end
		if hp > 2400000 then req = 275000000 end
        if hp > 300000 and hp <= 600000 then req = 25000000 end
        if hp > 600000 and hp <= 900000 then req = 50000000 end
        if hp > 900000 and hp <= 1200000 then req = 75000000 end
        if hp > 1200000 and hp <= 1500000 then req = 100000000 end
        if hp > 1500000 and hp <= 1725000 then req = 125000000 end
        if hp > 1725000 and hp <= 1950000 then req = 150000000 end
        if hp > 1950000 and hp <= 2175000 then req = 175000000 end
        if hp > 2175000 and hp <= 2400000 then req = 200000000 end      
	elseif class == 2 and job == 2 then										-- ROGUE
        if hp <= 215000 then req = 10000000 end
		if hp > 2000000 then req = 275000000 end
        if hp > 215000 and hp <= 430000 then req = 25000000 end
        if hp > 430000 and hp <= 645000 then req = 50000000 end
        if hp > 645000 and hp <= 860000 then req = 75000000 end
        if hp > 860000 and hp <= 1075000 then req = 100000000 end
        if hp > 1075000 and hp <= 1230000 then req = 125000000 end
        if hp > 1230000 and hp <= 1385000 then req = 150000000 end
        if hp > 1385000 and hp <= 1540000 then req = 175000000 end
        if hp > 1540000 and hp <= 1700000 then req = 200000000 end
        if hp > 1700000 and hp <= 1850000 then req = 225000000 end
        if hp > 1850000 and hp <= 2000000 then req = 250000000 end
	elseif class == 3 and job == 3 then										-- MAGE
        if hp <= 90000 then req = 10000000 end
		if hp > 825000 then req = 275000000 end
        if hp > 90000 and hp <= 180000 then req = 25000000 end
        if hp > 180000 and hp <= 270000 then req = 50000000 end
        if hp > 270000 and hp <= 360000 then req = 75000000 end
        if hp > 360000 and hp <= 450000 then req = 100000000 end
        if hp > 450000 and hp <= 512000 then req = 125000000 end
        if hp > 512000 and hp <= 575000 then req = 150000000 end
        if hp > 575000 and hp <= 637500 then req = 175000000 end
        if hp > 637500 and hp <= 700000 then req = 200000000 end
        if hp > 700000 and hp <= 762500 then req = 225000000 end
        if hp > 762500 and hp <= 825000 then req = 250000000 end      		
	elseif class == 4 and job == 4 then										-- POET	
        if hp <= 120000 then req = 10000000 end
		if hp > 1150000 then req = 275000000 end
        if hp > 120000 and hp <= 240000 then req = 25000000 end
        if hp > 240000 and hp <= 360000 then req = 50000000 end
        if hp > 360000 and hp <= 480000 then req = 75000000 end
        if hp > 480000 and hp <= 600000 then req = 100000000 end
        if hp > 600000 and hp <= 700000 then req = 125000000 end
        if hp > 700000 and hp <= 800000 then req = 150000000 end
        if hp > 800000 and hp <= 900000 then req = 175000000 end
        if hp > 900000 and hp <= 1000000 then req = 200000000 end
        if hp > 1000000 and hp <= 1100000 then req = 225000000 end
        if hp > 1100000 and hp <= 1150000 then req = 250000000 end
	end
	return req
end,


showExchange = function(player, type, times, req, add)
	
	local xp = req*times
	
	if type == "vita" then
		player:msg(12, "=================== Vita Exchange =======================", player.ID)
		player:msg(12, "Vita : "..format_number(player.baseHealth).." + "..format_number(add).." = "..format_number(player.baseHealth+add).."", player.ID)
	elseif type == "mana" then
		player:msg(12, "=================== Mana Exchange =======================", player.ID)
		player:msg(12, "Mana : "..format_number(player.baseMagic).." + "..format_number(add).." = "..format_number(player.baseMagic+add).."", player.ID)
	end
    player:msg(12, "Rate : " ..times.. " times x "..format_number(req).." Exp", player.ID)
    player:msg(12, "Exp  : " ..format_number(player.exp).. " - " ..format_number(xp).. "  = " ..format_number(player.exp - xp).. "", player.ID)
    player:msg(12, "=========================================================", player.ID)        
end,


getReqXPmagic = function(player, class)	-- Require Exp for 1 times exchange magic
	
	local mp = player.baseMagic
	local job = player.baseClass
	local req
	
	if class == 1 and job == 1 then											-- Warrior
		if mp <= 70000 then	req = 10000000 end
		if mp > 650000 then req = 275000000 end
		if mp > 70000 and mp <= 140000 then req = 25000000 end
		if mp > 140000 and mp <= 210000 then req = 50000000 end
		if mp > 210000 and mp <= 280000 then req = 75000000 end
		if mp > 280000 and mp <= 350000 then req = 100000000 end
		if mp > 350000 and mp <= 400000 then req = 125000000 end
		if mp > 400000 and mp <= 450000 then req = 150000000 end
		if mp > 450000 and mp <= 500000 then req = 175000000 end
		if mp > 500000 and mp <= 550000 then req = 200000000 end
		if mp > 550000 and mp <= 600000 then req = 225000000 end
		if mp > 600000 and mp <= 650000 then req = 250000000 end
	elseif class == 2 and job == 2 then										-- Rogue
		if mp <= 115000 then req = 10000000 end
		if mp > 1055000 then req = 275000000 end
		if mp > 115000 and mp <= 230000 then req = 25000000 end
		if mp > 230000 and mp <= 345000 then req = 50000000 end
		if mp > 345000 and mp <= 460000 then req = 75000000 end
		if mp > 460000 and mp <= 575000 then req = 100000000 end
		if mp > 575000 and mp <= 655000 then req = 125000000 end
		if mp > 655000 and mp <= 735000 then req = 150000000 end
		if mp > 735000 and mp <= 815000 then req = 175000000 end
		if mp > 815000 and mp <= 895000 then req = 200000000 end
		if mp > 895000 and mp <= 975000 then req = 225000000 end
		if mp > 975000 and mp <= 1055000 then req = 250000000 end
	elseif class == 3 and job == 3 then										-- Mage
		if mp <= 175000 then req = 10000000 end
		if mp > 1685000 then req = 275000000 end
		if mp > 175000 and mp <= 350000 then req = 25000000 end
		if mp > 350000 and mp <= 525000 then req = 50000000 end
		if mp > 525000 and mp <= 700000 then req = 75000000 end
		if mp > 700000 and mp <= 875000 then req = 100000000 end
		if mp > 875000 and mp <= 1010000 then req = 12500000 end
		if mp > 1010000 and mp <= 1145000 then req = 150000000 end
		if mp > 1145000 and mp <= 1280000 then req = 175000000 end
		if mp > 1280000 and mp <= 1415000 then req = 200000000 end
		if mp > 1415000 and mp <= 1550000 then req = 225000000 end
		if mp > 1550000 and mp <= 1685000 then req = 250000000 end
	elseif class == 4 and job == 4 then										-- Poet
		if mp <= 120000 then req = 10000000 end
		if mp > 1150000 then req = 275000000 end
		if mp > 120000 and mp <= 240000 then req = 25000000 end
		if mp > 240000 and mp <= 360000 then req = 50000000 end
		if mp > 360000 and mp <= 480000 then req = 75000000 end
		if mp > 480000 and mp <= 600000 then req = 100000000 end
		if mp > 600000 and mp <= 700000 then req = 125000000 end
		if mp > 700000 and mp <= 800000 then req = 150000000 end
		if mp > 800000 and mp <= 900000 then req = 175000000 end
		if mp > 900000 and mp <= 1000000 then req = 200000000 end
		if mp > 1000000 and mp <= 1100000 then req = 225000000 end
		if mp > 1100000 and mp <= 1150000 then req = 250000000 end		
	end
	return req
end
}		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
