onOpen = function(player)

	local m = player.m
	local x = player.x
	local y = player.y
	local s = player.side
	local obj
	
	if s == 0 then
		obj = getObject(m,x,y-1)
	elseif s == 1 then
		obj = getObject(m,x+1,y)
	elseif s == 2 then
		obj = getObject(m,x,y+1)
	elseif s == 3 then
		obj = getObject(m,x-1,y)
	end
	
	if m == 9 then
		if x == 7 or x == 8 or x == 9 then
			if s == 0 and y == 4 then
				if obj == 641 or obj == 636 or obj == 642 then
					setObject(9,7,3,0)
					setObject(9,8,3,0)
					setObject(9,9,3,0)
					player:playSound(404)
					player:sendMinitext("Doors Opened!")
				else
					setObject(9,7,3,641)
					setObject(9,8,3,636)
					setObject(9,9,3,642)
					player:playSound(405)
					player:sendMinitext("Doors Closed!")
				end
			end
		end
	elseif m == 12 then
		if x == 7 or x == 8 or x == 9 then
			if s == 0 and y == 3 then
				if obj == 641 or obj == 636 or obj == 642 then
					setObject(12,7,2,0)
		            setObject(12,8,2,0)
					setObject(12,9,2,0)
					player:playSound(404)
					player:sendMinitext("Doors Opened!")
				else
					setObject(12,7,2,641)
					setObject(12,8,2,636)
					setObject(12,9,2,642)
					player:playSound(405)
					player:sendMinitext("Doors Closed!")
				end
			end
		end
	elseif m == 2000 then
		if x == 116 or x == 117 then
			if s == 0 and y == 2 then
				if obj == 358 or obj == 359 then
					setObject(2000, 116, 1, 370)
					setObject(2000, 117, 1, 371)
					player:playSound(404)
					player:sendMinitext("Doors Opened!")
				else
					setObject(2000, 116, 1, 358)
					setObject(2000, 117, 1, 359)
					player:playSound(405)
					player:sendMinitext("Doors Closed!")
				end
			end
		end
	elseif m == 1104 or m == 1110 then
		if m == 1104 then mm = 1104 end
		if m == 1110 then mm = 1110 end
		if s == 0 and y == 3 then
			if x == 3 or x == 4 then
				if obj == 340 or obj == 341 then
					setObject(mm, 3, 2, 0)
					setObject(mm, 4, 2, 0)
					player:playSound(404)
					player:sendMinitext("Doors Opened!")					
				else
					setObject(mm, 3, 2, 340)
					setObject(mm, 4, 2, 341)
					player:playSound(405)
					player:sendMinitext("Doors Closed!")
				end
			elseif x == 6 or x == 7 then
				if obj == 340 or obj == 341 then
					setObject(mm, 6, 2, 0)
					setObject(mm, 7, 2, 0)
					player:playSound(404)
					player:sendMinitext("Doors Opened!")					
				else
					setObject(mm, 6, 2, 340)
					setObject(mm, 7, 2, 341)
					player:playSound(405)
					player:sendMinitext("Doors Closed!")
				end				
			elseif x == 11 or x == 12 then
				if obj == 338 or obj == 339 then
					setObject(mm, 11, 2, 0)
					setObject(mm, 12, 2, 0)
					player:playSound(404)
					player:sendMinitext("Doors Opened!")					
				else
					setObject(mm, 11, 2, 338)
					setObject(mm, 12, 2, 339)
					player:playSound(405)
					player:sendMinitext("Doors Closed!")
				end				
			elseif x == 14 or x == 15 then
				if obj == 338 or obj == 339 then
					setObject(mm, 14, 2, 0)
					setObject(mm, 15, 2, 0)
					player:playSound(404)
					player:sendMinitext("Doors Opened!")					
				else
					setObject(mm, 14, 2, 338)
					setObject(mm, 15, 2, 339)
					player:playSound(405)
					player:sendMinitext("Doors Closed!")
				end				
			elseif x == 19 or x == 20 then
				if obj == 340 or obj == 341 then
					setObject(mm, 19, 2, 0)
					setObject(mm, 20, 2, 0)
					player:playSound(404)
					player:sendMinitext("Doors Opened!")					
				else
					setObject(mm, 19, 2, 340)
					setObject(mm, 20, 2, 341)
					player:playSound(405)
					player:sendMinitext("Doors Closed!")
				end			
			elseif x == 22 or x == 23 then
				if obj == 340 or obj == 341 then
					setObject(mm, 22, 2, 0)
					setObject(mm, 23, 2, 0)
					player:playSound(404)
					player:sendMinitext("Doors Opened!")					
				else
					setObject(mm, 22, 2, 340)
					setObject(mm, 23, 2, 341)
					player:playSound(405)
					player:sendMinitext("Doors Closed!")
				end				
			end
		end
		
	end
end                 



function openDoors(player)


	
end