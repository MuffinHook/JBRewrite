-- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
local Players_upvr = game:GetService("Players")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local ActionButtonService_upvr = require(ReplicatedStorage_upvr.ActionButton.ActionButtonService)
local VehicleUtils_upvr = require(ReplicatedStorage_upvr.Vehicle.VehicleUtils)
local MovementRollService_upvr = require(ReplicatedStorage_upvr.MovementRoll.MovementRollService)
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local tbl_4_upvr = {}
local tbl = {}
local var17_upvr
if require(ReplicatedStorage_upvr.App.RunUtils).getEnv() == require(ReplicatedStorage_upvr.App.RunConsts).QA_NAME then
    var17_upvr = "rbxassetid://13556910021"
else
    var17_upvr = "rbxassetid://12753913583"
end
tbl.animationId = var17_upvr
var17_upvr = false
tbl.looped = var17_upvr
tbl_4_upvr.Roll = tbl
local tbl_3 = {}
var17_upvr = tbl_4_upvr
for i, v in var17_upvr do
    tbl_3[i] = Instance.new("Animation")
    tbl_3[i].AnimationId = v.animationId
    local var19_upvr
end
var17_upvr = {}
local function characterAdded_upvr(arg1) -- Line 31, Named "characterAdded"
    local Animator = arg1:WaitForChild("Humanoid"):WaitForChild("Animator")
    for i_2, v_2 in var19_upvr do
        local any_LoadAnimation_result1 = Animator:LoadAnimation(v_2)
        any_LoadAnimation_result1.Priority = Enum.AnimationPriority.Action
        any_LoadAnimation_result1.Looped = tbl_4_upvr[i_2].looped
        var17_upvr[i_2] = any_LoadAnimation_result1
    end
end
local function _(arg1) -- Line 42, Named "playerAdded"
    if arg1.Character then
        characterAdded_upvr(arg1.Character)
    end
    arg1.CharacterAdded:Connect(characterAdded_upvr)
end
local LocalPlayer = Players_upvr.LocalPlayer
if LocalPlayer.Character then
    characterAdded_upvr(LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(characterAdded_upvr)
local function _(arg1) -- Line 50, Named "playRollSound"
    local PrimaryPart_2 = arg1.PrimaryPart
    if not PrimaryPart_2 then
    else
        Audio_upvr.ObjectLocal(PrimaryPart_2, 13621046723, {
            Volume = 0.5;
        })
    end
end
local ReplicateMovementRollRemote_upvr = ReplicatedStorage_upvr:WaitForChild("ReplicateMovementRollRemote")
MovementRollService_upvr.onRollBegan:Connect(function(arg1, arg2) -- Line 62
    var17_upvr.Roll:Play()
    var17_upvr.Roll:AdjustSpeed(0.54 * var17_upvr.Roll.Length / arg2)
    ReplicateMovementRollRemote_upvr:FireServer()
    local PrimaryPart_4 = arg1.Character.PrimaryPart
    if not PrimaryPart_4 then
    else
        Audio_upvr.ObjectLocal(PrimaryPart_4, 13621046723, {
            Volume = 0.5;
        })
    end
end)
ReplicateMovementRollRemote_upvr.OnClientEvent:Connect(function(arg1) -- Line 73
    if arg1 ~= Players_upvr.LocalPlayer then
        local Character_2 = arg1.Character
        if Character_2 then
            local PrimaryPart_3 = Character_2.PrimaryPart
            if not PrimaryPart_3 then return end
            Audio_upvr.ObjectLocal(PrimaryPart_3, 13621046723, {
                Volume = 0.5;
            })
        end
    end
end)
local var42_upvw = {
    disabled = true;
    primary = false;
    priority = 600;
    useEvery = 5;
    image = "rbxassetid://13613171070";
    keyCodes = {Enum.KeyCode.LeftControl, Enum.KeyCode.RightControl, Enum.KeyCode.ButtonL3};
    onPressed = function(arg1) -- Line 90, Named "onPressed"
        if not MovementRollService_upvr.attemptRoll() then
            return false
        end
        return true
    end;
    onReleased = function() -- Line 96, Named "onReleased"
    end;
}
ActionButtonService_upvr.add(var42_upvw)
local function updateVisibility() -- Line 100
    local var43
    if ReplicatedStorage_upvr:GetAttribute("RollingEnabled") ~= true then
        var43 = false
    else
        var43 = true
    end
    ActionButtonService_upvr.setButtonEnabled(var42_upvw, not VehicleUtils_upvr.GetLocalVehiclePacket() and var43)
end
VehicleUtils_upvr.OnVehicleEntered:Connect(updateVisibility)
VehicleUtils_upvr.OnVehicleExited:Connect(updateVisibility)
ReplicatedStorage_upvr:GetAttributeChangedSignal("RollingEnabled"):Connect(updateVisibility)
if ReplicatedStorage_upvr:GetAttribute("RollingEnabled") ~= true then
else
end
ActionButtonService_upvr.setButtonEnabled(var42_upvw, not VehicleUtils_upvr.GetLocalVehiclePacket() and true)