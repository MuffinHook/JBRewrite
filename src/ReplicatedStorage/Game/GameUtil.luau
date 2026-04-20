local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local module = {
    OnTeamChanged = Signal.new();
    Team = require(ReplicatedStorage.Resource.Settings).EnumTeam.Prisoner;
    Schedule = nil;
    bounty = 0;
    onBountyChanged = Signal.new();
    removeDeathGui = nil;
    removeDeathLighting = nil;
}
local any_new_result1_upvr = require(ReplicatedStorage.Module.Window.WindowGroup).new()
function module.getCenterWindowGroup() -- Line 15
    return any_new_result1_upvr
end
return module