return {
    teamId = require(game:GetService("ReplicatedStorage").Resource.Settings).EnumTeam.Police;
    message = function(arg1) -- Line 6
        return "Use road spikes to pop %d tires.":format(arg1:GetGoal())
    end;
    goal = 3;
    rewardExp = 50;
}