local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage_upvr.Std.Signal)
local module_upvr = {
    onJumpPressed = Signal.new();
    onJumpReleased = Signal.new();
    jumpButton = {
        primary = true;
        priority = 1000;
        saturateTo = 0;
        image = "rbxassetid://7858404863";
        keyCodes = {Enum.KeyCode.Space, Enum.KeyCode.ButtonA};
    };
    sprintButton = {
        priority = 900;
        image = "rbxassetid://4939735995";
        keyCodes = {Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift, Enum.KeyCode.ButtonB};
        touchIsToggle = true;
        gamepadIsToggle = true;
    };
    crawlButton = {
        priority = 950;
        image = "rbxassetid://4939759147";
        keyCodes = {Enum.KeyCode.C, Enum.KeyCode.Z, Enum.KeyCode.DPadDown};
        allowPassThrough = true;
    };
    punchButton = {
        priority = 975;
        image = "rbxassetid://4939740172";
        keyCodes = {Enum.KeyCode.F, Enum.KeyCode.ButtonR2};
    };
    radioButton = {
        priority = 650;
        image = "rbxassetid://4970993126";
        keyCodes = {Enum.KeyCode.R, Enum.KeyCode.DPadLeft};
    };
}
local PlayerModuleService_upvr = require(ReplicatedStorage_upvr.PlayerModule.PlayerModuleService)
local ActionButtonService_upvr = require(ReplicatedStorage_upvr.ActionButton.ActionButtonService)
local VehicleUtils_upvr = require(ReplicatedStorage_upvr.Vehicle.VehicleUtils)
local InventoryItemSystem_upvr = require(ReplicatedStorage_upvr.Inventory.InventoryItemSystem)
local Players_upvr = game:GetService("Players")
local InventoryItemBinder_upvr = require(ReplicatedStorage_upvr.Inventory.InventoryItemBinder)
function module_upvr.init(arg1) -- Line 49
    module_upvr.jumpButton.onPressed = function(arg1_2) -- Line 50
        if arg1_2 ~= Enum.UserInputType.Keyboard and arg1_2 ~= Enum.UserInputType.Gamepad1 then
            PlayerModuleService_upvr.setIsJumping(true)
        end
        module_upvr.onJumpPressed:Fire()
    end
    module_upvr.jumpButton.onReleased = function() -- Line 58
        PlayerModuleService_upvr.setIsJumping(false)
        module_upvr.onJumpReleased:Fire()
    end
    ActionButtonService_upvr.add(module_upvr.jumpButton)
    module_upvr.sprintButton.onPressed = function() -- Line 65
        arg1.setSprinting(true)
    end
    module_upvr.sprintButton.onReleased = function() -- Line 68
        arg1.setSprinting(false)
    end
    ActionButtonService_upvr.add(module_upvr.sprintButton)
    module_upvr.crawlButton.onPressed = function() -- Line 73
        arg1.attemptToggleCrawling()
    end
    ActionButtonService_upvr.add(module_upvr.crawlButton)
    module_upvr.punchButton.onPressed = function() -- Line 77
        arg1.attemptPunch()
    end
    ActionButtonService_upvr.add(module_upvr.punchButton)
    local Radio_upvr = require(ReplicatedStorage_upvr.Game.Radio.Radio)
    module_upvr.radioButton.onPressed = function() -- Line 83
        Radio_upvr.Toggle()
    end
    ActionButtonService_upvr.add(module_upvr.radioButton)
    local function updatePunchVisibility(arg1_3) -- Line 89
        local var32
        if VehicleUtils_upvr.GetLocalVehiclePacket() == nil then
            var32 = false
        else
            var32 = true
        end
        local var33 = not var32
        if var33 then
            var33 = not InventoryItemSystem_upvr.getEquippedFor(Players_upvr.LocalPlayer)[1]
        end
        ActionButtonService_upvr.setButtonEnabled(module_upvr.punchButton, var33)
        if arg1_3 then
            ActionButtonService_upvr.setButtonPrimary(module_upvr.jumpButton, not var32)
        end
    end
    VehicleUtils_upvr.OnVehicleEntered:Connect(updatePunchVisibility)
    VehicleUtils_upvr.OnVehicleExited:Connect(updatePunchVisibility)
    local function handleItem(arg1_4) -- Line 100
        arg1_4._maid:GiveTask(arg1_4:GetEquippedSignal():Connect(function() -- Line 101
            local var35
            if var35 ~= Players_upvr.LocalPlayer then
            else
                if VehicleUtils_upvr.GetLocalVehiclePacket() == nil then
                    var35 = false
                else
                    var35 = true
                end
                local var36 = not var35
                if var36 then
                    var36 = not InventoryItemSystem_upvr.getEquippedFor(Players_upvr.LocalPlayer)[1]
                end
                ActionButtonService_upvr.setButtonEnabled(module_upvr.punchButton, var36)
            end
        end))
        if arg1_4:GetOwner() == Players_upvr.LocalPlayer then
            arg1_4._maid:GiveTask(function() -- Line 108
                local var38
                if VehicleUtils_upvr.GetLocalVehiclePacket() == nil then
                    var38 = false
                else
                    var38 = true
                end
                local var39 = not var38
                if var39 then
                    var39 = not InventoryItemSystem_upvr.getEquippedFor(Players_upvr.LocalPlayer)[1]
                end
                ActionButtonService_upvr.setButtonEnabled(module_upvr.punchButton, var39)
            end)
        end
    end
    local any_GetAll_result1, any_GetAll_result2, any_GetAll_result3 = InventoryItemBinder_upvr:GetAll()
    local var43
    for _, v in var43, any_GetAll_result2, any_GetAll_result3 do
        handleItem(v)
    end
    InventoryItemBinder_upvr:GetClassAddedSignal():Connect(handleItem)
    if VehicleUtils_upvr.GetLocalVehiclePacket() == nil then
        var43 = false
    else
        var43 = true
    end
    local var44 = not var43
    if var44 then
        var44 = not InventoryItemSystem_upvr.getEquippedFor(Players_upvr.LocalPlayer)[1]
    end
    ActionButtonService_upvr.setButtonEnabled(module_upvr.punchButton, var44)
end
return module_upvr
