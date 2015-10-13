user_pages_equipment = {

click = function(player, npc)

	local pc = Player(player.registry["on_page"])
	local totem
	local country
	local class
	
	gfxClone(pc, npc)
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 2
	
	local weap = pc:getEquippedItem(0)
	local armor = pc:getEquippedItem(1)
	local shield = pc:getEquippedItem(2)
	local helm = pc:getEquippedItem(3)
	local left = pc:getEquippedItem(4)
	local right = pc:getEquippedItem(5)
	local script1 = pc:getEquippedItem(6)
	local script2 = pc:getEquippedItem(7)
	local facea = pc:getEquippedItem(8)
	local crown = pc:getEquippedItem(9)
	local mantle = pc:getEquippedItem(10)
	local necklace = pc:getEquippedItem(11)
	local boots = pc:getEquippedItem(12)
	local coat = pc:getEquippedItem(13)
	
	local opts = {}
	if weap ~= nil then table.insert(opts,    "Weapon   : "..weap.name) end
	if armor ~= nil then table.insert(opts,   "Armor    : "..armor.name) end
	if shield ~= nil then table.insert(opts,  "Shield   : "..shield.name) end
	if helm ~= nil then table.insert(opts,    "Helm     : "..helm.name) end
	if left ~= nil then table.insert(opts,    "Left     : "..left.name) end
	if right ~= nil then table.insert(opts,   "Right    : "..right.name) end
	if script1 ~= nil then table.insert(opts, "LeftAcc  : "..script1.name) end
	if script2 ~= nil then table.insert(opts, "RightAcc : "..script2.name) end
	if facea ~= nil then table.insert(opts,   "FaceAcc  : "..facea.name) end
	if crown ~= nil then table.insert(opts,   "Crown    : "..crown.name) end
	if mantle ~= nil then table.insert(opts,  "Mantle   : "..mantle.name) end
	if necklace ~= nil then table.insert(opts,"Necklace : "..necklace.name) end
	if boots ~= nil then table.insert(opts,   "Boots    : "..boots.name) end
	if coat ~= nil then table.insert(opts,    "Coat     : "..coat.name) end
	table.insert(opts, "<< Back")
	
	menu = player:menuString("<b>["..pc.name.."'s Equipment]:",opts)
	
	if not menu == "<< Back" then
		doo = player:menuString("<b>["..pc.name.."'s Equipment]:", {"unEquip", "Delete", "Change"})
		if doo ~= nil then
			player:popUp("Not implemented yet!")
		end
	elseif menu == "<< Back" then
		user_pages.click(player, npc)
	end
	
end
}
	
	
	
	
	
	
	
	
	
