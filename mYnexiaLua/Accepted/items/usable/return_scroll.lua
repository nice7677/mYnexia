return_scroll = {

use = function(player)

	if player.country ~= 2 then player.country = 2 player:calcStat() end	-- jadikan semua nya Country Buya untuk sementara.
	
	local r = math.random(1,3)
	
	if not player:canAction(1,1,1) then return end
	if player.m == 14 or player.m == 15 then player:popUp("You cannot use return scroll here") return end

	if player.m == 20017 or player.m == 20018 then
		player:warp(11, math.random(13,14), 10)
		player:sendAnimation(296)
		player:playSound(29)
		return
	end
	
	if player.country == 2 then 						--Buya
		spring = 1002
		yunsil = 1001
		pepper = 1006
		x = math.random(3,4)
		xx = math.random(7,8)
		
		if r == 1 then
			a = math.random(1,2)
			if a == 1  then
				player:warp(spring, x, 5)
			elseif a == 2 then
				player:warp(spring, xx, 5)
			end
		elseif r == 2 then
			a = math.random(1,2)
			if a == 1  then
				player:warp(yunsil, x, 5)
			elseif a == 2 then
				player:warp(yunsil, xx, 5)
			end
		elseif r == 3 then
			a = math.random(1,2)
			if a == 1  then
				player:warp(pepper, x, 5)
			elseif a == 2 then
				player:warp(pepper, xx, 5)
			end
		end
		
		player:sendAction(7, 20)
		player:sendAnimation(16)
		player:playSound(29)
		player:sendMinitext("You've returned!")
		
	elseif player.country == 1 then				--Kugnae
		player.country = 2
		player:calcStat()
		return_scroll.use(player)
	end
end
}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		