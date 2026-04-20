local module = {}
local Binder_upvr = require(game:GetService("ReplicatedStorage").Std.Binder)
local TopExpBoardConsts_upvr = require(script.Parent.TopExpBoardConsts)
function module.init() -- Line 7
    Binder_upvr.new(TopExpBoardConsts_upvr.TAG_NAME, require(script.Parent.TopExpBoard)):Start()
end
return module