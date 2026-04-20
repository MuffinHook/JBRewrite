local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local OilRigConsts_upvr = require(ReplicatedStorage.OilRig.OilRigConsts)
local OilRigUtils_upvr = require(ReplicatedStorage.OilRig.OilRigUtils)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Players_upvr = game:GetService("Players")
local RobberyUtils_upvr = require(ReplicatedStorage.Robbery.RobberyUtils)
local RobberyConsts_upvr = require(ReplicatedStorage.Robbery.RobberyConsts)
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
function module_upvr.new(arg1, arg2) -- Line 21
    local any_new_result1_upvr = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1_upvr, module_upvr)
    local function handleProgressionState() -- Line 25
        any_new_result1_upvr.maid.progressionMaid = Maid_upvr.new()
        if not OilRigUtils_upvr.getIsPlayerInRobbery(any_new_result1_upvr.obj, Players_upvr.LocalPlayer) then return end
    end
    any_new_result1_upvr.maid:GiveTask(OilRigUtils_upvr.getProgressionStateChangedSignal(any_new_result1_upvr.obj):Connect(handleProgressionState))
    any_new_result1_upvr.maid:GiveTask(RobberyUtils_upvr.getStatusChangedSignal(any_new_result1_upvr.obj):Connect(function() -- Line 36, Named "handleStatus"
        any_new_result1_upvr.maid.currRobberyMaid = Maid_upvr.new()
        if not OilRigUtils_upvr.getIsPlayerInRobbery(any_new_result1_upvr.obj, Players_upvr.LocalPlayer) then
        elseif RobberyUtils_upvr.getStatus(any_new_result1_upvr.obj) ~= RobberyConsts_upvr.ENUM_STATUS.STARTED then
        end
    end))
    any_new_result1_upvr.maid.localPlayerRobberyMaid = Maid_upvr.new()
    local function handleLocalPlayerInRobbery_upvr() -- Line 50, Named "handleLocalPlayerInRobbery"
        any_new_result1_upvr.maid.progressionMaid = Maid_upvr.new()
        if not OilRigUtils_upvr.getIsPlayerInRobbery(any_new_result1_upvr.obj, Players_upvr.LocalPlayer) then
        else
        end
        any_new_result1_upvr.maid.currRobberyMaid = Maid_upvr.new()
        if not OilRigUtils_upvr.getIsPlayerInRobbery(any_new_result1_upvr.obj, Players_upvr.LocalPlayer) then
        elseif RobberyUtils_upvr.getStatus(any_new_result1_upvr.obj) ~= RobberyConsts_upvr.ENUM_STATUS.STARTED then
        end
        any_new_result1_upvr.maid.localPlayerRobberyMaid:DoCleaning()
    end
    any_new_result1_upvr.maid:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(any_new_result1_upvr.obj, OilRigConsts_upvr.PLAYERS_IN_ROBBERY_FOLDER_NAME, function(arg1_2, arg2_2) -- Line 61
        arg2_2:GiveTask(RxInstanceUtils_upvr.observeChildren(arg1_2, function(arg1_3, arg2_3) -- Line 63
            if arg1_3.Name == tostring(Players_upvr.LocalPlayer.UserId) then
                any_new_result1_upvr.maid.progressionMaid = Maid_upvr.new()
                if not OilRigUtils_upvr.getIsPlayerInRobbery(any_new_result1_upvr.obj, Players_upvr.LocalPlayer) then
                else
                end
                any_new_result1_upvr.maid.currRobberyMaid = Maid_upvr.new()
                if not OilRigUtils_upvr.getIsPlayerInRobbery(any_new_result1_upvr.obj, Players_upvr.LocalPlayer) then
                elseif RobberyUtils_upvr.getStatus(any_new_result1_upvr.obj) ~= RobberyConsts_upvr.ENUM_STATUS.STARTED then
                end
                any_new_result1_upvr.maid.localPlayerRobberyMaid:DoCleaning()
                arg2_3:GiveTask(arg1_3.Changed:Connect(handleLocalPlayerInRobbery_upvr))
            end
        end))
    end))
    any_new_result1_upvr.maid:GiveTask(any_new_result1_upvr.obj:WaitForChild("UpdateOilTankRemote").OnClientEvent:Connect(function(arg1_4, arg2_4) -- Line 75
        local OriginalSize = arg1_4:GetAttribute("OriginalSize")
        local Oil = arg1_4:FindFirstChild("Oil")
        local var17 = Oil
        if var17 then
            var17 = Oil:IsA("BasePart")
        end
        assert(var17)
        local var18 = 1 - arg2_4
        Oil.Size = Vector3.new(1, var18, 1) * OriginalSize
        Oil.CFrame = arg1_4:GetAttribute("OriginalCFrame") * CFrame.new(0, -OriginalSize.Y / 2 * (1 - var18), 0)
        if var18 <= 0.001 then
            Oil.Transparency = 1
        else
            Oil.Transparency = 0
        end
    end))
    any_new_result1_upvr:_listenEverywhere()
    return any_new_result1_upvr
end
function module_upvr._listenEverywhere(arg1) -- Line 94
    arg1.maid:GiveTask(OilRigUtils_upvr.getProgressionStateChangedSignal(arg1.obj):Connect(function() -- Line 95, Named "handleProgressionState"
        if OilRigUtils_upvr.getProgressionState(arg1.obj) == OilRigConsts_upvr.PROGRESSION_STATE.BlowUp then
            arg1:_launchBlowUp()
        end
    end))
end
function module_upvr.IsPlayerInRobbery(arg1, arg2) -- Line 103
    return OilRigUtils_upvr.getIsPlayerInRobbery(arg1.obj, arg2)
end
local Shockwave_upvr = require(ReplicatedStorage.Game.Shockwave)
local VehicleUtils_upvr = require(ReplicatedStorage.Vehicle.VehicleUtils)
local CharacterUtil_upvr = require(ReplicatedStorage.Game.CharacterUtil)
local Falling_upvr = require(ReplicatedStorage.Game.Falling)
function module_upvr._launchBlowUp(arg1) -- Line 106
    local Explosion = arg1.obj:FindFirstChild("OpenCloseSignal"):FindFirstChild("Explosion")
    assert(Explosion)
    Shockwave_upvr.new(Explosion.Position, {
        Duration = 4;
        MaxRadius = 750;
        StartTransparency = 0.2;
        EndTransparency = 1;
    }).OnPastLocalPlayer:Connect(function() -- Line 118
        local ShockwaveRemote = arg1.obj:FindFirstChild("ShockwaveRemote")
        if ShockwaveRemote then
            ShockwaveRemote:FireServer()
        end
        if VehicleUtils_upvr.GetLocalVehiclePacket() ~= nil then
            CharacterUtil_upvr.OnJump()
            task.wait(0.1)
        end
        Falling_upvr.StartRagdolling(5)
    end)
end
return require(ReplicatedStorage.Std.Binder).new(OilRigConsts_upvr.TAG_NAME, module_upvr)