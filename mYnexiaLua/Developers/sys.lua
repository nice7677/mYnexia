
_errhandler = function(str)

	return debug.traceback(str)
end

async = function(func)

	return function(player, ...)
		local args = { ... }
		_async(player, function()
			func(player, unpack(args))
			_asyncDone(player)
		end)
	end
end

convertGraphic = function(value, class)

	if class == "monster" then
		return 128*256+value
	elseif class == "item" then
		return 192*256+value
	end
	return value
end

getDialog = function(player, dialog)

	if (player.registry["languageSelection"] == 0) then
		return dialogs.english[dialog]
	elseif (player.registry["languageSelection"] == 1) then
		return dialogs.spanish[dialog]
	elseif (player.registry["languageSelection"] == 2) then
		return dialogs.french[dialog]
	elseif (player.registry["languageSelection"] == 3) then
		return dialogs.chinese[dialog]
	elseif (player.registry["languageSelection"] == 4) then
		return dialogs.portuguese[dialog]
	elseif (player.registry["languageSelection"] == 5) then
		return dialogs.indonesian[dialog]
	else
		return dialogs.english[dialog]
	end
end

checkBoard = function(player)

	local del = player.registry["board" .. player.board .. "del"]
	local write = player.registry["board" .. player.board .. "write"]
	player.boardDel = del
	player.boardWrite = write
end

f1Block = NPC(F1_NPC)
acPerArmor = 127 / 142462
armorPerAC = 142462 / 127
cronBlock = NPC(4294967295)
npchelpid = 66
noHP = "Not Enough HP"
noMP = "Not Enough MP"
cant_cast = "You cannot do that right now!"
already_cast = "Spell already cast!"
key = "intel2891"

advice = {"[INFO]: This server is made for FUN only!! so, let's have FUN!",
	"[INFO]: Press 'F1' for character status, information, Etc.",
	"[INFO]: For contacting staff, please whisper to '?'",
	"[INFO]: Press 'B' to show Bulletin boards, & 'M' to show Mailbox.",
	"[INFO]: Press 'Crtl + R' to refresh your screen.",
	"[INFO]: You could sell your item by Vending System from F4 npc.",
	"[INFO]: Someone interested in this server's project? contact us now!",
	"[INFO]: Please report any bugs found to our staff.",
	"[INFO]: Any suggestions can send via Nmail to 'God'/'NewBie' or Mail to myvees89@yahoo.com "}
	

getCurSeason = function()

	local season = curSeason()

	if (season == 1) then
		return "Winter"
	elseif (season == 2) then
		return "Spring"
	elseif (season == 3) then
		return "Summer"
	else
		return "Fall"
	end
end

minL = function(amount, limit)

	if (amount < limit) then
		return limit
	else
		return amount
	end
end


maxL = function(amount, limit)

	if (amount > limit) then
		return limit
	else
		return amount
	end
end