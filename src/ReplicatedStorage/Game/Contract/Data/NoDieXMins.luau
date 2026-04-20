return {
    teamId = require(game:GetService("ReplicatedStorage").Resource.Settings).EnumTeam.Police;
    message = function(arg1) -- Line 6
        return "Survive %d minutes without dying.":format(arg1:GetGoal())
    end;
    goal = 7;
    rewardExp = 25;
}