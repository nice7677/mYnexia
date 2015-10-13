mass_dance = {
cast=function(player)

	local list = player:getUsers()
	if(#list > 0) then
		for i = 1, #list do
			if(list[i].m ~= 134 and list[i].m ~= 135 and list[i].ID ~= 2 and list[i].ID ~= 18) then
			
				list[i]:sendAction(22,120)
				list[i]:talk(0, list[i].name..": Dance dance dance ~!!")
			end
		end
	end
	
	if player.ID == 2 or player.ID == 18 then
		player:spawn(10000, player.x+1, player.y)
		get = player:getObjectsInCell(player.m, player.x, player.y, BL_MOB)
		if #get > 0 then
			for i = 1, #get do

				get[i].gfxCrown = 117
				get[i].gfxArmor = 10072
				get[i].gfxName = "Yuri"
				get[i].gfxClone = 1
				get[i]:updateState()
				get[i]:sendStatus()
				get[i]:sendAction(22, 120)
				get[i]:talk(0, "Yuri: Dance dance dance ~!!")
				get[i]:setDuration("mass_dance", 4000)

			end
		end
	end
	
end,


uncast = function(block)

	block:removeHealth(block.health)
end
}

