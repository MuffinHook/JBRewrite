local Players_upvr = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local function _(arg1) -- Line 18, Named "GetHumanoid"
    local Character = arg1.Character
    if Character == nil then
        return nil
    end
    return Character:FindFirstChild("Humanoid")
end
local function _(arg1) -- Line 26, Named "GetRootPart"
    local Character_2 = arg1.Character
    local var6
    if Character_2 == nil then
        var6 = nil
    else
        var6 = Character_2:FindFirstChild("Humanoid")
    end
    if var6 == nil then
        return nil
    end
    return var6.RootPart
end
local module_upvr = {}
module_upvr.__index = module_upvr
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Turret_upvr = require(ReplicatedStorage.Turret2.Turret)
local CargoShipShared_upvr = require(script.Parent.CargoShipShared)
local RunService_upvr = game:GetService("RunService")
local Time_upvr = require(ReplicatedStorage.Module.Time)
local zero_vector3_upvr = Vector3.new()
function module_upvr.new(arg1) -- Line 37
    if arg1 == nil then
    else
    end
    assert(true)
    local module_upvr_2 = {}
    setmetatable(module_upvr_2, module_upvr)
    RxInstanceUtils_upvr.yieldForProperty(arg1, "PrimaryPart")
    module_upvr_2.Model = arg1
    module_upvr_2.Maid = Maid_upvr.new()
    module_upvr_2.ListTurret = {Turret_upvr.new(module_upvr_2.Model.TurretFront), Turret_upvr.new(module_upvr_2.Model.TurretBack)}
    module_upvr_2.Path = CargoShipShared_upvr.GetPath()
    module_upvr_2._cargoShipIdObj = arg1:WaitForChild("CargoShipId")
    local CargoShipBornAt_upvr = arg1:WaitForChild("CargoShipBornAt")
    module_upvr_2.BornAt = CargoShipBornAt_upvr.Value
    module_upvr_2.Maid:GiveTask(CargoShipBornAt_upvr.Changed:Connect(function() -- Line 57
        module_upvr_2.BornAt = CargoShipBornAt_upvr.Value
    end))
    local var20_upvr = module_upvr_2.Path.ApproxLength / CargoShipShared_upvr.Speed
    module_upvr_2.Maid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 64
        local any_GetNowSync_result1 = Time_upvr.GetNowSync()
        local var22 = (any_GetNowSync_result1 - module_upvr_2.BornAt) / var20_upvr
        if 1 < var22 then
            var22 = 1
        end
        module_upvr_2.SwayZ = math.cos(any_GetNowSync_result1 * 1.8) * 0.15
        module_upvr_2.SwayX = math.sin(any_GetNowSync_result1 * 1.5) * 0.1
        local any_GetWorldPositionAt_result1, any_GetWorldPositionAt_result2 = module_upvr_2.Path:GetWorldPositionAt(module_upvr_2.Path.ApproxLength * var22)
        module_upvr_2:SetPrimaryPartCFrame((CFrame.new(zero_vector3_upvr, any_GetWorldPositionAt_result2)) * (CFrame.Angles(0, 0, module_upvr_2.SwayZ * math.pi * 0.05) * CFrame.Angles(module_upvr_2.SwayX * math.pi * 0.05, 0, 0)) + any_GetWorldPositionAt_result1)
    end))
    local var25_upvw
    local function _() -- Line 85, Named "ChooseNextHorn"
        assert(true)
        var25_upvw = tick() + 60 * (1 + math.random() * 1)
    end
    assert(true)
    var25_upvw = tick() + 60 * (1 + math.random() * 1)
    module_upvr_2.Maid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 91
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        if module_upvr_2.Model:IsDescendantOf(workspace) == false then
            module_upvr_2:Destroy()
        else
            for i_2, v_2 in ipairs(module_upvr_2.ListTurret) do
                if v_2.TargetUserId ~= nil then
                    local TargetUserId = v_2.TargetUserId
                    local any_GetPlayerByUserId_result1 = Players_upvr:GetPlayerByUserId(TargetUserId)
                    if any_GetPlayerByUserId_result1 ~= nil then
                        local Character_6 = any_GetPlayerByUserId_result1.Character
                        if Character_6 == nil then
                            TargetUserId = nil
                        else
                            TargetUserId = Character_6:FindFirstChild("Humanoid")
                        end
                        if TargetUserId == nil then
                            local _
                        else
                        end
                        if TargetUserId.RootPart ~= nil then
                            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                            TargetUserId = v_2:PointAt
                            TargetUserId(TargetUserId.RootPart.Position)
                            TargetUserId = v_2:Update
                            TargetUserId()
                        end
                    end
                end
            end
            if var25_upvw < tick() then
                assert(true)
                i_2 = 60
                v_2 = 1 + math.random() * 1
                var25_upvw = tick() + i_2 * v_2
                module_upvr_2:FireHorn()
            end
        end
    end))
    module_upvr_2:FireHorn()
    Audio_upvr.ObjectLocal(module_upvr_2.Model.PrimaryPart, 5144228425, {
        Looped = true;
        Volume = 1;
        MaxDistance = 512;
        EmitterSize = 128;
    })
    module_upvr_2:ListenForFirstPickup()
    return module_upvr_2
