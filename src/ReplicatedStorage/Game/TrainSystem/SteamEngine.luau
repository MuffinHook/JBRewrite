local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Default_upvr = require(script.Parent.Default)
local function _(arg1, arg2) -- Line 9, Named "MakeSound"
    local Sound = Instance.new("Sound")
    Sound.SoundId = "rbxassetid://"..tostring(arg2)
    Sound.Volume = 0.25
    Sound.RollOffMaxDistance = 768
    Sound.RollOffMinDistance = 16
    Sound.RollOffMode = Enum.RollOffMode.InverseTapered
    Sound.Parent = arg1
    return Sound
end
local CollectionService_upvr = game:GetService("CollectionService")
local Joint_upvr = require(ReplicatedStorage_upvr.Std.Joint)
local RunUtils_upvr = require(ReplicatedStorage_upvr.App.RunUtils)
local function UpdateSound_upvr(arg1, arg2) -- Line 105, Named "UpdateSound"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local Character = LocalPlayer_upvr.Character
    local var62
    if not Character then
        return false
    end
    local Humanoid = Character:FindFirstChild("Humanoid")
    if not Humanoid then
        return false
    end
    local RootPart_2 = Humanoid.RootPart
    if not RootPart_2 then
        return false
    end
    local tick_result1_2 = tick()
    if 5 < tick_result1_2 - arg1.LastBell then
        var62 = arg1.LastBellSpeed
        if 30 < math.abs(arg2.Speed - var62) then
            arg1.LastBell = tick_result1_2
            arg1.LastBellSpeed = arg2.Speed
            arg1.SoundBell:Play()
        end
    end
    local var66
    if arg1.HornWait < var66 then
        arg1.LastHorn = tick_result1_2
        local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var66 = 4 + var62 * 2
            var62 = math.random()
            return var66
        end
        if 0.9 >= math.random() or not decompInlinedCondition_2() then
            var66 = math.random() * 20 + 40
        end
        arg1.HornWait = var66
        var66 = arg1.SoundWhistle:Play
        var66()
    end
    local const_number_2 = 500
    var62 = nil
    for i_2 = 1, #arg2.Cars do
        local var68 = arg2.Cars[i_2]
        if var68.Loaded then
            local Position_2 = var68.Model.Base.Position
            local Magnitude = (RootPart_2.Position - Position_2).Magnitude
            if Magnitude < const_number_2 then
                var62 = nil
                local var71 = Position_2
            elseif Magnitude < const_number_2 then
                var62 = Position_2
            end
        end
    end
    local SoundPart_2 = arg1.SoundPart
    if not var62 or not var71 then
        i_2 = workspace
        if SoundPart_2.Parent == i_2 then
            SoundPart_2.Parent = nil
        end
        return false
    end
    if SoundPart_2.Parent ~= workspace then
        SoundPart_2.Parent = workspace
    end
    local var73 = var71 + var62
    local var74 = var73 / 2
    if 200 < (var74 - SoundPart_2.Position).Magnitude then
        var73 = 0.2
    else
        var73 = 0.05
    end
    SoundPart_2.CFrame = SoundPart_2.CFrame:Lerp(CFrame.new(var74), var73)
