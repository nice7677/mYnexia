home = {

on_learn = function(player) player.registry["learned_home"] = 1 end,
on_forget = function(player) player.registry["learned_home"] = 0 end, 

cast = function(player, question)

	local magicCost = 10
	local q = string.lower(player.question)
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	if q == "y" then
		return_scroll.use(player)
	else
		anim(player)
		player:sendMinitext("Type 'y' for yes")
	end
end,


requirements = function(player)
	
	local txt
	txt = "- 100 Chesnut \n"
	txt = txt.."- 100 Coins \n"

	local level = 45
	local item = {43, 0}
	local amounts = {100, 100}
	local desc = {"Return/back to nearest inn in the city", "To learn this spell you must to sacriface:\n"..txt..""}
	return level, item, amounts, desc
end
}
	