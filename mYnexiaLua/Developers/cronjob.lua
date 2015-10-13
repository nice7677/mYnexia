onSec = function()
	block = NPC(4294967295)
	
	player:talk(2, "testing one two")

end

cronJobHour = function()
	
	block = NPC(4294967295)
	local jam = realHour()
	local menit = realMinute()
	
end

cronJobMin = function()
	
	block = NPC(4294967295)
	local d = realDay()


end

cronJobDay = function()

	block = NPC(4294967295)
	local d = realDay()

	player.registry["beri_sedekah"] = 0
	player.registry["dropped_white_amber"] = 0

--[[	
	if d == 1 then broadcast(-1, "== Monday, "..realHour()..":"..realMinute()..":"..realSecond().." ==") end
	if d == 2 then broadcast(-1, "== Tuesday, "..realHour()..":"..realMinute()..":"..realSecond().." ==") end
	if d == 3 then broadcast(-1, "== Wednesday, "..realHour()..":"..realMinute()..":"..realSecond().." ==") end
	if d == 4 then broadcast(-1, "== Thursday, "..realHour()..":"..realMinute()..":"..realSecond().." ==") end
	if d == 5 then broadcast(-1, "== Friday, "..realHour()..":"..realMinute()..":"..realSecond().." ==") end
	if d == 6 then broadcast(-1, "== Saturday, "..realHour()..":"..realMinute()..":"..realSecond().." ==") end
	if d == 7 then broadcast(-1, "== Sunday, "..realHour()..":"..realMinute()..":"..realSecond().." ==") end
]]--
end






















