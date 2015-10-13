cure_paralysis = {
on_learn = function(player) player.registry["learned_cure_paralyze"]=1 end,
on_forget = function(player) player.registry["learned_cure_paralyze"]=0 end,

cast = function(player, target)
	local magicCost = 30
	
	if (not player:canCast(1, 1, 0)) then return end
	if (player.magic < magicCost) then notEnoughMP(player) return end
	
	if target.blType == BL_PC then
		player:sendAnimation(246)
		player:sendMinitext("Invalid Target.")
		return
	elseif target.blType == BL_MOB then
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendMinitext("You cast Cure paralysis")
		target:sendAnimation(10)
		player:playSound(80)
		if target:hasDuration("paralyze") then
			target:setDuration("paralyze", 0)
			target.paralyzed = false
		end
	end
end,

requirements = function(player)

	txt = "- 50 Chesnut \n"
	txt = txt.. "- 1 Fresh Snake Meat \n"
	txt = txt.. "- 100 Coins "
	
	local level = 40
	local items = {43, 73, 0}
	local amounts = {50, 1, 100}
	local description = {"Cure target that have a working paralyzed spell", "To learn this spell you must to sacriface:\n"..txt..""}
	return level, items, amounts, desc
end
}