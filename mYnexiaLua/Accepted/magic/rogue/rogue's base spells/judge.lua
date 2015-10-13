judge = {

on_learn = function(player) player.registry["learned_judge"] = 1 end,
on_forget = function(player) player.registry["learned_judge"] = 0 end,

cast = function(player, target)

	if target ~= nil then
		player:popUp("Not implemented yet!")
	end
	
end,



requirements = function(player)
	
	local txt
	txt = "- 70 Chesnut \n"
	txt = txt.."- 30 Snake Meat \n"
	txt = txt.."- 150 Coins \n"
	
	local level = 17
	local item = {43, 49, 0}
	local amounts = {70,30,150}
	local desc = {"", "To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}