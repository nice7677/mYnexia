flich = {

on_learn = function(player) player.registry["learned_flich"] = 1 end,
on_forget = function(player) player.registry["learned_flich"] = 0 end,

cast = function(player)

	local item = getTargetFacing(player, BL_ITEM)
	
	if not player:canCast(1,1,0) then return end
	
	player:sendAction(6,20)
	
	if item == nil then
		anim(player)
		player:sendMinitext("No item found!")
		return
	else
		if item.id >= 0 and item.id <=10 then 
			item:delete()
			player:addGold(item.amount)
			player:talk(2, "I'll Take this "..item.amount.." Coins.")
			player:msg(0, "[INFO]: You picked "..item.amount.." gold", player.ID)
		else
			item:delete()
			player:addItem(item.yname, item.amount)
			player:talk(2, "I'll Take this "..item.amount.." "..item.name)
			player:msg(0, "[INFO]: You picked "..item.amount.." "..item.name, player.ID)
		end
	end
end,

requirements = function(player)
	
	local txt
	txt = "- 500 Chesnut"
	
	local level = 12
	local item = {43}
	local amounts = {500} 
	local desc = {"Quickly take item on ground", "To learn this spell you must to sacriface:\n"..txt..""}
	return level, item, amounts, desc
end
}



		
		
		
		
		
		
		
		
		
		
		



