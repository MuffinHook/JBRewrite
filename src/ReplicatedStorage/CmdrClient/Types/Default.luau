local CmdrPermission_upvr = require(game:GetService("ReplicatedStorage").CmdrExt.CmdrPermission)
return function(arg1) -- Line 5
    arg1:RegisterHook("BeforeRun", function(arg1_2) -- Line 6
        if CmdrPermission_upvr.groupAllowed(arg1_2.Executor, arg1_2.Group) then return end
        return "You don't have permission to run this command"
    end)
end