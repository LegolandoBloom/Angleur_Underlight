AngleurUnderlight_Queue = {
    unequip = false, -- true / false
    equip = nil -- itemID
}
local queue = AngleurUnderlight_Queue


local function isEligible(itemID)
    if not C_Item.IsEquippableItem(itemID) then return false end
    if not (C_Item.GetItemCount(itemID) >= 1) then
        return false
    end
    return true
end
local function equipRod()
    local fishingSlotItem = GetInventoryItemID("player", 28)
    queue.unequip = false
    if not isEligible(queue.equip) then
        Angleur_BetaPrint("equip item not eligible, removing from table.")
        queue.equip = nil
        return
    end
    if queue.equip == fishingSlotItem then
        Angleur_BetaPrint("equip successful")
        queue.equip = nil
        return
    end
    C_Item.EquipItemByName(queue.equip)
end


local function putInBag()
    local unequipTo = nil
    for i = 4, 0, -1 do
        local free, taipu = C_Container.GetContainerNumFreeSlots(i)
        if free > 0 then
            unequipTo = i
        end
    end
    Angleur_BetaPrint("will unequip to: ", unequipTo)
    if not unequipTo then
        Angleur_BetaPrint("no free slots in any of the bags")
        ClearCursor()
        queue.unequip = false
    elseif unequipTo == 0 then
        PutItemInBackpack()
    else
        PutItemInBag(CONTAINER_BAG_OFFSET + unequipTo)
    end
end
-- 1: holding something else  2: holding nothing 3: holding fishingSlotItem
local function checkCursor(fishingSlotItem)
    local infoType, itemID = GetCursorInfo()
    if infoType then
        if infoType == "item" and itemID == fishingSlotItem then
            return 3
        else
            return 1
        end
    end
    return 2
end
local function unequipRod()
    local fishingSlotItem = GetInventoryItemID("player", 28)
    if not fishingSlotItem then
        Angleur_BetaPrint("unequip successful, slot 28 empty")
        queue.unequip = false
        return
    end
    local cursorState = checkCursor(fishingSlotItem)
    if cursorState == 1 then
        Angleur_BetaPrint("Holding something else, waiting for player to release.")
        return
    elseif cursorState == 2 then
        PickupInventoryItem(28)
        cursorState = checkCursor(fishingSlotItem)
        if cursorState ==  3 then
            putInBag()
        end 
    elseif cursorState == 3 then
        putInBag()
    end
end

-- local loc = ItemLocation:CreateFromBagAndSlot(1, 2)
-- print(C_Item.GetItemName(loc))
-- C_Item.LockItem(loc)


-- local loc = ItemLocation:CreateFromBagAndSlot(1, 2)
-- C_Item.UnlockItem(loc)

local equipFrame = CreateFrame("Frame")
local erapusuThreshold = 0.3
local erapusuCounter = 0
function AngleurUnderlight_HandleQueue()
    if queue.unequip == false and queue.equip == nil then
        equipFrame:SetScript("OnUpdate", nil)
    else
        equipFrame:SetScript("OnUpdate", function(self, elapsed)
            erapusuCounter = erapusuCounter + elapsed
            if erapusuCounter < erapusuThreshold then
                return
            end
            erapusuCounter = 0
            if InCombatLockdown() then
                queue.unequip = false
                queue.equip = nil
                self:SetScript("OnUpdate", nil)
            end
            if queue.unequip then
                unequipRod()
            elseif queue.equip then
                equipRod()
            else
                Angleur_BetaPrint("table empty, removing script")
                if AngleurCharacter.sleeping == true and not IsSwimming() then
                    Angleur_FishingForAttentionAura()
                end
                self:SetScript("OnUpdate", nil)
            end
        end)
    end
end

SLASH_ANGLEURUNDERLIGHTTEST1 = "/undang1"
SlashCmdList["ANGLEURUNDERLIGHTTEST"] = function() 
    queue.unequip = true
    queue.equip = 133755
    AngleurUnderlight_HandleQueue()
end

SLASH_ANGLEURUNDERLIGHTTESTO1 = "/undang2"
SlashCmdList["ANGLEURUNDERLIGHTTESTO"] = function() 
    queue.unequip = false
    queue.equip = 133755
    AngleurUnderlight_HandleQueue()
end

SLASH_ANGLEURUNDERLIGHTTESTOO1 = "/undang3"
SlashCmdList["ANGLEURUNDERLIGHTTESTOO"] = function() 
    queue.unequip = true
    queue.equip = 198226
    AngleurUnderlight_HandleQueue()
end

SLASH_ANGLEURUNDERLIGHTTESTOOO1 = "/undang4"
SlashCmdList["ANGLEURUNDERLIGHTTESTOOO"] = function() 
    queue.unequip = false
    queue.equip = 198226
    AngleurUnderlight_HandleQueue()
end