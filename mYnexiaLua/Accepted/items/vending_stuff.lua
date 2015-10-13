vending_ransel = {
equip = function(player)
	
	player.registry["max_vending_slots"] = 5
	player:msg(4, "[Vending]  Max items ("..player.registry["total_v_item"].."/"..player.registry["max_vending_slots"]..") ====================", player.ID)
end,
	
while_equipped = function(player)

	player.registry["max_vending_slots"] = 5
end
}

------------------------------------------------------------------------------------------------------------------------------------

vending_cart = {
equip = function(player)
	
	player.registry["max_vending_slots"] = 10
	player:msg(4, "[Vending] Max items ("..player.registry["total_v_item"].."/"..player.registry["max_vending_slots"]..") ====================", player.ID)
end,

while_equipped = function(player)

	player.registry["max_vending_slots"] = 10
end
}

------------------------------------------------------------------------------------------------------------------------------------

vending_trolly = {
equip = function(player)
	
	player.registry["max_vending_slots"] = 15
	player:msg(4, "[Vending] Max items ("..player.registry["total_v_item"].."/"..player.registry["max_vending_slots"]..") ====================", player.ID)
end,

while_equipped =  function(player)

	player.registry["max_vending_slots"] = 15
end
}