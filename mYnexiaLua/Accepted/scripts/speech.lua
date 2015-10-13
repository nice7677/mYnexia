onSay = function(player)

	local printf = 1
	local caps = 0
	local speech = player.speech
	local p = player
	
	if (speech == "") then return end
	local lspeech = string.lower(player.speech)
	local length = string.len(lspeech)
	local online = {}
	local talkType = player.talkType
	online = player:getUsers()

	if player.gmLevel >= 98 then --[[ GM Command ]]---------------------------------------------------------------												

-- Gateway --															-- Gateway
		if string.match(lspeech, "/g (.+)") ~= nil then
			gate = string.match(lspeech, "/g (.+)")
			region = player.region
			if gate == "u" or gate == "n" then
				gateWarp(player, region, "u")
			elseif gate == "s" then
				gateWarp(player, region, "s")
			elseif gate == "b" then
				gateWarp(player, region, "b")
			elseif gate == "t" then
				gateWarp(player, region, "t")
			end
			printf = 0
		end	

	
		if tonumber(string.match(lspeech, "/mon (%d+)")) ~= nil then
			mon = tonumber(string.match(lspeech, "/mon (%d+)"))
			player:spawn(mon, player.x, player.y, 1)
			get = player:getObjectsInCell(player.m, player.x, player.y)
			if #get > 0 then
				for i = 1, #get do
					player:sendMinitext("Spawned 1 "..Mob(get[i]).name.."")
				end
			end
			printf = 0
		end
	
-- Ability to walk through the walls switch on/off for GM
		if lspeech == "/ww" then
			player.optFlags = 128
			player:refresh()
			player:updateState()
			player:sendStatus()
			player:sendMinitext("You use ww!")
			printf = 0
		end		
	
-- Flush Aethers --	
		if lspeech == "/flush" then
			player:flushAether()
			player:msg(0, "All aethers / delayed spells are flushed!", player.ID)
			printf = 0
		end

-- gfx Toggle switch on/off --		
		if lspeech == "/gfxtoogle" or lspeech == "/gfx" then															
			gfx_switch.cast(player)
			if player.gfxClone == 0 then
				player:sendMinitext("GFX toogle: OFF")
			elseif player.gfxClone == 1 then
				player:sendMinitext("GFX toogle: ON")
			end
			printf = 0
		end	

-- Switch to on/off how mobs are detecting a GM
		if lspeech == "/mobmaster" then
			if player.registry["mob_can_detect"] == 0 then
				player.registry["mob_can_detect"] = 1
				player:sendMinitext("Mob master : ON")
			elseif player.registry["mob_can_detect"] == 1 then
				player.registry["mob_can_detect"] = 0
				player:sendMinitext("Mob master : OFF")
			end
			printf = 0
		end

-- Change Totem --  Totem:  (0)JuJak, (1)Baekho, (2)Hyun Moo, (3)Chung Ryong, (4)Nothing
		for i = 0, 3 do																		
			if string.match(string.lower(player.speech), "/totem "..i) then
				player.totem = i
				player:sendMinitext("Totem: "..i)
				player:sendStatus()
				player:status()
				player:calcStat()
				player:updateState()
				printf = 0
			end
		end

-- Switch to on/off GM chat channel
		if (lspeech=="/gmc") then
			if (player.registry["gm_talk"]== 0) then
				player.registry["gm_talk"] = 1
				player:sendMinitext("GM Chat on.")
			else
				player.registry["gm_talk"] = 0
				player:sendMinitext("GM Chat off.")
			end
			printf = 0
		elseif (player.registry["gm_talk"]== 1) then
			if (string.byte(lspeech,1) == 47) then
			else
				player.speech = "/gm "..speech..""
			end
		end

-- test action 1,2,3,4,5,etc...		
		for i = 1, 32 do
			if string.match(string.lower(player.speech), "/act "..i) then
				player:sendAction(i, 60)
				printf = 0
			end
		end

-- Clean floor -- remove all items around on ground
		if player.speech == "/cfloor" then
			item = player:getObjectsInArea(BL_ITEM)
			if #item > 0 then
				for i = 1, #item do
					if distanceSquare(player, item[i], 5) then
						item[i]:delete()
						player:sendAction(6, 20)
					end
				end
			end
			player:talk(1, "Sweeping time!!")
		end
		
-- Add Gold 		
		if tonumber(string.match(lspeech, "/gold (%d+)")) ~= nil then
			if tonumber(string.match(lspeech, "/gold (%d+)")) < 0 
			or player.money + tonumber(string.match(lspeech, "(%d+)")) > 3000000000 then
				anim(player)
				player:sendMinitext("Over limit!")
				return
			end
			player:addGold(tonumber(string.match(lspeech, "/gold (%d+)")))
			player:sendMinitext("Added "..format_number(tonumber(string.match(lspeech, "/gold (%d+)"))).." coins")
			printf = 0
		end
	end
		

