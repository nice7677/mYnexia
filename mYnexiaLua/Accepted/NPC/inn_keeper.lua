inn_keeper = {

cast = function(player)

end,

click = async(function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	local total = player.registry["wardrobe_total"]
	local max = player.registry["max_wardrobe"]
	
	local buy = {40, 16, 21, 18005, 18004, 18006, 18007, 4080, 4081, 15001}
	
	if player.registry["bank_pin"] == 0 then
		register_bankPin.click(player, npc)
		return
	else
		local opts = {}
		table.insert(opts, "Supplies")
		table.insert(opts, "Storage")
		table.insert(opts, "Bank")
		table.insert(opts, "Wardrobe")
		table.insert(opts, "Change Bank Pin")
		table.insert(opts,"Take a sleep")
		table.insert(opts,"Mail Box")	
		table.insert(opts, "Exit")
		
		menu = player:menuString("<b>[Inn keeper]\n\nWhat can i help you?", opts)
		
		if menu == "Storage" then
			inn_keeper.f1click(player, npc)
		elseif menu == "Bank" then
			inn_keeper.click2(player, npc)
		elseif menu == "Supplies" then
			player:buyExtend("<b>[Inn keeper]\n\nWhat do you wish to buy?", buy)
		elseif menu == "Wardrobe" then
			if player.registry["max_wardrobe"] == 0 then player.registry["max_wardrobe"] = 15 end
			menu = player:menuString("<b>[Wardrobe]\n\nWhatsup with your wardrobe?\n\nWardrobe space: "..total.."/"..max, {"Deposit Item Mall", "Withdraw Item Mall", "Exit"})
			if menu == "Deposit Item Mall" then
				player:depositItemMall()
			elseif menu == "Withdraw Item Mall" then
				if player.registry["bank_access"] < os.time() then
					input = player:input("Please Enter your Pin number :")
					if math.abs(tonumber(input)) == player.registry["bank_pin"] then
						player.registry["bank_access"] = os.time()+40
						player:withdrawItemMall()
					else
						player:popUp("Incorrect PIN number!")
					end
				elseif player.registry["bank_access"] >= os.time() then
					player:withdrawItemMall()
				end
			end
		elseif menu == "Change Bank Pin" then
			change_pin(player, npc)
		elseif menu == "Mail Box" then
			local item = player:getParcel()
			local optsPO = {}
			table.insert(optsPO,"Send Parcel")	
			if (item ~= false) then table.insert(optsPO,"Receive Parcel") end
			if item ~= false then txt = "New pending parcel" else txt = "" end
			choice = player:menuString("<b>[Mail Box]\n\n"..txt.."",optsPO)		
			if choice == "Send Parcel" then	
				player:sendParcelTo(npc)
			elseif choice == "Receive Parcel" then	
				player:receiveParcelFrom(npc)
			end
		elseif menu == "Take a sleep" then
			player:dialogSeq({t, "<b>[Inn keeper]\n\nYou can borrow one of our beds for a sleep. This can regain your Health and Mana."}, 1)	
			local nap = player:menuString("Would you like to spend "..(player.level * 50).." coins for a sleep?", {"Yes", "No", "Exit"})	
			if (nap == "Yes") then	
				if (player:removeGold(player.level * 50)) then
					r = math.random(3)
					if r == 1 then player:warp(player.m, math.random(7,8), 5) end
					if r == 2 then player:warp(player.m, math.random(3,4), 5) end
					if r == 3 then player:warp(player.m, math.random(7,8), 9) end
					power_nap.cast(player)	
				end	
			end
		end
	end
end),

click2 = function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	if player.registry["bank_pin"] > 0 then
		menu = player:menuString("<b>[Bank]\n\nWhat can i help you?", {"Deposit Money", "Withdraw Money"})
		if menu == "Deposit Money" then
			player:bankAddMoney()
		elseif menu == "Withdraw Money" then
			if player.registry["bank_access"] < os.time() then
				input = player:input("Please Enter your Pin number :")
				if math.abs(tonumber(input)) == player.registry["bank_pin"] then
					player.registry["bank_access"] = os.time()+40
					player:bankWithdrawMoney()
				else
					player:popUp("Incorrect PIN number!")
				end
			elseif player.registry["bank_access"] >= os.time() then
				player:bankWithdrawMoney()
			end
		end
	else
		register_bankPin.click(player, npc)
	end
end,


f1click = function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0

	barang = player:menuString("<b>[Bank]\n\nWhat can i help you?", {"Deposit item", "Withdraw item", "Exit"})
	if barang == "Deposit item" then
		player:showBankAdd()
	elseif barang == "Withdraw item" then
		if player.registry["bank_access"] < os.time() then
			input = player:input("Please Enter your Pin number :")
			if math.abs(tonumber(input)) == player.registry["bank_pin"] then
				player.registry["bank_access"] = os.time()+40
				player:showBank("What do you want to withdraw?")
			else
				player:popUp("Incorrect PIN number!")
			end
		elseif player.registry["bank_access"] >= os.time() then
			player:showBank("What do you want to withdraw?")
		end		
	end
end
}


























