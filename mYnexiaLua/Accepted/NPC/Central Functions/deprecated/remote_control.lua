remote_control = {
click = function(player, npc)
	
	--if player.ID ~= 3 then player:popUp("You cannot do that") return end
	
	local pc = player.registry["still_controling"]

	if Player(pc) ~= nil then
	
		weap = Player(pc):getEquippedItem(EQ_WEAP)	
		armor = Player(pc):getEquippedItem(EQ_ARMOR)	
		crown = Player(pc):getEquippedItem(EQ_CROWN)	
		helm = Player(pc):getEquippedItem(EQ_HELM)	
		coat = Player(pc):getEquippedItem(EQ_COAT)	
		shield = Player(pc):getEquippedItem(EQ_SHIELD)	
		mantle = Player(pc):getEquippedItem(EQ_MANTLE)	
		boots = Player(pc):getEquippedItem(EQ_BOOTS)	
		neck = Player(pc):getEquippedItem(EQ_NECKLACE)	
		facea = Player(pc):getEquippedItem(EQ_FACEACC)
			
		npc.gfxTitle = Player(pc).title
		npc.gfxName = Player(pc).name
		npc.gfxHair = Player(pc).hair
		npc.gfxDye = Player(pc).skinColor
		npc.gfxFace = Player(pc).face
		npc.gfxFaceAT = 65535
	
		if weap ~= nil then
			npc.gfxWeap = weap.look
			npc.gfxWeapC = weap.lookC
		else
			npc.gfxWeap = 65535
		end
			
		if coat ~= nil then
			npc.gfxArmor = coat.look
			npc.gfxArmorC = coat.lookC
		else
			if armor ~= nil then
				npc.gfxArmor = armor.look
				npc.gfxArmorC = armor.lookC
			else
				npc.gfxArmor = Player(pc).sex
			end
		end
			
		if crown ~= nil then
			npc.gfxCrown = crown.look
			npc.gfxCrownC = crown.lookC
		else
			npc.gfxCrown = 65535
			if helm ~= nil then
				npc.gfxHelm = helm.look
				npc.gfxHelmC = helm.lookC
			else
				npc.gfxHelm = 65535
			end
		end
				
		if boots ~= nil then
			npc.gfxBoots = boots.look
			npc.gfxBootsC = boots.lookC
		else
			npc.gfxBoots = Player(pc).sex
		end
			
		if facea ~= nil then
			npc.gfxFaceA = facea.look
			npc.gfxFaceAC = facea.lookC
		else
			npc.gfxFaceA = 65535
		end
		
		if shield ~= nil then
			npc.gfxShield = shield.look
			npc.gfxShieldC = shield.lookC
		else
			npc.gfxShield = 65535
		end
			
		if mantle ~= nil then
			npc.gfxCape = mantle.look
			npc.gfxCapeC = mantle.lookC
		else
			npc.gfxCape = 65535
		end
			
		if neck ~= nil then
			npc.gfxNeck = neck.look
			npc.gfxNeckC = neck.lookC
		else
			npc.gfxNeck = 65535
		end
			
		npc.gfxClone = 1
		
		local t = {graphic = convertGraphic(npc.look ,"monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 2
		
		local opts = {}
		table.insert(opts, "Up")
		table.insert(opts, "Down")
		table.insert(opts, "Right")
		table.insert(opts, "Left")
			
		menu = player:menuString("[Remote Control]\nCurrent Target : "..Player(pc).name.."", opts)
		if Player(pc) ~= nil then
			if menu == "Up" then
				toXY(Player(pc), Player(pc).x, Player(pc).y-1)
				remote_control.click(player, npc)
			elseif menu == "Down" then
				toXY(Player(pc), Player(pc).x, Player(pc).y+1)
				remote_control.click(player, npc)
			elseif menu == "Right" then
				toXY(Player(pc), Player(pc).x+1, Player(pc).y)
				remote_control.click(player, npc)
			elseif menu == "Left" then
				toXY(Player(pc), Player(pc).x-1, Player(pc).y)
				remote_control.click(player, npc)
			end
			Player(pc):sendSide()
			Player(pc):refresh()
		end
	end
end
}
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			