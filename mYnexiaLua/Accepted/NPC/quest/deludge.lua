deludge = {

click = async(function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	local fox = {graphic = convertGraphic(34, "monster"), color = 5}
	local sword = {graphic = convertGraphic(647, "item"), color = 0}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local opts = {}
	if player.quest["deludge_revenge"] == 0 then table.insert(opts, "Why you look sad?") end
	table.insert(opts, "Exit")

	if player.quest["deludge_revenge"] == 0 then
		menu = player:menuString("<b>[Deludge]\n\n....", opts)
		if menu == "Why you look sad?" then
			player:dialogSeq({t, "<b>[Deludge]\n\nDo you care? Several years ago, i and my brother, we're very curious about the existence of a mysterious creature named '9-Tailed Fox'",
							t, "<b>[Deludge]\n\nAfter a few days we exploring, i remember that on the last day we decided to leave that cave. I thought we've failed to find that fox. But...",
							fox, "<b>[Deludge]\n\non the way out from that cave, we were attacked by a herd of foxes.. I saw him! he was in the middle of that foxes! The nine-tailed fox..",
							fox, "<b>[Deludge]\n\nWe cannot fight them. They're too many.. We deciced to escape from that cave.. But, me and my brother, we seperated. Long time passed, and theres no news of him at all.",
							t, "<b>[Deludge]\n\nMaybe he was killed by that fox! For revenge, would you help me to defeat and get that fox's tail?"}, 1)

			confirm = player:menuString("<b>[Deludge]\n\nI wish you would helping..",{"Allright i'll do it for you", "Exit"})
			if confirm == "Allright i'll do it for you" then
				player:msg(4, "=== [Quest] - 'Deludge revenge' - Defeat nine tailed fox (0/1) ===", player.ID)
				player:msg(4, "=== [Quest] - 'Deludge revenge' - Get item 'fox tails' (0/1) ===", player.ID)
				player.quest["deludge_revenge"] = 1
				player:dialogSeq({t, "<b>[Deludge]\n\nThank you very much! You're so kind.. I promise, i'll give you a reward when you're done."}, 1)
			end
		end
	elseif player.quest["deludge_revenge"] == 1 then
		menu = player:menuString("<b>[Deludge]\n\nOh, it's you.. Did you defeat him and get the tail?", {"Yes, here's it..", "Not yet, i've no time for that", "Exit"})
		if menu == "Yes, here's it.." then
			if player:hasItem("fox_tails", 1) == true and player:killCount(33) > 0 and not player:hasLegend("deludge_revenge") then
				player:dialogSeq({t, "<b>[Deludge]\n\nWow, you're so great !!",
								t, "<b>[Deludge]\n\nAs i promised.. here, take this",
								sword, "<b>[Deludge]\n\nThis is my brother's sword. This very precious to me. Once again, Thank you very much for your help."}, 1)
				player:flushKills(33)
				player:removeItem("fox_tails", 1)
				player:addItem("do_sword", 1)
				player.quest["deludge_revenge"] = 2
				finishedQuest(player)
				player:addLegend("Helping deludge revenge (mYnexia "..curYear().." "..getCurSeason()..")", "deludge_revenge", 18, 16)
			else
				player:dialogSeq({t, "<b>[Deludge]\n\nI'll waiting..."})
			end
		elseif menu == "Not yet, i've no time for that" then
			player:dialogSeq({t, "<b>[Deludge]\n\nDon't worry, i'll waiting.."})
		end
	elseif player.quest["deludge_revenge"] == 2 then
		player:dialogSeq({t, "<b>[Deludge]\n\nThanks for your help, i'll remember you!!"})
	end
end),

say = function(player, npc)
	
	local word = string.lower(player.speech)

	if player.gmLevel > 0 then
		if word == "reset" then
			player:flushKills(33)
			player.registry["get_do_sword"] = 0
			player.quest["deludge_revenge"] = 0
			player:removeLegendbyName("deludge_revenge")
			npc:talk(2, "Quest reset done for "..player.name)
		end
	end
end
}















