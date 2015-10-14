gift_box = {

use = function(player)

	if not player:canAction(1,1,1) then anim(player) return end
	
	local item = player:getInventoryItem(player.invSlot)
	local chance = math.random(1, 200)
	local rate10 = {6007, 7007, 7015, 7023, 7031}
	local rate30 = {3022, 3050, 3056, 3075, 3032}
	local im = {}
	for i = 16001, 16581, 10 do
		table.insert(im, i)
	end
	
	if player:hasItem("gift_box", 1) then
		if chance == 1 then										-- 1 % Item mall?
			player:addItem(im[math.random(#im)], 1)
			player:setDuration("fireworks", 5000)

		elseif chance >= 2 and chance <= 5 then 				-- 4%
			player.registry["event_point"] = player.registry["event_point"] + 10000
			player:sendMinitext("Event point : "..format_number(player.registry["event_point"]).." pts")
			player:talk(2, "Event point : +10000")			
		elseif chance > 5 and chance < 15 then						-- 10 %
			player:addItem(rate10[math.random(#rate10)], 1)
			player:talk(2, "1 "..Item(item).name)
		elseif chance > 15 and chance < 45 then					-- 30 &	
			player:addItem(rate30[math.random(#rate30)], 1)
			player:talk(2, Item(item).name.."")
		elseif chance > 45 and chance < 90 then					-- 50 %
			gold = math.random(500000, 1000000)
			player:addGold(gold)
			player:talk(2, format_number(gold).." coins")
		elseif chance > 90 then									-- 110 %
			item = math.random(62, 76)
			player:addItem(item, 1)
			player:talk(2, Item(item).name.."")
		end
		player:removeItem("gift_box", 1)
		player:sendAnimation(259)
		player:playSound(67)		
	end
end
}