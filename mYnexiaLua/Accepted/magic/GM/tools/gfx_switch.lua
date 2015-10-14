gfx_switch = {

cast = function(player)
	
	if not player:canCast(1,1,0) then return end
	
	if player.gfxClone == 0 then
		gfxClone(player, player)
		player.gfxClone = 1
		player:msg(4, "GFX : ON", player.ID)
	else
		player.gfxClone = 0
		player:msg(4, "GFX : OFF", player.ID)
	end

	player:updateState()
end,

while_cast = function(player)

	player.gfxClone = 1
end,


uncast = function(player)
	
	player.gfxClone = 0
	player:updateState()
end
}
