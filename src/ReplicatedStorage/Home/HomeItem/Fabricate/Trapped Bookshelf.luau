-- Reviewed by Claude
game:GetService("ReplicatedStorage")
local TrappedTrapUtils = require(script.Parent.TrappedTrapUtils)
local v1 = nil
return {
	init = function(p1)
		v1 = p1.Event
	end,
	setup = function(p1)
		TrappedTrapUtils.setup(p1, {
			doorName = "FakeDoor",
			spikesName = "Spikes",
			referenceName = "Shelving",
			regionName = "Region",
			offsetCf = CFrame.new(0.0900421143, 0.141143799, 0.781, 1, 0, 0, 0, 1, 0, 0, 0, 1),
			spikeSizeMin = 1.562,
			spikeSizeMax = 6.534,
			damageAmount = 36,
			audioId = 6909242121,
			doorCloseDelay = 1
		}, v1)
	end
}
