frisk = {

on_learn = function(player) player.registry["learned_frisk"] = 1 end,
on_forget = function(player) player.registry["learned_frisk"] = 0 end,


cast = function(player, target)

	local magicCost = 1000

	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end

	player:sendAction(6, 20)
	
	if target.blType == BL_MOB then
		target:sendAnimation(88)
		player:playSound(505)
		player.magic = player.magic - magicCost
		player:sendStatus()
		txt =      "Name   - "..target.name.." \n"
		txt = txt.."Health - ("..target.health.."/"..target.maxHealth..") \n"
		txt = txt.."Magic  - ("..target.magic.."/"..target.maxMagic..") \n"
		player:popUp(txt)
	else
		player:sendAnimation(246)
		player:sendMinitext("Invalid Target!")
	end
end,

requirements = function(player)
	
	local txt
	txt = "- 10 Chesnut"

	local level = 12
	local item = {43}
	local amounts = {10}
	local desc = {"Check target(mob only)'s health and magic", "To learn this spell you must to sacriface \n"..txt..""}
	return level, item, amounts, desc
end
}
		