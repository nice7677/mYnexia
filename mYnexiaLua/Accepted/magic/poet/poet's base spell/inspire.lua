inspire = {

on_learn = function(player) player.registry["learned_inspire"] = 1 end,
on_forget	 = function(player) player.registry["learned_inspire"] = 0 end,


cast = function(player, target)

	if not player:canCast(1,1,0) then return end
	
	if target.blType == BL_PC then
		if target.state == 1 then
			player:sendMinitext("Target already die!")
			anim(player)
			return
		else
			target:sendAnimation(18)
			player:playSound(80)
			player:sendAction(6, 20)
			player:sendMinitext("You cast Inspire")
			target:sendMinitext(player.name.." cast inspire on you")
			target:addMagic(player.magic)
			player.magic = 0
			player:sendStatus()
		end
	else
		anim(player)
		player:sendMinitext("Invalid Target!")
	end
end, 


requirements = function(player)
	
	txt = "- 10 Mountain ginseng \n"
	txt = txt.."- 20 Silver fox fur \n"
	txt = txt.."- 100 Coins \n"
	
	local level = 65
	local item = {46, 67, 0}
	local amounts = {10, 20, 100}
	local desc = {"Give current magic to target", "To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}