end
function module_upvr.GetId(arg1) -- Line 127
    return arg1._cargoShipIdObj.Value
end
function module_upvr.FireHorn(arg1) -- Line 130
    Audio_upvr.ObjectLocal(arg1.Model.PrimaryPart, 5128574531, {
        MaxDistance = 4000;
        EmitterSize = 256;
        Volume = 1;
        RollOffMode = Enum.RollOffMode.Linear;
    })
end
function module_upvr.ListenForFirstPickup(arg1) -- Line 137
    local var60_upvw
    var60_upvw = arg1.Model.ChildAdded:Connect(function(arg1_2) -- Line 139
        if arg1_2.Name == "HasFirstRobbed" then
            var60_upvw:Disconnect()
            Audio_upvr.ObjectLocal(arg1.Model.PrimaryPart, 5136785479, {
                Looped = true;
                Volume = 1;
                MaxDistance = 1024;
                EmitterSize = 64;
            })
        end
    end)
end
function module_upvr.SetTurretSeek(arg1, arg2) -- Line 150
    for _, v in ipairs(arg1.ListTurret) do
        v.TargetUserId = arg2[v.Model.Name]
    end
end
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local RayCast_upvr = require(ReplicatedStorage.Module.RayCast)
local CurrentCamera_upvr = workspace.CurrentCamera
function module_upvr.SetPrimaryPartCFrame(arg1, arg2) -- Line 156
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local Character_5 = LocalPlayer_upvr.Character
    local var77
    if Character_5 == nil then
        var77 = nil
    else
        var77 = Character_5:FindFirstChild("Humanoid")
    end
    if var77 == nil then
        local _
    else
    end
    if var77.RootPart then
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        local CFrame = var77.RootPart.CFrame
        var77 = RayCast_upvr
        var77 = var77.RayIgnoreNonCollide
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        var77 = var77(CFrame.p, -CFrame.UpVector, 16, var77.RootPart.Parent)
        if var77 and var77:IsDescendantOf(arg1.Model) then
        end
    end
    var77 = arg1.Model
    var77 = var77.PrimaryPart
    var77.CFrame = arg2
    if true then
        var77 = arg2 * arg1.Model.PrimaryPart.CFrame:Inverse()
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        var77.RootPart.CFrame = var77 * var77.RootPart.CFrame
        local any_ToObjectSpace_result1 = CurrentCamera_upvr.CFrame:ToObjectSpace(CurrentCamera_upvr.Focus)
        CurrentCamera_upvr.CFrame = CurrentCamera_upvr.CFrame * any_ToObjectSpace_result1 * (var77 - var77.p) * any_ToObjectSpace_result1:Inverse()
    end
end
function module_upvr.Destroy(arg1) -- Line 182
    arg1.Maid:Destroy()
    arg1.Maid = nil
end
return module_upvr