silver_thread = {

on_learn = function(player) player.registry["learned_silver_thread"] = 1 end,
on_forget = function(player) player.registry["learned_silver_thread"] = 0 end,

cast = function(player, question)

	local q = string.lower(player.question)

	if q ~= nil then
		if player.state == 1 then
			if q == "w" or q == "e" then
				player:warp(1013, 5, 4)
			else
				anim(player)
				player:sendMinitext("(W)est / (E)ast")
			end
		else
			anim(player)
			player:sendMinitext("You're still alive")
		end
	end
end,

requirements = function(player)

	txt = "\n- 10 Chesnut \n"
	txt = txt.."- 10 Rabbit Meat \n"
	
	local level = 5
	local item = {43, 41}
	local amounts = {10, 10}
	local desc = {"Take a dead spirit to nearest prophet for ressurection", "To learn this spell you must to sacriface "..txt..""}
	return level, items, amounts, desc
end
}
	