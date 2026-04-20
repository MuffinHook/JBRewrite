return {
    teamId = require(game:GetService("ReplicatedStorage").Resource.Settings).EnumTeam.Police;
    message = function(arg1) -- Line 6
        return "Pit maneuver %d different criminals.":format(arg1:GetGoal())
    end;
    goal = function() -- Line 9
        return math.random(5, 7)
    end;
    rewardExp = 40;
}