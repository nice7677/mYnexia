--utility script
--http://lua-users.org/wiki/FormattingNumbers





function format_number(amount)

	local formatted = amount
	
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then break end
	end
  return formatted
end

function get_totem_time(player)

    local totems = { "JuJak", "Baekho", "Hyun Moo", "Chung Ryong" } --
    local curTotem = ""
    local time = curTime()
    local curTotemID = 0
    
    if(time <= 0) then
        curTotemID = 3
    elseif(time <= 3) then
        curTotemID = 2
    elseif(time <= 6) then
        curTotemID = 1
    elseif(time <= 9) then
        curTotemID = 0
    elseif(time <= 12) then
        curTotemID = 3
    elseif(time <= 15) then
        curTotemID = 2
    elseif(time <= 18) then
        curTotemID = 1
    elseif(time <= 21) then
        curTotemID = 0
    end
    
    player.gameRegistry["current_totem_time"] = curTotemID
    
    return totems[curTotemID+1]

end

