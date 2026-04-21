local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module_upvr = {}
local var3_upvw
local ItemSystem_upvr = require(ReplicatedStorage_upvr.Game.ItemSystem.ItemSystem)
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local InventoryItemUtils_upvr = require(ReplicatedStorage_upvr.Inventory.InventoryItemUtils)
function module_upvr.Init(arg1) -- Line 10
    var3_upvw = require(ReplicatedStorage_upvr.Game.ItemSkin.UI.UI)
    arg1.em.qrdwl12x = function(arg1_2) -- Line 15, Named "qrdwl12x"
        assert(arg1_2)
        module_upvr.ItemSkinsOwned = arg1_2
        var3_upvw.UpdateOwned()
    end
    var3_upvw.OnSkinClick:Connect(function(arg1_3) -- Line 24
        local any_GetLocalEquipped_result1_3 = ItemSystem_upvr.GetLocalEquipped()
        if any_GetLocalEquipped_result1_3 == nil then
            error("Player has no item equipped.")
        end
        if any_GetLocalEquipped_result1_3.ApplySkin == nil then
            error(string.format("Item %s does not suppory skins.", any_GetLocalEquipped_result1_3.__ClassName))
        end
        if module_upvr.DoesPlayerOwn(arg1_3.Name) then
            any_GetLocalEquipped_result1_3:ApplySkin(arg1_3.Name)
        else
            any_GetLocalEquipped_result1_3:ApplySkinLocal(arg1_3.Name)
        end
        Audio_upvr.ObjectLocal(any_GetLocalEquipped_result1_3.Model.Skeleton.BoundingBox, 4761679152)
    end)
    local Event_upvr = arg1.Event
    var3_upvw.OnSkinBuyClick:Connect(function(arg1_4) -- Line 40
        local any_GetLocalEquipped_result1 = ItemSystem_upvr.GetLocalEquipped()
        if any_GetLocalEquipped_result1 == nil then
            error("Player has no item equipped.")
        end
        if any_GetLocalEquipped_result1.ApplySkin == nil then
            error(string.format("Item %s does not suppory skins.", any_GetLocalEquipped_result1.__ClassName))
        end
        Event_upvr:FireServer("m4dwvvqf", any_GetLocalEquipped_result1.inventoryItemValue, arg1_4.Name)
        Audio_upvr.ObjectLocal(any_GetLocalEquipped_result1.Model.Skeleton.BoundingBox, 4761679547)
    end)
    var3_upvw.OnClosed:Connect(function() -- Line 51
        local any_GetLocalEquipped_result1_2 = ItemSystem_upvr.GetLocalEquipped()
        if any_GetLocalEquipped_result1_2 ~= nil then
            if any_GetLocalEquipped_result1_2.ApplySkin == nil then
                error(string.format("Item %s does not suppory skins.", any_GetLocalEquipped_result1_2.__ClassName))
            end
            any_GetLocalEquipped_result1_2:ApplySkinLocal(InventoryItemUtils_upvr.getAttr(any_GetLocalEquipped_result1_2.inventoryItemValue, "SkinName"))
        end
    end)
end
function module_upvr.DoesPlayerOwn(arg1) -- Line 62
    if arg1 == "None" then
        return true
    end
    if module_upvr.ItemSkinsOwned == nil then
        error("Item skins have not been synced on client yet.")
    end
    return module_upvr.ItemSkinsOwned[arg1]
end
return module_upvr