
test_pin = {

cast = function(player)

	if player:hasDuration("test_pin") then return else
		pc = player:getObjectsInArea(BL_PC)
		if pc[1] ~= nil then
			player:setDuration("test_pin", 6000)
		end
	end
end,

while_cast_250 = function(player)
	
	pc = player:getObjectsInArea(BL_PC)
	if pc[1] ~= nil then
		rate = math.random(1,4)
		if rate == 1 then test_pin.atas(player, pc[1]) end
		if rate == 2 then test_pin.kiri(player, pc[1]) end
		if rate == 3 then test_pin.kanan(player, pc[1]) end
		if rate == 4 then test_pin.bawah(player, pc[1]) end
	end
end,


atas = function(player, target)

	player:warp(target.m, target.x, target.y-1)
	player.side = 2
	player:sendSide()
	player:sendAction(1, 20)
end,


bawah = function(player, target)

	player:warp(target.m, target.x, target.y+1)
	player.side = 0
	player:sendSide()
	player:sendAction(1, 20)
end,

kiri = function(player, target)

	player:warp(target.m, target.x-1, target.y)
	player.side = 1
	player:sendSide()
	player:sendAction(1, 20)
end,	

kanan = function(player, target)

	player:warp(target.m, target.x+1, target.y)
	player.side = 3
	player:sendSide()
	player:sendAction(1, 20)
end
}