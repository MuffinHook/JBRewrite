local Players_upvr = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local SmokeGrenadeConsts_upvr = require(script.Parent.SmokeGrenadeConsts)
local module_upvr_2 = {}
module_upvr_2.__index = module_upvr_2
module_upvr_2.__ClassName = "SmokeGrenade"
function module_upvr_2.new(arg1) -- Line 18
    local module_upvr = {}
    setmetatable(module_upvr, module_upvr_2)
    module_upvr._maid = Maid_upvr.new()
    module_upvr.maid = module_upvr._maid
    module_upvr._obj = arg1
    module_upvr.obj = module_upvr._obj
    module_upvr._thrownRemote = arg1:WaitForChild(SmokeGrenadeConsts_upvr.THROWN_REMOTE_NAME)
    module_upvr._thrownValue = arg1:WaitForChild(SmokeGrenadeConsts_upvr.THROWN_VALUE_NAME)
    module_upvr._maid:GiveTask(arg1:WaitForChild(SmokeGrenadeConsts_upvr.EXPLODE_REMOTE_NAME).OnClientEvent:Connect(function() -- Line 34
        module_upvr:_playExplosionFx()
    end))
    module_upvr._creatorIdValue = arg1:WaitForChild(SmokeGrenadeConsts_upvr.CREATOR_ID_VALUE_NAME)
    return module_upvr
end
function module_upvr_2._getJ(arg1, arg2) -- Line 44
    local var8 = (arg1._obj.PrimaryPart.Position - arg2).Magnitude / SmokeGrenadeConsts_upvr.BLAST_RADIUS
    if var8 < 0.001 then
        var8 = 0
    end
    if 0.999 < var8 then
        var8 = 1
    end
    return 1 - var8
