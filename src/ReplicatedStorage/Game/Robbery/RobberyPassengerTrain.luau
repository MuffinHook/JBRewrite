local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local CircleAction_upvr = require(ReplicatedStorage_upvr.Module.UI).CircleAction
local var3_upvw
local function _(arg1) -- Line 12, Named "comma"
    local string_match_result1, string_match_result2, string_match_result3_2 = string.match(arg1, "^([^%d]*%d)(%d*)(.-)$")
    return string_match_result1..string_match_result2:reverse():gsub("(%d%d%d)", "%1,"):reverse()..string_match_result3_2
end
local function _(arg1) -- Line 16, Named "FormatMoney"
    local var7
    if 0 <= arg1 then
        var7 = ""
    else
        var7 = '-'
    end
    local string_match_result1_2, string_match_result2_2, string_match_result3 = string.match(math.abs(arg1), "^([^%d]*%d)(%d*)(.-)$")
    return "%s$%s":format(var7, string_match_result1_2..string_match_result2_2:reverse():gsub("(%d%d%d)", "%1,"):reverse()..string_match_result3)
end
local function PlaySound_upvr(arg1, arg2) -- Line 20, Named "PlaySound"
    local Sound_upvr = Instance.new("Sound")
    Sound_upvr.SoundId = "rbxassetid://%d":format(arg2)
    Sound_upvr.Volume = 0.75
    Sound_upvr.RollOffMode = Enum.RollOffMode.InverseTapered
    Sound_upvr.Parent = arg1
    Sound_upvr:Play()
    delay(1, function() -- Line 27
        game.Debris:AddItem(Sound_upvr, Sound_upvr.TimeLength)
    end)
end
local function OpenRoofDoorRaw_upvr(arg1, arg2) -- Line 31, Named "OpenRoofDoorRaw"
    local assert_result1 = assert(arg1.Model.Model:FindFirstChild("Glass"..tostring(arg2)), "missing glassPart")
    if arg1.GlassIndexOpen[arg2] then return end
    arg1.GlassIndexOpen[arg2] = true
    assert_result1.CanCollide = false
    assert_result1.Transparency = 1
    PlaySound_upvr(assert_result1, 848150421)
    CircleAction_upvr.Remove(assert_result1)
    return true
end
local function _(arg1, arg2) -- Line 43, Named "OpenSideDoorRaw"
    if arg1.DoorIndexOpen[arg2] then return end
    arg1.DoorIndexOpen[arg2] = true
    arg1.DoorOpenFuncs[arg2]()
    CircleAction_upvr.Remove(assert(arg1.Model.Skeleton:FindFirstChild("Door"..tostring(arg2)), "missing doorModel"))
    return true
