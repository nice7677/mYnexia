


tongkat_sailor_moon = {

equip = function(player)

	player:addSpell("next_animation")
	player:addSpell("prev_animation")
	player:msg(4, "[INFO] 'Next' & 'Prev' animation spell added!", player.ID)
end,

while_equipped = function(player)

	player.registry["can_browse_spell"] = 1
end,

unequip = function(player)
	
	player.registry["can_browse_spell"] = 0
	player:removeSpell("next_animation")
	player:removeSpell("prev_animation")
	player:msg(4, "[INFO] 'Next' & 'Prev' animation spell removed!", player.ID)
end
}









next_animation = {

cast = function(player)
	
	if player.registry["can_browse_spell"] == 0 then return end
	if player.registry["gfx_spell"] > 427 then player:sendMinitext("Spell #: Tidak bisa lebih dari 427 pak") return end
	player.registry["gfx_spell"] = player.registry["gfx_spell"] + 1
	player:sendMinitext("Spell #: "..spell)
	player:selfAnimation(player.ID, player.registry["gfx_spell"], 0)
end
}

prev_animation = {

cast = function(player)
	
	if player.registry["can_browse_spell"] == 0 then return end
	if player.registry["gfx_spell"] < 0 then player:sendMinitext("Spell #: Tidak bisa kurang dari 0 pak") return end
	player.registry["gfx_spell"] = player.registry["gfx_spell"] - 1
	player:sendMinitext("Spell #: "..player.registry["gfx_spell"])
	player:selfAnimation(player.ID, player.registry["gfx_spell"], 0)
end
}























