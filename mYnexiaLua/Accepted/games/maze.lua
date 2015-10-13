
maze = {

changeDoor = function(player)

	local r = math.random(1,4)
	
	--[[
	if r == 1 then
		mazeDoor1.open(player)
		mazeDoor2.closed(player)
		mazeDoor3.closed(player)
		mazeDoor4.closed(player)
		
	elseif r == 2 then
		
		
	end
	]]--
end,


finish = function(player)
	
	player:warp(11, 3, 8)
	player:broadcast(20017, "[Maze] "..player.name.." has finished maze and warped out!")
	player:sendAction(10, 60)
	player:sendAnimation(265)
	player:playSound(86)
	player:playSound(123)
	player.registry["event_point"] = player.registry["event_point"] + 2000
	player:sendMinitext("Event Points: "..format_number(player.registry["event_point"]).." pts")
end
}







-- Maze door 1 ----------------------------------------------------------------------------------------------------------------------

mazeDoor1 = {

open = function(player)
	
	setObject(20017, 0, 53, 0)
	setObject(20017, 0, 54, 11744)
	setObject(20017, 0, 55, 0)
	setObject(20017, 0, 56, 0)
	setPass(20017, 0, 53, 0)
	setPass(20017, 0, 54, 0)
	setPass(20017, 0, 55, 0)
	setPass(20017, 0, 56, 0)
	player:broadcast(20017, "[Maze]  The way to go out was changed!")
end,

closed = function(player)

	setObject(20017, 0, 53, 15048)
	setObject(20017, 0, 54, 15048)
	setObject(20017, 0, 55, 15048)
	setObject(20017, 0, 56, 15048)
	setPass(20017, 0, 53, 1)
	setPass(20017, 0, 54, 1)
	setPass(20017, 0, 55, 1)
	setPass(20017, 0, 56, 1)	
	player:broadcast(20017, "[Maze]  The way to go out was changed!")
end
}

-- Maze door 2 ----------------------------------------------------------------------------------------------------------------------

mazeDoor2 = {

open =  function(player)

	setObject(20017, 160, 141, 11744)
	setObject(20017, 160, 142, 0)
	setObject(20017, 160, 143, 0)
	setPass(20017, 160, 141, 0)
	setPass(20017, 160, 142, 0)
	setPass(20017, 160, 143, 0)	
	player:broadcast(20017, "[Maze]  The way to go out was changed!")
end,

closed = function(player)

	setObject(20017, 160, 141, 15048)
	setObject(20017, 160, 142, 15048)
	setObject(20017, 160, 143, 15048)
	setPass(20017, 160, 141, 1)
	setPass(20017, 160, 142, 1)
	setPass(20017, 160, 143, 1)	
	player:broadcast(20017, "[Maze]  The way to go out was changed!")
end
}

-- Maze door 3 ----------------------------------------------------------------------------------------------------------------------

mazeDoor3 = {

open = function(player)

	setObject(20017, 53, 160, 0)
	setObject(20017, 54, 160, 0)
	setObject(20017, 55, 160, 0)
	setPass(20017, 53, 160, 0)
	setPass(20017, 54, 160, 0)
	setPass(20017, 55, 160, 0)	
	player:broadcast(20017, "[Maze]  The way to go out was changed!")
end,

closed = function(player)

	setObject(20017, 53, 160, 15048)
	setObject(20017, 54, 160, 15048)
	setObject(20017, 55, 160, 15048)
	setPass(20017, 53, 160, 1)
	setPass(20017, 54, 160, 1)
	setPass(20017, 55, 160, 1)	
	player:broadcast(20017, "[Maze]  The way to go out was changed!")	
end
}

-- Maze door 4 ----------------------------------------------------------------------------------------------------------------------

mazeDoor4 = {

open = function(player)

	setObject(20017, 101, 2, 0)
	setObject(20017, 102, 2, 0)
	setObject(20017, 103, 2, 0)
	setObject(20017, 101, 0, 0)
	setObject(20017, 102, 0, 0)
	setObject(20017, 103, 0, 0)
	setPass(20017, 101, 2, 0)
	setPass(20017, 102, 2, 0)
	setPass(20017, 103, 2, 0)
	player:broadcast(20017, "[Maze]  The way to go out was changed!")
end,
			
closed = function(player)

	setObject(20017, 101, 2, 11744)
	setObject(20017, 102, 2, 11744)
	setObject(20017, 103, 2, 11744)
	setObject(20017, 101, 0, 15048)
	setObject(20017, 102, 0, 15048)
	setObject(20017, 103, 0, 15048)
	setPass(20017, 101, 2, 1)
	setPass(20017, 102, 2, 1)
	setPass(20017, 103, 2, 1)
	player:broadcast(20017, "[Maze]  The way to go out was changed!")
end
}

































