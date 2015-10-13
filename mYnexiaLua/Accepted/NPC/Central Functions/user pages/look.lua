user_pages_status_look = {

click = function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 2
	
	local pc = Player(player.registry["on_page"])
	
	gfxClone(pc, npc)
	npc.gfxCrown = 65535	
	npc.gfxHelm = 255	
	npc.gfxFaceA = 65535	
	npc.gfxFaceAT = 65535
	npc.gfxArmor = pc.sex
	
	local xx = {}
	table.insert(xx, "Face      : "..pc.face)
	table.insert(xx, "FaceColor : "..pc.faceColor)
	table.insert(xx, "Hair      : "..pc.hair)
	table.insert(xx, "HairColor : "..pc.hairColor)
	table.insert(xx, "Skin      : "..pc.skinColor)
	table.insert(xx, "<< Back")
	
	txt =      "- Face      : "..pc.face.."\n"
	txt = txt.."- FaceColor : "..pc.faceColor.."\n"
	txt = txt.."- Hair      : "..pc.hair.."\n"
	txt = txt.."- HairColor : "..pc.hairColor.."\n"
	txt = txt.."- SkinColor : "..pc.skinColor.."\n"
	
	menu = player:menuString(""..txt.."", xx)
		
	if menu == "Face      : "..pc.face then
		player.registry["target_face"] = pc.face
		user_pages_face(player, npc)

	elseif menu == "FaceColor : "..pc.faceColor then
				
	
	elseif menu == "Hair      : "..pc.hair then
		user_pages_hair.click(player, npc)
	
	elseif menu == "HairColor : "..pc.hairColor then
	
	elseif menu == "Skin      : "..pc.skinColor then
	
	elseif menu == "<< Back" then
		user_pages.click(player, npc)
	end
end
}


user_pages_face = function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 2
	
	local pc = Player(player.registry["on_page"])
	
	npc.gfxCrown = 65535	
	npc.gfxHelm = 255	
	npc.gfxFaceA = 65535	
	npc.gfxFaceAT = 65535
	
	local opts = {}
	table.insert(opts, "->> Next")
	table.insert(opts, "Change to this face")
	table.insert(opts, "<<- Prev")
	
	menu = player:menuString("What model of face should "..pc.name.."'s change?\n\nFace ID: "..npc.gfxFace, opts)
	if menu == "->> Next" then
		npc.gfxFace = npc.gfxFace + 1
		if npc.gfxFace > 238 then npc.gfxFace =  200 end
		if npc.gfxFace < 200 then npc.gfxFace = 238 end
		user_pages_face(player, npc)
		
	elseif menu == "<<- Prev" then
		npc.gfxFace = npc.gfxFace - 1
		if npc.gfxFace > 238 then npc.gfxFace =  200 end
		if npc.gfxFace < 200 then npc.gfxFace = 238 end
		user_pages_face(player, npc)
		
	elseif menu == "Change to this face" then
		ok = player:menuString("Are you sure to change "..pc.name.."'s face to be like this?\nFaceID: "..npc.gfxFace.."", {"Yes", "No"})
		if ok == "Yes" then
			pc.face = npc.gfxFace
			pc:updateState()
			player:sendMinitext("Done!!")
			user_pages_face(player, npc)
		end
	end
end




user_pages_hair = {
click = function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 2

	local pc = Player(player.registry["on_page"])

	npc.gfxHairC = pc.hairColor
	npc.gfxCrown = 65535	
	npc.gfxHelm = 255	
	npc.gfxFaceA = 65535	
	npc.gfxFaceAT = 65535
	npc.gfxArmor = pc.sex

	local opts = {}
	table.insert(opts, "->> Next")
	table.insert(opts, "Change to this hair")
	table.insert(opts, "<<- Prev")
	
	menu = player:menuString("What model of hair should "..pc.name.."'s change?\nHair ID: "..npc.gfxHair, opts)
	if menu == "->> Next" then
		npc.gfxHair = npc.gfxHair + 1
		if npc.gfxHair > 151 then npc.gfxHair =  1 end
		if npc.gfxHair < 1 then npc.gfxHair = 151 end
		user_pages_hair.click(player, npc)
		
	elseif menu == "<<- Prev" then
		npc.gfxHair = npc.gfxHair - 1
		if npc.gfxHair > 151 then npc.gfxHair =  1 end
		if npc.gfxHair < 1 then npc.gfxHair = 151 end
		user_pages_hair.click(player, npc)
		
	else
		change = player:menuString("Are you sure to change "..pc.name.."'s hair to be like this?\nHair ID: "..npc.gfxHair, {"Yes", "No"})
		if change == "Yes" then
			pc.hair = npc.gfxHair
			pc:updateState()
			player:sendMinitext("Done!!")
			user_pages_hair.click(player, npc)
		end
	end
end
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
