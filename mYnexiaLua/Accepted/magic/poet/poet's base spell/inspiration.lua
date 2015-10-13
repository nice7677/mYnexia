inspiration = {

on_learn = function(player) player.registry["learned_inspiration"] = 1 end, 
on_forget = function(player) player.registry["learned_inspiration"] = 0 end, 

cast = function(player, target)
	
	local magic = target.magic*.25
	local magicCost = 1000

	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if target.ID == player.ID then return end

	if target.blType == BL_PC then
		if target.state ~= 1 then
			if player:canPK(target) then
				player:sendAction(6, 20)
				target.magic = target.magic - magic
				target:sendStatus()
				player:addMagic(magic)
				target:sendAnimation(11)
				player:sendAnimation(117)
				player:playSound(65)
				player:playSound(22)
				player:sendMinitext("You cast Inspiration")
				target:sendMinitext(player.name.." cast Inspiration on you")
				player:setAether("inspiration", 60000)
			end
		end
	else
		anim(player)
		player:sendMinitext("Invalid Target!")
	end

	
end,

requirements = function(player)

	txt = "- 1 Fraglie Rose \n"
	txt = txt.."- 1000 Coins \n"

	local level = 50
	local item = {7042, 0}
	local amounts = {1, 1000}
	local desc = {"", "To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}