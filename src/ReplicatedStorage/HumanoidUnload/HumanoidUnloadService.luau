local Signal = require(game:GetService("ReplicatedStorage").Std.Signal)
return {
    onHumanoidAdded = Signal.new();
    onHumanoidRemoving = Signal.new();
    mapHooked = {};
}