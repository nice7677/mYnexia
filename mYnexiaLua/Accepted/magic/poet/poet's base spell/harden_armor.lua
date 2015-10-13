harden_armor = {

on_learn = function(player) player.registry["learned_harden_armor"] = 1 end,
on_forget = function(player) player.registry["learned_harden_armor"] = 0 end,

cast = function(player, target)

	local magicCost = 500
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end

	if target.blType == BL_PC then
		if target:hasDuration("harden_armor") then return else
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:sendAction(6, 20)
			player:sendMinitext("You cast Harden Armor")
			target:sendAnimation(110)
			player:playSound(95)
			target:sendMinitext(player.name.." cast Harden Armor on you")
			target:setDuration("harden_armor", 240000)
		end
	end
end,

recast = function(player) player.armor = player.armor + 2500 end,
uncast = function(player) player:calcStat() end,

requirements = function(player)

	txt = "- 60 Chesnut \n"
	txt = txt.."- 20 Snake Meat \n"
	txt = txt.."- 100 Coins "

	local level = 22
	local item = {43, 49, 0}
	local amounts = {60, 20, 100}
	local desc = {"Increase target armor + 2500", "To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}