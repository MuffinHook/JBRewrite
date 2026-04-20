local var1_upvw = (1/60)
game:GetService("RunService").Stepped:Connect(function(arg1, arg2) -- Line 7
    var1_upvw += (arg2 - var1_upvw) * 0.1
end)
return {
    getEstimatedPhysicsStepsMult = function() -- Line 12, Named "getEstimatedPhysicsStepsMult"
        return var1_upvw / (1/60)
    end;
}