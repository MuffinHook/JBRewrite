local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Default_upvr = require(script.Parent.Default)
local function _(arg1, arg2) -- Line 7, Named "MakeSound"
    local Sound_4 = Instance.new("Sound")
    Sound_4.SoundId = "rbxassetid://"..tostring(arg2)
    Sound_4.Volume = 0.25
    Sound_4.RollOffMaxDistance = 768
    Sound_4.RollOffMinDistance = 16
    Sound_4.RollOffMode = Enum.RollOffMode.InverseTapered
    Sound_4.Parent = arg1
    return Sound_4
end
local RunUtils_upvr = require(ReplicatedStorage_upvr.App.RunUtils)
local function UpdateSound_upvr(arg1, arg2) -- Line 74, Named "UpdateSound"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local Character = LocalPlayer_upvr.Character
    local var31
    if not Character then
        return false
    end
    local Humanoid_3 = Character:FindFirstChild("Humanoid")
    if not Humanoid_3 then
        return false
    end
    local RootPart = Humanoid_3.RootPart
    if not RootPart then
        return false
    end
    local var35
    if arg1.HornWait < var35 then
        arg1.LastHorn = tick()
        local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var35 = 4 + var31 * 2
            var31 = math.random()
            return var35
        end
        if 0.9 >= math.random() or not decompInlinedCondition() then
            var35 = math.random() * 20 + 40
        end
        arg1.HornWait = var35
        var35 = arg1.SoundHorn:Play
        var35()
    end
    local const_number = 500
    var31 = nil
    for i = 1, #arg2.Cars do
        local var37 = arg2.Cars[i]
        if var37.Loaded then
            local Position = var37.Model.Base.Position
            local Magnitude = (RootPart.Position - Position).Magnitude
            if Magnitude < const_number then
                var31 = nil
                local var40 = Position
            elseif Magnitude < const_number then
                var31 = Position
            end
        end
    end
    local SoundPart = arg1.SoundPart
    if not var31 or not var40 then
        i = workspace
        if SoundPart.Parent == i then
            SoundPart.Parent = nil
        end
        return false
    end
    if SoundPart.Parent ~= workspace then
        SoundPart.Parent = workspace
    end
    local var42 = var40 + var31
    local var43 = var42 / 2
    if 200 < (var43 - SoundPart.Position).Magnitude then
        var42 = 0.2
    else
        var42 = 0.05
    end
    SoundPart.CFrame = SoundPart.CFrame:Lerp(CFrame.new(var43), var42)
end
return {
    MakeCar = function(arg1, arg2) -- Line 18, Named "MakeCar"
        local Model = arg1.Model
        local Part = Instance.new("Part")
        Part.Anchored = true
        Part.CanCollide = false
        Part.Transparency = 1
        local Sound_2 = Instance.new("Sound")
        Sound_2.SoundId = "rbxassetid://"..tostring(690528575)
        Sound_2.Volume = 0.25
        Sound_2.RollOffMaxDistance = 768
        Sound_2.RollOffMinDistance = 16
        Sound_2.RollOffMode = Enum.RollOffMode.InverseTapered
        Sound_2.Parent = Model.Model.Front
        local var9 = Sound_2
        var9.EmitterSize = 50
        var9.Volume = 0.45
        local Sound_3 = Instance.new("Sound")
        Sound_3.SoundId = "rbxassetid://"..tostring(10563947644)
        Sound_3.Volume = 0.25
        Sound_3.RollOffMaxDistance = 768
        Sound_3.RollOffMinDistance = 16
        Sound_3.RollOffMode = Enum.RollOffMode.InverseTapered
        Sound_3.Parent = Model.BackBogey
        local var11 = Sound_3
        var11.Looped = true
        var11:Play()
        local Sound = Instance.new("Sound")
        Sound.SoundId = "rbxassetid://"..tostring(10563992041)
        Sound.Volume = 0.25
        Sound.RollOffMaxDistance = 768
        Sound.RollOffMinDistance = 16
        Sound.RollOffMode = Enum.RollOffMode.InverseTapered
        Sound.Parent = Part
        local var13 = Sound
        var13.Looped = true
        var13:Play()
        arg1.SoundPart = Part
        arg1.SoundHorn = var9
        local tick_result1_2_upvw = tick()
        Model.Model.Front.Touched:connect(function(arg1_2) -- Line 38
            if RunUtils_upvr.isStudio() then
            else
                local tick_result1_3 = tick()
                if tick_result1_3 - tick_result1_2_upvw < 0.1 then return end
                local Vehicles_2 = workspace:FindFirstChild("Vehicles")
                if Vehicles_2 and arg1_2:IsDescendantOf(Vehicles_2) then
                    repeat
                        local Parent_2 = arg1_2.Parent
                    until Parent_2.Parent == Vehicles_2 and Parent_2 == Vehicles_2
                    if Parent_2.Parent == Vehicles_2 then
                        ReplicatedStorage_upvr:FindFirstChild("HitByTrainRemote"):FireServer()
                    end
                end
                local Parent_4 = arg1_2.Parent
                if Parent_4 == LocalPlayer_upvr.Character then
                    local Humanoid = Parent_4:FindFirstChild("Humanoid")
                    if Humanoid and 1 < Humanoid.Health then
                        arg2:FireServer('y'.."blpzfhb":sub(2, 4):reverse():reverse():reverse():reverse():reverse().."".."kho3", 100, "Train")
                        tick_result1_2_upvw = tick_result1_3
                    end
                end
            end
        end)
        arg1.LastHorn = 0
        arg1.HornWait = 0
        return Default_upvr.MakeCar(arg1)
    end;
    MoveCar = function(arg1, arg2, arg3, arg4) -- Line 125, Named "MoveCar"
        UpdateSound_upvr(arg1, arg2)
        return Default_upvr.MoveCar(arg1, arg2, arg3, arg4)
    end;
    DestroyCar = function(arg1) -- Line 131, Named "DestroyCar"
        arg1.SoundPart:Destroy()
        arg1.SoundHorn:Destroy()
        return Default_upvr.DestroyCar(arg1)
    end;
}