end
return {
    MakeCar = function(arg1, arg2) -- Line 20, Named "MakeCar"
        local Model = arg1.Model
        CollectionService_upvr:AddTag(Model.Model.TrainPassenger, "RobberyMarker")
        local Base = arg1.Base
        local tbl = {}
        for _, v in next, Model.SteamWheels:GetChildren() do
            v.Anchored = false
            table.insert(tbl, Joint_upvr.CustomMotor(v, Base, CFrame.new(), Base.CFrame:toObjectSpace(v.CFrame)))
        end
        arg1.Wheels = tbl
        local WheelLink = Model.WheelLink
        WheelLink.Anchored = false
        arg1.WheelLinkMotor = Joint_upvr.Motor(WheelLink, Base, WheelLink.CFrame:ToObjectSpace(Base.CFrame))
        local Part = Instance.new("Part")
        Part.Anchored = true
        Part.CanCollide = false
        Part.Transparency = 1
        Part.Parent = workspace
        local Sound_3 = Instance.new("Sound")
        Sound_3.SoundId = "rbxassetid://"..tostring(988440047)
        Sound_3.Volume = 0.25
        Sound_3.RollOffMaxDistance = 768
        Sound_3.RollOffMinDistance = 16
        Sound_3.RollOffMode = Enum.RollOffMode.InverseTapered
        Sound_3.Parent = Model.Model.Bell
        local var20 = Sound_3
        var20.EmitterSize = 50
        var20.Volume = 0.4
        local Sound_4 = Instance.new("Sound")
        Sound_4.SoundId = "rbxassetid://"..tostring(2801432206)
        Sound_4.Volume = 0.25
        Sound_4.RollOffMaxDistance = 768
        Sound_4.RollOffMinDistance = 16
        Sound_4.RollOffMode = Enum.RollOffMode.InverseTapered
        Sound_4.Parent = Model.Model.Bell
        local var22 = Sound_4
        var22.EmitterSize = 250
        var22.Volume = 0.5
        local Sound_2 = Instance.new("Sound")
        Sound_2.SoundId = "rbxassetid://"..tostring(10574713204)
        Sound_2.Volume = 0.25
        Sound_2.RollOffMaxDistance = 768
        Sound_2.RollOffMinDistance = 16
        Sound_2.RollOffMode = Enum.RollOffMode.InverseTapered
        Sound_2.Parent = Model.BackBogey
        local var24 = Sound_2
        var24.PlaybackSpeed = 1
        var24.Volume = 0.15
        var24.EmitterSize = 10
        var24.Looped = true
        var24:Play()
        arg1.SoundChugga = var24
        local Sound_5 = Instance.new("Sound")
        Sound_5.SoundId = "rbxassetid://"..tostring(10563992041)
        Sound_5.Volume = 0.25
        Sound_5.RollOffMaxDistance = 768
        Sound_5.RollOffMinDistance = 16
        Sound_5.RollOffMode = Enum.RollOffMode.InverseTapered
        Sound_5.Parent = Part
        local var26 = Sound_5
        var26.Looped = true
        var26.Volume = 0.25
        var26:Play()
        arg1.SoundPart = Part
        arg1.SoundBell = var20
        arg1.SoundWhistle = var22
        local tick_result1_3_upvw = tick()
        Model.Model.Front.Touched:connect(function(arg1_2) -- Line 66
            if RunUtils_upvr.isStudio() then
            else
                local tick_result1 = tick()
                if tick_result1 - tick_result1_3_upvw < 0.1 then return end
                local Vehicles = workspace:FindFirstChild("Vehicles")
                if Vehicles and arg1_2:IsDescendantOf(Vehicles) then
                    repeat
                        local Parent_3 = arg1_2.Parent
                    until Parent_3.Parent == Vehicles and Parent_3 == Vehicles
                    if Parent_3.Parent == Vehicles then
                        ReplicatedStorage_upvr:FindFirstChild("HitByTrainRemote"):FireServer()
                    end
                end
                local Parent_2 = arg1_2.Parent
                if Parent_2 == LocalPlayer_upvr.Character then
                    local Humanoid_4 = Parent_2:FindFirstChild("Humanoid")
                    if Humanoid_4 and 1 < Humanoid_4.Health then
                        arg2:FireServer("yzplkho3", 100, "Train")
                        tick_result1_3_upvw = tick_result1
                    end
                end
            end
        end)
        arg1.LastHorn = 0
        arg1.HornWait = 0
        arg1.LastBell = 0
        arg1.LastBellSpeed = 0
        return Default_upvr.MakeCar(arg1)
    end;
    MoveCar = function(arg1, arg2, arg3, arg4) -- Line 174, Named "MoveCar"
        local var79 = arg2.Speed * arg3
        local RightVector = arg1.Base.CFrame.RightVector
        for _, v_2 in next, arg1.Wheels do
            v_2.C0 *= CFrame.Angles(math.sign(v_2.Part0.CFrame.RightVector:Dot(RightVector)) * var79 / 3.368, 0, 0)
        end
        arg1._wheelLinkAngle = (arg1._wheelLinkAngle or 0) + var79 / 2
        arg1.WheelLinkMotor.C1 = CFrame.new(0, math.sin(arg1._wheelLinkAngle) * 2, math.cos(arg1._wheelLinkAngle) * 2)
        UpdateSound_upvr(arg1, arg2)
        return Default_upvr.MoveCar(arg1, arg2, arg3, arg4)
    end;
    DestroyCar = function(arg1) -- Line 196, Named "DestroyCar"
        arg1.SoundPart:Destroy()
        arg1.SoundBell:Destroy()
        arg1.SoundWhistle:Destroy()
        arg1.SoundChugga:Destroy()
        return Default_upvr.DestroyCar(arg1)
    end;
}