gateway = {

on_learn = function(player) player.registry["learned_gateway"] = 1 end,
on_forget = function(player) player.registry["learned_gateway"] = 0 end,

cast = function(player, question)

	local q = string.lower(player.question)
	local m = player.m
	local magicCost = 10
	local x
	local y
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if player.indoor > 0 or player.warpOut > 0 then player:sendAnimation(246) player:sendMinitext("It doesn't work here") return end
	
	if m == 10000 then
		if q == "u" or q == "n" then
			x = math.random(16, 18)
			y = math.random(12, 14)
			player:warp(10000, x, y)
			player:sendMinitext("You arrived at North Gate of "..player.mapTitle)
		elseif q == "s" then
			x = math.random(199, 202)
			y = math.random(201, 203)
			player:warp(10000, x, y)
			player:sendMinitext("You arrived at South Gate of "..player.mapTitle)
		elseif q == "b" or q == "w" then
			x = math.random(4, 6)
			y = math.random(107, 109)
			player:warp(10000, x, y)
			player:sendMinitext("You arrived at West Gate of "..player.mapTitle)		
		elseif q == "t" or q == "e" then
			x = math.random(210, 212)
			y = math.random(165, 167)
			player:warp(10000, x, y)
			player:sendMinitext("You arrived at East Gate of "..player.mapTitle)
		end
		player:playSound(29)
		player:sendAnimation(16)
		player:sendAction(6, 20)
		player:sendMinitext("You cast Gateway")
		return
	end
	if player.region == 1 then
		if q == "u" or q == "n" then
			x = math.random(71,76)
			y = math.random(24,27)
			player:warp(1000,x,y)
			player:sendMinitext("You arrived at North Gate of Buya")
		elseif q == "s" then
			x = math.random(74, 77)
			y = math.random(145, 147)
			player:warp(1000,x,y)
			player:sendMinitext("You arrived at South Gate of Buya")
		elseif q == "b" or q == "w" then
			x = math.random(8, 10)
			y = math.random(89, 91)
			player:warp(1000,x,y)
			player:sendMinitext("You arrived at West Gate of Buya")
		elseif q == "t" or q == "e" then
			x = math.random(133, 135)
			y = math.random(88, 90)
			player:warp(1000,x,y)
			player:sendMinitext("You arrived at East Gate of Buya")
		else
			player:sendAnimation(246)
			player:sendMinitext("Cannot find any Gate")
		end
	elseif player.region == 6 then		-- Mythic I
		if q == "u" or q == "n" then
			x = math.random(28, 30)
			player:warp(6000, x, 14)
			player:sendMinitext("You arrived at North Gate of Mythic I")
		elseif q == "s" then
			x = math.random(28, 30)
			player:warp(6000, x, 50)
			player:sendMinitext("You arrived at South Gate of Mythic I")
		elseif q == "b" or q == "w" then
			x = math.random(8, 9)
			y = math.random(22, 24)
			player:warp(6000, x, y)
			player:sendMinitext("You arrived at West Gate of Mythic I")
		elseif q == "t" or q == "e" then
			x = math.random(46, 48)
			y = math.random(33, 34)
			player:warp(6000, x, y)
			player:sendMinitext("You arrived at East Gate of Mythic I")
		else
			player:sendAnimation(246)
			player:sendMinitext("Cannot find any Gate")
		end
	elseif player.region == 5 then		-- Vortex
		if q == "u" or q == "n" then
			x = math.random(32, 33)
			y = math.random(13, 14)
			player:warp(5000,x,y)
			player:sendMinitext("You arrived at North Gate of Vortex")
		elseif q == "s" then
			x = math.random(33, 35)
			y = math.random(50)
			player:warp(5000,x,y)
			player:sendMinitext("You arrived at South Gate of Vortex")
		elseif q == "b" or q == "w" then
			x = math.random(10,12)
			y = math.random(33,35)
			player:warp(5000,x,y)
			player:sendMinitext("You arrived at West Gate of Vortex")
		elseif q == "t" or q == "e" then
			x = math.random(57,59)
			y = math.random(34, 36)
			player:warp(5000,x,y)
			player:sendMinitext("You arrived at East Gate of Vortex")
		else
			player:sendAnimation(246)
			player:sendMinitext("Cannot find any Gate")
		end
	elseif player.region == 10 then		-- Castle
		if q == "u" or q == "n" then
			x = math.random(29, 31)
			y = math.random(27, 29)
			player:warp(20001,x,y)
			player:sendMinitext("You arrived at North Gate of Castle")
		elseif q == "s" then
			x = math.random(30,31)
			y = 60
			player:warp(20001,x,y)
			player:sendMinitext("You arrived at South Gate of Castle")
		elseif q == "b" or q == "w" then
			x = math.random(6,7)
			y = 60
			player:warp(20001,x,y)
			player:sendMinitext("You arrived at West Gate of Castle")
		elseif q == "t" or q == "e" then
			x = math.random(53,54)
			y = 60
			player:warp(20001,x,y)
			player:sendMinitext("You arrived at East Gate of Castle")
		else
			player:sendAnimation(246)
			player:sendMinitext("Cannot find any Gate")
		end
	elseif player.region == 2 then		-- Kugnae
		if q == "u" or q == "n" then
			x = math.random(108, 110)
			y = math.random(13, 15)
			player:warp(2000, x, y)
			player:sendMinitext("You arrived at North Gate of Kugnae")
		elseif q == "s" then
			x = math.random(109, 111)
			y = math.random(209, 211)
			player:warp(2000, x, y)
			player:sendMinitext("You arrived at South Gate of Kugnae")	
		elseif q == "b" or q == "w" then
			x = math.random(15, 17)
			y = math.random(106, 108)
			player:warp(2000, x, y)
			player:sendMinitext("You arrived at West Gate of Kugnae")
		elseif q == "t" or q == "e" then
			x = math.random(204, 206)
			y = math.random(106, 108)
			player:warp(2000, x, y)
			player:sendMinitext("You arrived at East Gate of Kugnae")
		else
			player:sendAnimation(246)
			player:sendMinitext("Cannot find any Gate")
		end
	else
		anim(player)
		player:sendMinitext("Cannot find any gates!")
		return
	end
	
	player:playSound(29)
	player:sendAnimation(16)
	player:sendAction(6, 20)
	player:sendMinitext("You cast Gateway")	
end,


requirements = function(player)

	txt = "- 10 Chesnut \n"
	txt = txt.."- 10 Rabbit Meat \n"

	local level = 5
	local item = {43, 41}
	local amounts = {10, 10}
	local desc = {"Ability to warp to gate in city (North/East/West/South).","To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}
	