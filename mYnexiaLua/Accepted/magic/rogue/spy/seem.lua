seem ={

on_learn = function(player) player.registry["learned_seem"] = 1 end,
on_forget = function(player) player.registry["learned_seem"] = 0 end,

cast = function(player)

    local pc = getTargetFacing(player, BL_PC)
    local magicCost = 1000
    local duration = 30000
    local aether = 60000
    
    if not player:canCast(1,1,0) then return end                       
    if player.magic < magicCost then notEnoughMP(player) return end 
    if player.gfxClone == 1 then return end
    if player:hasDuration("seem") then
        player:sendAnimation(279)
        player:sendMinitext("Spell already cast!")
        return
    end
    
    if pc ~= nil then
        if player.state == 1 or player.state == 4 then return else
            player_gfxClone(player, pc)
            player.gfxClone = 1
            player:refresh()
            player:sendMinitext("You cast Seem")
            player:setDuration("seem", duration)
            player:setAether("seem", aether)
        end
    end
end,

while_cast = function(player)

    player.gfxClone = 1
end,


uncast = function(player)

    player.gfxClone = 0
    player:refresh()
    player:calcStat()
end
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
