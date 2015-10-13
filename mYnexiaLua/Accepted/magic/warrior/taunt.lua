taunt = {
cast=function(player,target)
	local d= { }
	local e= { }
	local f= { }
	local h= { }
	local m=player.m
	local curx=player.x
	local cury=player.y
	local threatcalc= 0
	
	if (not player:canCast(1, 1, 0)) then player:sendAnimation(246) return end
	if(player.magic<250) then player:sendAnimation(246) player:sendMinitext("Mp tidak cukup.") return end
	if(player.state==1) then player:sendAnimation(246) player:sendMinitext("Roh tidak dapat melakukannya.") return end
	if(player.state==3) then player:sendAnimation(246) player:sendMinitext("Tidak bisa melakukannya saat ini.") return end

		for x=-10,10 do
			for y=-10,10 do
				d=player:getObjectsInCell(m,player.x+x,player.y+y,BL_MOB)
				if(#d>0) then

					for z=1,#d do


						if(d[z].target==0) then

							d[z].state=MOB_HIT
							--d[z].target=player.ID
							player:setThreat(d[z].ID,100)
							d[z].attacker=player.ID
							d[z]:removeHealthExtend(10, 1, 1, 1, 1, 0)
							d[z]:sendAnimation(248)


						elseif(d[z].target~=0) then

							if(Player(d[z].target).classBase~=1) then

								d[z].state=MOB_HIT
								--d[z].target=player.ID

								threatcalc = threat.getHighestThreat(d[z])
								threatcalc = (threatcalc*1.05) + 100

								player:setThreat(d[z].ID,threatcalc)
								d[z].attacker=player.ID
								d[z]:removeHealthExtend(10, 1, 1, 1, 1, 0)
								d[z]:sendAnimation(248)


							elseif(Player(d[z].target).classBase==1) then

								local dx=math.abs(d[z].x-Player(d[z].target).x)
								local dy=math.abs(d[z].y-Player(d[z].target).y)
								local dxy=dx+dy
								if(dxy>3) then
									--This lets warriors keep the mobs that are targeting them in a three tile circle around them

									d[z].state=MOB_HIT
									--d[z].target=player.ID

									threatcalc = threat.getHighestThreat(d[z])
									threatcalc = (threatcalc*1.05) + 100

									player:setThreat(d[z].ID,threatcalc)


									d[z].attacker=player.ID
									d[z]:removeHealthExtend(10, 1, 1, 1, 1, 0)
									d[z]:sendAnimation(248)
								end
							end
						end


					end
				end

			end
		end



	player:addMana(-250)
	player:sendAction(18,125)
	player:sendAnimation(369)
	player:playSound(307)
	player:setAether("taunt",0)
	player:talk(2,"COME HERE!")
end,
}
