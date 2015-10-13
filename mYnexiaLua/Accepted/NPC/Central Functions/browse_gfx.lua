
browse_gfx = {

click = function(player, npc)

	gfxClone(player, npc)
	player.dialogType = 2
	
	local opts = {}
	table.insert(opts, "Face")
	table.insert(opts, "Hair")
	table.insert(opts, "Skin color")
	table.insert(opts, "Equipments")
	
	menu = player:menuString("<b>[Browse GFX]\n\nWhat gfx would you browse?", opts)
	
	if menu == "Face" then
		gfxClone(player, npc)
		browse_gfx.face(player, npc)
	elseif menu == "Hair" then
		gfxClone(player, npc)
		browse_gfx.hair(player, npc)
	elseif menu == "Skin color" then
		gfxClone(player, npc)
		browse_gfx.skin(player, npc)
	elseif menu == "Equipments" then
		local eq = {"Helm", "Crown", "Weapon", "Shield", "Armor", "Mantle", "Boots", "Necklace", "Face acc"}
		choice = player:menuString("<b>[Browse GFX]\n\nWhat equipments would you browse?", eq)
		if choice == "Helm" then
			browse_gfx.helm(player, npc)
		elseif choice == "Crown" then
			browse_gfx.crown(player, npc)
		elseif choice == "Weapon" then
			browse_gfx.weapon(player, npc)
		elseif choice == "Shield" then
			browse_gfx.shield(player, npc)
		elseif choice == "Armor" then
			browse_gfx.armor(player, npc)
		elseif choice == "Mantle" then
			browse_gfx.mantle(player, npc)
		elseif choice == "Boots" then
			browse_gfx.boots(player, npc)
		elseif choice == "Necklace" then
			browse_gfx.necklace(player, npc)
		elseif choice == "Face acc" then
			browse_gfx.face(player, npc)
		end
	end
end,


face = function(player, npc)

	local face = player.registry["browse_gfx_face"]
	local hair = player.registry["browse_gfx_hair"]
	local skin = player.registry["browse_gfx_skin"]
	local helm = player.registry["browse_gfx_helm"]
	local crown = player.registry["browse_gfx_crown"]
	local weapon = player.registry["browse_gfx_wepaon"]
	local shield = player.registry["browse_gfx_shield"]
	local armor = player.registry["browse_gfx_armor"]
	local mantle = player.registry["browse_gfx_mantle"]
	local boots = player.registry["browse_gfx_boots"]
	local neck = player.registry["browse_gfx_neck"]
	local face = player.registry["browse_gfx_face"]
	
	if face > 238 then player.registry["browse_gfx_face"] = 200 elseif face < 200 then player.registry["browse_gfx_face"] = 238 end
	if hair > 151 then player.registry["browse_gfx_hair"] = 0 elseif hair < 0 then player.registry["browse_gfx_hair"] = 151 end
	if skin < 0 then player.registry["browse_gfx_skin"] = 0 end

	
end
}
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	