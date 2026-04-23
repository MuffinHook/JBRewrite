game:GetService("ReplicatedStorage")
local TrappedTrapUtils = require(script.Parent.TrappedTrapUtils)
local v1 = nil
return {
	init = function(p1) --[[ Name: init | Line: 6 | Upvalues: v1 (ref) ]]
		v1 = p1.Event
	end,
	setup = function(p1) --[[ Name: setup | Line: 9 | Upvalues: TrappedTrapUtils (copy), v1 (ref) ]]
		TrappedTrapUtils.setup(p1, {
			doorName = "FakeDoor",
			spikesName = "Spikes",
			referenceName = "Metal",
			regionName = "Region",
			offsetCf = CFrame.new(-0.00280761719, -1.17230225, 0.356445312, 1, 0, 0, 0, 1, 0, 0, 0, 1),
			spikeSizeMin = 1.31,
			spikeSizeMax = 5,
			damageAmount = 36,
			audioId = 6909242121,
			doorCloseDelay = 1
		}, v1)
	end
}