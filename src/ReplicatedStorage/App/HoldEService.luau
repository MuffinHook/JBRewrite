local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_upvr = {}
local CircleAction_upvr = require(ReplicatedStorage.Module.UI).CircleAction
local ActionButtonService_upvr = require(ReplicatedStorage.ActionButton.ActionButtonService)
local ItemSystem_upvr = require(ReplicatedStorage.Game.ItemSystem.ItemSystem)
local Players_upvr = game:GetService("Players")
local VehicleUtils_upvr = require(ReplicatedStorage.Vehicle.VehicleUtils)
local InventoryItemBinder_upvr = require(ReplicatedStorage.Inventory.InventoryItemBinder)
function module_upvr.init() -- Line 12
    module_upvr._button = {
        primary = true;
        priority = 1050;
        noSink = true;
        saturateTo = 0;
        image = "rbxassetid://10770151584";
        keyCodes = {Enum.KeyCode.E, Enum.KeyCode.ButtonY};
        onPressed = function() -- Line 22, Named "onPressed"
            CircleAction_upvr.Press()
        end;
        onReleased = function() -- Line 25, Named "onReleased"
            CircleAction_upvr.Release()
        end;
    }
    ActionButtonService_upvr.add(module_upvr._button)
    CircleAction_upvr.onVisibilityChanged:Connect(function(arg1) -- Line 32
        if arg1 and module_upvr._button._pressed then
            module_upvr._button.onPressed()
        end
    end)
    local function updateVisibility_upvr(arg1) -- Line 39, Named "updateVisibility"
        local any_GetEquipped_result1 = ItemSystem_upvr.GetEquipped(Players_upvr.LocalPlayer)
        local var17 = not VehicleUtils_upvr.GetLocalVehiclePacket()
        local var18 = not any_GetEquipped_result1
        if not var18 then
            if any_GetEquipped_result1.ShootBegin ~= nil then
                var18 = false
            else
                var18 = true
            end
        end
        local var19
        if var18 or any_GetEquipped_result1 == nil then
            var19 = 1050
        else
            var19 = 775
        end
        if module_upvr._button.disabled == var17 or arg1 then
            ActionButtonService_upvr.setButtonEnabled(module_upvr._button, var17)
        end
        ActionButtonService_upvr.setButtonPrimary(module_upvr._button, var18)
        ActionButtonService_upvr.setButtonPriority(module_upvr._button, var19)
    end
    updateVisibility_upvr(true)
    local function handleItem(arg1) -- Line 61
        arg1._maid:GiveTask(arg1:GetEquippedSignal():Connect(function() -- Line 62
            if arg1:GetOwner() ~= Players_upvr.LocalPlayer then
            else
                updateVisibility_upvr()
            end
        end))
        if arg1:GetOwner() == Players_upvr.LocalPlayer then
            arg1._maid:GiveTask(function() -- Line 69
                updateVisibility_upvr()
            end)
        end
    end
    for _, v in InventoryItemBinder_upvr:GetAll() do
        handleItem(v)
    end
    InventoryItemBinder_upvr:GetClassAddedSignal():Connect(handleItem)
    VehicleUtils_upvr.OnVehicleEntered:Connect(function(arg1) -- Line 78
        updateVisibility_upvr()
    end)
    VehicleUtils_upvr.OnVehicleExited:Connect(function(arg1) -- Line 81
        updateVisibility_upvr()
    end)
end
return module_upvr