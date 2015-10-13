gift_box = {

use = function(player)

	if not player:canAction(1,1,1) then anim(player) return end
	
	local item = player:getInventoryItem(player.invSlot)
	local chance = math.random(200)
	local r = math.random(1,5)
	
	if player:hasItem("gift_box", 1) then
		if chance < 5 then										-- 5 %
			player.registry["event_point"] = player.registry["event_point"] + 10000
			player:sendMinitext("Event point : "..format_number(player.registry["event_point"]).." pts")
			player:talk(2, "Event point : +10000")
		elseif chance > 5 and chance < 15 then						-- 10 %
			if r == 1 then item = 6007 end
			if r == 2 then item = 7007 end
			if r == 3 then item = 7015 end
			if r == 4 then item = 7023 end
			if r == 5 then item = 7031 end
			player:addItem(item, 1)
			player:talk(2, "1 "..Item(item).name)
		elseif chance > 15 and chance < 45 then					-- 30 &
			if r == 1 then item = 3022 end
			if r == 2 then item = 3050 end
			if r == 3 then item = 3056 end
			if r == 4 then item = 3075 end
			if r == 5 then item = 3032 end
			player:addItem(item, 1)
			player:talk(2, Item(item).name.."")
		elseif chance > 45 and chance < 90 then					-- 50 %
			gold = math.random(500000, 1000000)
			player:addGold(gold)
			player:talk(2, format_number(gold).." coins")
		elseif chance > 90 then									-- 110 %
			item = math.random(70, 80)
			player:addItem(item, 1)
			player:talk(2, Item(item).name.."")
		end
		player:removeItem("gift_box", 1)
		player:sendAnimation(259)
		player:playSound(67)		
	end
end
}