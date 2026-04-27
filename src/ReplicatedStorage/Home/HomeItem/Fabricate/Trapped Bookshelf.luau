game:GetService("ReplicatedStorage")
local TrappedTrapUtils = require(script.Parent.TrappedTrapUtils)
local trapEventHandler = nil
return {
	init = function(eventConfig)
		trapEventHandler = eventConfig.Event
	end,
	setup = function(trapSetupConfig)
		TrappedTrapUtils.setup(trapSetupConfig, {
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
		}, trapEventHandler)
	end
}
