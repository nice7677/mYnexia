valor = {

on_learn = function(player) player.registry["learned_valor"] = 1 end,
on_forget = function(player) player.registry["learned_valor"] = 0 end,

cast = function(player, target)

	local magicCost = 500
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end

	if target.blType == BL_PC then
		if target:hasDuration("valor") then return else
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:sendAction(6, 20)
			player:sendMinitext("You cast valor")
			target:sendAnimation(11)
			player:playSound(8)
			target:sendMinitext(player.name.." cast valor on you")
			target:setDuration("valor", 240000)
		end
	end
end,

recast = function(player) player.deduction = player.might+3 end,
uncast = function(player) player:calcStat() end,

requirements = function(player)

	txt = "- 10 Hartshorn \n"
	txt = txt.."- 20 Snake Meat \n"
	txt = txt.."- 100 Coins \n"

	local level = 27
	local item = {63, 49, 0}
	local amounts = {10, 20, 100}
	local desc = {"Increase target's might +3", "To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}