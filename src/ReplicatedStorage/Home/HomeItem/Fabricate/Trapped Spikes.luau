game:GetService("ReplicatedStorage")
local TrappedTrapUtils = require(script.Parent.TrappedTrapUtils)
local trapEvent = nil
return {
	init = function(config)
		trapEvent = config.Event
	end,
	setup = function(config)
		TrappedTrapUtils.setup(config, {
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
		}, trapEvent)
	end
}
