local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VehicleData_upvr = require(ReplicatedStorage.Game.Garage.VehicleData)
local function updateVehicleCamera_upvr(arg1, arg2) -- Line 12, Named "updateVehicleCamera"
    local var3 = os.clock() / 2
    arg1.CFrame = CFrame.Angles(0, var3 % (-math.pi*2), 0) * CFrame.Angles(math.sin(var3 * 0.5) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, arg2.BoundingBox.Size.Magnitude * 0.8)
end
local function _(arg1) -- Line 19, Named "getVehicleDataForMake"
    for _, v in ipairs(VehicleData_upvr) do
        if v.Make == arg1 then
            return v
        end
    end
end
local PlayerDataConsts_upvr = require(ReplicatedStorage.PlayerData.PlayerDataConsts)
local StoreData_upvr = require(ReplicatedStorage.Game.Garage.StoreData)
local getDefaultVehicleModel_upvr = require(ReplicatedStorage.Game.getDefaultVehicleModel)
local HomeItemUIUtils_upvr = require(ReplicatedStorage.Home.HomeItem.HomeItemUIUtils)
local ItemSkinUIUtils_upvr = require(ReplicatedStorage.Game.ItemSkin.UI.ItemSkinUIUtils)
local SAFE_DATA_upvr = require(ReplicatedStorage.Safes.SafesConsts).SAFE_DATA
local ConsumablesData_upvr = require(ReplicatedStorage.Consumables.ConsumablesData)
return function(arg1) -- Line 27
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    assert(arg1.ItemType, "missing ItemType")
    local module = {}
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local CategoryName = arg1.CategoryName
    local any_GetCategoryByName_result1_upvr = StoreData_upvr.GetCategoryByName(CategoryName)
    local ItemName = arg1.ItemName
    local any_GetItemByName_result1_upvr = StoreData_upvr.GetItemByName(CategoryName, ItemName)
    if not any_GetItemByName_result1_upvr or typeof(any_GetItemByName_result1_upvr) ~= "table" then
        warn("Missing vehCust for: "..CategoryName..'/'..ItemName)
        return
    end
    function module.getInst() -- Line 40
        return any_GetCategoryByName_result1_upvr.GetInstance(any_GetItemByName_result1_upvr)
    end
    module.getInstCompare = "VehCust"..CategoryName..ItemName
    module.updateCamera = any_GetCategoryByName_result1_upvr.Update
    do
        return module
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end