end
local Joint_upvr = require(ReplicatedStorage_upvr.Std.Joint)
local zero_cframe_upvr = CFrame.new()
local function SetupPassengerCar_upvr(arg1) -- Line 54, Named "SetupPassengerCar"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local tbl_3 = {}
    local function GrabAction(arg1_2, arg2) -- Line 56
        if arg2 then
            arg1_2.IsMine = true
            var3_upvw:FireServer('g'.."".."zkeug":sub(2, 4):reverse():reverse():reverse().."".."".."ra9k4lpb6gh":sub(5, 7):reverse()..""..'n', arg1.SystemId, arg1.Id, arg1_2.SpawnName, arg1_2.ItemName)
        end
        return true
    end
    arg1.Items = {}
    local Model = arg1.Model
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    for i, v in Model.Model.Cash:GetChildren() do
        local tbl = {
            Part = v;
            Name = "Grab Cash";
            Timed = true;
            Duration = 0.65;
            Dist = 6;
            Callback = GrabAction;
            SpawnName = v.Name;
            ItemName = "RackOfCash";
        }
        CircleAction_upvr.Add(tbl, v)
        table.insert(tbl_3, tbl)
        arg1.Items[v.Name] = v
    end
    if arg1.Name ~= "PassengerArmor" then
        for i_2 = 1, 2 do
            i = Model.Model:FindFirstChild("Glass"..tostring(i_2))
            v = {}
            v.Part = i
            v.Name = "Break Glass"
            v.ValidRoot = arg1.Model
            v.Timed = true
            v.NoRay = true
            v.Duration = 1.5
            v.Dist = 10
            function v.Callback(arg1_3, arg2) -- Line 118, Named "Action"
                if arg2 then
                    if not OpenRoofDoorRaw_upvr(arg1, arg1_3.GlassIndex) then
                        return false
                    end
                    var3_upvw:FireServer('t'.."zgdj18by4u":sub(2, 6):reverse():reverse():reverse():reverse():reverse().."".."c5", arg1.SystemId, arg1.Id, arg1_3.GlassIndex)
                end
                return true
            end
            v.GlassIndex = i_2
            CircleAction_upvr.Add(v, i)
            table.insert(tbl_3, v)
            local _
        end
    end
    for i_3 = 1, 2 do
        i = Model.Skeleton:FindFirstChild("Door"..tostring(i_3))
        if i then
            v = i.PrimaryPart
            local tbl_2 = {
                Part = v;
                Name = "Open Door";
                ValidRoot = arg1.Model;
                Timed = false;
                NoRay = true;
                Dist = 10;
                Callback = function(arg1_4, arg2) -- Line 147, Named "SideDoorAction"
                    if arg2 then
                        local var39 = arg1
                        local DoorIndex = arg1_4.DoorIndex
                        if var39.DoorIndexOpen[DoorIndex] then
                        else
                            var39.DoorIndexOpen[DoorIndex] = true
                            var39.DoorOpenFuncs[DoorIndex]()
                            CircleAction_upvr.Remove(assert(var39.Model.Skeleton:FindFirstChild("Door"..tostring(DoorIndex)), "missing doorModel"))
                        end
                        if not true then
                            return false
                        end
                        var3_upvw:FireServer('p'.."".."fmhhptm":sub(5, 5):reverse().."".."".."ggvwiyost":sub(5, 7):reverse():reverse():reverse():reverse():reverse().."".."5ee", arg1.SystemId, arg1.Id, arg1_4.DoorIndex)
                    end
                    return true
                end;
                DoorIndex = i_3;
            }
            CircleAction_upvr.Add(tbl_2, i)
            table.insert(tbl_3, tbl_2)
        end
    end
    arg1.CircleActionSpecs = tbl_3
    arg1.GlassIndexOpen = {}
    arg1.DoorIndexOpen = {}
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local function OnCarCreated_upvr(arg1) -- Line 180, Named "OnCarCreated"
    if arg1.Name:sub(1, 9) == "Passenger" then
        SetupPassengerCar_upvr(arg1)
    end
end
local function OnCarDestroyed_upvr(arg1) -- Line 186, Named "OnCarDestroyed"
    if arg1.Name:sub(1, 9) == "Passenger" then
        if arg1.CircleActionSpecs then
            for _, v_2 in next, arg1.CircleActionSpecs do
                if not v_2.Kill then
                    v_2.Kill = true
                end
            end
            return
        end
        warn("Car.CircleActionSpecs is nil")
        print(arg1)
    end
end
local var44_upvw
local var45_upvw
local TrainSystem_upvr = require(ReplicatedStorage_upvr.Game.TrainSystem)
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
return {
    Init = function(arg1) -- Line 201, Named "Init"
        var3_upvw = arg1.Event
        var44_upvw = arg1.em
        var45_upvw = arg1.ScreenGui
        TrainSystem_upvr.Signals.OnCarCreated:Connect(OnCarCreated_upvr)
        TrainSystem_upvr.Signals.OnCarDestroyed:Connect(OnCarDestroyed_upvr)
        function var44_upvw.guekpl4n(arg1_5, arg2, arg3) -- Line 210
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            local any_GetSystemById_result1 = TrainSystem_upvr.GetSystemById(arg1_5)
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            do
                return nil
            end
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        end
        function var44_upvw.t81jdgc5(arg1_6, arg2, arg3) -- Line 237
            local any_GetSystemById_result1_2 = TrainSystem_upvr.GetSystemById(arg1_6)
            if not any_GetSystemById_result1_2 then
                return nil
            end
            local any_GetCarById_result1 = TrainSystem_upvr.GetCarById(any_GetSystemById_result1_2, arg2)
            if not any_GetCarById_result1 then
                return nil
            end
            OpenRoofDoorRaw_upvr(any_GetCarById_result1, arg3)
            return true
        end
    end;
}