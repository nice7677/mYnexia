

delete_spawn = {

cast = function(player, target)
	
	mysql = require "luasql.mysql"
	local env = mysql.mysql()
	local conn = env:connect("mYnexia", "god", "user=god", "127.0.0.1")
	
	player:sendAction(6, 60)
	if target.blType == BL_MOB then
		id = target.id
		conn:execute("DELETE from Spawns where SpnId = '"..id.."'")
		
		target:removeHealth(target.health)
		player:msg(4, "[MySQL] 'DELETE from Spawns where SpnId = "..target.ID.."'", player.ID)
		player:popUp("Deleted!")
	end
	--conn:execute([[DELETE from sample3 where id ='12']])
end
}