amnesia = {

on_learn = function(player) player.registry["learned_amnesia"] = 1 end,
on_forget = function(player) player.registry["learned_amnesia"] = 0 end,

cast = function(player, target)
	
	local magicCost = 1000
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if target.ID == player.ID then return end
	
	if target:hasDuration("amnesia") then
		anim(player)
		player:sendMinitext("Spell already cast!")
		return
	else
		if target.blType == BL_PC then
			if player:canPK(target) then
				player:sendAction(6, 20)
				target:sendAnimation(130)
				target:sendAnimation(34)
				target:setDuration("amnesia", 7000)
				player:playSound(32)
			end
		elseif target.blType == BL_MOB then
			target:sendAnimation(130)
			target:sendAnimation(34)
			target:setDuration("amnesia", 7000)
			player:sendAction(6, 20)
			player:playSound(32)
		end
	end
end,

while_cast = function(block)

	block.drunk = 1
	block:playSound(24)
	block:sendAnimation(318)
end,

uncast = function(block)

	block:calcStat()
	block.drunk = 0
end,

requirements = function(player)
	
	local txt
	txt = "- 50 Chesnut \n"
	txt = txt.."- 20 Fox Fur \n"
	txt = txt.."- 1 Lucky Coin \n"
	txt = txt.."- 2 Great Tiger Pelt \n"
	txt = txt.."- 200 Coins \n"

	local level = 43
	local item = {43, 12, 7047, 70, 0}
	local amounts = {50, 20, 1, 2, 200}
	local desc = {"","To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}
	
	
	