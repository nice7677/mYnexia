
--[[
onDeathMob = function(mob)

	local rate = math.random(10)
	local name = mob.yname
	local d = math.random(10)
	
	if rate > 6 then
	
-- Rabbit Cave ----------------------------------------------------------------------------------------------------------------

		if name == "rabbit1" or name == "rabbit2" then mob:dropItem(41, 1) end
		if name == "squirrel" then mob:dropItem(43, 1)
			if d < 3 then mob:dropItem(76, 1) end
		end
		if name == "deer1" or name == "deer2" then mob:dropItem(63, 1) end
		if name == "horse" then mob:dropItem(72, 1) end
		
-- Rat Cave ----------------------------------------------------------------------------------------------------------------	
	
		if name == "mouse" then mob:dropItem(44, 1) end
		if name == "rat" or name == "white_rat" or name == "fierce_mouse" then mob:dropItem(44, 1)
			if d < 3 then mob:dropItem(Item("obsidian").id, 1) else mob:dropItem(Item("topaz").id, 1) end
		end
		if name == "bat" or name == "old_bat" then
			if d < 3 then mob:dropItem(45, 1) else mob:dropItem(46, 1) end
		end
		if name == "centipede" or name == "giant_centipede" then
			if d < 3 then mob:dropItem(74, 1) else mob:dropItem(75, 1) end
		end
		
-- Snake Cave ---------------------------------------------------------------------------------------------------------------- 	
	
		if name == "snake" or name == "white_snake" then mob:dropItem(49, 1) end
		if name == "wild_snake" or name == "earth_snake" then mob:dropItem(73, 1) end
		if name == "cobra" then mob:dropItem(73, 1)
			if d < 3 then mob:dropItem(Item("poisonous_novice_knife").id, 1) end
		end	
		if name == "worm" or name == "fire_worm" then mob:dropItem(Item("centipede").id, 1)
			if d < 3 then mob:dropItem(Item("amber").id, 1) else mob:dropItem(Item("dark_amber").id, 1) end
		end
		if name == "pig" or name == "wild_pig" then mob:dropItem(50, 1) end	
		
-- Fox Cave ----------------------------------------------------------------------------------------------------------------	
	
		if name == "fox" or name == "blood_fox" or name == "sun_fox" then mob:dropItem(12, 1) end
		if name == "lighting_fox" then mob:dropItem(67, 1) end	
		if name == "brown_fox" then mob:dropItem(69, 1) end
		if name == "nine_tailed_fox" then
			if d < 2 then  mob:dropItem(Item("fox_tails").id, 1) end
		end
		if name == "wolf" or name == "white_wolf" or name == "fire_wolf" then mob:dropItem(37, 1)
			if d < 3 then mob:dropItem(Item("amethyst_stone").id, 1) end
		end
		if name == "raven" or name == "blood_raven" or name == "angry_crow" then mob:dropItem(Item("dark_amber").id, 1) end
		
-- Bear Cave ----------------------------------------------------------------------------------------------------------------	

		if name == "bear" or name == "bir_bear" then mob:dropItem(Item("bear_fur").id, 1)
			if d < 3 then mob:dropItem(Item("bear_heart").id, 1) end
		end
		if name == "tiger" then mob:dropItem(Item("tiger_meat").id, 1) end
		if name == "old_tiger" then mob:dropItem(Item("tiger_meat").id, 1)
			if d < 3 then mob:dropItem(Item("holy_pelt").id, 1) end
		end
		if name == "red_tiger" then mob:dropItem(Item("great_tiger_pelt").id, 1)
			if d < 3 then mob:dropItem(Item("red_tiger_pelt").id, 1) end
		end
		
-- Red Tiger Cave ----------------------------------------------------------------------------------------------------------------	
	
		if name == "giant_grasshoppers" or name == "blood_ticks" or name == "blood_grasshoppers" then mob:dropItem(Item("ginseng").id, 1)
			if d < 3 then mob:dropItem(Item("mountain_ginseng").id, 1) end
		end
		if name == "blue_bat" then
			if d == 3 then mob:dropItem(Item("war_hat").id, 1) elseif d == 2 then mob:dropItem(Item("lucky_coin").id, 1) end
		end
		if name == "blue_tiger" then mob:dropItem(Item("tiger_pelt").id, 1) end
		if name == "brown_tiger" then mob:dropItem(Item("tiger_pelt").id, 1)
			if d < 3 then item = Item("great_tiger_pelt").id end
		end
		if name == "blood_tiger" then item = Item("great_tiger_pelt").id
			if d == 3 then mob:dropItem(Item("sacred_ring").id, 1) elseif d == 2 then mob:dropItem(Item("iron_saber").id, 1) end
		end
		if name == "old_red_tiger" then mob:dropItem(Item("red_tiger_pelt").id, 1)
			if d == 3 then mob:dropItem(Item("steel_sword").id, 1) elseif d == 2 then mob:dropItem(Item("fraglie_rose").id, 1) end
		end
		
-- Scorpion Cave ----------------------------------------------------------------------------------------------------------------
		
		if name == "lobster" then mob:dropItem(Item("amber").id, 1) end
		if name == "giant_scorpion" then mob:dropItem(Item("amber").id, 1)
			if d == 3 then mob:dropItem(Item("hunang_axe").id, 1) end
		end
		if name == "scorpion" or name == "black_lobster" then mob:dropItem(Item("amber").id, 1) end
		if name == "white_scorpion" then
			if d == 3 then mob:dropItem(Item("tao_stone").id, 1) end
		end
		if name == "big_scorpion" or name == "white_lobster" or name == "green_lobster" then mob:dropItem(Item("dark_amber").id, 1)
			if d == 3 then mob:dropItem(Item("bekyun_spike").id, 1) end
		end
		if name == "red_scorpion" then
			if d == 3 then mob:dropItem(Item("hunang_axe").id, 1) end
		end
		
-- Ghost Cave ----------------------------------------------------------------------------------------------------------------
		
		if name == "ghost" then mob:dropItem(Item("amber").id, 1) end
		if name == "civil_ghost" or name == "ghost_sentry" then
			if d == 1 then mob:dropItem(Item("steel_sword").id, 1) end
			if d == 2 then mob:dropItem(Item("iron_saber").id, 1) end
		end
		if name == "ghost_thief" or name == "gatekeeper_ghost" then
			if d == 3 then mob:dropItem(Item("death_brain").id, 1) end
		end
		if name == "warrior_ghost" then
			if d == 3 then mob:dropItem(Item("maxcaliber").id, 1) end
		end
		if name == "magical_ghost" then
			if d == 3 then mob:dropItem(Item("sadistic_staff").id, 1) end
		end		



--  Cave ----------------------------------------------------------------------------------------------------------------
--  Cave ----------------------------------------------------------------------------------------------------------------
	end
	
end
]]--






























