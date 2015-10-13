ignite = {

on_learn = function(player) player.registry["learned_ignite"] = 1 end,
on_forget = function(player) player.registry["learned_ignite"] = 0 end,


cast = function(player, target)
	
	local magicCost = 1000
	local damage = math.random(1750, 2750) + player.wisdom*.5
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	if target.state == 1 then
		player:sendAnimation(246)
		player:sendMinitext("Invalid Target!")
		return
	else
		if target.blType == BL_MOB then
			player:sendAction(6, 20)
			target.attacker = player.ID
			threat = target:removeHealthExtend(damage, 1,1,1,1,2)
			player:addThreat(target.ID, threat)
			target:removeHealthExtend(damage, 1,1,1,1,0)
			target:sendAnimation(4)
			player:playSound(19)
			player:sendMinitext("You cast Ignite")
		elseif target.blType == BL_PC then
			if player:canPK(target) then
				if target.ID == player.ID then return else
					target.attacker = player.ID
					target:sendAnimation(4)
					player:playSound(19)
					player:sendAction(6, 20)
					target:removeHealthExtend(damage, 1,1,1,1,0)
					player:sendMinitext("You cast Ignite")
					target:sendMinitext(player.name.." attack you with Ignite")
				end
			end
		end
		player.magic = player.magic - magicCost
		player:sendStatus()
	end
end,

requirements = function(player)
	
	local txt
	txt = "- 30 Chesnut \n"
	txt = txt.."- 5 Silver Fox Fur \n"
	txt = txt.."- 2 Topaz \n"
	txt = txt.."- 200 Coins \n"
	
	local level = 24
	local item = {43, 67, 47, 0}
	local amounts = {30, 5, 2, 200}
	local desc = {"Ignite", "To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}