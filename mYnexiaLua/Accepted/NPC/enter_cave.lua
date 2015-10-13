enter_cave = {


click = async(function(player, npc)

	local req = npc.look
	local m = player.m
	local x = player.x
	local y = player.y
	local s = player.side
	local level = player.level
	
	if level < req then
		if s == 0 then player:warp(m,x,y+1) end
		if s == 1 then player:warp(m,x-1,y) end
		if s == 2 then player:warp(m,x,y-1) end
		if s == 3 then player:warp(m,x+1,y) end
		anim(player)
		player:sendMinitext("You're too weak for enter (min lv: "..req..")")
	end
end)
}
