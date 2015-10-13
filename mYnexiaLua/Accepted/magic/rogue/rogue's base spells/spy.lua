spy = {
on_learn = function(player) player.registry["learned_spy"] = 1 end,
on_forget = function(player) player.registry["learned_spy"] = 0 end,


cast = function(player, target)

	local magicCost = 500
	local threat
	
	a =      "- Name   : "..target.name.."\n"
	a = a.."- Level  : "..target.level.."\n"
	a = a.."- Health : "..target.health.."/"..target.maxHealth.."\n"
	a = a.."- Magic  : "..target.magic.."/"..target.maxMagic.."\n"
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player:sendAction(6, 20)
	player:sendMinitext("You cast Spy")
	
	if target.blType == BL_MOB then
		target:sendAnimation(88)
		player:playSound(505)
		player:popUp(a)
		
	elseif target.blType == BL_PC then
		if target.level <= player.level then
			target:sendAnimation(88)
			player:playSound(505)
			player:popUp(a)
			target:sendMinitext(player.name.." cast Spy on you")
		else
			player:sendMinitext("Target stronger than you!")
			player:sendAnimation(246)
		end
	end
end,


requirements = function(player)
	
	local txtt
	txtt = "- 100 Chesnut \n"
	txtt = txtt.."- 15 Fox Fur \n"
	txtt = txtt.."- 20 Tiger Meat \n"
	txtt = txtt.."- 200 Coins \n"
	
	local level = 28
	local item = {43, 12, 55, 0}
	local amounts = {100, 15, 20, 200}
	local desc = {"Get target's status info", "To learn this spell you must to sacriface\n"..txtt..""}
	return level, item, amounts, desc
end
}