local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local PlayerModule_upvr = LocalPlayer_upvr.PlayerScripts.PlayerModule
local CameraSensitivity_upvr = PlayerModule_upvr:FindFirstChild("CameraModule"):FindFirstChild("CameraSensitivity")
PlayerModule_upvr:FindFirstChild("CameraModule"):FindFirstChild("CameraOffset").Value = Vector3.new(2, 1, 0.25)
local any_GetCameras_result1_upvr = require(PlayerModule_upvr):GetCameras()
local UserInputService_upvr = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerUtils_upvr = require(ReplicatedStorage.Game.PlayerUtils)
local CurrentCamera_upvr = workspace.CurrentCamera
local var9_upvw = 0
local var10_upvw = 0
local module_upvr = {
    Locked = true;
}
local function GetLocalAccessoryParts_upvr() -- Line 33, Named "GetLocalAccessoryParts"
    if LocalPlayer_upvr.Character then
        for _, v in LocalPlayer_upvr.Character:QueryDescendants("BasePart#Handle") do
            if v.Parent:IsA("Accessory") and (v:FindFirstChild("BodyBackAttachment") or v:FindFirstChild("NeckAttachment")) then
                table.insert({}, v)
            end
        end
    end
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    return {}
end
local function _() -- Line 47, Named "HideAccessories"
    for _, v_2 in GetLocalAccessoryParts_upvr() do
        v_2.LocalTransparencyModifier = 0.8
    end
end
local function _() -- Line 52, Named "ShowAccessories"
    local var26
    if var26 then
        var26 = LocalPlayer_upvr
        var26 = var26.Character:FindFirstChild("Head")
    end
    local var30
    for _, v_3 in GetLocalAccessoryParts_upvr() do
        if var26 then
            var30 = var26.LocalTransparencyModifier
        else
            var30 = 0
        end
        v_3.LocalTransparencyModifier = var30
    end
end
local var31_upvw
local var32_upvw
local function InputChanged_upvr(arg1) -- Line 61, Named "InputChanged"
    if arg1.UserInputType == Enum.UserInputType.MouseMovement then
        local Delta = arg1.Delta
        var9_upvw -= Delta.X * 0.005
        var10_upvw -= Delta.Y * 0.005
        var10_upvw = math.clamp(var10_upvw, -1.4, 1.2)
    end
end
local Logic_upvr = require(ReplicatedStorage.Module.Logic)
local gameSettingType_upvr = require(ReplicatedStorage.GameSettings.gameSettingType)
local GameSettingsService_upvr = require(ReplicatedStorage.GameSettings.GameSettingsService)
function module_upvr.Init() -- Line 78
    var31_upvw = Logic_upvr.MakeSpring()
    var31_upvw.Target = 70
    var31_upvw.v = 0
    var31_upvw.p = var31_upvw.Target
    var31_upvw.Damp = 0.9
    var31_upvw.Freq = 20
    var32_upvw = Logic_upvr.MakeSpring()
    var32_upvw.Target = 0
    var32_upvw.v = 0
    var32_upvw.p = var32_upvw.Target
    var32_upvw.Damp = 0.9
    var32_upvw.Freq = 40
    UserInputService_upvr.InputChanged:Connect(InputChanged_upvr)
    local tbl = {
        name = "weaponCamLock";
        title = "Weapon Camera Lock";
        type = gameSettingType_upvr.Checkbox;
        defaultValue = true;
        order = 200;
    }
    GameSettingsService_upvr.add(tbl)
    module_upvr.setLocked(tbl:getValue())
    tbl.onChanged:Connect(function(arg1) -- Line 102, Named "handleSetting"
        module_upvr.setLocked(arg1)
    end)
    module_upvr.UISetting = tbl
end
local var38_upvw
module_upvr.equipped = false
function module_upvr.Adjust(arg1) -- Line 114
    var9_upvw += arg1.Y
    var10_upvw += arg1.X
end
function module_upvr.SetRecoilSpring(arg1) -- Line 120
    assert(arg1)
    var38_upvw = arg1
end
function module_upvr.setLocked(arg1) -- Line 124
    module_upvr.Locked = arg1
    module_upvr.updateMouseLock()
end
local InputUtils_upvr = require(ReplicatedStorage.Std.InputUtils)
function module_upvr.updateMouseLock() -- Line 128
    local any_getHumanoid_result1 = PlayerUtils_upvr.getHumanoid(LocalPlayer_upvr)
    local activeMouseLockController = any_GetCameras_result1_upvr.activeMouseLockController
    if activeMouseLockController then
        if module_upvr.Locked or InputUtils_upvr.isTouch() or UserInputService_upvr:GetLastInputType() == Enum.UserInputType.Gamepad1 or module_upvr.equipped and not any_getHumanoid_result1.Sit and not any_getHumanoid_result1.PlatformStand then
            if not activeMouseLockController:GetIsMouseLocked() then
                activeMouseLockController:OnMouseLockToggled()
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
        elseif activeMouseLockController:GetIsMouseLocked() then
            activeMouseLockController:OnMouseLockToggled()
        end
    end
    local var42 = not module_upvr.getMouseLocked()
    if any_getHumanoid_result1 and any_getHumanoid_result1.AutoRotate ~= var42 then
        any_getHumanoid_result1.AutoRotate = var42
    end
