local module = {}
local InputUtils_upvr = require(game:GetService("ReplicatedStorage").Std.InputUtils)
function module.basic(arg1, arg2) -- Line 7
    if not InputUtils_upvr.isGamepad() then return end
    assert(arg1)
    assert(arg2)
    local HapticEffect = Instance.new("HapticEffect")
    HapticEffect.Radius = 3
    HapticEffect.Looped = true
    HapticEffect.Type = Enum.HapticEffectType.Custom
    HapticEffect:SetWaveformKeys({FloatCurveKey.new(0, arg1)})
    HapticEffect.Parent = workspace
    HapticEffect:Play()
    if arg2 ~= math.huge then
        task.delay(arg2, HapticEffect.Destroy, HapticEffect)
    end
    return HapticEffect
end
return module