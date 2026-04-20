local Players_upvr = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local VaultDoorPuzzleUtils_upvr = require(ReplicatedStorage.Casino.VaultDoorPuzzleUtils)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
local CircleAction_upvr = require(ReplicatedStorage.Module.UI).CircleAction
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function module_upvr.new(arg1, arg2) -- Line 18
    local any_new_result1_2_upvr = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1_2_upvr, module_upvr)
    RxInstanceUtils_upvr.yieldForProperty(arg1, "PrimaryPart")
    any_new_result1_2_upvr.manifest = arg2
    any_new_result1_2_upvr._pos = 0
    local tbl = {
        Part = any_new_result1_2_upvr.obj.PrimaryPart;
        Name = "";
        Timed = false;
        Dist = 8;
        Callback = function(arg1_2, arg2_2) -- Line 27, Named "action"
            if arg2_2 then
                if not any_new_result1_2_upvr:GetHacker() then
                    arg2.requestHackRemote:FireServer()
                else
                    arg2.updateDirectionRemote:FireServer()
                end
            end
            return true
        end;
        Enabled = true;
        PreUpdateFun = function(arg1_3) -- Line 37, Named "preUpdateFun"
            local any_GetHacker_result1_3 = any_new_result1_2_upvr:GetHacker()
            local var13 = not any_new_result1_2_upvr:GetDisabled()
            if var13 then
                var13 = true
                if any_GetHacker_result1_3 ~= nil then
                    if any_GetHacker_result1_3 ~= Players_upvr.LocalPlayer then
                        var13 = false
                    else
                        var13 = true
                    end
                end
            end
            arg1_3.Enabled = var13
        end;
        PreUpdatePeriod = 0.1;
    }
    any_new_result1_2_upvr.spec = tbl
    any_new_result1_2_upvr.maid:GiveTask(CircleAction_upvr.Add(tbl, any_new_result1_2_upvr.obj.PrimaryPart))
    any_new_result1_2_upvr.maid:GiveTask(any_new_result1_2_upvr:GetHackerChangedSignal():Connect(function() -- Line 54
        local any_GetHacker_result1_2 = any_new_result1_2_upvr:GetHacker()
        if any_GetHacker_result1_2 then
            local any_new_result1 = Maid_upvr.new()
            any_new_result1_2_upvr.maid.hackMaid = any_new_result1
            any_new_result1_2_upvr:_hookHacker(any_new_result1, any_GetHacker_result1_2)
        else
            any_new_result1_2_upvr.maid.hackMaid = nil
            any_new_result1_2_upvr:_hookHacker()
        end
    end))
    any_new_result1_2_upvr:_hookHacker()
    return any_new_result1_2_upvr
end
local RunService_upvr = game:GetService("RunService")
function module_upvr._hookHacker(arg1, arg2, arg3) -- Line 69
    if arg2 ~= nil then
        local any_GetDirection_result1_upvw = arg1:GetDirection()
        arg2:GiveTask(arg1:GetDirectionChangedSignal():Connect(function() -- Line 74
            any_GetDirection_result1_upvw = arg1:GetDirection()
        end))
        local var22_upvw = 0
        arg2:GiveTask(RunService_upvr.Heartbeat:Connect(function(arg1_4) -- Line 77
            var22_upvw += 5 * any_GetDirection_result1_upvw * arg1_4
            var22_upvw *= 0.95
            local var23 = arg1
            var23._pos += var22_upvw * arg1_4
            arg1.manifest.innerModel:SetPrimaryPartCFrame(arg1.obj.PrimaryPart.CFrame * CFrame.Angles(0, 0, arg1._pos))
        end))
        if arg3 == Players_upvr.LocalPlayer then
            arg1.spec.Name = "Change Direction"
        end
    else
        arg1.spec.Name = "Crack"
    end
end
function module_upvr.GetHackerChangedSignal(arg1) -- Line 91
    return VaultDoorPuzzleUtils_upvr.getHackerChangedSignal(arg1.obj)
end
function module_upvr.GetHacker(arg1) -- Line 94
    return VaultDoorPuzzleUtils_upvr.getHacker(arg1.obj)
end
function module_upvr.SetDirection(arg1, arg2) -- Line 97
    return VaultDoorPuzzleUtils_upvr.setDirection(arg1.obj, arg2)
end
function module_upvr.GetDirection(arg1) -- Line 100
    return VaultDoorPuzzleUtils_upvr.getDirection(arg1.obj)
end
function module_upvr.GetDirectionChangedSignal(arg1) -- Line 103
    return VaultDoorPuzzleUtils_upvr.getDirectionChangedSignal(arg1.obj)
end
function module_upvr.GetDisabled(arg1) -- Line 106
    return VaultDoorPuzzleUtils_upvr.getDisabled(arg1.obj)
end
return require(ReplicatedStorage.ManifestBinder).new("VaultDoorPuzzle", {
    innerModel = require(ReplicatedStorage.Door2.DoorConsts).INNER_MODEL_NAME;
    requestHackRemote = "RequestHack";
    updateDirectionRemote = "UpdateDirection";
}, module_upvr)