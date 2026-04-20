return {
    teamId = require(game:GetService("ReplicatedStorage").Resource.Settings).EnumTeam.Criminal;
    message = function(arg1) -- Line 6
        return "Rob the Bank %d times.":format(arg1:GetGoal())
    end;
    goal = function() -- Line 9
        return math.random(3, 4)
    end;
    rewardExp = 60;
}