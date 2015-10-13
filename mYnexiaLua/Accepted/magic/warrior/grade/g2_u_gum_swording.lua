u_gum_swording = {

on_learn = function(player) player.registry["learned_u_gum_swording"] = 1 end,
on_forget = function(player) player.registry["learned_u_gum_swording"] = 0 end,


cast = function(player)

	local magicCost = 3000
	local healthCost = player.health*.5
	local damage = player.health*1.8
	local threat
	local m = player.m
	local x = player.x
	local y = player.y
	local s = player.side
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player.health = player.health - healthCost
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendAction(1, 20)
	player:playSound(104)
	player:talk(2, "Force Bleh~!!!")
	player:setAether("u_gum_swording", 15000)
	player:sendMinitext("You cast U Gum Swording")

	for i = 1, 3 do
		local pc = getTargetFacing(player, BL_PC, 0, i)
		local mob = getTargetFacing(player, BL_MOB, 0, i)
		
		if s==0 then player:sendAnimationXY(342,x,y-i) end
		if s==1 then player:sendAnimationXY(342,x+i,y) end
		if s==2 then player:sendAnimationXY(342,x,y+i) end
		if s==3 then player:sendAnimationXY(342,x-i,y) end		
		
		if pc ~= nil then
			if player:canPK(pc) then
				pc.attacker = player.ID
				pc:sendAnimation(9)
				pc:sendMinitext(player.name.." hit you with U gum Swording")
				pc:removeHealthExtend(damage, 1,1,1,1,0)
				player:playSound(89)
			end
		elseif mob ~= nil then
			mob:sendAnimation(9)
			mob.attacker = player.ID
			threat = mob:removeHealthExtend(damage, 1,1,1,1,2)
			player:addThreat(mob.ID, threat)
			mob:removeHealthExtend(damage, 1,1,1,1,0)
			player:playSound(89)
		end
	end
end
}