end
local Promise_upvr = require(ReplicatedStorage.Std.Promise)
local PlayerUtils_upvr = require(ReplicatedStorage.Game.PlayerUtils)
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local CamShaker_upvr = require(ReplicatedStorage.Game.CamShaker.CamShaker)
local CurrentCamera_upvr = workspace.CurrentCamera
local Lighting_upvr = game:GetService("Lighting")
local Color3_new_result1_upvr = Color3.new(1, 1, 1)
local Anim_upvr = require(ReplicatedStorage.Module.Anim)
local RunService_upvr = game:GetService("RunService")
function module_upvr_2._playExplosionFx(arg1) -- Line 55
    local FX_DURATION = SmokeGrenadeConsts_upvr.FX_DURATION
    local any_new_result1_2_upvw = Maid_upvr.new()
    Promise_upvr.delay(FX_DURATION):andThenCall(any_new_result1_2_upvw.Destroy, any_new_result1_2_upvw)
    local any_getHumanoid_result1_upvr = PlayerUtils_upvr.getHumanoid(LocalPlayer_upvr)
    local any_getRootPart_result1_upvw = PlayerUtils_upvr.getRootPart(LocalPlayer_upvr)
    if (arg1._obj.PrimaryPart.Position - any_getRootPart_result1_upvw.Position).Magnitude < SmokeGrenadeConsts_upvr.BLAST_RADIUS then
        local any_new_result1 = CamShaker_upvr.new(Enum.RenderPriority.Camera.Value + 2, function(arg1_2) -- Line 67
            CurrentCamera_upvr.CFrame *= arg1_2
        end)
        any_new_result1:Start()
        any_new_result1:Shake(CamShaker_upvr.Presets.Explosion)
        Promise_upvr.delay(2):andThenCall(any_new_result1.Stop, any_new_result1)
        any_getHumanoid_result1_upvr.NameDisplayDistance = 0
        any_new_result1_2_upvw:GiveTask(function() -- Line 76
            any_getHumanoid_result1_upvr.NameDisplayDistance = 100
        end)
    end
    local BlurEffect_upvr = Instance.new("BlurEffect")
    BlurEffect_upvr.Size = 0
    BlurEffect_upvr.Parent = Lighting_upvr
    any_new_result1_2_upvw:GiveTask(BlurEffect_upvr)
    local ColorCorrectionEffect_upvr = Instance.new("ColorCorrectionEffect")
    ColorCorrectionEffect_upvr.TintColor = Color3_new_result1_upvr
    ColorCorrectionEffect_upvr.Parent = Lighting_upvr
    any_new_result1_2_upvw:GiveTask(ColorCorrectionEffect_upvr)
    local any_new_result1_upvr = Anim_upvr.new(0.1)
    any_new_result1_upvr.OnCompleted:Connect(function() -- Line 92
        any_new_result1_upvr:Destroy()
    end)
    any_new_result1_2_upvw:GiveTask(any_new_result1_upvr)
    any_new_result1_upvr.Maid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 96
        local any_Update_result1_2 = any_new_result1_upvr:Update()
        local any__getJ_result1_3 = arg1:_getJ(any_getRootPart_result1_upvw.Position)
        BlurEffect_upvr.Size = any_Update_result1_2 * any__getJ_result1_3 * SmokeGrenadeConsts_upvr.FX_BLUR_SIZE
        ColorCorrectionEffect_upvr.TintColor = Color3_new_result1_upvr:lerp(SmokeGrenadeConsts_upvr.FX_COLOR, any_Update_result1_2 * any__getJ_result1_3)
    end))
    any_new_result1_upvr.Maid:GiveTask(function() -- Line 103
        any_new_result1_2_upvw.distanceRuntime = RunService_upvr.Heartbeat:Connect(function() -- Line 104
            any_getRootPart_result1_upvw = PlayerUtils_upvr.getRootPart(LocalPlayer_upvr)
            local any__getJ_result1 = arg1:_getJ(any_getRootPart_result1_upvw.Position)
            BlurEffect_upvr.Size = any__getJ_result1 * SmokeGrenadeConsts_upvr.FX_BLUR_SIZE
            ColorCorrectionEffect_upvr.TintColor = Color3_new_result1_upvr:lerp(SmokeGrenadeConsts_upvr.FX_COLOR, any__getJ_result1)
        end)
    end)
    Promise_upvr.delay(FX_DURATION - 0.1 - 1):andThen(function() -- Line 113
        any_new_result1_2_upvw.distanceRuntime = nil
        local any_new_result1_upvr_2 = Anim_upvr.new(1)
        any_new_result1_2_upvw:GiveTask(any_new_result1_upvr_2)
        any_new_result1_upvr_2.Maid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 117
            local any_Update_result1 = any_new_result1_upvr_2:Update()
            local any__getJ_result1_2 = arg1:_getJ(any_getRootPart_result1_upvw.Position)
            BlurEffect_upvr.Size = (1 - any_Update_result1) * any__getJ_result1_2 * SmokeGrenadeConsts_upvr.FX_BLUR_SIZE
            ColorCorrectionEffect_upvr.TintColor = Color3_new_result1_upvr:lerp(SmokeGrenadeConsts_upvr.FX_COLOR, (1 - any_Update_result1) * any__getJ_result1_2)
        end))
    end)
    Promise_upvr.delay(FX_DURATION):andThen(function() -- Line 125
        any_new_result1_2_upvw:Destroy()
        any_new_result1_2_upvw = nil
    end)
end
function module_upvr_2.SetThrown(arg1) -- Line 130
    arg1._thrownValue.Value = true
    arg1._thrownRemote:FireServer()
end
function module_upvr_2.GetThrown(arg1) -- Line 134
    return arg1._thrownValue.Value
end
function module_upvr_2.GetCreator(arg1) -- Line 137
    return Players_upvr:GetPlayerByUserId(arg1._creatorIdValue.Value)
end
function module_upvr_2.SetVelocity(arg1, arg2) -- Line 142
    if arg2 == nil then
    else
    end
    assert(true)
    arg1._obj.PrimaryPart.Velocity = arg2
end
function module_upvr_2.SetRotVelocity(arg1, arg2) -- Line 147
    if arg2 == nil then
    else
    end
    assert(true)
    arg1._obj.PrimaryPart.RotVelocity = arg2
end
function module_upvr_2.Destroy(arg1) -- Line 152
    assert(arg1._maid)
    arg1._maid = nil
    arg1._maid:Destroy()
    setmetatable(arg1, nil)
end
return module_upvr_2