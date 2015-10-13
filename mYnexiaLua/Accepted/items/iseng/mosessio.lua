mosessio = {

use = function(player)

	if not player:canAction(1,1,0) then return end
	
	player:addSpell("lethal_strike")
	player:addSpell("withenal_strike")
	player:addSpell("sword_rash")
	player:addSpell("shadow_sword")
	player:addSpell("burst")
	player:addSpell("ambush")
	player:addSpell("gateway")
	player:sendAnimation(131)
	player:playSound(112)
end
}