-- Sensitive commands!!		
	if player.ID == 2 then
	
		if (string.match(lspeech,"/tile (%d+)") ~= nil) then
			local j = string.match(lspeech,"/tile (%d+)")
			local x,y
			j = j * 1
			x = (j / 11) + 1
			y = (j % 11)
			if (y == 0) then
				y = y + 11
				x = x - 1
			end
		--	player:warp(10001,x,y)
			player:talk(0,"Tile "..j.." found.")
			printf=0
		elseif (string.match(player.speech, "/testmap (.+)") ~= nil and string.sub(player.speech, 1, 8) == "/testmap") then
			local map = string.match(player.speech, "/testmap (.+)")
			local mapNum = 30000 + player.ID
			
			if (string.byte(map, string.len(map) - 3) == 46) then
				os.execute("cd ../mYnexiaMaps;svn up;cd ../mynexia")
				setMap(mapNum, "../mYnexiaMaps/"..map)
				player:warp(mapNum, 5, 5)
				player.spell = 1
			else
				player:sendMinitext("Only .map is supported, sorry.")
			end	
			printf = 0
		end
		-- Mapper End
		
		if (lspeech == "/reload") and player.ID == 2 then
			-- os.execute("cd ../mYnexiaMaps;svn up;cd ../mYnexiaLua; svn up; cd ../mynexia; svn up")
			-- player.speech = "/reload"
			-- player:gmMsg("<Console>: "..player.name.." has svn up and reloaded the server.", 50)
			-- os.execute("echo "..player.name.." has SVN UP and RELOADED server.")
			
		elseif (lspeech == "svn up") then
			os.execute("cd ../mYnexiaMaps;svn up;cd ../mYnexiaLua; svn up; cd ../mynexia; svn up")
			player:gmMsg("<Console>: "..player.name.." has svn up the server.", 50)
			os.execute("echo "..player.name.." has SVN UP the server.")
			printf = 0
		elseif lspeech == "/metan" then
			os.execute("./metan")
			player:gmMsg("<Console>: "..player.name.." has used ./metan", 50)
			os.execute("echo "..player.name.." has used ./metan")
			printf = 0
		elseif lspeech == "/make map" then
			os.execute("svn up")
			player:gmMsg("<Console>: "..player.name.." has begun SVN UP + MAP compile.", 50)
			player.gameRegistry["make"] = os.time()
			os.execute("make map")
			local make = os.difftime(os.time(),player.gameRegistry["make"])
			if (make < 4) then
				player:gmMsg("<Console>: Compilation ERROR on MAP by "..player.name.." ("..make..")", 50)
			else
				player:gmMsg("<Console>: "..player.name.." has SVN UP & compiled map in "..make.." seconds.", 50)
				os.execute("echo "..player.name.." has svn up and compiled map.")
			end
			printf = 0
		elseif (lspeech == "/make char") then
			os.execute("svn up")
			player:gmMsg("<Console>: "..player.name.." has begun SVN UP + CHAR compile.", 50)
			player.gameRegistry["make"] = os.time()
			os.execute("make char")
			local make = os.difftime(os.time(),player.gameRegistry["make"])
			player:gmMsg("<Console>: "..player.name.." has SVN UP & compiled char in "..make.." seconds.", 50)
			os.execute("echo "..player.name.." has svn up and compiled char.")
			printf = 0
		elseif (lspeech == "/make login") then
			os.execute("svn up")
			player:gmMsg("<Console>: "..player.name.." has begun SVN UP + LOGIN compile.", 50)
			player.gameRegistry["make"] = os.time()
			os.execute("make login")
			local make = os.difftime(os.time(),player.gameRegistry["make"])
			player:gmMsg("<Console>: "..player.name.." has SVN UP & compiled LOGIN in "..make.." seconds.", 50)
			os.execute("echo "..player.name.." has svn up and compiled login.")
			printf = 0
		elseif (speech=="nside")then
			if (player.side == -2) then
				player:sendMinitext("Skipping -1.")
				player.side = 0
				return
			end
			player.side = player.side + 1
			player:sendSide()
			printf = 0
		elseif (speech=="pside")then
			if (player.side == 0) then
				player:sendMinitext("Can't have negative side.")
				return
			end
			player.side = player.side - 1
			player:sendSide()
			printf = 0			
		elseif (speech=="side")then
			player:sendMinitext("Side: "..player.side)
			printf = 0			
		end
	end -- END OF SPECIAL COMMAND

	
	if player.registry["team_iseng2"] > 0 or player.ID == 2 then
		local say = {"nweap", "pweap", "weap", "narmor", "parmor", "armor", "nshield", "pshield", "shield", "nhelm", "phelm", "helm", "ncape", "pcape", "cape", "ncrown", "pcrown", "crown", "nface", "pface", "face", "nboots", "pboots", "boots", "nneck", "pneck", "neck", "nfacea", "pfacea", "facea", "nfaceat", "pfaceat", "faceat", "nhair", "phair", "hair","nsdye","psdye"}
		local name = {"Weapon", "Weapon", "Weapon", "Armor", "Armor", "Armor", "Shield", "Shield", "Shield", "Helmet", "Helmet", "Helmet", "Cape", "Cape", "Cape", "Crown", "Crown", "Crown", "Face", "Face", "Face", "Boots", "Boots", "Boots", "Necklace", "Necklace", "Necklace", "Face Accessory", "Face Accessory", "Face Accessory", "Face AccessoryT", "Face AccessoryT", "Face AccessoryT", "Hair", "Hair", "Hair"}
		local var = {p.gfxWeap, p.gfxWeap, p.gfxWeap, p.gfxArmor, p.gfxArmor, p.gfxArmor, p.gfxShield, p.gfxShield, p.gfxShield, p.gfxHelm, p.gfxHelm, p.gfxHelm, p.gfxCape, p.gfxCape, p.gfxCape, p.gfxCrown, p.gfxCrown, p.gfxCrown, p.gfxFace, p.gfxFace, p.gfxFace, p.gfxBoots, p.gfxBoots, p.gfxBoots, p.gfxNeck, p.gfxNeck, p.gfxNeck, p.gfxFaceA, p.gfxFaceA, p.gfxFaceA, p.gfxFaceAT, p.gfxFaceAT, p.gfxFaceAT, p.gfxHair, p.gfxHair, p.gfxHair}
		local x	


		if tonumber(string.match(lspeech, "obj (%d+)")) ~= nil then
			obj = tonumber(string.match(lspeech, "obj (%d+)"))
			object.setFacingObject(player, "set", obj)
			printf = 0
			
		elseif (speech == "nobj") then
			object.next_prev(player, "next")
			printf = 0
			
		elseif (speech == "pobj") then
			object.next_prev(player, "prev")
			printf = 0
			
		elseif lspeech == "cobj" then
			object.setFacingObject(player, "del", 0)
			printf = 0
		
		elseif (lspeech == "obj") then
			object.getObject(player)
			printf = 0
			
		elseif (lspeech == "tile") then
			player:talk(0, "Tile: "..getTile(player.m, player.x, player.y))
			printf = 0
			
		elseif (speech == "ntile") then
			if (getTile(p.m, p.x, p.y) == 38108) then
				player:sendMinitext("You are at the last tile: 38108")
			else
				setTile(p.m, p.x, p.y, getTile(p.m, p.x, p.y) + 1)
				player:sendMinitext("Tile : "..getTile(p.m, p.x, p.y))
			end
			printf = 0
		elseif (speech == "ptile") then
			if (getTile(p.m, p.x, p.y) == 0) then
				player:sendMinitext("You are at the first tile: 0")
			else
				setTile(p.m, p.x, p.y, getTile(p.m, p.x, p.y) - 1)
				player:sendMinitext("Tile : "..getTile(p.m, p.x, p.y))
			end
			printf = 0
		end	
	
		
