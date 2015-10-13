


setPk = {
cast = function(player)
	
	local pc = player:getObjectsInMap(player.m, BL_PC)
	
	if #pc > 0 then
		for i = 1, #pc do
			if pc[i].pk == 0 then
				pc[i].registry["warFlag"] = 1
				pc[i].pk = 1
				pc[i]:sendStatus()
				pc[i]:sendMinitext("PK: On")
			end
		end
	end
	
	player:sendAction(6, 20)
end
}
	