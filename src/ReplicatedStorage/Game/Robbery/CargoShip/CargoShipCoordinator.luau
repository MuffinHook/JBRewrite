local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Silo_upvr = require(ReplicatedStorage.Game.Silo)
local function _() -- Line 18, Named "GetRootPart"
    local Character = LocalPlayer_upvr.Character
    if Character == nil then
        return nil
    end
    local Humanoid_2 = Character:FindFirstChild("Humanoid")
    if Humanoid_2 == nil then
        return nil
    end
    return Humanoid_2.RootPart
end
local tbl_upvr = {}
tbl_upvr.__index = tbl_upvr
setmetatable(tbl_upvr, Silo_upvr)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
function tbl_upvr.new(arg1) -- Line 34
    local any_new_result1_upvr_2 = Silo_upvr.new(arg1)
    setmetatable(any_new_result1_upvr_2, tbl_upvr)
    any_new_result1_upvr_2.BayMaid = Maid_upvr.new()
    any_new_result1_upvr_2._door1Part = any_new_result1_upvr_2.Model:WaitForChild("Door1")
    any_new_result1_upvr_2._door2Part = any_new_result1_upvr_2.Model:WaitForChild("Door2")
    any_new_result1_upvr_2.Size = any_new_result1_upvr_2._door1Part.Size
    any_new_result1_upvr_2.BayMaid:GiveTask(Interval_upvr.every(0.5):Connect(function() -- Line 44
        local Character_4 = LocalPlayer_upvr.Character
        if Character_4 ~= nil then
            local Humanoid_3 = Character_4:FindFirstChild("Humanoid")
            if Humanoid_3 ~= nil then
                local RootPart = Humanoid_3.RootPart
                local var18
                if RootPart ~= nil then
                    var18 = any_new_result1_upvr_2.Model.Door1
                    var18 = var18.Position
                    if (RootPart.Position - var18).Magnitude >= 128 then
                        var18 = false
                    else
                        var18 = true
                    end
                    if var18 ~= any_new_result1_upvr_2.IsOpen then
                        if var18 then
                            any_new_result1_upvr_2:Open(2)
                            return
                        end
                        any_new_result1_upvr_2:Close(2)
                    end
                end
            end
        end
    end))
    return any_new_result1_upvr_2
end
function tbl_upvr.SetDoorOpen(arg1, arg2) -- Line 68
    local _door1Part = arg1._door1Part
    local var20 = -arg1.Size.Z * arg2
    _door1Part.Size = Vector3.new(arg1.Size.X, arg1.Size.Y, arg1.Size.Z + var20)
    _door1Part.CFrame = arg1.Door1CF * CFrame.new(0, 0, var20 * 0.5)
    local _door2Part = arg1._door2Part
    local var22 = -arg1.Size.Z * arg2
    _door2Part.Size = Vector3.new(arg1.Size.X, arg1.Size.Y, arg1.Size.Z + var22)
    _door2Part.CFrame = arg1.Door2CF * CFrame.new(0, 0, var22 * 0.5)
end
function tbl_upvr.Destroy(arg1) -- Line 79
    arg1:SetDoorOpen(0)
    Silo_upvr.Destroy(arg1)
    arg1.BayMaid:DoCleaning()
    arg1.BayMaid = nil