end
function module_upvr.getMouseLocked() -- Line 155
    local var44 = any_GetCameras_result1_upvr.activeMouseLockController
    if var44 then
        var44 = any_GetCameras_result1_upvr.activeMouseLockController:GetIsMouseLocked()
    end
    return var44
end
function module_upvr.getSensitivity() -- Line 159
    return CameraSensitivity_upvr.Value
end
function module_upvr.setSensitivity(arg1) -- Line 162
    CameraSensitivity_upvr.Value = arg1
    local any_getSensitivity_result1_upvr = module_upvr.getSensitivity()
    return function() -- Line 165
        CameraSensitivity_upvr.Value = any_getSensitivity_result1_upvr
    end
end
local os_clock_result1_upvw = os.clock()
local MovementRollService_upvr = require(ReplicatedStorage.MovementRoll.MovementRollService)
function module_upvr.Update() -- Line 170
    local os_clock_result1_2 = os.clock()
    local var54 = os_clock_result1_2 - os_clock_result1_upvw
    os_clock_result1_upvw = os_clock_result1_2
    module_upvr.updateMouseLock()
    local var55
    if module_upvr.getMouseLocked() then
        var55 = LocalPlayer_upvr
        if not MovementRollService_upvr.isPlayerRolling(var55) then
            var55 = LocalPlayer_upvr
            local any_getRootPart_result1 = PlayerUtils_upvr.getRootPart(var55)
            if any_getRootPart_result1 then
                var55 = any_getRootPart_result1.CFrame
                any_getRootPart_result1.CFrame = CFrame.lookAt(Vector3.new(), (CurrentCamera_upvr.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit) + var55.p
            end
        end
    end
    var55 = CurrentCamera_upvr
    var55.FieldOfView = var31_upvw:Update()
    var55 = nil
    if var38_upvw then
        var55 = var38_upvw:Update()
    end
    if var55 then
        CurrentCamera_upvr.CFrame = CurrentCamera_upvr.CFrame * CFrame.Angles(0, var55.Y * var54 * 60, 0) * CFrame.Angles(var55.X * var54 * 60, 0, 0)
    end
end
function module_upvr.Zoom(arg1) -- Line 198
    var31_upvw:SetTarget(arg1)
end
function module_upvr.GetCameraDistance() -- Line 201
    local activeCameraController_2 = any_GetCameras_result1_upvr.activeCameraController
    if not activeCameraController_2 then
        return 0
    end
    return activeCameraController_2:GetCameraToSubjectDistance()
end
function module_upvr.SetCameraDistance(arg1) -- Line 208
    local activeCameraController = any_GetCameras_result1_upvr.activeCameraController
    if not activeCameraController then
        return 0
    end
    return activeCameraController:SetCameraToSubjectDistance(arg1)
end
local var59_upvw = false
local var60_upvw
function module_upvr.OnItemEquipped(arg1, arg2) -- Line 216
    module_upvr.equipped = true
    local Character = LocalPlayer_upvr.Character
    assert(Character)
    assert(Character:FindFirstChild("Humanoid"))
    if arg1 then
        if math.abs(var32_upvw.Target - 2) <= 0.01 then
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
    end
    var32_upvw.p = 0
    var32_upvw.v = 0
    var32_upvw.t = tick()
    var32_upvw:SetTarget(2)
    var59_upvw = true
    var60_upvw = {Character, workspace.Items}
    if not arg2 then
        for _, v_4 in GetLocalAccessoryParts_upvr() do
            v_4.LocalTransparencyModifier = 0.8
        end
    end
    module_upvr.Update()
    PlayerModule_upvr:FindFirstChild("CameraModule"):FindFirstChild("DisableAutoRotate").Value = true
end
function module_upvr.OnItemUnequipped() -- Line 242
    module_upvr.equipped = false
    var31_upvw.p = 70
    var31_upvw.Target = var31_upvw.p
    CurrentCamera_upvr.FieldOfView = 70
    assert(LocalPlayer_upvr.Character)
    local var72
    if var72 then
        var72 = LocalPlayer_upvr
        var72 = var72.Character:FindFirstChild("Head")
    end
    local var76
    for _, v_5 in GetLocalAccessoryParts_upvr() do
        if var72 then
            var76 = var72.LocalTransparencyModifier
        else
            var76 = 0
        end
        v_5.LocalTransparencyModifier = var76
    end
    var72 = module_upvr
    var72 = var72.updateMouseLock
    var72()
    var72 = PlayerModule_upvr:FindFirstChild("CameraModule"):FindFirstChild("DisableAutoRotate")
    var72.Value = false
end
return module_upvr