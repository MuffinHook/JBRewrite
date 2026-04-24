-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
return {
	onHumanoidAdded = Signal.new(),
	onHumanoidRemoving = Signal.new(),
	mapHooked = {}
}
