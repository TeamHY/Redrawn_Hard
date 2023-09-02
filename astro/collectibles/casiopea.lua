local isc = require("astro.lib.isaacscript-common")

Astro.Collectible.CASIOPEA = Isaac.GetItemIdByName("Casiopea")

if EID then
    EID:addCollectible(Astro.Collectible.CASIOPEA, "다음 게임 시작 시 랜덤 황금 장신구와 {{Pill1}}Gulp!가 소환됩니다.", "카시오페아")
end

Astro:AddCallback(
    ModCallbacks.MC_POST_GAME_STARTED,
    ---@param isContinued boolean
    function(_, isContinued)
        if not isContinued and Astro.Data.RunCasiopea then
            local player = Isaac.GetPlayer()
            local game = Game()
            local currentRoom = game:GetLevel():GetCurrentRoom()
            local itemPool = game:GetItemPool()
            local pillColor = itemPool:ForceAddPillEffect(PillEffect.PILLEFFECT_GULP)

            Isaac.Spawn(
                EntityType.ENTITY_PICKUP,
                PickupVariant.PICKUP_PILL,
                pillColor,
                currentRoom:FindFreePickupSpawnPosition(player.Position, 40, true),
                Vector.Zero,
                nil
            )
            Isaac.Spawn(
                EntityType.ENTITY_PICKUP,
                PickupVariant.PICKUP_TRINKET,
                itemPool:GetTrinket() + 32768,
                currentRoom:FindFreePickupSpawnPosition(player.Position, 40, true),
                Vector.Zero,
                nil
            )

            Astro.Data.RunCasiopea = false
        end
    end
)

Astro:AddCallbackCustom(
    isc.ModCallbackCustom.POST_PLAYER_COLLECTIBLE_ADDED,
    ---@param player EntityPlayer
    ---@param collectibleType CollectibleType
    function(_, player, collectibleType)
        Astro.Data.RunCasiopea = true
    end,
    Astro.Collectible.CASIOPEA
)
