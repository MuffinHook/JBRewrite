local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module = {}
local waitForChild_upvr = require(ReplicatedStorage_upvr.Std.waitForChild)
local RobberyBonusConsts_upvr = require(script.Parent.RobberyBonusConsts)
function module.init(arg1) -- Line 6
    local em_upvr = arg1.em
    waitForChild_upvr(ReplicatedStorage_upvr, RobberyBonusConsts_upvr.FIREWORK_FX_REMOTE_NAME):andThen(function(arg1_2) -- Line 8
        arg1_2.OnClientEvent:Connect(function() -- Line 9
            em_upvr.at2y4lws(10)
        end)
    end)
end
return module