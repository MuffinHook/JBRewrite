local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemCamera_upvr = require(ReplicatedStorage.Game.ItemSystem.ItemCamera)
local any_GetCameras_result1_upvw = require(game:GetService("Players").LocalPlayer.PlayerScripts.PlayerModule):GetCameras()
local Basic_upvr = require(script.Parent.Basic)
local tbl_upvr = {
    Motion = {
        Hip = {
            Springs = {
                ItemOffset = Vector3.new(0, 0.60000, -1.5);
                ItemRotation = Vector3.new();
                NeckRotation = Vector3.new();
                WaistRotation = Vector3.new();
            };
        };
        Eyes = {
            Springs = {
                ItemOffset = Vector3.new(0, 2.70000, -1);
                ItemRotation = Vector3.new();
                NeckRotation = Vector3.new(0.20000, 0, 0);
                WaistRotation = Vector3.new(-0.2000, 0, 0);
            };
        };
        RightWristRotation = CFrame.new();
        LeftWristRotation = CFrame.new();
    };
}
local var11_upvw
local module_upvr = {
    __ClassName = "Binoculars";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Basic_upvr)
function module_upvr.Init(arg1) -- Line 43
    var11_upvw = arg1.ScreenGui
end
function module_upvr.new(arg1, arg2, arg3) -- Line 46
    local any_new_result1_upvr = Basic_upvr.new(arg1, arg2, tbl_upvr, arg3)
    setmetatable(any_new_result1_upvr, module_upvr)
    if any_new_result1_upvr.Local then
        any_new_result1_upvr.Maid:GiveTask(function() -- Line 51
            any_new_result1_upvr:Hide()
        end)
    end
    return any_new_result1_upvr
end
local PartUtils_upvr = require(ReplicatedStorage.Std.PartUtils)
function module_upvr.Look(arg1) -- Line 58
    if arg1.Local then
        local var16 = var11_upvw.AbsoluteSize.X + 40
        local Y = var11_upvw.AbsoluteSize.Y
        var11_upvw.Binoculars.ImageLabel.Size = UDim2.new(0, var16, 0, var16 * 0.6)
        var11_upvw.Binoculars.ImageLabel.Position = UDim2.new(0.5, -var16 * 0.5, 0.5, -var16 * 0.6 * 0.5)
        var11_upvw.Binoculars.BarTop.Position = UDim2.new(0, 0, 0, -100)
        var11_upvw.Binoculars.BarTop.Size = UDim2.new(1, 0, 0, (Y - var16 * 0.6) * 0.5 + 20 + 100)
        var11_upvw.Binoculars.BarBottom.Size = UDim2.new(1, 0, 0, (Y - var16 * 0.6) * 0.5 + 20)
        var11_upvw.Binoculars.BarBottom.Position = UDim2.new(0, 0, 1, -((Y - var16 * 0.6) * 0.5 + 20))
        var11_upvw.Binoculars.Visible = true
        ItemCamera_upvr.Zoom(15)
        local activeCameraController_2 = any_GetCameras_result1_upvw.activeCameraController
        if activeCameraController_2 then
            arg1.prevSubjectDistance = activeCameraController_2.currentSubjectDistance
            activeCameraController_2:SetCameraToSubjectDistance(0.5)
        end
        ItemCamera_upvr.setSensitivity(0.3)
        arg1.rollbackTransparency = PartUtils_upvr.setPropertyWithRollback(arg1.Model, "LocalTransparencyModifier", 1)
    end
    arg1.SpringItemOffset:SetTarget(arg1.Config.Motion.Eyes.Springs.ItemOffset)
    arg1.SpringItemRotation:SetTarget(arg1.Config.Motion.Eyes.Springs.ItemRotation)
    arg1.SpringNeckRotation:SetTarget(arg1.Config.Motion.Eyes.Springs.NeckRotation)
    arg1.SpringWaistRotation:SetTarget(arg1.Config.Motion.Eyes.Springs.WaistRotation)
end
function module_upvr.Hide(arg1) -- Line 86
    if arg1.Local then
        if var11_upvw.Binoculars.Visible then
            var11_upvw.Binoculars.Visible = false
            ItemCamera_upvr.Zoom(70)
            if arg1.prevSubjectDistance then
                local activeCameraController = any_GetCameras_result1_upvw.activeCameraController
                if activeCameraController then
                    activeCameraController:SetCameraToSubjectDistance(arg1.prevSubjectDistance)
                end
                arg1.prevSubjectDistance = nil
            end
            ItemCamera_upvr.setSensitivity(1)
        end
        if arg1.rollbackTransparency then
            arg1.rollbackTransparency()
            arg1.rollbackTransparency = nil
        end
    end
    arg1.SpringItemOffset:SetTarget(arg1.Config.Motion.Hip.Springs.ItemOffset)
    arg1.SpringItemRotation:SetTarget(arg1.Config.Motion.Hip.Springs.ItemRotation)
    arg1.SpringNeckRotation:SetTarget(arg1.Config.Motion.Hip.Springs.NeckRotation)
    arg1.SpringWaistRotation:SetTarget(arg1.Config.Motion.Hip.Springs.WaistRotation)
end
function module_upvr.InputBegan(arg1, arg2, arg3) -- Line 111
    local var21 = true
    if arg2.UserInputType ~= Enum.UserInputType.MouseButton1 then
        var21 = false
        if arg2.UserInputType == Enum.UserInputType.Gamepad1 then
            if arg2.KeyCode ~= Enum.KeyCode.ButtonR2 then
                var21 = false
            else
                var21 = true
            end
        end
    end
    if var21 then
        arg1:Look()
        if arg1.Local then
            arg1:BroadcastInputBegan(arg2)
        end
    end
    Basic_upvr.InputBegan(arg1, arg2, arg3)
end
function module_upvr.InputEnded(arg1, arg2) -- Line 124
    local var22 = true
    if arg2.UserInputType ~= Enum.UserInputType.MouseButton1 then
        var22 = false
        if arg2.UserInputType == Enum.UserInputType.Gamepad1 then
            if arg2.KeyCode ~= Enum.KeyCode.ButtonR2 then
                var22 = false
            else
                var22 = true
            end
        end
    end
    if var22 then
        arg1:Hide()
        if arg1.Local then
            arg1:BroadcastInputBegan(arg2)
        end
    end
end
return module_upvr