clear_gfx = {

click = async(function(player)

	player.gfxClone = 0
	player:updateState()
	
end)
}

mall_welcome = {
click = function(player)

	player.dialogType = 0
	txt =      "<b>           [Item Mall Shop]\n\n"
	txt = txt.."----------------------------------------\n"
	txt = txt.."               Welcome !!\n\n"
	txt = txt.."We're sorry,\n\nThis building are still in under construction, "
	txt = txt.."there's not much things yet. But you still can go inside and take a look.^^\n\n"   
	txt = txt.."We'll do our best!\n\nIf there's any idea or sugestions you want to share with us,\n\nplease contact :         Nmail :\nmyvees89@yahoo.com       God / Newbie\n\n\n"
	player:popUp(txt.."Fri Sep 4 01:44:46 2015")


end
}