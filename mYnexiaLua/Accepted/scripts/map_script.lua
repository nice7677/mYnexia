
--------------------- Login -----------------------------------



login = function(player)
	
	local adate = os.date("%A, %d %B %Y - %H:%M:%S")
	local curTotemTime = get_totem_time(player)	
	local logincount = player.registry["login_count"]
	local god = Player(2)
	local friends = player:getFriends()
	
	player:setDuration("vending_menu", 0)
	player.enchant = 1
	if player.ID ~= 2 then player:msg(4, "[Login]: "..player.name.." has logged in ("..player.mapTitle.."/"..player.m..")", god.ID) end

	player:updateState()

	if logincount > 0 then
	    logincount = logincount + 1
		if player:staff() == true then
		else
			if #friends > 0 then
				for i = 1, #friends do
					player:msg(4, ""..player.name.." has logged in.", friends[i].ID)
				end
			end
		end
		player.registry["login_count"] = logincount
	end
	
    player:msg(4, "[System]: "..adate.." ("..curTotemTime.." time)", player.ID)
	
	if player.ID == 4 then
		if god ~= nil then player:warp(god.m, god.x, god.y) end
	end
end




-- Logout -------------------------------------------------------------------------------


logout = function(player)
	
	local god = Player(2)
	local req = player.registry["summon_pet"]
	
	player.registry["mentor_by"] = 0
	player.registry["alter_stats_target"] = 0
	player.registry["summoned_mount"] = 0
	player.registry["mount_speed"] = 0
	player:setDuration("gfx_switch", 0)	
	player.registry["summoned_pet"] = 0
	player.registry["summon_pet"] = 0	
	player.registry["red_script"] = 0
	player.registry["blue_script"] = 0
	player.registry["green_script"] = 0
	player.registry["permanentSpawnStatus"] = 0
	player:removeSpell("addPermanentSpawn")
	player:removeSpell("add_script")	
	
	if player.ID ~= 2 then god:msg(4, "[Login]: "..player.name.." has logged out.", god.ID) end
	if Mob(req) ~= nil then Mob(req):removeHealth(Mob(req).health) end
	if player.gfxClone == 1 then player.gfxClone = 0 end
	
	if (player.gmLevel < 50) then
		if (player:staff() == true) then
		else
			local friends = player:getFriends()
			if (#friends > 0) then
				for i = 1, #friends do
					player:msg(4, ""..player.name.." has logged out.", friends[i].ID)
				end
			end
		end
	end
end


-- Map Weather -------------------------------------------------------------------------------


mapWeather = function()
	local x, weather
	weather = math.random(1,5)
	if(math.random(4) == 2) then
		if(weather > 3 and weather < 5 and getCurSeason() == "Spring") then
			setWeather(0,0,0)
		elseif(weather >= 2 and weather < 4 and getCurSeason() == "Summer") then
			setWeather(0,0,0)
		elseif(weather == 4 and getCurSeason() == "Fall") then
			setWeather(0,0,0)
		elseif(weather > 3 and getCurSeason() == "Winter") then
			setWeather(0,0,0)
		elseif(weather <= 3 and weather > 1 and getCurSeason() == "Spring") then
			setWeather(0,0,1)
		elseif(weather == 1 and getCurSeason() == "Summer") then
			setWeather(0,0,1)
		elseif(weather >= 2 and weather < 4 and getCurSeason() == "Fall") then
			setWeather(0,0,1)
		elseif(weather == 1 and (getCurSeason() == "Spring" or getCurSeason() == "Fall")) then
			setWeather(0,0,2)
		elseif(weather <= 3 and getCurSeason() == "Winter") then
			setWeather(0,0,2)
		elseif(weather == 5 and getCurSeason() == "Spring") then
			setWeather(0,0,3)
		elseif(weather >= 4 and getCurSeason() == "Summer") then
			setWeather(0,0,3)
		elseif(weather == 5 and getCurSeason() == "Fall") then
			setWeather(0,0,3)
		else
			setWeather(0,0,getWeather(0,0))
		end
	else
		setWeather(0,0,getWeather(0,0))
	end
end


-- Map Light --------------------------------------------------------------------------------

mapLight = function()

    local mlight = 0
    local ctime = curTime()
	
    if (ctime < 1) then
        mlight = 18
    elseif (ctime < 2) then
        mlight = 19
    elseif (ctime < 3) then
        mlight = 20
    elseif (ctime < 4) then
        mlight = 21
    elseif (ctime < 5) then
        mlight = 22
    elseif (ctime < 6) then
        mlight = 23
    elseif (ctime < 7) then
        mlight = 24
    elseif (ctime < 8) then
        mlight = 25
    elseif (ctime < 9) then
        mlight = 26
    elseif (ctime < 10) then
        mlight = 27
    elseif (ctime >= 10 and ctime < 14) then
        mlight = 0
    elseif (ctime < 15) then
        mlight = 27
    elseif (ctime < 16) then
        mlight = 26
    elseif (ctime < 17) then
        mlight = 25
    elseif (ctime < 18) then
        mlight = 24
    elseif (ctime < 19) then
        mlight = 23
    elseif (ctime < 20) then
        mlight = 22
    elseif (ctime < 21) then
        mlight = 21
    elseif (ctime < 22) then
        mlight = 20
    elseif (ctime < 23) then
        mlight = 19
    elseif (ctime < 24) then
        mlight = 18
    end
    
    --function setLight(region,indoor,lightnumber)
    --setLight(0, 0, mlight)--region 0
    setLight(1, 0, mlight)--region 1
    setLight(2, 0, mlight)--region 2
end


-------------- Entering Map -------------------------------------------------------------

mapEnter = function(player)

	if player.m == 1015 and not player:hasLegend("born") and player.registry["bank_pin"] > 0 then
		if not player:hasLegend("born") then
			player:removeLegendbyName("born")
			player:addLegend("Born in mYnexia " ..curYear()..", "..getCurSeason(), "born", 8, 16)
			broadcast(-1, "[INFO]: " ..player.name.. " has born into mYnexia !!!" )
		end
	elseif player.m == 1001 and player.registry["bank_pin"] == 0 then
		register_bankPin.click(player, npc)
	else
		if not player:hasLegend("born") and player.registry["bank_pin"] == 0 then
			player:warp(7, 7, 9)
			player:sendAnimation(16)
			player.side = 2
			player:sendSide()
		end
	end
end


---------------- Leaving Map  -----------------------------------------------------------------

mapLeave = function(player)
	
	local pc = player:getObjectsInMap(player.m, BL_PC)
	
	if player.m == 8 then
		if #pc == 0 then
			setObject(8, 14, 19, 15000)
			setObject(8, 15, 19, 15000)
			setObject(8, 16, 19, 15000)
		end
	elseif player.m == 9 then
		if #pc == 0 then
			setObject(9, 7, 3, 641)
			setObject(9, 8, 3, 636)
			setObject(9, 9, 3, 642)
		end
	elseif player.m == 10 then
		elevator_npc.destination(player, "lobby")
		
	elseif player.m == 14 then
		player.gfxClone = 0
		player:updateState()

	elseif player.m == 10006 then
		player.gfxClone = 0
		player:updateState()
	end
	
end

------------- on Scripted Tile ----------------------------------------------------------------

onScriptedTile = function(player)

	if player.m == 10 then
		elevator_npc.warp(player)
	elseif player.m == 1000 then
		tile = getTile(1000, player.x, player.y)
		if tile >= 117 and tile <= 124 then
			if player.state ~= 1 then
				pushBack(player)
				player:sendAnimation(246)
			end
		end
	end
end































