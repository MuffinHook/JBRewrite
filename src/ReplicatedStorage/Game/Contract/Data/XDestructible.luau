return {
    teamId = require(game:GetService("ReplicatedStorage").Resource.Settings).EnumTeam.Criminal;
    message = function(arg1) -- Line 6
        return string.format("Knock over %d items.", arg1:GetGoal());
    end;
    goal = function() -- Line 9
        return 400 + math.random(0, 10)
    end;
    rewardExp = 45;
}