-- Warps to specified map with coordinates		
		if (string.match(lspeech, "warp (%d+ %d+ %d+)") ~= nil and string.sub(lspeech, 1, 4) == "warp") then
			local map = tonumber(string.match(player.speech, "warp (%d+) %d+ %d+"))
			local x = tonumber(string.match(player.speech, "warp %d+ (%d+) %d+"))
			local y = tonumber(string.match(player.speech, "warp %d+ %d+ (%d+)"))	
			player:warp(map, x, y)
			printf = 0
		end	

		-- Forget spell
		if string.match(lspeech, "/del (.+)") ~= nil then
			spell = string.match(lspeech, "/del (.+)")
			if player:hasSpell(spell) then
				player:removeSpell(spell)
				player:sendMinitext("Done!!")
			end
			printf = 0
		end
		
-- Summon		
		if string.match(lspeech, "/sum (.+)") ~= nil then
			sum = tostring(string.match(lspeech, "/sum (.+)")) target = Player(sum)
			if target ~= nil then
				if target.registry["being_summon"] == 0 then
					target:warp(player.m, player.x, player.y)
					target:sendAnimation(16)
					player:playSound(29)
				end
			else
				anim(player)
				player:sendMinitext("User not found!")
			end
			printf = 0
		end

		if lspeech == "/totalmob" then
			mob = player:getObjectsInMap(player.m, BL_MOB)
			player:talk(2, "#Mobs : "..#mob)
			player:sendMinitext("#Mobs : "..#mob)
			printf = 0
		elseif lspeech == "/totalitem" then
			item = player:getObjectsInMap(player.m, BL_ITEM)
			player:talk(2, "#Items : "..#item)
			player:sendMinitext("#items : "..#item)
			printf = 0
		end
		
	
		if (lspeech == "pass") then
			local pass = getPass(player.m, player.x, player.y)
			local string2
			if pass == 0 then
				string2 = "True"
			elseif pass == 1 then
				string2 = "False"
			end
			player:talk(2, "Pass: "..string2)
			printf = 0
		end		

-- Increase Speed
	
		for i = 0, 100 do
			if string.match(string.lower(player.speech), "/ms "..i) then
				player.speed = i
				player:sendMinitext("Move Speed : "..i)
				player:updateState()
				printf = 0
			end
		end

		
-- Approach 		
		if string.match(lspeech, "/app (.+)") ~=nil then
			app = tostring(string.match(lspeech, "/app (.+)")) target = Player(app)				
			if target ~= nil then
				if target.registry["being_approach"] == 0 then
					player:warp(target.m, target.x, target.y)
					player:sendAnimation(16)
					player:playSound(29)
				end
			else
				anim(player)
				player:sendMinitext("user not found!")
			end
			printf = 0
		end

-- Get spells --
		if string.match(lspeech, "/s (.+)") ~= nil then											
			spell = string.match(lspeech, "/s (.+)")
			if not player:hasSpell(spell) then
				player:addSpell(spell)
				player:sendminitext("New spell added!")
			else
				anim(player)
				player:sendMinitext("You're already has that spell!")				
			end
			printf = 0
		end		
		
-- GFX Color
		if lspeech == "hairc" then
			player:sendMinitext("Hair color: "..p.gfxHairC)
			printf = 0
		end
		if lspeech == "nhairc" then
			p.gfxHairC = p.gfxHairC +1
			player:sendMinitext("Hair color: "..p.gfxHairC)
			printf = 0
			player:updateState()
		end
		if lspeech == "phairc" then
			p.gfxHairC = p.gfxHairC -1
			player:sendMinitext("Hair color: "..p.gfxHairC)
			printf = 0
			player:updateState()
		end
		if lspeech == "nweapc" then
			p.gfxWeapC = p.gfxWeapC +1
			player:sendMinitext("Weapon Color: "..player.gfxWeapC)
			printf = 0
			player:updateState()
		end
		if lspeech == "pweapc" then
			p.gfxWeapC = p.gfxWeapC - 1
			player:sendMinitext("Weappn Color: "..player.gfxWeapC)
			printf = 0
			player:updateState()
		end
		if lspeech == "narmorc" then
			p.gfxArmorC = p.gfxArmorC + 1
			player:sendMinitext("Armor Color: "..player.gfxArmorC)
			printf = 0
			player:updateState()
		end
		if lspeech == "parmorc" then
			p.gfxArmorC = p.gfxArmorC - 1
			player:sendMinitext("Armor Color: "..player.gfxArmorC)
			printf = 0
			player:updateState()
		end
		if lspeech == "ncrownc" then
			p.gfxCrownC = p.gfxCrownC +1
			player:sendMinitext("Crown Color: "..player.gfxCrownC)
			printf = 0
			player:updateState()
		end
		if lspeech == "pcrownc" then
			p.gfxCrownC = p.gfxCrownC - 1
			player:sendMinitext("Crown Color: "..player.gfxCrownC)
			printf = 0
			player:updateState()
		end
		if lspeech == "crownc" then
			player:sendMinitext("Crown Color: "..player.gfxCrownC)
			printf = 0
		end
		if lspeech == "armorc" then
			player:sendMinitext("Armor Color: "..player.gfxArmorC)
			printf = 0
		end
		if lspeech == "weapc" then
			player:sendMinitext("Weapon Color: "..player.gfxWeapC)
			printf = 0
		end

		for x = 1, #say do
			if (lspeech==""..say[x] or string.match(lspeech, ""..say[x].." (%d+)") ~= nil or string.match(lspeech, ""..say[x].." %d+ (%d+)") ~= nil) and string.sub(lspeech, 0, string.len(say[x])) == say[x] then
				local nn = 0
				local x2 = x - 2
				
				if x%3 == 0 then
-- GFX Look
					if string.match(lspeech, ""..say[x].." (%d+)") ~= nil then
						vn = tonumber(string.match(lspeech, ""..say[x].." (%d+)"))
						if x == 3 		then p.gfxWeap = vn
							elseif x == 6 then p.gfxArmor = vn
							elseif x == 9 then p.gfxShield = vn
							elseif x == 12 then p.gfxHelm = vn
							elseif x == 15 then p.gfxCape = vn
							elseif x == 18 then p.gfxCrown = vn
							elseif x == 21 then p.gfxFace = vn
							elseif x == 24 then p.gfxBoots = vn
							elseif x == 27 then p.gfxNeck = vn
							elseif x == 30 then p.gfxFaceA = vn
							elseif x == 33 then p.gfxFaceAT = vn
							elseif x == 36 then p.gfxHair = vn
						end
-- GFX Look Color						
						if string.match(lspeech, ""..say[x].." %d+ (%d+)") ~= nil then
							vnc = tonumber(string.match(lspeech, ""..say[x].." %d+ (%d+)"))
							if x == 3 then p.gfxWeapC = vnc
								elseif x == 6 then p.gfxArmorC = vnc
								elseif x == 9 then p.gfxShieldC = vnc
								elseif x == 12 then p.gfxHelmC = vnc
								elseif x == 15 then p.gfxCapeC = vnc
								elseif x == 18 then p.gfxCrownC = vnc
								elseif x == 21 then p.gfxFaceC = vnc
								elseif x == 24 then p.gfxBootsC = vnc
								elseif x == 27 then p.gfxNeckC = vnc
								elseif x == 30 then p.gfxFaceAC = vnc
								elseif x == 33 then p.gfxFaceATC = vnc
								elseif x == 36 then p.gfxHairC = vnc
							end
						end

						player:updateState()
						player:sendMinitext(""..name[x].." Number: "..vn.." Color: "..vnc.."")
					elseif lspeech == say[x] then
						player:sendMinitext(""..name[x].." GFX: "..var[x])
					end
					nn = 1
				end			
			if nn == 0 then	
				if x2 % 3 == 0 then	
					if var[x] == 65535 then	
						player:sendMinitext("You have reached the minimum of  "..name[x].." GFX; -1.")	
					else	
						if x <= 3 then	
							if var[x] == 10000 then p.gfxWeap = 385	
								elseif var[x] == 20000 then p.gfxWeap = 10122	
								elseif var[x] == 30000 then p.gfxWeap = 20129	
							else	
								p.gfxWeap = var[x] - 1	
							end	
						elseif x <= 6 then	
							if var[x] == 10000 then	
								p.gfxArmor = 344	
							else	
								p.gfxArmor = var[x] - 1	
							end	
						elseif x <= 9 then	
							if var[x] == 10000 then	
								p.gfxShield = 50	
							else	
								p.gfxShield = var[x] - 1	
							end	
						elseif x <= 12 then p.gfxHelm = var[x] - 1	
						elseif x <= 15 then p.gfxCape = var[x] - 1	
						elseif x <= 18 then p.gfxCrown = var[x] - 1	
						elseif x <= 21 then p.gfxFace = var[x] - 1	
						elseif x <= 24 then p.gfxBoots = var[x] - 1	
						elseif x <= 27 then p.gfxNeck = var[x] - 1	
						elseif x <= 30 then p.gfxFaceA = var[x] - 1	
						elseif x <= 33 then p.gfxFaceAT = var[x] - 1	
						elseif x <= 36 then	
							p.gfxHair = var[x] - 1	
						end	
						player:updateState()	
						player:sendMinitext(""..name[x].." Number: "..(var[x] - 1).."")	
					end						
				else	
					if x <= 3 then	
						if var[x] == 385 then p.gfxWeap = 10000	
							elseif var[x] == 10122 then p.gfxWeap = 20000	
							elseif var[x] == 20129 then p.gfxWeap = 30000	
						else	
							p.gfxWeap = var[x] + 1	
						end	
					elseif x <= 6 then	
						if var[x] == 344 then p.gfxArmor = 10000 else p.gfxArmor = var[x] + 1 end	
					elseif x <= 9 then	
						if var[x] == 50 then p.gfxShield = 10000 else p.gfxShield = var[x] + 1 end	
					elseif x <= 12 then p.gfxHelm = var[x] + 1	
					elseif x <= 15 then p.gfxCape = var[x] + 1	
					elseif x <= 18 then p.gfxCrown = var[x] + 1	
					elseif x <= 21 then p.gfxFace = var[x] + 1	
					elseif x <= 24 then p.gfxBoots = var[x] + 1	
					elseif x <= 27 then p.gfxNeck = var[x] + 1	
					elseif x <= 30 then p.gfxFaceA = var[x] + 1	
					elseif x <= 33 then p.gfxFaceAT = var[x] + 1	
					elseif x <= 36 then p.gfxHair = var[x] + 1	
					end	
					player:updateState()	
					player:sendMinitext(""..name[x].." Number: "..(var[x] + 1).."")	
				end	
			end
			printf = 0
			break
			end
		end

-- Icon viewer
		if (string.match(lspeech, "icon (%d+)") ~= nil and string.match(lspeech, "icon %d+ (%d+)") == nil) then
			local x = tonumber(string.match(lspeech, "icon (%d+)"))
			player.registry["gfx_icons"] = x
			player.registry["gfx_icons_color"] = 0
			async(iconViewer(player, "n"))
			printf = 0
		elseif (string.match(lspeech, "icon %d+ (%d+)") ~= nil) then
			local x = tonumber(string.match(lspeech, "icon (%d+)"))
			local y = tonumber(string.match(lspeech, "icon %d+ (%d+)"))
			player.registry["gfx_icons"] = x
			player.registry["gfx_icons_color"] = y
			async(iconViewer(player, "nc"))
			printf = 0
		elseif (lspeech == "nicon") then
			async(iconViewer(player, "n"))
			printf = 0
		elseif (lspeech == "picon") then
			async(iconViewer(player, "p"))
			printf = 0
		elseif (lspeech == "niconc") then
			async(iconViewer(player, "nc"))
			printf = 0
		elseif (lspeech == "piconc") then
			async(iconViewer(player, "pc"))
			printf = 0
			
-- Change disguise / mob look (must on state 4)
		elseif (speech=="ndis") then
			if ( player.disguise > 1449 or player.disguise < 1 ) then
                                player.disguise = 1
				player:sendMinitext("You may not go over 1449 on disguise.")
				return
			end
			if (player.disguise == 1508) then
				player:sendMinitext("You may not go over 1508 on disguise.")
				return
			end
			local oldstate = player.state
			
			player.state = 0
			player:updateState()
			if (player.disguise == 1341) or (player.disguise == 1393) then
				player.disguise = player.disguise + 2
			else
				player.disguise = player.disguise + 1
			end
			player.state = oldstate
			player:updateState()
			player:sendMinitext("Disguise #: "..player.disguise)
			printf = 0
		elseif (speech=="pdis") then
			if (player.disguise == 0) then
				player:sendMinitext("You may not have negative disguise.")
				return
			end
			local oldstate = player.state
			
			player.state = 0			
			player:updateState()
			if (player.disguise == 1343) or (player.disguise == 1395) then
				player.disguise = player.disguise - 2
			else
				player.disguise = player.disguise - 1
			end
			player.state = oldstate
			player:updateState()
			player:sendMinitext("Disguise #: "..player.disguise)
			printf = 0
		elseif (speech=="dis")then
			player:sendMinitext("Disguise #: "..player.disguise)
			printf = 0
			--Disguise Color
		elseif (string.match(speech, "dis (%d+)") ~= nil and string.sub(speech, 0, 3) == "dis") then
			local oldstate = player.state
				
			player.state = 0
			player:updateState()
			
			if (tonumber(string.match(speech, "dis (%d+)")) < 0 or tonumber(string.match(speech, "dis (%d+)")) == 1342 or tonumber(string.match(speech, "dis (%d+)")) == 1394) then
				player:sendMinitext("Disguise not allowed.")
			else
				player.disguise = tonumber(string.match(speech, "dis (%d+)"))
			end
			
			player.state = oldstate
			player:updateState()
			printf = 0
		elseif (speech=="ndisc") then
			if (player.disguiseColor == 255) then
				player:sendMinitext("You may not go over 255 on disguiseColor.")
				return
			end
			local oldstate = player.state
			
			player.state = 0
			player:updateState()
			player.disguiseColor = player.disguiseColor + 1
			player.state = oldstate
			player:updateState()
			player:sendMinitext("Disguise Color #: "..player.disguiseColor)
			printf = 0
		elseif (speech=="pdisc") then
			if (player.disguiseColor == 0) then
				player:sendMinitext("You may not have negative disguise color.")
				return
			end
			local oldstate = player.state
			
			player.state = 0			
			player:updateState()
			player.disguiseColor = player.disguiseColor - 1
			player.state = oldstate
			player:updateState()
			player:sendMinitext("Disguise Color #: "..player.disguiseColor)
			printf = 0
		elseif (speech=="disc")then
			player:sendMinitext("Disguise Color #: "..player.disguiseColor)
			printf = 0			

-- Change armor color / dye	--		
		elseif (speech=="ndye")then
			if (player.gfxClone == 1) then
				player.gfxDye = player.gfxDye + 1
			else
				player.armorColor = player.armorColor + 1
			end
			
			player:refresh()
			printf = 0
		elseif (speech=="pdye")then
			if (player.gfxClone == 1) then
				player.gfxDye = player.gfxDye - 1
			else
				player.armorColor = player.armorColor - 1
			end
			
			player:refresh()
			printf = 0
			
		elseif (speech=="nsdye")then 
			if (player.gfxClone == 1) then
				player.gfxShieldC = player.gfxShieldC + 1
			else
				player.armorColor = player.armorColor + 1
			end
			
			player:refresh()
			printf = 0
		elseif (speech=="psdye")then
			--player:talk(0,"what the "..player.gfxClone)
			if (player.gfxClone == 1) then
				
				player.gfxShieldC = player.gfxShieldC - 1
			else
				player.armorColor = player.armorColor - 1
			end
			
			player:refresh()
			printf = 0
		elseif (speech=="sdye")then
			--player:talk(0,"what the "..player.gfxClone)
			if (player.gfxClone == 1) then
				player:sendMinitext("gfxShieldC: "..player.gfxShieldC)
			else
				player.armorColor = player.armorColor - 1
			end
			
			player:refresh()
			printf = 0
		elseif (speech=="dye")then
			if (player.gfxClone == 1) then
				player:sendMinitext("gfxDye: "..player.gfxDye)
			else
				player:sendMinitext("Dye: "..player.armorColor)
			end
			
			printf = 0
		elseif (string.match(speech, "dye (%d+)") ~= nil and string.sub(speech, 0, 3) == "dye") then
			if (player.gfxClone == 1) then
				player.gfxDye = tonumber(string.match(speech, "dye (%d+)"))
			else
				player.armorColor = tonumber(string.match(speech, "dye (%d+)"))
			end
			
			player:refresh()
			printf = 0

-- Change skin color			
		elseif (speech=="nskin")then
			if (player.gfxClone == 1) then
				player.gfxSkinC = player.gfxSkinC + 1
			else
				player.skinColor = player.skinColor + 1
			end
			
			player:updateState()
			printf = 0
		elseif (speech=="pskin")then
			if (player.gfxClone == 1) then
				player.gfxSkinC = player.gfxSkinC - 1
			else
				player.skinColor = player.skinColor - 1
			end
			
			player:updateState()
			printf = 0			
		elseif (speech=="skin")then
			if (player.gfxClone == 1) then
				player:talk(0, "gfxSkinC: "..player.gfxSkinC)
			else
				player:talk(0,"Skin color: "..player.skinColor)
			end	
			printf = 0

		elseif (string.match(speech, "skin (%d+)") ~= nil and string.sub(speech, 0, 4) == "skin") then
			if (player.gfxClone == 1) then
				player.gfxSkinC = tonumber(string.match(speech, "skin (%d+)"))
			else
				player.skinColor = tonumber(string.match(speech, "skin (%d+)"))
			end
			
			player:updateState()
			printf = 0

-- Browse spells animation 			
		elseif (speech=="nspell") then
			if (player.registry["gfx_spell"] == 427) then
				player:sendMinitext("You may not go over 427 on spell graphics.")
			else
				player.registry["gfx_spell"] = player.registry["gfx_spell"] + 1
			--	player:sendAnimation(player.registry["gfx_spell"])
				player:selfAnimation(player.ID, player.registry["gfx_spell"], 0)
				player:sendMinitext("Spell #: "..player.registry["gfx_spell"])
			end
			
			printf = 0
		elseif (speech=="pspell") then
			if (player.registry["gfx_spell"] == 0) then
				player:sendMinitext("You may not have negative spell graphics.")
			else
				player.registry["gfx_spell"] = player.registry["gfx_spell"] - 1
			--	player:sendAnimation(player.registry["gfx_spell"])
				player:selfAnimation(player.ID, player.registry["gfx_spell"], 0)
				player:sendMinitext("Spell #: "..player.registry["gfx_spell"])
			end
			
			player:sendAnimation(player.registry["gfx_spell"])
			printf = 0
		elseif (speech=="spell") then
			player:sendMinitext("Spell #: "..player.registry["gfx_spell"])
			player:selfAnimation(player.ID, player.registry["gfx_spell"], 0)
		--	player:sendAnimation(player.registry["gfx_spell"])
			printf = 0
		elseif (string.match(speech, "spell (%d+)") ~= nil and string.sub(speech, 0, 5) == "spell") then
			player.registry["gfx_spell"] = tonumber(string.match(speech, "spell (%d+)"))
			player:selfAnimation(player.ID, player.registry["gfx_spell"], 0)
		--	player:sendAnimation(player.registry["gfx_spell"])
			printf = 0

			
-- Browse sound effect			
		elseif (speech=="nsound") then
			if (player.registry["gfx_sound"] == 1518) then
				player:sendMinitext("You may not go over 1518 on sound effects.")
			else
				if (player.registry["gfx_sound"] == 147) then
					player.registry["gfx_sound"] = 200
				elseif (player.registry["gfx_sound"] == 206) then
					player.registry["gfx_sound"] = 300
				elseif (player.registry["gfx_sound"] == 313) then
					player.registry["gfx_sound"] = 331
				elseif (player.registry["gfx_sound"] == 371) then
					player.registry["gfx_sound"] = 401
				elseif (player.registry["gfx_sound"] == 421) then
					player.registry["gfx_sound"] = 500
				elseif (player.registry["gfx_sound"] == 514) then
					player.registry["gfx_sound"] = 600
				elseif (player.registry["gfx_sound"] == 603) then
					player.registry["gfx_sound"] = 700
				elseif (player.registry["gfx_sound"] == 740) then
					player.registry["gfx_sound"] = 900
				elseif (player.registry["gfx_sound"] == 910) then
					player.registry["gfx_sound"] = 1001
				else
					player.registry["gfx_sound"] = player.registry["gfx_sound"] + 1
				end
				
				player:playSound(player.registry["gfx_sound"])
				player:sendMinitext("Sound : "..player.registry["gfx_sound"])
			end
			
			printf = 0
		elseif (speech=="psound") then
			if (player.registry["gfx_sound"] == 0) then
				player:sendMinitext("You may not have negative sound effects.")
			else
				if (player.registry["gfx_sound"] == 200) then
					player.registry["gfx_sound"] = 147
				elseif (player.registry["gfx_sound"] == 300) then
					player.registry["gfx_sound"] = 206
				elseif (player.registry["gfx_sound"] == 331) then
					player.registry["gfx_sound"] = 313
				elseif (player.registry["gfx_sound"] == 401) then
					player.registry["gfx_sound"] = 371
				elseif (player.registry["gfx_sound"] == 500) then
					player.registry["gfx_sound"] = 421
				elseif (player.registry["gfx_sound"] == 600) then
					player.registry["gfx_sound"] = 514
				elseif (player.registry["gfx_sound"] == 700) then
					player.registry["gfx_sound"] = 603
				elseif (player.registry["gfx_sound"] == 900) then
					player.registry["gfx_sound"] = 740
				elseif (player.registry["gfx_sound"] == 1001) then
					player.registry["gfx_sound"] = 910
				else
					player.registry["gfx_sound"] = player.registry["gfx_sound"] - 1
				end
				
				player:playSound(player.registry["gfx_sound"])
				player:sendMinitext("Sound : "..player.registry["gfx_sound"])
			end
			
			printf = 0
		elseif (speech=="sound") then
			player:sendMinitext("Sound #: "..player.registry["gfx_sound"])
			player:playSound(player.registry["gfx_sound"])
			printf = 0
		elseif (string.match(speech, "sound (%d+)") ~= nil and string.sub(speech, 0, 5) == "sound") then
			player.registry["gfx_sound"] = tonumber(string.match(speech, "sound (%d+)"))
			player:playSound(player.registry["gfx_sound"])
			printf = 0
		elseif (string.match(speech, "dps (%d+)") ~= nil and string.sub(speech, 0, 3) == "dps") then
			--[[
			if (player.registry["dps_potion"] > 0) then
				player.sendMinitext("You've already used that.")
			else
				player.registry["dps_potion_len"] = tonumber(string.match(speech, "dps (%d+)"))
				player.registry["dps_potion"] = os.time() + player.registry["dps_potion_len"]
			end
			]]--
			printf = 0
		end
	end

-- set character to afk mode with message	
	if (string.sub(lspeech, 1, 5) == "/afk ") then
		player.afkMessage = string.sub(lspeech, 6)
		printf = 0
	end

-- Test connection speed	
	if (lspeech == "/ping") then player:talk(2, "Ping? Pong! "..player.ping.."ms") printf = 0 end
	if (player.state == 0) then
		if lspeech == "lol" then player:sendAction(11,80) end
	end

-- Calculator
	if (string.byte(speech,1)==61) then--== 99)then
		if ((string.byte(speech,2)>=48) and (string.byte(speech,2)<=57)) or ((string.byte(speech,2)==40) and ((string.byte(speech,3)>=48) and (string.byte(speech,3)<=57))) or ((string.byte(speech,2)==46) and ((string.byte(speech,3)>=48) and (string.byte(speech,3)<=57)))then
			local eq = string.gsub(speech,"=","")
			local f, l, x
			f = ""
			for l in string.gmatch(eq,".") do f = f..l end	
			x = string.gsub(""..f.." = $return "..f.."$", "%$(.-)%$", function (s) return loadstring(s)() end)
		--	player:msg(11, "Answer is: "..x, player.ID)
			player:talk(0, ""..x)
			printf=0
		end
	end
	
	mob = player:getObjectsInMap(player.m, BL_MOB)
	
	if #mob > 0 then
		for i = 1, #mob do
			if mob[i].yname == "wind_walk" and mob[i]:hasDuration("wind_walk") then
				if mob[i].registry["wind_walk_owner"] == player.ID then
					if string.find(player.speech, "(.*)/(.*)") == nil then
						mob[i]:talk(0, player.name..": "..player.speech)
					end
				end
			end
		end
	end


	if (printf==1)then
		player:speak(player.speech,talkType)
	else
		return
	end
end
