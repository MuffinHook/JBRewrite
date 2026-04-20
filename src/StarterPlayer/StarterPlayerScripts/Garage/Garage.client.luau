local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GarageConsts = require(ReplicatedStorage.Garage.GarageConsts)
local store_upvr = require(ReplicatedStorage.App.store)
local OwnershipConsts_upvr = require(ReplicatedStorage.Ownership.OwnershipConsts)
ReplicatedStorage:WaitForChild(GarageConsts.UPDATE_OWNED_REMOTE_NAME).OnClientEvent:Connect(function(arg1) -- Line 8
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local tbl_3 = {}
    for i, v in pairs(arg1) do
        if i ~= "CustomizationSlots" then
            tbl_3[i] = v
        end
    end
    for i_2 in pairs(OwnershipConsts_upvr.COLOR_CATEGORY_TYPES) do
        tbl_3[i_2] = tbl_3.Color
    end
    tbl_3.Color = nil
    for i_3 in pairs(OwnershipConsts_upvr.TEXTURE_CATEGORY_TYPES) do
        tbl_3[i_3] = tbl_3.Texture
    end
    store_upvr:dispatch({
        type = "setOwnedRaw";
        owned = tbl_3;
    })
    store_upvr:dispatch({
        type = "setSavesRaw";
        saves = arg1.CustomizationSlots;
    })
end)
ReplicatedStorage:WaitForChild(GarageConsts.UPDATE_EQUIPPED_REMOTE_NAME).OnClientEvent:Connect(function(arg1) -- Line 34
    local tbl = {
        type = "setEquippedRaw";
    }
    tbl.equipped = arg1
    store_upvr:dispatch(tbl)
end)
ReplicatedStorage:WaitForChild(GarageConsts.UPDATE_FAVORITED_REMOTE_NAME).OnClientEvent:Connect(function(arg1) -- Line 42
    local tbl_2 = {
        type = "setFavoritedRaw";
    }
    tbl_2.favorited = arg1
    store_upvr:dispatch(tbl_2)
end)
ReplicatedStorage:WaitForChild(GarageConsts.SET_IN_PHYSICAL_REMOTE_NAME).OnClientEvent:Connect(function(arg1) -- Line 50
    local tbl_4 = {
        type = "setInPhysical";
    }
    tbl_4.inPhysical = arg1
    store_upvr:dispatch(tbl_4)
end)
local PopularSort_upvr = require(ReplicatedStorage.Garage.PopularSort)
ReplicatedStorage:WaitForChild(GarageConsts.FILL_POPULAR_SORT_REMOTE_NAME).OnClientEvent:Connect(function(arg1) -- Line 59
    PopularSort_upvr.setRaw(arg1)
end)