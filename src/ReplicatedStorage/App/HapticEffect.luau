local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InputUtils = require(ReplicatedStorage.Std.InputUtils)
return {
	basic = function(p1, p2) --[[ Name: basic | Line: 7 | Upvalues: InputUtils (copy) ]]
		if InputUtils.isGamepad() then
			assert(p1)
			assert(p2)
			local HapticEffect = Instance.new("HapticEffect")
			HapticEffect.Radius = 3
			HapticEffect.Looped = true
			HapticEffect.Type = Enum.HapticEffectType.Custom
			HapticEffect:SetWaveformKeys({ FloatCurveKey.new(0, p1) })
			HapticEffect.Parent = workspace
			HapticEffect:Play()
			if p2 ~= (1 / 0) then
				task.delay(p2, HapticEffect.Destroy, HapticEffect)
			end
			return HapticEffect
		end
	end
}