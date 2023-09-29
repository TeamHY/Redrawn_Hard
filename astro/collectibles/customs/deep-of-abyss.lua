Astro.Collectible.DEEP_OF_ABYSS = Isaac.GetItemIdByName("Deep Of Abyss")

if EID then
    EID:addCollectible(
        Astro.Collectible.DEEP_OF_ABYSS,
        "사용 시 {{Card41}}Black Rune 효과를 발동합니다.",
        "깊은 심연"
    )
end

Astro:AddCallback(
    ModCallbacks.MC_USE_ITEM,
    ---@param collectibleID CollectibleType
    ---@param rngObj RNG
    ---@param playerWhoUsedItem EntityPlayer
    ---@param useFlags UseFlag
    ---@param activeSlot ActiveSlot
    ---@param varData integer
    function(_, collectibleID, rngObj, playerWhoUsedItem, useFlags, activeSlot, varData)
        playerWhoUsedItem:UseCard(Card.RUNE_BLACK, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER)
        return true
    end,
    Astro.Collectible.DEEP_OF_ABYSS
)
