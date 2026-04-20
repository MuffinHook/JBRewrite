local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_upvr = {}
local LightningUtils_upvr = require(ReplicatedStorage.Game.LightningUtils)
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local var5_upvw = 0
local Lighting_upvr = game:GetService("Lighting")
local RunService_upvr = game:GetService("RunService")
local Anim_upvr = require(ReplicatedStorage.Module.Anim)
function module_upvr.StrikePosition(arg1, arg2) -- Line 12
    local tbl = {}
    tbl.Origin = arg1
    tbl.Target = arg2
    tbl.Transparency = 0.6
    local Part_upvr = Instance.new("Part")
    Part_upvr.Anchored = true
    Part_upvr.CanCollide = false
    Part_upvr.Transparency = 1
    Part_upvr.Position = arg2
    Part_upvr.Parent = workspace
    Audio_upvr.ObjectLocal(Part_upvr, 5042136770, {
        Volume = 2;
        EmitterSize = 60;
        MaxPlaybackTime = 8;
    })
    Audio_upvr.ObjectLocal(Part_upvr, 457217618, {
        EmitterSize = 60;
        TimePosition = 1;
        MaxPlaybackTime = 8;
    })
    delay(8, function() -- Line 30
        Part_upvr:Destroy()
    end)
    local tick_result1 = tick()
    if 1 < tick_result1 - var5_upvw then
        var5_upvw = tick_result1
        local Color3_fromRGB_result1_upvr_2 = Color3.fromRGB(164, 172, 186)
        local Color3_fromRGB_result1_upvr = Color3.fromRGB(64, 76, 93)
        Lighting_upvr.OutdoorAmbient = Color3_fromRGB_result1_upvr_2
        local Clouds_upvr = workspace.Terrain.Clouds
        Clouds_upvr.Density = 1
        Clouds_upvr.Cover = 0.9
        Clouds_upvr.Color = Color3_fromRGB_result1_upvr
        task.delay(0.2, function() -- Line 46
            local os_clock_result1_upvr = os.clock()
            local var21_upvw
            var21_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 50
                local var22 = (os.clock() - os_clock_result1_upvr) / 0.5
                if 1 <= var22 then
                    var22 = 1
                end
                Lighting_upvr.OutdoorAmbient = Color3_fromRGB_result1_upvr_2:lerp(Lighting_upvr:GetAttribute("_OutdoorAmbient"), var22)
                Clouds_upvr.Density = math.lerp(1, Lighting_upvr:GetAttribute("_CloudsDensity"), var22)
                Clouds_upvr.Cover = math.lerp(0.9, Lighting_upvr:GetAttribute("_CloudsCover"), var22)
                Clouds_upvr.Color = Color3_fromRGB_result1_upvr:lerp(Lighting_upvr:GetAttribute("_CloudsColor"), var22)
                if var22 == 1 then
                    var21_upvw:Disconnect()
                end
            end)
        end)
    end
    Color3_fromRGB_result1_upvr_2 = task.delay
    local any_strikePosition_result1_upvr = LightningUtils_upvr.strikePosition(tbl)
    Color3_fromRGB_result1_upvr_2(1, function() -- Line 69
        local any_new_result1_upvr = Anim_upvr.new(4)
        local children_upvr = any_strikePosition_result1_upvr:GetChildren()
        local any_Connect_result1_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 73
            local any_Update_result1 = any_new_result1_upvr:Update()
            for _, v in ipairs(children_upvr) do
                v.Transparency = 0.6 * (1 - any_Update_result1) + 1 * any_Update_result1
            end
        end)
        any_new_result1_upvr.OnCompleted:Connect(function() -- Line 79
            any_Connect_result1_upvw:Disconnect()
            any_Connect_result1_upvw = nil
            any_new_result1_upvr:Destroy()
            any_strikePosition_result1_upvr:Destroy()
        end)
    end)
end
function module_upvr.Init(arg1) -- Line 87
    arg1.em.h5dl90gc = function(arg1_2, arg2) -- Line 89, Named "h5dl90gc"
        module_upvr.StrikePosition(arg1_2, arg2)
    end
end
return module_upvr