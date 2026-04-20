local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage_upvr.Std.BaseObject)
local BountyConsts_upvr = require(ReplicatedStorage_upvr.Bounty.BountyConsts)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
local BountyBoardService_upvr = require(ReplicatedStorage_upvr.Bounty.BountyBoardService)
function module_upvr.new(arg1) -- Line 12
    local any_new_result1 = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1, module_upvr)
    local clone = ReplicatedStorage_upvr.Bounty.Res.MostWanted:Clone()
    any_new_result1.maid:GiveTask(clone)
    clone.Parent = arg1:WaitForChild("Board")
    clone.Board:AddTag(BountyConsts_upvr.BOARD_LIST_TAG_NAME)
    BountyBoardService_upvr.updateGui(clone.Board, BountyBoardService_upvr.getTopBounties(4))
    return any_new_result1
end
return require(ReplicatedStorage_upvr.Std.Binder).new(BountyConsts_upvr.BOARD_TAG_NAME, module_upvr)