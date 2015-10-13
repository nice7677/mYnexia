
games_officer = {

click = async(function(player, npc)
	
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local x, y
	local r = math.random(1,5)
	local opts = {}
	table.insert(opts, "The great maze")
	table.insert(opts, "Exit")
	
	menu = player:menuString("<b>[Games officer]\n\nWhat game you want to play?", opts)
	
	if menu == "The great maze" then
--[[
		if player.registry["enter_great_maze"] > os.time() then
			player:dialogSeq({t, "<b>[Games officer]\n\nYou only can enter maze 1 time in 1 hour.."})
			return
		else
			player.registry["enter_great_maze"] = os.time()+3600
			if r == 1 then x = 54 y = 23 end
			if r == 2 then x = 97 y = 23 end
			if r == 3 then x = 99 y = 79 end
			if r == 4 then x = 113 y = 123 end
			if r == 5 then x = 34 y = 151 end
			player:warp(20017, x, y)
		end
]]--
		
	end
end)
}












































