local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InputUtils = require(ReplicatedStorage.Std.InputUtils)
return {
	basic = function(amplitude, duration)
		if InputUtils.isGamepad() then
			assert(amplitude)
			assert(duration)
			local HapticEffect = Instance.new("HapticEffect")
			HapticEffect.Radius = 3
			HapticEffect.Looped = true
			HapticEffect.Type = Enum.HapticEffectType.Custom
			HapticEffect:SetWaveformKeys({ FloatCurveKey.new(0, amplitude) })
			HapticEffect.Parent = workspace
			HapticEffect:Play()
			if duration ~= (1 / 0) then
				task.delay(duration, HapticEffect.Destroy, HapticEffect)
			end
			return HapticEffect
		end
	end
}