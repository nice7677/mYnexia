feral = {

on_learn = function(player) player.registry["learned_feral"] = 1 end,
on_forget = function(player) player.registry["learned_feral"] = 0 end,

cast = function(player, question)

	local magicCost = 50
	local q = string.lower(player.question)
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	if player.state == 0 then
		if player:hasDuration("feral") then return else
			player.magic = player.magic - magicCost
			player:setDuration("feral", 45000)
			player:sendAnimation(3)
			player:playSound(36)
			if q == "c" then
				player.registry["cat_feral"] = 1
				player.disguise = 909
			elseif q == "d" then	
				player.registry["dog_feral"] = 1
				player.disguise = 855					
			elseif q == "p" then	
				player.registry["pig_feral"] = 1
				player.disguise = 891			
			end
			player.state= 4	
			player:sendStatus()
			player:updateState()
		end
	end
end,

while_cast = function(player)
	
	if player.registry["cat_feral"] == 1 then
		player.disguise = 909
	elseif player.registry["dog_feral"] == 1 then
		player.disguise = 855
	elseif player.registry["pig_feral"] == 1 then
		player.disguise = 891
	end
	player.state= 4			
end,


uncast = function(player)

	if player.state == 4 then player.state = 0 end
	player:calcStat()
	player:updateState()
	player.registry["cat_feral"] = 0
	player.registry["dog_feral"] = 0
	player.registry["pig_feral"] = 0
end,

requirements = function(player)
	
	local txt
	txt = "- 50 Chesnut \n" 
	txt = txt.."- 10 Chesnut \n" 
	txt = txt.."- 100 Coins \n" 

	local level = 14
	local item = {43, 41, 0}
	local amounts = {50, 10, 100}
	local desc = {"Transform to animal (cat, dog, pig)", "To learn this spell you must to sacriface \n"..txt..""}
	return level, item, amounts, desc
end
}