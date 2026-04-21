return {
    teamId = require(game:GetService("ReplicatedStorage").Resource.Settings).EnumTeam.Criminal;
    message = function(arg1) -- Line 6
        return string.format("Rob the Bank %d times.", arg1:GetGoal());
    end;
    goal = function() -- Line 9
        return math.random(3, 4)
    end;
    rewardExp = 60;
}