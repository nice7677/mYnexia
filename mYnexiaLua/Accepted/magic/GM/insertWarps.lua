

insert_warps = {

cast = function(player, question)

	local path = "/root/mynexia/mYnexiaMaps/warps.txt"
	local file = io.open(path, "a+")
	local m = player.m
	local x = player.x
	local y = player.y
	local txt
	
	if string.match(string.lower(player.question), "f") ~= nil or tonumber(player.question) == 1 then
		file:write(m..",	" ..x.. ",	" ..y.."\n")
		file:flush()
		player:sendAnimationXY(228, x, y, 30)
		player:playSound(6)
		player:msg(0, "From -> "..player.mapTitle.."("..player.m.."),   X: "..player.x..",   Y: "..player.y.."  >> "..path, player.ID)
	elseif string.match(string.lower(player.question), "t") ~= nil or tonumber(player.question) == 2 then
		file:write(",	"..m.. ",	" ..x.. ",	" ..y.."\n")
		file:flush()
		player:sendAnimationXY(235, x, y, 30)
		player:playSound(6)
		player:msg(0, "To   -> "..player.mapTitle.."("..player.m.."),   X: "..player.x..",   Y: "..player.y.."  >> "..path, player.ID)
	elseif string.match(string.lower(player.question), "n") ~= nil or tonumber(player.question) == 3 then
		file:write("/n")
		file:flush()
		player:msg(0, "/n  >> "..path, player.ID)
	elseif string.match(string.lower(player.question, ":(.+)")) ~= nil then
		txt = string.match(string.lower(player.question, ":(.+)"))
		file:write(txt)
		file:flush()
		player:msg(0, ": "..txt.."  >> "..path, player.ID)
	elseif string.match(string.lower(player.question, "help")) ~= nil then
		anim(player)
		player:msg(0, "============== Command ==============", player.ID)
		player:msg(0, "'f' or '1' : insert 'From' coordinate", player.ID)
		player:msg(0, "'t' or '2' : insert 'To' coordinate", player.ID)
		player:msg(0, "'n' or '3' : insert a 'New line'", player.ID)
		player:msg(0, "': text'   : insert a text", player.ID)
	end
end
}	
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		