
user_pages_status = {

click = function(player, npc)

	local pc = Player(player.registry["on_page"])
	local totem
	local country
	local class
	
	gfxClone(pc, npc)
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 2
	
	local opts = {}
	
	if pc.totem == 0 then totem = "Jujak" end
	if pc.totem == 1 then totem = "Baekho" end
	if pc.totem == 2 then totem = "Hyun moo" end
	if pc.totem == 3 then totem = "Chungryong" end
	if pc.spouse > 0 then partner = Player(pc.spouse).name end
	if pc.spouse == 0 then	partner = "None" end
	if pc.country == 1 then country = "Koguryo" end
	if pc.country == 2 then country = "Buya" end
	if pc.baseClass == 0 then class = "Novice" end
	if pc.baseClass == 1 then class = "Warrior" end
	if pc.baseClass == 2 then class = "Rogue" end
	if pc.baseClass == 3 then class = "Mage" end
	if pc.baseClass == 4 then class = "Poet" end
	if pc.sex == 0 then gender = "Male" end
	if pc.sex == 1 then gender = "Female" end
	
	if player.ID == 2 or player.ID == 18 then
		if pc.gmLevel > 0 then table.insert(opts, "gmLevel: "..pc.gmLevel) end
	end
							table.insert(opts,    "PP : "..format_number(pc.registry["play_point"]))
							table.insert(opts,    "EP : "..format_number(pc.registry["event_point"]))
							table.insert(opts,    "BP : "..format_number(pc.registry["battle_point"]))
							table.insert(opts,    "Level  : "..pc.level)		
							table.insert(opts,    "Class  : "..class)
							table.insert(opts,    "Totem  : "..totem)
							table.insert(opts,    "Nation : "..country)
	if pc.spouse > 0 then table.insert(opts,      "Partner: "..partner) end
							table.insert(opts,    "Title  : "..pc.title)
							table.insert(opts,    "Gender : "..gender)	
							table.insert(opts,    "Exp    : "..format_number(pc.exp))
							table.insert(opts,    "Base Vita   : "..format_number(pc.baseHealth))
							table.insert(opts,    "Base Mana   : "..format_number(pc.baseMagic))							
							table.insert(opts,    "Base Might  : "..pc.might)
							table.insert(opts,    "Base Will   : "..pc.will)
							table.insert(opts,    "Base Grace  : "..pc.grace)
							table.insert(opts,    "Regen  : "..pc.regen)
							table.insert(opts,    "vRegen : "..pc.vRegen)
							table.insert(opts,    "mRegen : "..pc.mRegen)
	if player.ID == 2 then table.insert(opts, "Reset") end
	table.insert(opts, "<< Back")
		
	change = player:menuString("<b>["..pc.name.."'s Status]: ", opts)		
			
	if change == "Level  : "..pc.level then	
		if player.registry["can_alter_stats"] == 1 or player.ID == 2 or player.ID == 18 then
			level = player:input("Change level ("..pc.level..") to?")		
			if tonumber(level) > 0 then		
				pc.level = tonumber(level)		
				pc:calcStat()
				player:sendMinitext("Done!")
				user_pages_status.click(player, npc)
			end
		else
			Player(2):msg(4, "[Alter Stats]: "..player.name.." is try to changing "..pc.name.."'s level!", Player(2).ID)
			player:dialogSeq({t, "You can not do that!"}, 1)
			user_pages_status.click(player, npc)
		end
	
	elseif change == "PP : "..format_number(pc.registry["play_point"]) then
		if not player.ID == 2 then
			player:dialogSeq({t, "You cannot change target's play points!"},1)
			user_pages_status.click(player, npc)
			return
		else
			pp = player:input(pc.name.."'s PP : "..format_number(pc.registry["play_point"]).."\n\nChange PP to :")
			if math.abs(tonumber(pp)) ~= nil then
				ok = player:menuString("PP Before : "..format_number(pc.registry["play_point"]).."\n\nPP After  : "..format_number(math.abs(tonumber(pp))).."\nChange it?", {"Yes", "No"})
				if ok == "Yes" then
					pc.registry["play_point"] = math.abs(tonumber(pp))
					player:sendMinitext("Done!")
					user_pages_status.click(player, npc)
				end
			else
				player:dialogSeq({t, "Numberic only!"},1)
				user_pages_status.click(player, npc)
			end
		end
		
	elseif change == "BP : "..format_number(pc.registry["battle_point"]) then
		if not player.ID == 2 then
			player:dialogSeq({t, "You cannot change target's Battle points!"},1)
			user_pages_status.click(player, npc)
			return
		else	
			bp = player:input(pc.name.."'s BP: "..format_number(pc.registry["battle_point"]).."\n\nChange BP to :")
			if math.abs(tonumber(bp)) ~= nil then
				ok = player:menuString("BP Before : "..format_number(pc.registry["battle_point"]).."\n\nBP After  : "..format_number(math.abs(tonumber(bp))).."\nChange it?", {"Yes", "No"})
				if ok == "Yes" then
					pc.registry["battle_point"] = math.abs(tonumber(bp))
					player:sendMinitext("Done!")
					user_pages_status.click(player, npc)
				end
			else
				player:dialogSeq({t, "Numberic only!"},1)
				user_pages_status.click(player, npc)
			end		
		end
		
	elseif change == "EP : "..format_number(pc.registry["event_point"]) then
		if not player.ID == 2 then
			player:dialogSeq({t, "You cannot change target's play points!"},1)
			user_pages_status.click(player, npc)
			return
		else	
			ep = player:input(pc.name.."'s EP: "..format_number(pc.registry["event_point"]).."\n\nChange EP to :")
			if math.abs(tonumber(ep)) ~= nil then
				ok = player:menuString("EP Before : "..format_number(pc.registry["event_point"]).."\n\nEP After  : "..format_number(math.abs(tonumber(ep))).."\nChange it?", {"Yes", "No"})
				if ok == "Yes" then
					pc.registry["event_point"] = math.abs(tonumber(ep))
					player:sendMinitext("Done!")
					user_pages_status.click(player, npc)
				end
			else
				player:dialogSeq({t, "Numberic only!"},1)
				user_pages_status.click(player, npc)
			end		
		end

	elseif change == "<< Back" then
		user_pages.click(player, npc)
	
	
	elseif change == "gmLevel: "..pc.gmLevel then
		if player.registry["can_alter_stats"] == 1 or player.ID == 2 then
			lvl = player:input("Set Gm level to:")
			if tonumber(lvl) >= 0 then
				ok = player:menuString("Set "..pc.name.."'s gmLevel to "..tonumber(lvl).."?",{"Yes", "No"})
				if ok == "Yes" then
					pc.gmLevel = tonumber(lvl)
					player:sendMinitext("Done!")
					user_pages_status.click(player, npc)
				end
			else
				player:dialogSeq({t, "Numberic only!"})
				user_pages_status.click(player, npc)
			end
		else
			player:dialogSeq({t, "You can not do that!"}, 1)
			user_pages_status.click(player, npc)
			Player(2):msg(4, "[Alter Stats]: "..player.name.." is try to changing "..pc.name.."'s Vita!", Player(2).ID)
		end
	
	elseif change == "Class  : "..class then
		class = player:menuString("Change "..pc.name.."'s base class to?",{"Novice", "Warrior", "Rogue", "Mage", "Poet"})
		if class ~= nil then
			if class == "Novice" then
				pc.class = 0
			elseif class == "Warrior" then
				pc.class = 1
			elseif class == "Rogue" then
				pc.class = 2
			elseif class == "Mage" then
				pc.class = 3
			elseif class == "Poet" then
				pc.class = 4
			end
			pc:calcStat()
			pc:status()
			player:sendMinitext("Done!")
			user_pages_status.click(player, npc)
		end
		
	elseif change == "Nation : "..country then
		country = player:menuString("Change "..pc.name.. "'s nation to?", {"Buya", "Koguryo"})
		if country ~= nil then
			if country == "Buya" then
				pc.country = 2
			elseif country == "Koguryo" then
				pc.country = 1
			end
			pc:calcStat()
			pc:status()
			player:sendMinitext("Done!")
			user_pages_status.click(player, npc)
		end
	elseif change == "Totem  : "..totem then
		totem = player:menuString("Change to ?", {"Jujak", "Baekho", "Hyunmoo", "Chungryong"})
		if totem ~= nil then
			if totem == "Jujak" then
				pc.totem = 0		
			elseif totem == "Baekho" then
				pc.totem = 1			
			elseif totem == "Hyunmoo" then
				pc.totem = 2			
			elseif totem == "Chungryong" then
				pc.totem = 3		
			end
			pc:sendStatus()
			player:sendMinitext("Done!")
			user_pages_status.click(player, npc)
		end
	elseif change == "Base Vita   : "..format_number(pc.baseHealth) then	
		if player.registry["can_alter_stats"] == 1 or player.ID == 2 or player.ID == 18 then
			vita = player:input("Change Vita ("..format_number(pc.baseHealth)..") to?")		
			if tonumber(vita) > 0 then		
				pc.baseHealth = tonumber(vita)			
				pc:sendStatus()
				pc:calcStat()
				player:sendMinitext("Done!")
				user_pages_status.click(player, npc)					
			end		
		else
			player:dialogSeq({t, "You can not do that!"}, 1)
			user_pages_status.click(player, npc)
			Player(2):msg(4, "[Alter Stats]: "..player.name.." is try to changing "..pc.name.."'s Vita!", Player(2).ID)
		end
	elseif change == "Base Mana   : "..format_number(pc.baseMagic) then
		if player.registry["can_alter_stats"] == 1 or player.ID == 2 or player.ID == 18 then
			mana = player:input("Change Magic ("..format_number(pc.baseMagic)..") to?")		
			if tonumber(mana) > 0 then		
				pc.baseMagic = tonumber(mana)
				pc:sendStatus()
				pc:calcStat()		
				player:sendMinitext("Done!")
				user_pages_status.click(player, npc)					
			end		
		else
			player:dialogSeq({t, "You can not do that!"}, 1)
			user_pages_status.click(player, npc)
			Player(2):msg(4, "[Alter Stats]: "..player.name.." is try to changing "..pc.name.."'s Mana!", Player(2).ID)
		end
	elseif change == "Skin   : "..pc.skinColor then		
		skin = player:input("Change "..pc.name.." Skin "..pc.skinColor.." to?")		
		if tonumber(skin) >= 0 then
			pc.skinColor = tonumber(skin)
			pc:sendStatus()
			player:refresh()
			pc:calcStat()
			player:sendMinitext("Done!")
			user_pages_status.click(player, npc)		
		end		
	elseif change ==  "Gender : "..gender then		
		gen = player:menuString("Change "..pc.name.."'s gender to?",{"Male", "Female"})
		if gen ~= nil then
			if gen == "Male" then
				pc.sex = 0
			elseif gen == "Female" then
				pc.sex = 1
			end
			pc:calcStat()
			pc:updateState()
			pc:status()
			player:sendMinitext("Done!")
			user_pages_status.click(player, npc)
		end
			
	elseif change == "Title  : "..pc.title then		
		title = player:input("Change Title "..pc.title.." to?")		
		title = tostring(title)		
		if string.len(tostring(title)) > 0 and string.len(tostring(title)) <= 12 then		
			pc.title = tostring(title)		
			pc:calcStat()		
			player:sendMinitext("Done!")
			user_pages_status.click(player, npc)					
		end		
	elseif change == "Base Might  : "..pc.might then	
		might = player:input("Change Might ("..pc.might..") to?")	
		if tonumber(might) >= 0 then		
			pc.registry["base_might"] = tonumber(might)
			player:sendMinitext("Done!")
			user_pages_status.click(player, npc)					
		end					
	elseif change == "Base Will   : "..pc.will then		
		will = player:input("Change Will ("..pc.will..") to?")		
		if tonumber(will) >= 0 then		
			pc.registry["base_will"] = tonumber(will)	
			player:sendMinitext("Done!")
			user_pages_status.click(player, npc)					
		end		
	elseif change == "Base Grace  : "..pc.grace then		
		grace = player:input("Change Grace ("..pc.grace..") to?")		
		if tonumber(grace) >= 0 then		
			pc.registry["base_grace"] = tonumber(grace)	
			player:sendMinitext("Done!")
			user_pages_status.click(player, npc)					
		end		
	elseif change == "Exp    : "..format_number(pc.exp) then		
		if player.registry["can_alter_stats"] == 1 or player.ID == 2 or player.ID == 18 then
			exp = player:input("Change Exp ("..format_number(pc.exp)..") to?")		
			if tonumber(exp) >= 0 then		
				pc.exp = tonumber(exp)
				pc:sendStatus()
				pc:calcStat()
				player:sendMinitext("Done!")
				user_pages_status.click(player, npc)				
			end	
		else
			player:dialogSeq({t, "You can not do that!"}, 1)
			user_pages_status.click(player, npc)
			Player(2):msg(4, "[Alter Stats]: "..player.name.." is try to changing "..pc.name.."'s Experience!", Player(2).ID)
		end
	elseif change == "Regen  : "..pc.regen then
		if player.registry["can_alter_stats"] == 1 or player.ID == 2 then
			regen = player:input("Change Regen ("..pc.regen..") to?")		
			if tonumber(regen) >= 0 then		
				pc.regen = tonumber(regen)
				pc:sendStatus()
				pc:calcStat()
				player:sendMinitext("Done!")
				user_pages_status.click(player, npc)						
			end
		else
			player:dialogSeq({t, "You can not do that!"}, 1)
			user_pages_status.click(player, npc)
			Player(2):msg(4, "[Alter Stats]: "..player.name.." is try to changing "..pc.name.."'s Regen!", Player(2).ID)
		end		
	elseif change == "vRegen : "..pc.vRegen then
		if player.registry["can_alter_stats"] == 1 or player.ID == 2 then
			v = player:input("Change vRegen ("..pc.vRegen..") to?")		
			if tonumber(v) >= 0 then		
				pc.vRegen = tonumber(v)
				pc:sendStatus()
				pc:calcStat()		
				player:sendMinitext("Done!")
				user_pages_status.click(player, npc)					
			end
		else
			player:dialogSeq({t, "You can not do that!"}, 1)
			user_pages_status.click(player, npc)
			Player(2):msg(4, "[Alter Stats]: "..player.name.." is try to changing "..pc.name.."'s vRegen!", Player(2).ID)
		end			
	elseif change ==  "mRegen : "..pc.mRegen then
		if player.registry["can_alter_stats"] == 1 or player.ID == 2 then
			m = player:input("Change mRegen ("..pc.mRegen..") to?")		
			if tonumber(m) >= 0 then		
				pc.mRegen = tonumber(m)
				pc:sendStatus()
				pc:calcStat()		
				player:sendMinitext("Done!")
				user_pages_status.click(player, npc)					
			end
		else
			player:dialogSeq({t, "You can not do that!"}, 1)
			user_pages_status.click(player, npc)
			Player(2):msg(4, "[Alter Stats]: "..player.name.." is try to changing "..pc.name.."'s mRegen!", Player(2).ID)
		end		
	elseif change == "Reset" then
		if player.registry["can_alter_stats"] == 1 or player.ID == 2 then
			a = player:menuString("This option will reset all the stat of "..pc.name.." to Level 1", {"Yes", "No"})		
			if a == "Yes" then		
				pc.exp = 0		
				pc:giveXP(1)		
				pc.baseMight = 1		
				pc.baseGrace = 1		
				pc.baseWill = 1		
				pc.baseAC = 75		
				pc.baseResist = 75		
				pc.baseHealth = 100		
				pc.baseMagic = 100		
				pc.baseRegen = 0		
				pc.baseVRegen = 0		
				pc.baseMRegen = 0		
				pc.baseMinDam = 0		
				pc.baseMaxDam = 0		
				pc.basePhysDeduct = 0		
				pc.baseProtection = 0		
				pc.baseSpeed = 80			
				pc.weapDuraMod = 1			
				pc.armorDuraMod = 1			
				pc.registry["base_might"] = 0			
				pc.registry["base_grace"] = 0			
				pc.registry["base_will"] = 0			
				pc.registry["base_ac"] = 0			
				pc.registry["base_mr"] = 0			
				pc.registry["base_vita"] = 0			
				pc.registry["base_mana"] = 0			
				pc.registry["base_regen"] = 0			
				pc.registry["base_vregen"] = 0			
				pc.registry["base_mregen"] = 0			
				pc.registry["base_mindam"] = 0			
				pc.registry["base_maxdam"] = 0			
				pc.registry["base_pd"] = 0			
				pc.registry["base_prot"] = 0			
				pc.registry["base_speed"] = 0			
				pc.registry["base_wdm"] = 0			
				pc.registry["base_adm"] = 0			
				pc.ap = 0			
				pc.sp = 0			
				pc.level = 1			
				pc.class = 0			
				pc:calcStat()			
				pc.health = pc.maxHealth			
				pc.magic = pc.maxMagic			
				pc:calcStat()			
				player:sendMinitext("Done!")
				user_pages_status.click(player, npc)
			end
		else
			player:dialogSeq({t, "You can not do that!"}, 1)
			user_pages_status.click(player, npc)
			Player(2):msg(4, "[Alter Stats]: "..player.name.." is trying to reset "..pc.name.."'s character status!", Player(2).ID)		
		end	
	end
end
}




