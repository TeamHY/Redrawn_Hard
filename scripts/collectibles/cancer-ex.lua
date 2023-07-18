Astrobirth.Collectible.CANCER_EX = Isaac.GetItemIdByName("Cancer EX")

if EID then
    EID:addCollectible(Astrobirth.Collectible.CANCER_EX, "몬스터에게 준 피해의 1/4 만큼 방안에 모든 몬스터들에게 대미지를 입힙니다", "초 게자리")
end

Astrobirth:AddCallback(
    ModCallbacks.MC_ENTITY_TAKE_DMG,
    ---@param entity Entity
    ---@param amount number
    ---@param damageFlags number
    ---@param source EntityRef
    ---@param countdownFrames number
    function(_, entity, amount, damageFlags, source, countdownFrames)
        local player = Isaac.GetPlayer(0)
        local entities = Isaac.GetRoomEntities()

        if
            player:HasCollectible(Astrobirth.Collectible.CANCER_EX) and entity:IsVulnerableEnemy() and
                entity.Type ~= EntityType.ENTITY_FIREPLACE
         then
            if
                source.Type == EntityType.ENTITY_TEAR or
                    damageFlags & DamageFlag.DAMAGE_LASER == DamageFlag.DAMAGE_LASER or
                    source.Type == EntityType.ENTITY_KNIFE
             then
                for i = 1, #entities do
                    if entities[i]:IsVulnerableEnemy() and entities[i].Type ~= EntityType.ENTITY_FIREPLACE then
                        entities[i]:TakeDamage(amount / 5, 0, EntityRef(player), 1)
                    end
                end
            end
        end
    end
)