end
local any_new_result1_upvr = require(ReplicatedStorage.Std.Binder).new("CargoShip", require(script.Parent.CargoShip))
local CollectionService_upvr = game:GetService("CollectionService")
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local MinimapService_upvr = require(ReplicatedStorage.App.MinimapService)
return {
    Init = function(arg1) -- Line 88, Named "Init"
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        local em = arg1.em
        local Event_upvr = arg1.Event
        local function OnRocketExploded_upvr(arg1_2) -- Line 92, Named "OnRocketExploded"
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            local Character_3 = LocalPlayer_upvr.Character
            local var38
            if Character_3 == nil then
                var38 = nil
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            local Humanoid_4 = Character_3:FindFirstChild("Humanoid")
            if Humanoid_4 == nil then
                var38 = nil
            else
                var38 = Humanoid_4.RootPart
            end
            if var38 == nil then
            else
                if (arg1_2 - var38.Position).Magnitude < 64 then
                    Event_upvr:FireServer('n'.."".."r61hnzk":sub(5, 5):reverse():reverse():reverse().."".."".."qlsc5vsqqy":sub(4, 6):reverse().."".."".."u3uzgr":sub(5, 5):reverse().."".."dd", arg1_2)
                end
                -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            end
        end
        any_new_result1_upvr:GetClassAddedSignal():Connect(function(arg1_3) -- Line 104
            for _, v in ipairs(arg1_3.ListTurret) do
                v.Maid:GiveTask(v.RocketWorld.OnRocketExploded:Connect(OnRocketExploded_upvr))
            end
        end)
        any_new_result1_upvr:Start()
        function em.fj0gftoj(arg1_4, arg2) -- Line 112
            for _, v_2 in any_new_result1_upvr:GetAll() do
                if v_2:GetId() == arg1_4 then
                    v_2:SetTurretSeek(arg2)
                end
            end
        end
        local var51_upvw
        local var57
        for _, v_3 in ipairs(CollectionService_upvr:GetTagged("CargoDepotDoor")) do
            if var51_upvw ~= nil then
                var57 = false
            else
                var57 = true
            end
            assert(var57, "Cargo bay already exists!")
            var57 = v_3
            var51_upvw = tbl_upvr.new(var57)
        end
        CollectionService_upvr:GetInstanceAddedSignal("CargoDepotDoor"):Connect(function(arg1_5) -- Line 121, Named "AddedFun"
            local var52
            if var51_upvw ~= nil then
                var52 = false
            else
                var52 = true
            end
            assert(var52, "Cargo bay already exists!")
            var52 = arg1_5
            var51_upvw = tbl_upvr.new(var52)
        end)
        CollectionService_upvr:GetInstanceRemovedSignal("CargoDepotDoor"):Connect(function() -- Line 125, Named "RemovedFun"
            local var53
            if var51_upvw == nil then
                var53 = false
            else
                var53 = true
            end
            assert(var53, "Cargo bay already destroyed!")
            var51_upvw:Destroy()
            var51_upvw = nil
        end)
        local var58_upvw
        local var59_upvw
        function em.fmsajstw(arg1_6) -- Line 139
            if var58_upvw ~= nil then
                var58_upvw:Disconnect()
                var58_upvw = nil
            end
            if arg1_6 then
                if var59_upvw == nil then
                    var59_upvw = Audio_upvr.ObjectLocal(LocalPlayer_upvr.PlayerGui, 1837327837, {
                        Looped = true;
                        Volume = 0;
                    })
                    var59_upvw.SoundGroup = game.SoundService.RobberyMusic
                end
                var58_upvw = Audio_upvr.FadeTo(var59_upvw, 0.7, 2, function() -- Line 149
                    var58_upvw = nil
                end)
            else
                var58_upvw = Audio_upvr.FadeTo(var59_upvw, 0, 4, function() -- Line 153
                    var59_upvw:Destroy()
                    var59_upvw = nil
                    var58_upvw = nil
                end)
            end
        end
        function em.k8qzh5d6(arg1_7) -- Line 160
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            MinimapService_upvr.addWaypoint({
                name = "CargoShip";
                position = (var51_upvw.Door1CF.p + var51_upvw.Door2CF.p) * 0.5;
                priority = 1000;
                minDist = 0;
            })
            do
                return
            end
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            MinimapService_upvr.removeWaypointByName("CargoShip")
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        end
        function em.qjbv3y41() -- Line 175
            Audio_upvr.ObjectLocal(LocalPlayer_upvr.PlayerGui, 1988476450)
        end
    end;
}