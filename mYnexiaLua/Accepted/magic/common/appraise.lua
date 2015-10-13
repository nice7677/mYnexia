appraise = {

on_learn = function(player) player.registry["learned_appraise"] = 1 end,
on_forget = function(player) player.registry["learned_appraise"] = 0 end,

cast = function(player, question)
	
	local q = player.question
	
	
end,


requirements = function(player)
	
	txt = "- 10 Chesnut \n"
	txt = txt.."- 10 Rabbit Meat \n"
	
	local level = 1
	local item = {43, 41}
	local amounts = {10, 10}
	local desc = {"Examaining an item in inventory", "To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}