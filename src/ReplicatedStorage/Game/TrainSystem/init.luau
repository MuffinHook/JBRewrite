local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage_upvr.Std.Signal)
local var3_upvw
local tbl_upvr_2 = {
    OnCarCreated = Signal.new();
    OnCarDestroyed = Signal.new();
    OnCarEntered = Signal.new();
    OnCarExited = Signal.new();
}
local TrainSystemUtils = require(script.TrainSystemUtils)
local MoveTrain_upvr = TrainSystemUtils.MoveTrain
local RaycastParams_new_result1_upvr = RaycastParams.new()
RaycastParams_new_result1_upvr.FilterType = Enum.RaycastFilterType.Include
RaycastParams_new_result1_upvr.IgnoreWater = true
local function PopulateCar_upvr(arg1, arg2, arg3) -- Line 33, Named "PopulateCar"
    local Base = arg3.Base
    local arg2 = require(arg2)
    arg1.Model = arg3
    arg1.Base = Base
    arg1.Length = Base.Size.Z
    arg1.InvertBogey = false
    arg2.MakeCar(arg1, var3_upvw)
    tbl_upvr_2.OnCarCreated:Fire(arg1)
    assert(arg1.BogeyMotorFront)
    assert(arg1.BogeyMotorBack)
    assert(arg1.BogeyOffsetFront)
    assert(arg1.BogeyOffsetBack)
    arg1.MoveCar = arg2.MoveCar
    arg1.DestroyCar = arg2.DestroyCar
    arg1.Loaded = true
    return arg1
end
local function RenderTrain_upvr(arg1, arg2) -- Line 55, Named "RenderTrain"
    for i = #arg1.Cars, 1, -1 do
        local var12 = arg1.Cars[i]
        if var12.Loaded then
            var12:MoveCar(arg1, arg2, 0)
        end
    end
