local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
require(ReplicatedStorage.Std.TableUtils)
local BountyConsts = require(ReplicatedStorage.Bounty.BountyConsts)
local BountyBoardService = require(ReplicatedStorage.Bounty.BountyBoardService)
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(p1) --[[ Line: 12 | Upvalues: BaseObject (copy), t (copy), ReplicatedStorage (copy), BountyConsts (copy), BountyBoardService (copy) ]]
	local v1 = BaseObject.new(p1)
	setmetatable(v1, t)
	local Board = p1:WaitForChild("Board")
	local v3 = ReplicatedStorage.Bounty.Res.MostWanted:Clone()
	v1.maid:GiveTask(v3)
	v3.Parent = Board
	v3.Board:AddTag(BountyConsts.BOARD_LIST_TAG_NAME)
	BountyBoardService.updateGui(v3.Board, (BountyBoardService.getTopBounties(4)))
	return v1
end
return Binder.new(BountyConsts.BOARD_TAG_NAME, t)