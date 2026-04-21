return {
    teamId = require(game:GetService("ReplicatedStorage").Resource.Settings).EnumTeam.Police;
    message = function(arg1) -- Line 6
        return string.format("Arrest %d criminals.", arg1:GetGoal());
    end;
    goal = function() -- Line 9
        return math.random(12, 15)
    end;
    rewardExp = 50;
}