end
local tbl_upvr_3 = {}
local var16_upvw
local var17_upvw
local Time_upvr = require(ReplicatedStorage_upvr.Module.Time)
local CalculateDistanceAhead_upvr = TrainSystemUtils.CalculateDistanceAhead
local CollectionService_upvr = game:GetService("CollectionService")
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local JetPack_upvr = require(ReplicatedStorage_upvr.Game.JetPack.JetPack)
local VehicleUtils_upvr = require(ReplicatedStorage_upvr.Vehicle.VehicleUtils)
local CurrentCamera_upvr = workspace.CurrentCamera
local RunService_upvr = game:GetService("RunService")
return {
    Init = function(arg1) -- Line 83, Named "Init"
        var3_upvw = arg1.Event
        var16_upvw = arg1.em
        local Folder_upvr = Instance.new("Folder")
        Folder_upvr.Name = "Trains"
        Folder_upvr.Parent = workspace
        var17_upvw = {Folder_upvr}
        RaycastParams_new_result1_upvr.FilterDescendantsInstances = {Folder_upvr}
        local ChangePositionReplication_upvr = ReplicatedStorage_upvr:FindFirstChild("ChangePositionReplication")
        local function PopulateTrain_upvr(arg1_2) -- Line 97, Named "PopulateTrain"
            for _, v in next, arg1_2.Cars do
                v.SystemId = arg1_2.Id
                local Name = v.Name
                local clone = ReplicatedStorage_upvr.Resource.TrainCars[Name]:Clone()
                local SOME = script:FindFirstChild(Name)
                if not SOME then
                    SOME = script.Default
                end
                clone:PivotTo(CFrame.new(0, -200, 0))
                clone.Parent = Folder_upvr
                PopulateCar_upvr(v, SOME, clone)
                task.wait()
            end
        end
        function var16_upvw.ffasyi25(arg1_3) -- Line 109
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            local _ = 1
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [16.425]
            if tbl_upvr_3 == arg1_3.Id then
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        end
        local const_number_upvw = 0
        local function ReplicateTrain_upvr(arg1_4) -- Line 120, Named "ReplicateTrain"
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            local _ = 1
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [16.425]
            if tbl_upvr_3 == arg1_4.SystemId then
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        end
        function var16_upvw.iuck8pmh(arg1_5) -- Line 165
            for _, v_2 in next, arg1_5 do
                ReplicateTrain_upvr(v_2)
            end
        end
        function var16_upvw.gve5mfno(arg1_6) -- Line 170
            for i_6 = 1, #tbl_upvr_3 do
                local var49 = tbl_upvr_3[i_6]
                if var49.Id == arg1_6 then
                    table.remove(tbl_upvr_3, i_6)
                    for _, v_3 in next, var49.Cars do
                        repeat
                            task.wait()
                        until v_3.DestroyCar ~= nil and os.clock() + 5 < os.clock()
                        if v_3.DestroyCar then
                            tbl_upvr_2.OnCarDestroyed:Fire(v_3)
                            v_3:DestroyCar()
                        else
                            warn("Car has no DestroyCar function")
                            print(v_3)
                        end
                    end
                    return true
                end
            end
            return false
        end
        function var16_upvw.mqpabvo3(arg1_7, arg2, arg3) -- Line 195
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            local _ = 1
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [14.937]
            if tbl_upvr_3 == arg1_7 then
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        end
        local function wvtflozc(arg1_8) -- Line 204
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            local _ = 1
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [14.425]
            if tbl_upvr_3 == arg1_8 then
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        end
        var16_upvw.wvtflozc = wvtflozc
        wvtflozc = {}
        local var52_upvr = wvtflozc
        for _, v_4 in CollectionService_upvr:GetTagged("ReplicateCharacterTrain") do
            table.insert(var52_upvr, v_4)
        end
        local tbl_upvr = {}
        local tbl_upvr_4 = {}
        CollectionService_upvr:GetInstanceAddedSignal("ReplicateCharacterTrain"):Connect(function(arg1_9) -- Line 226
            table.insert(var52_upvr, arg1_9)
            if tbl_upvr_4[arg1_9] then
                task.cancel(tbl_upvr_4[arg1_9])
                tbl_upvr_4[arg1_9] = nil
            end
        end)
        CollectionService_upvr:GetInstanceRemovedSignal("ReplicateCharacterTrain"):Connect(function(arg1_10) -- Line 235
            table.remove(var52_upvr, table.find(var52_upvr, arg1_10))
            if tbl_upvr_4[arg1_10] then
                task.cancel(tbl_upvr_4[arg1_10])
            end
            tbl_upvr_4[arg1_10] = task.delay(2, function() -- Line 245
                tbl_upvr[arg1_10] = nil
                tbl_upvr_4[arg1_10] = nil
            end)
        end)
        local var61_upvw
        local var62_upvw
        local UnsafePositionReplication_upvr = ReplicatedStorage_upvr:FindFirstChild("UnsafePositionReplication")
        local os_clock_result1_upvw = os.clock()
        local zero_cframe_upvw = CFrame.new()
        RunService_upvr.Heartbeat:Connect(function(arg1_11) -- Line 256, Named "Stepped"
            -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            local var96
            if #tbl_upvr_3 <= var96 then
                if var61_upvw then
                    tbl_upvr_2.OnCarExited:Fire(var61_upvw)
                end
                var61_upvw = nil
                var62_upvw = nil
                return
            end
            var96 = "Train Update"
            debug.profilebegin(var96)
            local var97
            var96 = nil
            local var98
            local Character = LocalPlayer_upvr.Character
            if Character then
                local Humanoid = Character:FindFirstChild("Humanoid")
                if Humanoid then
                    var98 = Humanoid.RootPart
                    if var98 then
                        if not JetPack_upvr.IsFlying() then
                            var97 = workspace:Raycast(var98.Position, Vector3.new(0, -20, 0), RaycastParams_new_result1_upvr)
                            if var97 and var97.Instance then
                                var97 = var97.Instance
                            end
                        end
                    end
                end
            end
            if not var97 then
                if var61_upvw then
                    tbl_upvr_2.OnCarExited:Fire(var61_upvw)
                end
                var61_upvw = nil
                var62_upvw = nil
            end
            for _, v_5 in next, tbl_upvr_3 do
                for i_10 = #v_5.Cars, 1, -1 do
                    local var101 = v_5.Cars[i_10]
                    if var101.Loaded and var97 and var97:IsDescendantOf(var101.Model) then
                        var96 = var101.Base
                        if not var61_upvw then
                            tbl_upvr_2.OnCarEntered:Fire(var101)
                        elseif var61_upvw ~= var101 then
                            tbl_upvr_2.OnCarExited:Fire(var61_upvw, true)
                            tbl_upvr_2.OnCarEntered:Fire(var101)
                        end
                        var61_upvw = var101
                        var62_upvw = v_5
                    end
                end
                local var102
                if v_5.ServerDistanceAhead then
                    i_10 = v_5.ServerDistanceAhead
                    var102 = v_5.ServerSpeed + i_10
                elseif v_5.ServerSpeed then
                    var102 = v_5.ServerSpeed
                else
                    var102 = v_5.Speed
                end
                v_5.Speed += (var102 - v_5.Speed) * 0.1
                MoveTrain_upvr(v_5, arg1_11)
                RenderTrain_upvr(v_5, arg1_11)
            end
            debug.profileend()
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            local CFrame_3 = var96.CFrame
            local var104 = CFrame_3 * var96.CFrame:Inverse()
            local any_GetLocalVehiclePacket_result1_2 = VehicleUtils_upvr.GetLocalVehiclePacket()
            if not any_GetLocalVehiclePacket_result1_2 or not any_GetLocalVehiclePacket_result1_2.Passenger then
                var98.CFrame = var104 * var98.CFrame
            end
            local any_ToObjectSpace_result1 = CurrentCamera_upvr.CFrame:ToObjectSpace(CurrentCamera_upvr.Focus)
            CurrentCamera_upvr.CFrame = CurrentCamera_upvr.CFrame * any_ToObjectSpace_result1 * (var104 - var104.p) * any_ToObjectSpace_result1:Inverse()
            assert(var61_upvw)
            if UnsafePositionReplication_upvr and 0.2 < os.clock() - os_clock_result1_upvw and (not zero_cframe_upvw or not CFrame_3:ToObjectSpace(var98.CFrame):FuzzyEq(zero_cframe_upvw)) then
                os_clock_result1_upvw = os.clock()
                UnsafePositionReplication_upvr:FireServer("Train", var61_upvw.Id, CFrame_3:ToObjectSpace(var98.CFrame))
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                zero_cframe_upvw = CFrame_3:ToObjectSpace(var98.CFrame)
            end
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        end)
        tbl_upvr_2.OnCarEntered:Connect(function(arg1_12) -- Line 397
            -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
            local var116
            if var116 then
                var116 = nil
                if arg1_12.Base then
                    local CFrame_2 = arg1_12.Base.CFrame
                end
                for i_11, v_6 in LocalPlayer_upvr.Character:GetDescendants() do
                    if v_6:IsA("BasePart") then
                        if var116 == nil and v_6.Name == "HumanoidRootPart" then
                            var116 = v_6.CFrame
                        end
                        v_6.CollisionGroup = "PlayersInTrain"
                    end
                end
                if var116 and CFrame_2 then
                    if ChangePositionReplication_upvr then
                        i_11 = true
                        v_6 = arg1_12.Id
                        ChangePositionReplication_upvr:FireServer("Train", i_11, v_6, CFrame_2:ToObjectSpace(var116))
                    end
                end
            end
        end)
        tbl_upvr_2.OnCarExited:Connect(function(arg1_13, arg2) -- Line 415
            if LocalPlayer_upvr.Character then
                for i_12, v_7 in LocalPlayer_upvr.Character:GetDescendants() do
                    if v_7:IsA("BasePart") then
                        v_7.CollisionGroup = "Players"
                    end
                end
            end
            if not arg2 and ChangePositionReplication_upvr then
                i_12 = false
                ChangePositionReplication_upvr:FireServer(nil, i_12)
            end
        end)
    end;
    Signals = tbl_upvr_2;
    GetSystemById = function(arg1) -- Line 66, Named "GetSystemById"
        for i_2 = 1, #tbl_upvr_3 do
            if tbl_upvr_3[i_2].Id == arg1 then
                return tbl_upvr_3[i_2]
            end
        end
        return false
    end;
    GetCarById = function(arg1, arg2) -- Line 74, Named "GetCarById"
        for i_3 = 1, #arg1.Cars do
            if arg1.Cars[i_3].Id == arg2 then
                return arg1.Cars[i_3]
            end
        end
        return false
    end;
    MoveTrain = MoveTrain_upvr;
}