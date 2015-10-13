horse = {
on_mount = function(player, mob)

	if mob.state == MOB_HIT then
		player:sendAnimation(246)
		player:sendMinitext("They are not be able to ride now!")
		return
	end

	if mob.lookColor == 35 then
		player.registry["mounted_id"] = mob.mobID
		player:sendStatus()
		player.disguise = 26
		player.state = 3
		player:updateState()
		
		player.registry["on_mounted_horseID"] = mob.ID
		Mob(player.registry["on_mounted_horseID"]):warp(1,3,3)
	end
end
}