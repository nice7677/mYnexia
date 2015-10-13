shadow_dance_old = {

on_learn = function(player) player.registry["learned_shadow_dance_old"] = 1 end,
on_forget = function(player) player.registry["learned_shadow_dance_old"] = 0 end,

cast = function(player)

	local magicCost = 5000
	local dura = 120000
	local sound = 36
	local anim = 100
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	if player:hasDuration("shadow_dance_old") then
		anim(player)
		player:sendMinitext("Spell already cast!")
		return
	else
		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendMinitext("You cast Shadow Dance Old")
		player:setDuration("shadow_dance_old", dura)
		player:playSound(sound)
		player:sendAnimation(anim)
	end
	
end,

while_cast = function(player)
end,

recast = function(player)

	player.armor = player.armor + 2500
end,

uncast = function(player)

	player:calcStat()
end, 

requirements = function(player)
	
	local txt
	txt = "- 200 Chesnut \n"
	txt = txt.."- 10 Dark Amber \n"
	txt = txt.."- 6000 Coins \n"
	
	local level = 99
	local item = {43, 18008, 0}
	local amounts = {200, 10, 6000}
	local desc = {"Increase Armor", "To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}