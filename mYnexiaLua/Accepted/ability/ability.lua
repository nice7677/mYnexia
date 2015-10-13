

ability = {

click = function(player, npc)

	gfxClone(player, npc)
	player.dialogType = 2
	local opts = {}
	if player.registry["learned_sheperd"] > 0 then 		table.insert(opts, "Sheperd") end
	if player.registry["learned_weaving"] > 0 then 		table.insert(opts, "Weaving") end
	if player.registry["learned_farming"] > 0 then 		table.insert(opts, "Farming") end	
	if player.registry["learned_gem_mining"] > 0 then 	table.insert(opts, "Gem mining") end
	if player.registry["learned_gem_cuting"] > 0 then 	table.insert(opts, "Gem cuting") end
	if player.registry["learned_ore_mining"] > 0 then 	table.insert(opts, "Ore mining") end
	if player.registry["learned_lumberjack"] > 0 then 	table.insert(opts, "Lumberjack") end
	menu = player:menuString("<b>[Ability's info]\n\nWhat type of ability?", opts)
	
	if menu == "Sheperd" then
		ability.info(player, "sheperd")
	elseif menu == "Weaving" then
		ability.info(player, "weaving")
	elseif menu == "Gem mining" then
		ability.info(player, "gem_mining")
	elseif menu == "Gem cuting" then
		ability.info(player, "gem_cuting")
	elseif menu == "Ore mining" then
		ability.info(player, "ore_mining")
	elseif menu == "Lumberjack" then
		ability.info(player, "lumberjack")
	end
end,

----------------------------- CAST --------------------------------------------

cast = function(player)
	
	local obj = getObjFacing(player, player.side)
	local mob = getTargetFacing(player, BL_MOB)
	if not player:canCast(1,1,0) then return end
	if player:hasDuration("ability") then return end
	
	if player.registry["ability"] > 0 then player.registry["ability"] = 0 end
	if mob ~= nil then
	
-- Ore mining
		if mob.yname == "auto_ore" then
			player:sendAnimation(315)
			player:playSound(121)
		
-- Sheperd		
		elseif mob.yname == "auto_sheep" then
			player:sendAnimation(311)
			player:playSound(120)
			
-- Gem mining
		elseif mob.yname == "auto_monkey" then
			player:sendAnimation(315)
			player:playSound(120)
			
		end
		player:sendAction(28, 250)
		player:setDuration("ability", 6000)
	else
	
	
		if obj ~= nil then
			
-- Weaving			
			if obj == 3204 and player.m == 10005 then
				if player:hasItem("wool", 1) == true or player:hasItem("fine_wool", 1) == true then
					player:sendAction(28, 250)
					player:sendAnimation(272)
					player:playSound(120)
					player:setDuration("ability", 6000)
				else
					anim(player)
					player:setDuration("weaving", 0)
					player:msg(4, "[INFO] You need material item for this (Wool / Fine wool)", player.ID)
				end
			end
		end
	end
end,

-------------------- WHILE CAST -----------------------------------

while_cast = function(player)
	
	local obj = getObjFacing(player, player.side)
	local mob = getTargetFacing(player, BL_MOB)	
	local r = math.random(5)

	if player.registry["ability"] >= 100 then return else
		if player.registry["ability"] == 99 then
			player.registry["ability"] = player.registry["ability"] + 1
		elseif player.registry["ability"] == 75 then
			player.registry["ability"] = player.registry["ability"] + 24
		else
			player.registry["ability"] = player.registry["ability"]+25
		end
	end	
	
	
	if mob ~= nil then
	
-- Ore mining	
		if mob.yname == "auto_ore" then
			player:sendAnimation(315)
			
-- Sheperd			
		elseif mob.yname == "auto_sheep" then
			player:sendAnimation(311)

-- Gem mining
		elseif mob.yname == "auto_monkey" then
			player:sendAnimation(315)
-- 		
		end
	else
	
		if obj ~= nil then
			
-- Weaving			
			if obj == 3204 and player.m == 10005 then
				player:sendAnimation(272)
			end
		else
			player:setDuration("ability", 0)
		end
	end
	
	player:talk(2, "Ability: "..player.registry["ability"].."%")
end,

-------------- UNCAST ----------------------------------------------

uncast = function(player)
	
	local obj = getObjFacing(player, player.side)
	local weap = player:getEquippedItem(EQ_WEAP)
	local mob = getTargetFacing(player, BL_MOB)
	local r = math.random(70)
	local weavingExp = math.random(1,3)
	local sheperdExp = math.random(1,2)
	local oreMiningExp = math.random(1,2)
	local gemMiningExp = math.random(1,2)
	
	player:updateState()
	
	if weap ~= nil then
		if obj ~= nil then player:sendAction(28, 120)
			
-- Weaving
			if obj == 3204 and player.m == 10005 then player:sendAnimation(272)
			
				ability.leveling(player, weavingExp, "weaving")
				
				if weap.yname == "wooden_string" or weap.yname == "bronze_string" then player:deductDura(EQ_WEAP, 10) end
				if weap.yname == "silver_string" or weap.yname == "golden_string" then player:deductDura(EQ_WEAP, 2) end
				if player:hasItem("wool", 1) == true then
					player:removeItem("wool", 1)
					player:addItem("clothes", 1)
				return else
					if player:hasItem("fine_wool", 1) == true then
						player:removeItem("fine_wool", 1)
						player:addItem("fine_clothes", 1)
						ability.bonusxp(player, 2, "weaving")
					return else
						player:msg(4, "[INFO] You need a material item for this ability ('wool'/'Fine wool')", player.ID)
					end
				end
			end
		end
		
		
		if mob ~= nil then player:sendAction(28, 120)

-- Ore Mining		
			if mob.yname == "auto_ore" then player:sendAnimation(315)
			
				ability.leveling(player, oreMiningExp, "ore_mining")
				
				if weap.yname == "wooden_pickaxe" or weap.yname == "bronze_pickaxe" then player:deductDura(EQ_WEAP, 10) end
				if weap.yname == "silver_pickaxe" or weap.yname == "golden_pickaxe" then player:deductDura(EQ_WEAP, 2) end
				
				if r <= 2 then player:addItem("mineral_stone_a+", 1) end
				if r >= 3 and r <= 5 then player:addItem("mineral_stone_a", 1) end
				if r >= 6 and r <= 9 then player:addItem("mineral_stone_b+", 1) end
				if r >= 10 and r <= 14 then player:addItem("mineral_stone_b", 1) end
				if r >= 15 and r <= 25 then player:addItem("mineral_stone_c+", 1) end
				if r >= 26 and r <= 41 then player:addItem("mineral_stone_c", 1) end

				
-- Sheperd
			elseif mob.yname == "auto_sheep" then player:sendAnimation(311)

				ability.leveling(player, sheperdExp, "sheperd")
				
				if weap.yname == "scissors" or weap.yname == "bronze_scissors" then player:deductDura(EQ_WEAP, 10) end
				if weap.yname == "silver_scissors" or weap.yname == "golden_scissors" then player:deductDura(EQ_WEAP, 2) end
				wool = math.random(1,10)
				if wool <= 3 then
					player:addItem("fine_wool", 1)
				else
					player:addItem("wool", 1)
				end
-- Gem mining				
			elseif mob.yname == "auto_monkey" then player:sendAnimation(315)
				
				ability.leveling(player, gemMiningExp, "gem_mining")

				player:sendMinitext("Gem mining exp gained "..gemMiningExp.." points")
				if weap.yname == "wooden_net" or weap.yname == "bronze_net" then player:deductDura(EQ_WEAP, 10) end
				if weap.yname == "silver_net" or weap.yname == "golden_net" then player:deductDura(EQ_WEAP, 2) end

				if r <= 5 then player:addItem("yellow_amber", 1) end
				if r >= 6 and r <= 9 then player:addItem("red_amber", 1) end
				if r >= 10 and r <= 14 then player:addItem("white_amber", 1) end
				if r >= 15 and r <= 25 then player:addItem("dark_amber", 1) end
				if r >= 26 and r <= 41 then player:addItem("amber", 1) end
			end
		end
	else
		anim(player)
		player:sendMinitext("Cannot find any ability object")
	end
end,



leveling = function(player, get, ability)

	local level = player.registry[ability.."_level"]
	local tnl = player.registry[ability.."_tnl"]
	local get = math.abs(tonumber(get))
	local name, icon
	
	if ability == "sheperd" then name = "Sheperd" icon = 137 end 
	if ability == "ore_mining" then name = "Ore mining" icon = 125 end
	if ability == "weaving" then name =	"Weaving" icon = 64 end
	if ability == "gem_mining" then name = "Gem mining" icon = 72 end
	
	if level == 1 then
		if tnl > 0 then
			player.registry[ability.."_tnl"] = player.registry[ability.."_tnl"] - get
			player:sendMinitext(ability.." experience gained "..get.." points ("..tnl-get..")")
		return else
			if player:hasLegend("beginner_"..ability) then player:removeLegendbyName("beginner_"..ability) end
			player:addLegend("Specialization "..name, "specialization_"..ability, icon, 108)
			player.registry[ability.."_level"] = player.registry[ability.."_level"]+1
			player.registry[ability.."_tnl"] = 1250
			finishedQuest(player)
			player:sendMinitext("You're Specialization on "..ability.." now!")
		end
	elseif level == 2 then
		if tnl > 0 then
			player.registry[ability.."_tnl"] = player.registry[ability.."_tnl"] - get
			player:sendMinitext(ability.." experience gained "..get.." points ("..tnl-get..")")
		return else
			if player:hasLegend("specialization_"..ability) then player:removeLegendbyName("specialization_"..ability) end
			player:addLegend("Trained "..name, "trained_"..ability, icon, 108)		
			player.registry[ability.."_level"] = player.registry[ability.."_level"]+1
			player.registry[ability.."_tnl"] = 2500
			finishedQuest(player)
			player:sendMinitext("You're Trained on "..ability.." now!")
		end
	elseif level == 3 then
		if tnl > 0 then
			player.registry[ability.."_tnl"] = player.registry[ability.."_tnl"] - get
			player:sendMinitext(ability.." experience gained "..get.." points ("..tnl-get..")")
		return else
			if player:hasLegend("trained_"..ability) then player:removeLegendbyName("trained_"..ability) end
			player:addLegend("Great "..name, "great_"..ability, icon, 108)		
			player.registry[ability.."_level"] = player.registry[ability.."_level"]+1
			player.registry[ability.."_tnl"] = 3250
			finishedQuest(player)
			player:sendMinitext("You're Great on "..ability.." now!")
		end
	elseif level == 4 then
		if tnl > 0 then
			player.registry[ability.."_tnl"] = player.registry[ability.."_tnl"] - get
			player:sendMinitext(ability.." experience gained "..get.." points ("..tnl-get..")")
		return else
			if player:hasLegend("great_"..ability) then player:removeLegendbyName("great_"..ability) end
			player:addLegend("Talented "..name, "talented_"..ability, icon, 108)		
			player.registry[ability.."_level"] = player.registry[ability.."_level"]+1
			player.registry[ability.."_tnl"] = 10000
			finishedQuest(player)
			player:sendMinitext(ability.."You're Talented on "..ability.." now!")
		end
	elseif level == 5 then
		if tnl > 0 then
			player.registry[ability.."_tnl"] = player.registry[ability.."_tnl"] - get
			player:sendMinitext(ability.." experience gained "..get.." points ("..tnl-get..")")
		return else
			if player:hasLegend("talented_"..ability) then player:removeLegendbyName("talented_"..ability) end
			player:addLegend("Skilled "..name, "skilled_"..ability, icon, 108)		
			player.registry[ability.."_level"] = player.registry[ability.."_level"]+1
			player.registry[ability.."_tnl"] = 22500
			finishedQuest(player)
			player:sendMinitext("You're Skilled on "..ability.." now!")
		end
	elseif level == 6 then
		if tnl > 0 then
			player.registry[ability.."_tnl"] = player.registry[ability.."_tnl"] - get
			player:sendMinitext(ability.." experience gained "..get.." points ("..tnl-get..")")
		return else
			if player:hasLegend("skilled_"..ability) then player:removeLegendbyName("skilled_"..ability) end
			player:addLegend("Professional "..name, "professional_"..ability, icon, 108)		
			player.registry[ability.."_level"] = player.registry[ability.."_level"]+1
			player.registry[ability.."_tnl"] = 35000
			finishedQuest(player)
			player:sendMinitext("You're Professional on "..ability.." now!")
		end
	elseif level == 7 then
		if tnl > 0 then
			player.registry[ability.."_tnl"] = player.registry[ability.."_tnl"] - get
			player:sendMinitext(ability.." experience gained "..get.." points ("..tnl-get..")")
		return else
			if player:hasLegend("professional_"..ability) then player:removeLegendbyName("professional_"..ability) end
			player:addLegend("Expert "..name, "expert_"..ability, icon, 108)		
			player.registry[ability.."_level"] = player.registry[ability.."_level"]+1
			player.registry[ability.."_tnl"] = 45000
			finishedQuest(player)
			player:sendMinitext("You're Expert on "..ability.." now!")
		end
	elseif level == 8 then
		if tnl > 0 then
			player.registry[ability.."_tnl"] = player.registry[ability.."_tnl"] - get
			player:sendMinitext(ability.." experience gained "..get.." points ("..tnl-get..")")
		return else
			if player:hasLegend("expert_"..ability) then player:removeLegendbyName("expert_"..ability) end
			player:addLegend("Master "..name, "master_"..ability, icon, 108)		
			player.registry[ability.."_level"] = player.registry[ability.."_level"]+1
			finishedQuest(player)
			player:sendMinitext("You're Master on "..ability.." now!")
		end
	elseif level == 9 then
		return
	end
end,


bonusxp = function(player, xp, ability)

	local xp = math.abs(tonumber(xp))
	if ability == nil then return nil end
	if player.registry[ability.."_tnl"] > xp then
		player.registry[ability.."_tnl"] = player.registry[ability.."_tnl"] - xp
		player:sendMinitext("Bonus "..ability.." xp : "..xp.." ("..player.registry[ability.."_tnl"]..")")
	end
end,
		


------------------------------------- GET ABILITY INFO -------------------------------------

info = function(player, ability)
	
	local level = player.registry[ability.."_level"]
	local tnl = player.registry[ability.."_tnl"]
	
	if level  == 0 and tnl == 0 then return nil end
	local lv, txt
	
	if level == 1 then lv = "Beginner" end
	if level == 2 then lv = "Specialization" end
	if level == 3 then lv = "Trained" end
	if level == 4 then lv = "Great" end
	if level == 5 then lv = "Talented" end
	if level == 6 then lv = "Skilled" end
	if level == 7 then lv = "Professional" end
	if level == 8 then lv = "Expert" end
	if level == 9 then lv = "Master" end

	txt =      "<b>["..ability.."]\n\n"
	txt = txt.."<b>-------------------------------------\n"
	txt = txt.."Level : "..lv.."\n"
	txt = txt.."Exp to next level : "..tnl.." points\n\n\n"
	player:popUp(txt)
end
}





















































